package com.bd.hotel.reservations.bootstrap;

import com.bd.hotel.reservations.application.service.ClienteService;
import com.bd.hotel.reservations.application.service.FuncionarioService;
import com.bd.hotel.reservations.application.service.UserService;
import com.bd.hotel.reservations.persistence.entity.Hotel;
import com.bd.hotel.reservations.persistence.entity.User;
import com.bd.hotel.reservations.persistence.enums.CargoFuncionario;
import com.bd.hotel.reservations.persistence.enums.Role;
import com.bd.hotel.reservations.persistence.repository.ClienteRepository;
import com.bd.hotel.reservations.persistence.repository.FuncionarioRepository;
import com.bd.hotel.reservations.persistence.repository.HotelRepository;
import com.bd.hotel.reservations.persistence.repository.UserRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.context.annotation.Profile;
import org.springframework.core.annotation.Order;
import org.springframework.stereotype.Component;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.util.List;

@Component
@Order(10)
@Profile("dev")
@RequiredArgsConstructor
class UsersSeeder implements SeederInterface {

    private final UserRepository userRepository;
    private final FuncionarioRepository funcionarioRepository;
    private final ClienteRepository clienteRepository;
    private final HotelRepository hotelRepository;

    private final UserService userService;
    private final FuncionarioService funcionarioService;
    private final ClienteService clienteService;

    @Override
    public void seed() {
        seedGerente("gerente@local.dev", "password", "Gerente Local", "00011122233");
    seedGerente("gerente2@local.dev", "password2", "Gerente Local 2", "44455566677");

        seedClientes(List.of(
                new SeedCliente("user1@local.dev", "password1", "Cliente 1", "11111111111", "81999990001", LocalDate.of(1990, 1, 1)),
                new SeedCliente("user2@local.dev", "password2", "Cliente 2", "22222222222", "81999990002", LocalDate.of(1995, 5, 15)),
                new SeedCliente("user3@local.dev", "password3", "Cliente 3", "33333333333", "81999990003", LocalDate.of(1988, 12, 30))
        ));
    }

    private void seedGerente(String email, String rawPassword, String nome, String cpf) {
        if (userRepository.existsByEmail(email)) {
            return;
        }

        User user = userService.criarUsuario(email, rawPassword, Role.GERENTE);

        if (!funcionarioRepository.existsByUserId(user.getId())) {
    
            Hotel hotel = hotelRepository.findById(1L)
                    .orElseThrow(() -> new IllegalStateException("Cadastre um Hotel antes de rodar o UsersSeeder!"));

            funcionarioService.criarPerfil(user, nome, cpf, hotel, CargoFuncionario.GERENTE, new BigDecimal("4500.00"));
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
                    seedCliente.celular(),
                    seedCliente.dataNascimento()
            );
        }
    }

    private record SeedCliente(
            String email,
            String rawPassword,
            String nome,
            String cpf,
            String celular,
            LocalDate dataNascimento
    ) {}
}