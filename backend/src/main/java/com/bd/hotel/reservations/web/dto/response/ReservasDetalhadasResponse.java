package com.bd.hotel.reservations.web.dto.response;

import java.math.BigDecimal;
import java.util.List;

public record ReservasDetalhadasResponse(
        String id,
        String status,
        String clientName,
        String clientEmail,
        String clientCpf,
        String clientPhone,
        Long roomId,
        String roomNumber,
        String roomCategory,
        Integer roomCapacity,
        BigDecimal pricePerNight,
        BigDecimal totalValue,
        String stayDuration,
        String startDate,
        String endDate,
        List<Long> servicosAdicionaisIds
) {}