package com.bd.hotel.reservations.application.service;

import com.bd.hotel.reservations.persistence.entity.Funcionario;
import com.bd.hotel.reservations.persistence.entity.User;
import com.bd.hotel.reservations.persistence.repository.FuncionarioRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class FuncionarioService {
    private final FuncionarioRepository funcionarioRepository;

    public void criarPerfil(User user, String nome, String matricula) {
        Funcionario funcionario = Funcionario.builder()
                .user(user)
                .nome(nome)
                .matricula(matricula)
                .build();

        funcionarioRepository.save(funcionario);
    }
}