package com.bd.hotel.reservations.web.mapper;

import com.bd.hotel.reservations.persistence.entity.Cliente;
import com.bd.hotel.reservations.persistence.entity.User;
import com.bd.hotel.reservations.web.dto.request.ClienteRegisterRequest;
import com.bd.hotel.reservations.web.dto.response.ClienteResponse;
import org.springframework.stereotype.Component;
import java.util.List;

@Component
public class ClienteMapper {

    public Cliente toEntity(ClienteRegisterRequest request, User user) {
        return Cliente.builder()
                .user(user)
                .nome(request.nome())
                .cpf(request.cpf())
                .telefone(request.telefone())
                .dataNascimento(request.dataNascimento())
                .build();
    }

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