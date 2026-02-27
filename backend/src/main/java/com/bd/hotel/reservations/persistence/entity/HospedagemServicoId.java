package com.bd.hotel.reservations.persistence.entity;

import jakarta.persistence.Column;
import jakarta.persistence.Embeddable;

import java.io.Serializable;
import java.time.Instant;
import java.util.Objects;

@Embeddable
public class HospedagemServicoId implements Serializable {
    @Column(name = "hospedagem_id")
    private Long hospedagemId;

    @Column(name = "servico_adicional_id")
    private Long servicoAdicionalId;

    @Column(name = "data_solicitacao")
    private Instant dataSolicitacao;

    public HospedagemServicoId() {}

    public HospedagemServicoId(Long hospedagemId, Long servicoAdicionalId, Instant dataSolicitacao) {
        this.hospedagemId = hospedagemId;
        this.servicoAdicionalId = servicoAdicionalId;
        this.dataSolicitacao = dataSolicitacao;
    }

    @Override public boolean equals(Object o) {
        if (this == o) return true;
        if (!(o instanceof HospedagemServicoId that)) return false;
        return Objects.equals(hospedagemId, that.hospedagemId)
                && Objects.equals(servicoAdicionalId, that.servicoAdicionalId)
                && Objects.equals(dataSolicitacao, that.dataSolicitacao);
    }

    @Override public int hashCode() {
        return Objects.hash(hospedagemId, servicoAdicionalId, dataSolicitacao);
    }
}
