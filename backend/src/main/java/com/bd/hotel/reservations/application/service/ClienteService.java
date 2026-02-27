package com.bd.hotel.reservations.application.service;

import com.bd.hotel.reservations.persistence.entity.Cliente;
import com.bd.hotel.reservations.persistence.entity.User;
import com.bd.hotel.reservations.persistence.repository.ClienteRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import java.time.LocalDate;

@Service
@RequiredArgsConstructor
public class ClienteService {
    private final ClienteRepository clienteRepo;

    public void criarPerfil(User user, String nome, String cpf, String telefone, LocalDate dataNascimento) {
        Cliente cliente = Cliente.builder()
                .user(user)
                .nome(nome)
                .cpf(cpf)
                .telefone(telefone)
                .dataNascimento(dataNascimento)
                .build();

        clienteRepo.save(cliente);
    }
}