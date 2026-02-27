package com.bd.hotel.reservations.application.service;

import com.bd.hotel.reservations.persistence.entity.Cliente;
import com.bd.hotel.reservations.persistence.entity.User;
import com.bd.hotel.reservations.persistence.repository.ClienteRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class ClienteService {
    private final ClienteRepository clienteRepo;

    public Cliente criarPerfil(User user, String nome, String cpf, String celular) {
        Cliente cliente = Cliente.builder()
                .user(user)
                .nome(nome)
                .cpf(cpf)
                .celular(celular)
                .build();

        return clienteRepo.save(cliente);
    }
}