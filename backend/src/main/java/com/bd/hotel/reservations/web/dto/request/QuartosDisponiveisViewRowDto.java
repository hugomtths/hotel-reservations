package com.bd.hotel.reservations.web.dto.request;

import java.math.BigDecimal;

public record QuartosDisponiveisViewRowDto(
        Long quartoId,
        String numero,
        String tipo,
        Integer capacidade,
        BigDecimal preco
) {}