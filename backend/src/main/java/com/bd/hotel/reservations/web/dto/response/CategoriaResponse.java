package com.bd.hotel.reservations.web.dto.response;

import lombok.Builder;
import lombok.Getter;

import java.math.BigDecimal;

@Builder
@Getter
public class CategoriaResponse {
    Long id;
    String nome;
    BigDecimal precoDiaria;
    Integer capacidade;
    String descricao;
}