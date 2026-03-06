package com.bd.hotel.reservations.web.dto.response;

import java.time.LocalDate;

public record ClienteResponse(
    Long id,
    Long userId,
    String nome,
    String cpf,
    String telefone,
    LocalDate dataNascimento,
    String email
) {}
