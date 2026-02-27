package com.bd.hotel.reservations.persistence.entity;

import jakarta.persistence.*;
import lombok.AccessLevel;
import lombok.Getter;
import lombok.NoArgsConstructor;

import java.io.Serializable;
import java.time.Instant;
import java.util.HashSet;
import java.util.Objects;
import java.util.Set;

@Entity
@Table(name = "hospedagem", uniqueConstraints = {
        @UniqueConstraint(name = "uk_hospedagem_reserva", columnNames = "reserva_id")
})
@Getter
class Hospedagem {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    // Pode ser null (walk-in)
    @OneToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "reserva_id", unique = true,
            foreignKey = @ForeignKey(name = "fk_hospedagem_reserva"))
    private Reserva reserva;

    @ManyToOne(optional = false, fetch = FetchType.LAZY)
    @JoinColumn(name = "cliente_id", nullable = false,
            foreignKey = @ForeignKey(name = "fk_hospedagem_cliente"))
    private Cliente cliente;

    @Column(name = "data_checkin_real", nullable = false)
    private Instant dataCheckinReal;

    @Column(name = "data_checkout_real")
    private Instant dataCheckoutReal;

    @ManyToMany
    @JoinTable(
            name = "hospedagem_quarto",
            joinColumns = @JoinColumn(name = "hospedagem_id"),
            inverseJoinColumns = @JoinColumn(name = "quarto_id")
    )
    private Set<Quarto> quartos = new HashSet<>();

    @OneToMany(mappedBy = "hospedagem", cascade = CascadeType.ALL, orphanRemoval = true)
    private Set<HospedagemServico> servicos = new HashSet<>();

    @PrePersist
    void prePersist() {
        if (dataCheckinReal == null) dataCheckinReal = Instant.now();
    }
}
