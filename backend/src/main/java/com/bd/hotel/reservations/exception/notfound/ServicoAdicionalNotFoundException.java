package com.bd.hotel.reservations.exception.notfound;

public class ServicoAdicionalNotFoundException extends RuntimeException {
    public ServicoAdicionalNotFoundException(Long id) {
        super("Serviço adicional não encontrado com id: " + id);
    }
}