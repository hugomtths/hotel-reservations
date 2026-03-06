package com.bd.hotel.reservations.persistence.repository;

import com.bd.hotel.reservations.web.dto.request.QuartosDisponiveisViewRowDto;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.temporal.ChronoUnit;
import java.util.List;

@Repository
public class QuartosDisponiveisViewRepository {

    private final JdbcTemplate jdbcTemplate;

    public QuartosDisponiveisViewRepository(JdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
    }

    public List<QuartosDisponiveisViewRowDto> listarDisponiveis(
            LocalDate start,
            LocalDate endExclusive,
            Long hotelId
    ) {
        long nights = ChronoUnit.DAYS.between(start, endExclusive);

        if (nights <= 0) {
            return List.of();
        }

        return jdbcTemplate.query("""
            SELECT
              v.quarto_id      AS quartoId,
              v.numero         AS numero,
              v.categoria_nome AS tipo,
              v.capacidade     AS capacidade,
              v.preco_diaria   AS preco
            FROM vw_quartos_disponiveis_por_data v
            WHERE v.dia >= ? AND v.dia < ?
              AND (? IS NULL OR v.hotel_id = ?)
            GROUP BY v.quarto_id, v.numero, v.categoria_nome, v.capacidade, v.preco_diaria
            HAVING COUNT(*) = ?
            ORDER BY v.preco_diaria, v.numero
        """,
                (rs, rowNum) -> new QuartosDisponiveisViewRowDto(
                        rs.getLong("quartoId"),
                        rs.getString("numero"),
                        rs.getString("tipo"),
                        rs.getObject("capacidade", Integer.class),
                        rs.getObject("preco", BigDecimal.class)
                ),
                start,
                endExclusive,
                hotelId,
                hotelId,
                nights
        );
    }
}
