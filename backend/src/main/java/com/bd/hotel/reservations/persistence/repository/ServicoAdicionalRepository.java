package com.bd.hotel.reservations.persistence.repository;

import com.bd.hotel.reservations.persistence.entity.ServicoAdicional;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface ServicoAdicionalRepository extends JpaRepository<ServicoAdicional, Long> {
}