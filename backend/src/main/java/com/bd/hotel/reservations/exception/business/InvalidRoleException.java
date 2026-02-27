package com.bd.hotel.reservations.exception.business;

import com.bd.hotel.reservations.exception.ApiException;
import org.springframework.http.HttpStatus;

public class InvalidRoleException extends ApiException {
    public InvalidRoleException(String role) {
        super(
                "INVALID_ROLE",
                HttpStatus.UNAUTHORIZED,
                "Role inválida",
                "Role: " + role
        );
    }
}
