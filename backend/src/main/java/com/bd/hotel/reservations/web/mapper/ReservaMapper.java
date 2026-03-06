package com.bd.hotel.reservations.web.mapper;

import com.bd.hotel.reservations.persistence.entity.Quarto;
import com.bd.hotel.reservations.persistence.entity.Reserva;
import com.bd.hotel.reservations.web.dto.request.ReservaRequest;
import com.bd.hotel.reservations.web.dto.response.ReservaResponse;
import org.springframework.stereotype.Component;

import java.util.Set;
import java.util.stream.Collectors;

@Component
public class ReservaMapper {

    public ReservaResponse toResponse(Reserva reserva) {

        Set<Long> quartoIds = reserva.getQuartos()
                .stream()
                .map(Quarto::getId)
                .collect(Collectors.toSet());

        return new ReservaResponse(
                reserva.getId(),
                reserva.getCliente().getId(),
                reserva.getDataCheckinPrevisto(),
                reserva.getDataCheckoutPrevisto(),
                quartoIds,
                Set.of()
        );
    }
}