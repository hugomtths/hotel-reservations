package com.bd.hotel.reservations.exception.notfound;

import com.bd.hotel.reservations.exception.ApiException;
import org.springframework.http.HttpStatus;

public class ReservaNotFoundException extends ApiException {
    public ReservaNotFoundException(Long reservaId) {
        super(
                "RESERVA_NOT_FOUND",
                HttpStatus.NOT_FOUND,
                "Recurso não encontrado",
                "Reserva não encontrada com id: " + reservaId
        );
    }
}
