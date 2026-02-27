package com.bd.hotel.reservations.bootstrap;

import com.bd.hotel.reservations.application.service.ClienteService;
import com.bd.hotel.reservations.application.service.FuncionarioService;
import com.bd.hotel.reservations.application.service.UserService;
import com.bd.hotel.reservations.persistence.entity.User;
import com.bd.hotel.reservations.persistence.enums.Role;
import com.bd.hotel.reservations.persistence.repository.ClienteRepository;
import com.bd.hotel.reservations.persistence.repository.FuncionarioRepository;
import com.bd.hotel.reservations.persistence.repository.UserRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.context.annotation.Profile;
import org.springframework.core.annotation.Order;
import org.springframework.stereotype.Component;

import java.util.List;

@Component
@Order(10)
@Profile("dev")
@RequiredArgsConstructor
class UsersSeeder implements SeederInterface {

    private final UserRepository userRepository;
    private final FuncionarioRepository funcionarioRepository;
    private final ClienteRepository clienteRepository;

    private final UserService userService;
    private final FuncionarioService funcionarioService;
    private final ClienteService clienteService;

    @Override
    public void seed() {
        // 1) GERENTE (User + Funcionario)
        seedGerente("gerente@local.dev", "password", "Gerente Local", "MAT-0001");
        seedGerente("gerente2@local.dev", "password2", "Gerente Local 2", "MAT-0002");

        // 2) CLIENTES (User + Cliente)
        seedClientes(List.of(
                new SeedCliente("user1@local.dev", "password1", "Cliente 1", "11111111111", "81999990001"),
                new SeedCliente("user2@local.dev", "password2", "Cliente 2", "22222222222", "81999990002"),
                new SeedCliente("user3@local.dev", "password3", "Cliente 3", "33333333333", "81999990003")
        ));
    }

    private void seedGerente(String email, String rawPassword, String nome, String matricula) {
        if (userRepository.existsByEmail(email)) {
            return;
        }

        User user = userService.criarUsuario(email, rawPassword, Role.GERENTE);

        if (!funcionarioRepository.existsByUserId(user.getId())) {
            funcionarioService.criarPerfil(user, nome, matricula);
        }
    }

    private void seedClientes(List<SeedCliente> clientes) {
        for (SeedCliente seedCliente : clientes) {

            if (userRepository.existsByEmail(seedCliente.email()) || clienteRepository.existsByCpf(seedCliente.cpf())) {
                continue;
            }

            User user = userService.criarUsuario(seedCliente.email(), seedCliente.rawPassword(), Role.CLIENTE);

            clienteService.criarPerfil(
                    user,
                    seedCliente.nome(),
                    seedCliente.cpf(),
                    seedCliente.celular()
            );
        }
    }

    private record SeedCliente(
            String email,
            String rawPassword,
            String nome,
            String cpf,
            String celular
    ) {}
}
