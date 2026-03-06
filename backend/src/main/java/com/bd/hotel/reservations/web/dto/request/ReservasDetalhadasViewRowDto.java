package com.bd.hotel.reservations.web.dto.request;

import java.time.LocalDate;
import java.time.OffsetDateTime;

public record ReservasDetalhadasViewRowDto(
        Long reservaId,
        OffsetDateTime dataReserva,
        LocalDate dataCheckinPrevisto,
        LocalDate dataCheckoutPrevisto,
        String statusReserva,
        Long clienteId,
        String clienteNome,
        String clienteCpf,
        String clienteTelefone,
        Long qtdQuartos,
        String quartos,
        String servicos
) {}