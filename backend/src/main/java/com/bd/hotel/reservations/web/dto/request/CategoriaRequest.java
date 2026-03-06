package com.bd.hotel.reservations.web.dto.request;

import jakarta.validation.constraints.*;
import java.math.BigDecimal;

public record CategoriaRequest(
        @NotBlank
        @Size(max = 30)
        String nome,

        @NotNull
        @DecimalMin(value = "0.00")
        BigDecimal precoDiaria,

        @NotNull
        @Min(1)
        Integer capacidade
) {}
