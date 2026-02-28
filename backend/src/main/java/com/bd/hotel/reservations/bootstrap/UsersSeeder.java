package com.bd.hotel.reservations.bootstrap;

import com.bd.hotel.reservations.application.service.ClienteService;
import com.bd.hotel.reservations.application.service.FuncionarioService;
import com.bd.hotel.reservations.application.service.UserService;
import com.bd.hotel.reservations.exception.notfound.HotelNotFoundException;
import com.bd.hotel.reservations.persistence.entity.Hotel;
import com.bd.hotel.reservations.persistence.entity.User;
import com.bd.hotel.reservations.persistence.enums.CargoFuncionario;
import com.bd.hotel.reservations.persistence.enums.Role;
import com.bd.hotel.reservations.persistence.repository.ClienteRepository;
import com.bd.hotel.reservations.persistence.repository.FuncionarioRepository;
import com.bd.hotel.reservations.persistence.repository.HotelRepository;
import com.bd.hotel.reservations.persistence.repository.UserRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Value;
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

    @Value("${app.seed.hotel-id:0}")
    private Long hotelId;

    @Override
    public void seed() {
        Hotel hotel = resolveHotel();

        // 1) FUNCIONARIOS (User(role=FUNCIONARIO) + Funcionario(cargo=GERENTE))
        seedFuncionario(hotel, "funcionario@local.dev", "password", "Funcionario Local", "00000000000");
        seedFuncionario(hotel, "funcionario2@local.dev", "password2", "Funcionario Local 2", "00000000001");

        // 2) CLIENTES (User(role=CLIENTE) + Cliente)
        seedClientes(List.of(
                new SeedCliente("user1@local.dev", "password1", "Cliente 1", "11111111111", "81999990001", LocalDate.of(1998, 1, 10)),
                new SeedCliente("user2@local.dev", "password2", "Cliente 2", "22222222222", "81999990002", LocalDate.of(2000, 5, 21)),
                new SeedCliente("user3@local.dev", "password3", "Cliente 3", "33333333333", "81999990003", LocalDate.of(1995, 9, 3))
        ));
    }

    private Hotel resolveHotel() {
        if (hotelId != null && hotelId > 0) {
            return hotelRepository.findById(hotelId)
                    .orElseThrow(() -> new HotelNotFoundException(hotelId));
        }

        return hotelRepository.findAll().stream()
                .findFirst()
                .orElseThrow(() -> new IllegalStateException("Nenhum hotel cadastrado."));
    }

    private void seedFuncionario(Hotel hotel, String email, String rawPassword, String nome, String cpf) {
        String normalizedEmail = email.trim().toLowerCase();

        if (userRepository.existsByEmail(normalizedEmail)) {
            return;
        }

        User user = userService.criarUsuario(normalizedEmail, rawPassword, Role.FUNCIONARIO);

        if (funcionarioRepository.existsByUserId(user.getId())) {
            return;
        }

        funcionarioService.criarPerfil(
                user,
                nome,
                hotel,
                CargoFuncionario.GERENTE,
                BigDecimal.ZERO,
                cpf
        );
    }

    private void seedClientes(List<SeedCliente> clientes) {
        for (SeedCliente sc : clientes) {
            String normalizedEmail = sc.email().trim().toLowerCase();

            if (userRepository.existsByEmail(normalizedEmail) || clienteRepository.existsByCpf(sc.cpf())) {
                continue;
            }

            User user = userService.criarUsuario(normalizedEmail, sc.rawPassword(), Role.CLIENTE);

            clienteService.criarPerfil(
                    user,
                    sc.nome(),
                    sc.cpf(),
                    sc.telefone(),
                    sc.dataNascimento()
            );
        }
    }

    private record SeedCliente(
            String email,
            String rawPassword,
            String nome,
            String cpf,
            String telefone,
            LocalDate dataNascimento
    ) {}
}