package com.bd.hotel.reservations.web.dto.request;

import com.bd.hotel.reservations.persistence.enums.StatusQuarto;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Positive;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

import java.math.BigDecimal;
import java.util.Set;

@Getter
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class QuartoRequest {

    @NotNull(message = "O ID do hotel é obrigatório")
    private Long hotelId;

    @NotNull(message = "O ID da categoria é obrigatório")
    private Long categoriaId;

    @NotBlank(message = "O número do quarto é obrigatório")
    private String numero;

    private StatusQuarto status;

    @Positive(message = "A área deve ser maior que zero")
    private BigDecimal area;

    private Set<Long> comodidadeIds;
}