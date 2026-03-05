CREATE OR REPLACE VIEW vw_relatorio_reservas AS
WITH
-- total de reservas no sistema (exceto canceladas, se você quiser contar canceladas, remova o WHERE)
total_reservas AS (
    SELECT COUNT(*)::bigint AS total
    FROM reserva r
    WHERE r.status_reserva <> 'CANCELADA'
),

-- reservas "ativas hoje": hóspedes com hospedagem aberta (checkout real ainda não ocorreu)
reservas_ativas_hoje AS (
    SELECT COUNT(*)::bigint AS total
    FROM hospedagem h
    WHERE h.data_checkout_real IS NULL
      AND h.data_checkin_real::date <= current_date
),

-- receita estimada total (por reserva): noites * preco_diaria, somando por quartos da reserva
receita_estimada_total AS (
    SELECT COALESCE(SUM(
                            (r.data_checkout_previsto - r.data_checkin_previsto) * cat.preco_diaria
                    ), 0)::numeric(12,2) AS total
    FROM reserva r
             JOIN reserva_quarto rq ON rq.reserva_id = r.id
             JOIN quarto q ON q.id = rq.quarto_id
             JOIN categoria cat ON cat.id = q.categoria_id
    WHERE r.status_reserva <> 'CANCELADA'
),

-- receita estimada do mês atual (baseada no mês do check-in previsto)
receita_mes_atual AS (
    SELECT COALESCE(SUM(
                            (r.data_checkout_previsto - r.data_checkin_previsto) * cat.preco_diaria
                    ), 0)::numeric(12,2) AS total
    FROM reserva r
             JOIN reserva_quarto rq ON rq.reserva_id = r.id
             JOIN quarto q ON q.id = rq.quarto_id
             JOIN categoria cat ON cat.id = q.categoria_id
    WHERE r.status_reserva <> 'CANCELADA'
      AND date_trunc('month', r.data_checkin_previsto) = date_trunc('month', current_date)
),

-- ocupação hoje: quartos ocupados / quartos totais * 100
-- "ocupados hoje" = quartos em hospedagens abertas
ocupacao_hoje AS (
    SELECT
        COALESCE(ROUND(
                         CASE
                             WHEN COUNT(q.id) = 0 THEN 0
                             ELSE (COUNT(DISTINCT hq.quarto_id)::numeric / COUNT(q.id)::numeric) * 100
                             END
                     , 1), 0)::numeric(5,1) AS taxa
    FROM quarto q
             LEFT JOIN hospedagem_quarto hq ON hq.quarto_id = q.id
             LEFT JOIN hospedagem h ON h.id = hq.hospedagem_id
        AND h.data_checkout_real IS NULL
        AND h.data_checkin_real::date <= current_date

    
),

-- taxa de cancelamento no mês: (quantidade de reservas canceladas / total de reservas cadastradas no mês) * 100
-- considera todas as reservas cujo check-in estava previsto para o mês atual
taxa_cancelamento_mes AS (
    SELECT COALESCE(ROUND(
        CASE WHEN COUNT(*) = 0 THEN 0
        ELSE (SUM(CASE WHEN status_reserva = 'CANCELADA' THEN 1 ELSE 0 END)::numeric / COUNT(*)::numeric) * 100
        END, 2), 0)::numeric(5,2) AS taxa
    FROM reserva
    WHERE date_trunc('month', data_checkin_previsto) = date_trunc('month', current_date)
),

-- média de permanência no mês: média matemática da diferença de dias entre o check-out e o check-in
-- filtra apenas as reservas não canceladas com check-in previsto para o mês atual
media_permanencia_mes AS (
    SELECT COALESCE(ROUND(
        AVG((data_checkout_previsto - data_checkin_previsto)::numeric), 1
    ), 0)::numeric(5,1) AS dias
    FROM reserva
    WHERE status_reserva <> 'CANCELADA'
      AND date_trunc('month', data_checkin_previsto) = date_trunc('month', current_date)
),

-- valor perdido por cancelamentos no mês: somatório da receita (noites * preço da diária) que deixou de entrar
-- considera exclusivamente as reservas com status 'CANCELADA' do mês atual.
valor_perdido_cancelamentos_mes AS (
    SELECT COALESCE(SUM(
        (r.data_checkout_previsto - r.data_checkin_previsto) * cat.preco_diaria
    ), 0)::numeric(12,2) AS total
    FROM reserva r
    JOIN reserva_quarto rq ON rq.reserva_id = r.id
    JOIN quarto q ON q.id = rq.quarto_id
    JOIN categoria cat ON cat.id = q.categoria_id
    WHERE r.status_reserva = 'CANCELADA'
      AND date_trunc('month', r.data_checkin_previsto) = date_trunc('month', current_date)
),

-- ticket médio por cliente no mês: receita total do mês dividida pela quantidade de clientes únicos (CPFs distintos)
-- conta apenas clientes com reservas válidas (não canceladas) no mês atual para saber quanto cada um gasta em média
ticket_medio_cliente_mes AS (
    SELECT COALESCE(ROUND(
        CASE WHEN COUNT(DISTINCT r.cliente_id) = 0 THEN 0
        ELSE SUM((r.data_checkout_previsto - r.data_checkin_previsto) * cat.preco_diaria) / COUNT(DISTINCT r.cliente_id)
        END, 2), 0)::numeric(12,2) AS valor
    FROM reserva r
    JOIN reserva_quarto rq ON rq.reserva_id = r.id
    JOIN quarto q ON q.id = rq.quarto_id
    JOIN categoria cat ON cat.id = q.categoria_id
    WHERE r.status_reserva <> 'CANCELADA'
      AND date_trunc('month', r.data_checkin_previsto) = date_trunc('month', current_date)
)

SELECT
    tr.total                   AS total_reservas,
    rah.total                  AS reservas_ativas_hoje,
    ret.total                  AS receita_estimada_total,
    rma.total                  AS receita_mes_atual,
    oh.taxa                    AS taxa_ocupacao_hoje,
    tcm.taxa                   AS taxa_cancelamento_mes_pct,
    mpm.dias                   AS media_permanencia_mes_dias,
    vpc.total                  AS valor_perdido_cancelamentos_mes,
    tmc.valor                  AS ticket_medio_cliente_mes
FROM total_reservas tr
         CROSS JOIN reservas_ativas_hoje rah
         CROSS JOIN receita_estimada_total ret
         CROSS JOIN receita_mes_atual rma
         CROSS JOIN ocupacao_hoje oh
         CROSS JOIN taxa_cancelamento_mes tcm
         CROSS JOIN media_permanencia_mes mpm
         CROSS JOIN valor_perdido_cancelamentos_mes vpc
         CROSS JOIN ticket_medio_cliente_mes tmc;