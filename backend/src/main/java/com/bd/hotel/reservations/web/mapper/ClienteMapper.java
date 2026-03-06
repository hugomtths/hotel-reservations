package com.bd.hotel.reservations.web.mapper;

import com.bd.hotel.reservations.persistence.entity.Cliente;
import com.bd.hotel.reservations.web.dto.response.ClienteResponse;
import org.springframework.stereotype.Component;

import java.util.List;

@Component
public class ClienteMapper {

    public ClienteResponse toResponse(Cliente cliente) {
        return new ClienteResponse(
                cliente.getId(),
                cliente.getUser().getId(),
                cliente.getNome(),
                cliente.getCpf(),
                cliente.getTelefone(),
                cliente.getDataNascimento(),
                cliente.getUser().getEmail()
        );
    }

    public List<ClienteResponse> toResponseList(List<Cliente> clientes) {
        return clientes.stream()
                .map(this::toResponse)
                .toList();
    }
}