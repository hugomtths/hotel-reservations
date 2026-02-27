package com.bd.hotel.reservations.exception.business;

import com.bd.hotel.reservations.exception.ApiException;
import org.springframework.http.HttpStatus;

public class InvalidCredentialsException extends ApiException {
    public InvalidCredentialsException() {
        super(
                "INVALID_CREDENTIALS",
                HttpStatus.UNAUTHORIZED,
                "Credenciais inválidas",
                "Email ou senha incorretos."
        );
    }
}
