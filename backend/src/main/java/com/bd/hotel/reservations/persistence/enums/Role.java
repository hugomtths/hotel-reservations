package com.bd.hotel.reservations.persistence.enums;

import com.bd.hotel.reservations.exception.business.InvalidRoleException;
import com.fasterxml.jackson.annotation.JsonCreator;

public enum Role {
    GERENTE,
    ATENDENTE,
    CLIENTE;

    @JsonCreator
    public static Role from(String value) {
        if (value == null) {
            return null;
        }
        try {
            return Role.valueOf(value.toUpperCase());
        } catch (IllegalArgumentException ex) {
            throw new InvalidRoleException(value);
        }
    }

}