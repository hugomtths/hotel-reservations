package com.bd.hotel.reservations.web.dto.response;

import java.math.BigDecimal;

public record FuncionarioResponse(
    Long id,
    Long userId,
    String nome,
    String cpf,
    String email,
    String cargo,
    BigDecimal salario,
    String hotelNome
) {}
