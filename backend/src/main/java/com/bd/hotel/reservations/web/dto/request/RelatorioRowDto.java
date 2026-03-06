package com.bd.hotel.reservations.web.dto.request;

import java.math.BigDecimal;

public record RelatorioRowDto(
        Long totalReservas,
        Long reservasAtivasHoje,
        BigDecimal receitaEstimadaTotal,
        BigDecimal receitaMesAtual,
        BigDecimal taxaOcupacaoHoje,
        BigDecimal taxaCancelamentoMesPct,
        BigDecimal mediaPermanenciaMesDias,
        BigDecimal valorPerdidoCancelamentosMes,
        BigDecimal ticketMedioClienteMes
) {}