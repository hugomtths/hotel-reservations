package com.bd.hotel.reservations.exception.business;

import com.bd.hotel.reservations.exception.ApiException;
import org.springframework.http.HttpStatus;

public class InvalidDateException extends ApiException {
    public InvalidDateException(String message) {
        super(
                "INVALID_DATE",
                HttpStatus.BAD_REQUEST,
                "Data inválida",
                message
        );
    }
}
