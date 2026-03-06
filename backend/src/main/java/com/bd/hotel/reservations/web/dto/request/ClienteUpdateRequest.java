package com.bd.hotel.reservations.web.dto.request;

import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Past;
import java.time.LocalDate;

public record ClienteUpdateRequest(
    @NotBlank(message = "O nome é obrigatório")
    String nome,

    @NotBlank(message = "O telefone é obrigatório")
    String telefone,

    @Past
    @NotNull(message = "A data de nascimento é obrigatória")
    LocalDate dataNascimento,

    @NotBlank(message = "O CPF é obrigatório")
    String cpf,

    @NotBlank(message = "O e-mail é obrigatório")
    @Email(message = "E-mail inválido")
    String email
) {}
