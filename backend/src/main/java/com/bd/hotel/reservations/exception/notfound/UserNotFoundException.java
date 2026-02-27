package com.bd.hotel.reservations.exception.notfound;

import com.bd.hotel.reservations.exception.ApiException;
import org.springframework.http.HttpStatus;

public class UserNotFoundException extends ApiException {
    public UserNotFoundException(Long id) {
        super(
                "USER_NOT_FOUND",
                HttpStatus.NOT_FOUND,
                "Recurso não encontrado",
                "User não encontrado com id: " + id
        );
    }
}
