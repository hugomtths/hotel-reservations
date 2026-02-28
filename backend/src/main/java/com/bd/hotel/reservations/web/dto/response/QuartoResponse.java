package com.bd.hotel.reservations.web.dto.response;

import com.bd.hotel.reservations.persistence.enums.StatusQuarto;
import lombok.Builder;
import lombok.Getter;

import java.math.BigDecimal;

@Builder
@Getter
public class QuartoResponse {
    Long id;
    String numero;
    StatusQuarto status;
    BigDecimal area;
    Long hotelId;
    CategoriaResponse categoria;
}