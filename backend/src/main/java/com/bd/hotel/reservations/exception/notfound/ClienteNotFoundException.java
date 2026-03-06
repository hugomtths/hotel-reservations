package com.bd.hotel.reservations.exception.notfound;

import com.bd.hotel.reservations.exception.ApiException;
import org.springframework.http.HttpStatus;

public class ClienteNotFoundException extends ApiException {
    public ClienteNotFoundException(Long userId) {
        super(
                "CLIENTE_NOT_FOUND",
                HttpStatus.NOT_FOUND,
                "Recurso não encontrado",
                "Cliente não encontrado com id: " + userId
        );
    }

    public ClienteNotFoundException(String chave) {
        super(
                "CLIENTE_NOT_FOUND",
                HttpStatus.NOT_FOUND,
                "Recurso não encontrado",
                "Cliente não encontrado com email/cpf: " + chave
        );
    }
}
