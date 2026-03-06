package com.bd.hotel.reservations.persistence.repository;

import com.bd.hotel.reservations.persistence.entity.Quarto;
import com.bd.hotel.reservations.persistence.enums.StatusQuarto;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface QuartoRepository extends JpaRepository<Quarto, Long> {

    List<Quarto> findByStatus(StatusQuarto status);

    List<Quarto> findByNumero(String numero);
}