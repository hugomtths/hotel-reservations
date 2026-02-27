package com.bd.hotel.reservations.bootstrap;

import com.bd.hotel.reservations.application.service.FuncionarioService;
import com.bd.hotel.reservations.application.service.UserService;
import com.bd.hotel.reservations.exception.business.EmailAlreadyRegisteredException;
import com.bd.hotel.reservations.persistence.entity.User;
import com.bd.hotel.reservations.persistence.enums.Role;
import com.bd.hotel.reservations.persistence.repository.FuncionarioRepository;
import com.bd.hotel.reservations.persistence.repository.UserRepository;
import jakarta.transaction.Transactional;
import lombok.RequiredArgsConstructor;
import org.jspecify.annotations.NonNull;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.ApplicationArguments;
import org.springframework.boot.ApplicationRunner;
import org.springframework.context.annotation.Profile;
import org.springframework.stereotype.Component;

@Component
@Profile("prod")
@RequiredArgsConstructor
public class ProdGerenteSeeder implements ApplicationRunner {

    private final UserRepository userRepository;
    private final FuncionarioRepository funcionarioRepository;

    private final UserService userService;
    private final FuncionarioService funcionarioService;

    @Value("${app.bootstrap-gerente.enabled:false}")
    private boolean enabled;

    @Value("${app.bootstrap-gerente.email:gerente@prod.dev}")
    private String email;

    @Value("${app.bootstrap-gerente.password:password}")
    private String password;

    @Value("${app.bootstrap-gerente.nome:Gerente}")
    private String nome;

    @Value("${app.bootstrap-gerente.matricula:GER-0001}")
    private String matricula;

    @Override
    @Transactional
    public void run(@NonNull ApplicationArguments args) {
        if (!enabled) return;

        if (email == null || email.isBlank() || password == null || password.isBlank()) {
            throw new IllegalStateException("Bootstrap gerente enabled, but email/password not provided");
        }

        if (userRepository.existsByRole(Role.GERENTE)) return;

        if (userRepository.existsByEmail(email)) {
            throw new EmailAlreadyRegisteredException(email);
        }

        User user = userService.criarUsuario(email, password, Role.GERENTE);

        if (funcionarioRepository.existsByUserId(user.getId())) return;

        funcionarioService.criarPerfil(user, nome, matricula);
    }
}
