package com.bd.hotel.reservations.persistence.repository;

import java.math.BigDecimal;

public record RelatorioRowDto(
        Long totalReservas,
        Long reservasAtivasHoje,
        BigDecimal receitaEstimadaTotal,
        BigDecimal receitaMesAtual,
        BigDecimal taxaOcupacaoHoje
) {}