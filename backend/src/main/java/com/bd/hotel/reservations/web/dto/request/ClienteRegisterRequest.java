package com.bd.hotel.reservations.web.dto.request;

import jakarta.validation.constraints.*;
import java.time.LocalDate;

public record ClienteRegisterRequest(
        @NotBlank(message = "Email é obrigatório")
        @Email(message = "Email deve ser válido")
        String email,

        @NotBlank(message = "Senha é obrigatória")
        @Size(min = 6, message = "Senha deve ter no mínimo 6 caracteres")
        String password,

        @NotBlank(message = "Nome é obrigatório")
        String nome,

        @NotBlank(message = "CPF é obrigatório")
        String cpf,

        @NotBlank
        String telefone,

        @Past
        @NotNull
        LocalDate dataNascimento
) {}