package com.bd.hotel.reservations.persistence.entity;


import jakarta.persistence.Column;
import jakarta.persistence.Embeddable;

import java.io.Serializable;
import java.util.Objects;

@Embeddable
class ReservaServicoId implements Serializable {
    @Column(name = "reserva_id")
    private Long reservaId;

    @Column(name = "servico_adicional_id")
    private Long servicoAdicionalId;

    public ReservaServicoId() {}
    public ReservaServicoId(Long reservaId, Long servicoAdicionalId) {
        this.reservaId = reservaId;
        this.servicoAdicionalId = servicoAdicionalId;
    }

    @Override public boolean equals(Object o) {
        if (this == o) return true;
        if (!(o instanceof ReservaServicoId that)) return false;
        return Objects.equals(reservaId, that.reservaId)
                && Objects.equals(servicoAdicionalId, that.servicoAdicionalId);
    }
    @Override public int hashCode() { return Objects.hash(reservaId, servicoAdicionalId); }
}
