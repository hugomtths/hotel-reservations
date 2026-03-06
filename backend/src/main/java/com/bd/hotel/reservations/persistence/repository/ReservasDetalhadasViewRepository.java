package com.bd.hotel.reservations.persistence.repository;

import com.bd.hotel.reservations.web.dto.request.ReservasDetalhadasViewRowDto;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;
import java.time.LocalDate;
import java.time.OffsetDateTime;
import java.util.List;

@Repository
public class ReservasDetalhadasViewRepository {

    private final JdbcTemplate jdbc;

    public ReservasDetalhadasViewRepository(JdbcTemplate jdbc) {
        this.jdbc = jdbc;
    }

    public List<ReservasDetalhadasViewRowDto> listarTudo() {
        return jdbc.query("""
            SELECT
              reserva_id              AS reservaId,
              data_reserva            AS dataReserva,
              data_checkin_previsto   AS dataCheckinPrevisto,
              data_checkout_previsto  AS dataCheckoutPrevisto,
              status_reserva          AS statusReserva,
              cliente_id              AS clienteId,
              cliente_nome            AS clienteNome,
              cliente_cpf             AS clienteCpf,
              cliente_telefone        AS clienteTelefone,
              qtd_quartos             AS qtdQuartos,
              quartos::text           AS quartos,
              servicos::text          AS servicos
            FROM vw_reservas_detalhadas
            ORDER BY reserva_id
        """, (rs, i) -> new ReservasDetalhadasViewRowDto(
                rs.getLong("reservaId"),
                rs.getObject("dataReserva", OffsetDateTime.class),
                rs.getObject("dataCheckinPrevisto", LocalDate.class),
                rs.getObject("dataCheckoutPrevisto", LocalDate.class),
                rs.getString("statusReserva"),
                rs.getLong("clienteId"),
                rs.getString("clienteNome"),
                rs.getString("clienteCpf"),
                rs.getString("clienteTelefone"),
                rs.getLong("qtdQuartos"),
                rs.getString("quartos"),
                rs.getString("servicos")
        ));
    }
}