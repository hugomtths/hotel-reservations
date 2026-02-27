package com.bd.hotel.reservations.application.service;

import com.bd.hotel.reservations.exception.business.EmailAlreadyRegisteredException;
import com.bd.hotel.reservations.persistence.entity.User;
import com.bd.hotel.reservations.persistence.enums.Role;
import com.bd.hotel.reservations.persistence.repository.UserRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class UserService {
    private final UserRepository userRepository;
    private final PasswordEncoder encoder;

    public User criarUsuario(String email, String senha, Role role) {

        if (userRepository.findByEmail(email).isPresent()) {
            throw new EmailAlreadyRegisteredException(email);
        }

        User user = User.builder()
                .email(email)
                .passwordHash(encoder.encode(senha))
                .role(role)
                .build();

        return userRepository.save(user);
    }
}