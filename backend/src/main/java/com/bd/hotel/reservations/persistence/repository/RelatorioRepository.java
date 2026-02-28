package com.bd.hotel.reservations.persistence.repository;

import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

@Repository
public class RelatorioRepository {

    private final JdbcTemplate jdbc;

    public RelatorioRepository(JdbcTemplate jdbc) {
        this.jdbc = jdbc;
    }

    public RelatorioRowDto obterRelatorio(Long hotelId) {

        return jdbc.queryForObject("""
            WITH
            total_reservas AS (
                SELECT COUNT(*)::bigint AS total
                FROM reserva r
                WHERE r.status_reserva <> 'CANCELADA'
            ),
            reservas_ativas_hoje AS (
                SELECT COUNT(*)::bigint AS total
                FROM hospedagem h
                -- se quiser filtrar por hotel, precisa passar por hospedagem_quarto -> quarto
                WHERE h.data_checkout_real IS NULL
                  AND h.data_checkin_real::date <= current_date
                  AND (
                      ? IS NULL OR EXISTS (
                          SELECT 1
                          FROM hospedagem_quarto hq
                          JOIN quarto q ON q.id = hq.quarto_id
                          WHERE hq.hospedagem_id = h.id
                            AND q.hotel_id = ?
                      )
                  )
            ),
            receita_estimada_total AS (
                SELECT COALESCE(SUM(
                    (r.data_checkout_previsto - r.data_checkin_previsto) * cat.preco_diaria
                ), 0)::numeric(12,2) AS total
                FROM reserva r
                JOIN reserva_quarto rq ON rq.reserva_id = r.id
                JOIN quarto q ON q.id = rq.quarto_id
                JOIN categoria cat ON cat.id = q.categoria_id
                WHERE r.status_reserva <> 'CANCELADA'
                  AND (? IS NULL OR q.hotel_id = ?)
            ),
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
                  AND (? IS NULL OR q.hotel_id = ?)
            ),
            ocupacao_hoje AS (
                SELECT
                    COALESCE(ROUND(
                        CASE
                            WHEN COUNT(q.id) = 0 THEN 0
                            ELSE (
                                COUNT(DISTINCT hq.quarto_id)::numeric
                                / COUNT(q.id)::numeric
                            ) * 100
                        END
                    , 1), 0)::numeric(5,1) AS taxa
                FROM quarto q
                LEFT JOIN hospedagem_quarto hq ON hq.quarto_id = q.id
                LEFT JOIN hospedagem h ON h.id = hq.hospedagem_id
                    AND h.data_checkout_real IS NULL
                    AND h.data_checkin_real::date <= current_date
                WHERE (? IS NULL OR q.hotel_id = ?)
            )
            SELECT
              tr.total  AS totalReservas,
              rah.total AS reservasAtivasHoje,
              ret.total AS receitaEstimadaTotal,
              rma.total AS receitaMesAtual,
              oh.taxa   AS taxaOcupacaoHoje
            FROM total_reservas tr
            CROSS JOIN reservas_ativas_hoje rah
            CROSS JOIN receita_estimada_total ret
            CROSS JOIN receita_mes_atual rma
            CROSS JOIN ocupacao_hoje oh
        """,
                (rs, i) -> new RelatorioRowDto(
                        rs.getLong("totalReservas"),
                        rs.getLong("reservasAtivasHoje"),
                        rs.getBigDecimal("receitaEstimadaTotal"),
                        rs.getBigDecimal("receitaMesAtual"),
                        rs.getBigDecimal("taxaOcupacaoHoje")
                ),
                hotelId, hotelId,
                hotelId, hotelId,
                hotelId, hotelId,
                hotelId, hotelId
        );
    }
}