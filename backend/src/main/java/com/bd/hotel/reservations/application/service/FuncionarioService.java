package com.bd.hotel.reservations.application.service;

import com.bd.hotel.reservations.persistence.entity.Funcionario;
import com.bd.hotel.reservations.persistence.entity.User;
import com.bd.hotel.reservations.persistence.enums.CargoFuncionario;
import com.bd.hotel.reservations.persistence.repository.FuncionarioRepository;
import com.bd.hotel.reservations.persistence.entity.Hotel;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import java.math.BigDecimal;

@Service
@RequiredArgsConstructor
public class FuncionarioService {
    private final FuncionarioRepository funcionarioRepository;

    public void criarPerfil(User user, String nome, String cpf, Hotel hotel, CargoFuncionario cargo, BigDecimal salario) {
        Funcionario funcionario = Funcionario.builder()
                .user(user)
                .nome(nome)
                .cpf(cpf)
                .hotel(hotel)
                .cargo(cargo)
                .salario(salario)
                .build();

        funcionarioRepository.save(funcionario);
    }
}