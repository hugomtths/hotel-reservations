package com.bd.hotel.reservations.persistence.entity;

import com.bd.hotel.reservations.persistence.enums.MetodoPagamento;
import com.bd.hotel.reservations.persistence.enums.StatusPagamento;
import jakarta.persistence.*;

import java.math.BigDecimal;
import java.time.Instant;

@Entity
@Table(name = "pagamento")
class Pagamento {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @OneToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "reserva_id", unique = true)
    private Reserva reserva;

    @OneToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "hospedagem_id", unique = true)
    private Hospedagem hospedagem;

    @Column(name = "valor_total", nullable = false, precision = 10, scale = 2)
    private BigDecimal valorTotal;

    @Column(name = "data_pagamento", nullable = false)
    private Instant dataPagamento;

    @Enumerated(EnumType.STRING)
    @Column(name = "metodo_pagamento", nullable = false, length = 50)
    private MetodoPagamento metodoPagamento;

    @Enumerated(EnumType.STRING)
    @Column(name = "status_pagamento", nullable = false, length = 20)
    private StatusPagamento statusPagamento = StatusPagamento.PENDENTE;

    @PrePersist
    void prePersist() {
        if (dataPagamento == null) dataPagamento = Instant.now();
    }
}