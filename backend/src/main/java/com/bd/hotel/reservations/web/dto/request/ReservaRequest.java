package com.bd.hotel.reservations.web.dto.request;

import jakarta.validation.constraints.*;
import java.time.LocalDate;
import java.util.Set;

public record ReservaRequest(
        Long clienteId,

        Long quartoId,

        @NotNull(message = "A data de check-in é obrigatória")
        @FutureOrPresent(message = "A data de check-in não pode ser no passado")
        LocalDate dataCheckinPrevisto,

        @NotNull(message = "A data de check-out é obrigatória")
        @FutureOrPresent(message = "A data de check-out não pode ser no passado")
        LocalDate dataCheckoutPrevisto,

        Set<Long> servicoIds
) {}