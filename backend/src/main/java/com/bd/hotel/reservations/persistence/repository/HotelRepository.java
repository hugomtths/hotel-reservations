package com.bd.hotel.reservations.persistence.repository;

import com.bd.hotel.reservations.persistence.entity.Hotel;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface HotelRepository extends JpaRepository<Hotel, Long> {
}