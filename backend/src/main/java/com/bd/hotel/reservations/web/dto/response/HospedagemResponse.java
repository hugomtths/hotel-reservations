package com.bd.hotel.reservations.web.dto.response;

import java.math.BigDecimal;
import java.util.List;

public record HospedagemResponse(
        Long id,
        Long reservaId,
        Long quartoId,
        String numeroQuarto,
        String categoriaQuarto,
        String nomeCliente,
        String cpfCliente,
        String emailCliente,
        String telefoneCliente,
        String dataCheckinReal, 
        String dataCheckoutReal, 
        List<PagamentoResponse> pagamentos
) {
    public record PagamentoResponse(
        Long id,
        String metodoPagamento,
        String statusPagamento,
        BigDecimal valorTotal
    ) {}
}