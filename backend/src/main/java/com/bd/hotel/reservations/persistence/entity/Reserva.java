package com.bd.hotel.reservations.persistence.entity;

import com.bd.hotel.reservations.persistence.enums.StatusReserva;
import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;

import java.io.Serializable;
import java.time.Instant;
import java.time.LocalDate;
import java.util.HashSet;
import java.util.Objects;
import java.util.Set;

@Entity
@Table(name = "reserva")
@Getter
@NoArgsConstructor
@AllArgsConstructor
class Reserva {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne(optional = false, fetch = FetchType.LAZY)
    @JoinColumn(name = "cliente_id", nullable = false,
            foreignKey = @ForeignKey(name = "fk_reserva_cliente"))
    private Cliente cliente;

    @Column(name = "data_reserva", nullable = false)
    private Instant dataReserva;

    @Column(name = "data_checkin_previsto", nullable = false)
    private LocalDate dataCheckinPrevisto;

    @Column(name = "data_checkout_previsto", nullable = false)
    private LocalDate dataCheckoutPrevisto;

    @Enumerated(EnumType.STRING)
    @Column(name = "status_reserva", nullable = false, length = 20)
    private StatusReserva statusReserva = StatusReserva.PENDENTE;

    @ManyToMany
    @JoinTable(
            name = "reserva_quarto",
            joinColumns = @JoinColumn(name = "reserva_id"),
            inverseJoinColumns = @JoinColumn(name = "quarto_id")
    )
    private Set<Quarto> quartos = new HashSet<>();

    @OneToMany(mappedBy = "reserva", cascade = CascadeType.ALL, orphanRemoval = true)
    private Set<ReservaServico> servicos = new HashSet<>();

    @PrePersist
    void prePersist() {
        if (dataReserva == null) dataReserva = Instant.now();
    }
}
