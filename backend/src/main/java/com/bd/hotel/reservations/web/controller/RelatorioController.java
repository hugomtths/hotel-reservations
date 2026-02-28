package com.bd.hotel.reservations.web.controller;

import com.bd.hotel.reservations.application.service.RelatorioService;
import com.bd.hotel.reservations.web.dto.response.RelatorioResponse;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/relatorios")
@RequiredArgsConstructor
public class RelatorioController {

    private final RelatorioService relatorioService;

    @GetMapping("/reservas")
    public RelatorioResponse relatorioReservas(
            @RequestParam(required = false) Long hotelId
    ) {
        return relatorioService.obterRelatorio(hotelId);
    }
}