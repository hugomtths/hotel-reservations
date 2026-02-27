package com.bd.hotel.reservations.persistence.repository;

import com.bd.hotel.reservations.persistence.entity.Cliente;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface ClienteRepository extends JpaRepository<Cliente, Long> {
    Optional<Cliente> findByUserId(Long userId);

    boolean existsByCpf(String cpf);
}
