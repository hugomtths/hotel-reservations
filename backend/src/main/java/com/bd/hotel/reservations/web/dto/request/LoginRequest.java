package com.bd.hotel.reservations.web.dto.request;

import jakarta.validation.constraints.*;

public record LoginRequest(
        @Email(message = "Email deve ser válido")
        @NotBlank(message = "Email é obrigatório")
        String email,

        @NotBlank(message = "Senha é obrigatória")
        String password
) {}
