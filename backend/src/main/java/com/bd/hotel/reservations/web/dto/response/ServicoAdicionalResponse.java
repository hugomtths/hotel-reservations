package com.bd.hotel.reservations.web.dto.response;

import java.math.BigDecimal;

public record ServicoAdicionalResponse(
    Long id,
    String nomeServico,
    String descricao,
    BigDecimal preco
) {}