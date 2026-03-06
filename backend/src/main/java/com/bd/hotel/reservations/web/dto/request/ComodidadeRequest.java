package com.bd.hotel.reservations.web.dto.request;

import jakarta.validation.constraints.NotBlank;

public record ComodidadeRequest(
    @NotBlank(message = "O nome da comodidade é obrigatório")
    String nome
) {}