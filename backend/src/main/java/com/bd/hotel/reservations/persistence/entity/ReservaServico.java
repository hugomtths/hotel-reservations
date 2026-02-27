package com.bd.hotel.reservations.persistence.entity;

import jakarta.persistence.*;
import lombok.Getter;

@Getter
@Entity
@Table(name = "reserva_servico")
class ReservaServico {
    @EmbeddedId
    private ReservaServicoId id;

    @MapsId("reservaId")
    @ManyToOne(optional = false, fetch = FetchType.LAZY)
    @JoinColumn(name = "reserva_id", nullable = false)
    private Reserva reserva;

    @MapsId("servicoAdicionalId")
    @ManyToOne(optional = false, fetch = FetchType.LAZY)
    @JoinColumn(name = "servico_adicional_id", nullable = false)
    private ServicoAdicional servicoAdicional;

    @Column(nullable = false)
    private Long quantidade = 1L;
}
