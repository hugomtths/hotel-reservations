package com.bd.hotel.reservations.web.dto.response;

public record LoginResponse(
        String accessToken,
        String tokenType,
        long expiresIn
) {}