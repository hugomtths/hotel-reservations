package com.bd.hotel.reservations.web.dto.request;

import com.bd.hotel.reservations.persistence.enums.StatusQuarto;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Positive;
import java.math.BigDecimal;
import java.util.Set;

public record QuartoRequest(
    @NotNull(message = "O ID do hotel é obrigatório")
    Long hotelId,

    @NotNull(message = "O ID da categoria é obrigatório")
    Long categoriaId,

    @NotBlank(message = "O número do quarto é obrigatório")
    String numero,

    StatusQuarto status,

    @Positive(message = "A área deve ser maior que zero")
    BigDecimal area,

    Set<Long> comodidadeIds
) {}