package com.bd.hotel.reservations.exception.notfound;

import com.bd.hotel.reservations.exception.ApiException;
import org.springframework.http.HttpStatus;

public class QuartoNotFoundException extends ApiException {
    public QuartoNotFoundException(Long quartoId) {
        super(
                "QUARTO_NOT_FOUND",
                HttpStatus.NOT_FOUND,
                "Recurso não encontrado",
                "Quarto não encontrado com id: " + quartoId
        );
    }
}
