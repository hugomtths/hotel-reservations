package com.bd.hotel.reservations.web.mapper;

import com.bd.hotel.reservations.persistence.repository.RelatorioRowDto;
import com.bd.hotel.reservations.web.dto.response.RelatorioResponse;
import org.springframework.stereotype.Component;

@Component
public class RelatorioMapper {

    public RelatorioResponse toResponse(RelatorioRowDto row) {
        if (row == null) return null;
        return new RelatorioResponse(
                row.totalReservas(),
                row.reservasAtivasHoje(),
                row.receitaEstimadaTotal(),
                row.receitaMesAtual(),
                row.taxaOcupacaoHoje()
        );
    }
}