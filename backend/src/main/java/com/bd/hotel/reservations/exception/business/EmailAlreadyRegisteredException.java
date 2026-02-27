package com.bd.hotel.reservations.exception.business;

import com.bd.hotel.reservations.exception.ApiException;
import org.springframework.http.HttpStatus;

public class EmailAlreadyRegisteredException extends ApiException {
    public EmailAlreadyRegisteredException(String email) {
        super("EMAIL_ALREADY_REGISTERED",
                HttpStatus.CONFLICT,
                "Conflito de dados",
                "Email já cadastrado: " + email);
    }
}
