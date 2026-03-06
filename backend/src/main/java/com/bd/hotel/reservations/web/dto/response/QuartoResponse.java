package com.bd.hotel.reservations.web.dto.response;

import com.bd.hotel.reservations.persistence.enums.StatusQuarto;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

import java.math.BigDecimal;
import java.util.Set;

@Builder
@Getter
@AllArgsConstructor
@NoArgsConstructor
public class QuartoResponse {
    private Long id;
    private String numero;
    private StatusQuarto status;
    private BigDecimal area;
    private Long hotelId;
    private CategoriaResponse categoria;
    private Set<ComodidadeResponse> comodidades;
}