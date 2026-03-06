package com.bd.hotel.reservations.web.dto.response;

import java.math.BigDecimal;

public record CategoriaResponse(
        Long id,
        String nome,
        BigDecimal precoDiaria,
        Integer capacidade
) {}
