package com.bd.hotel.reservations.persistence.entity;

import jakarta.persistence.*;
import lombok.AccessLevel;
import lombok.Getter;
import lombok.NoArgsConstructor;

import java.time.Instant;

@Entity
@Table(name = "hospedagem_servico")
@Getter
@NoArgsConstructor(access = AccessLevel.PROTECTED)
public class HospedagemServico {

    @EmbeddedId
    private HospedagemServicoId id;

    @MapsId("hospedagemId")
    @ManyToOne(optional = false, fetch = FetchType.LAZY)
    @JoinColumn(name = "hospedagem_id", nullable = false)
    private Hospedagem hospedagem;

    @MapsId("servicoAdicionalId")
    @ManyToOne(optional = false, fetch = FetchType.LAZY)
    @JoinColumn(name = "servico_adicional_id", nullable = false)
    private ServicoAdicional servicoAdicional;

    @Column(nullable = false)
    private Long quantidade = 1L;

    public HospedagemServico(Hospedagem hospedagem, ServicoAdicional servicoAdicional, Long quantidade) {
        this.hospedagem = hospedagem;
        this.servicoAdicional = servicoAdicional;
        this.quantidade = (quantidade == null ? 1L : quantidade);

        Instant now = Instant.now();
        this.id = new HospedagemServicoId(
                hospedagem.getId(),
                servicoAdicional.getId(),
                now
        );
    }
}