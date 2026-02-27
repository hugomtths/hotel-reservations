package com.bd.hotel.reservations.exception.business;

import com.bd.hotel.reservations.exception.ApiException;
import org.springframework.http.HttpStatus;

public class CpfAlreadyRegisteredException extends ApiException {
    public CpfAlreadyRegisteredException(String cpf) {
        super(
                "CPF_ALREADY_REGISTERED",
                HttpStatus.CONFLICT,
                "Conflito de dados",
                "CPF já cadastrado: " + cpf
        );
    }
}
