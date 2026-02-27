package com.bd.hotel.reservations.persistence.repository;

import com.bd.hotel.reservations.persistence.entity.Funcionario;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;

public interface FuncionarioRepository extends JpaRepository<Funcionario, Long> {
    Optional<Funcionario> findByUserId(Long userId);
}
