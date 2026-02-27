package com.bd.hotel.reservations.web.dto.response;

import lombok.Builder;
import lombok.Getter;

@Getter
@Builder
public class ClienteRegisterResponse {
    Long userId;
    Long clienteId;
    String email;
}
