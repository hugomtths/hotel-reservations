package com.bd.hotel.reservations.web.dto.response;

import java.math.BigDecimal;

public record RelatorioResponse(
        Long totalReservas,
        Long reservasAtivasHoje,
        BigDecimal receitaEstimadaTotal,
        BigDecimal receitaMesAtual,
        BigDecimal taxaOcupacaoHoje
) {}