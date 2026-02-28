package com.bd.hotel.reservations.persistence.entity;


import com.bd.hotel.reservations.persistence.enums.StatusQuarto;
import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

import java.math.BigDecimal;
import java.util.HashSet;
import java.util.Set;

@Entity
@Table(name = "quarto")
@Builder
@Getter
@NoArgsConstructor
@AllArgsConstructor
public class Quarto {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne(optional = false, fetch = FetchType.LAZY)
    @JoinColumn(name = "hotelId", nullable = false)
    private Hotel hotel;

    @ManyToOne(optional = false, fetch = FetchType.LAZY)
    @JoinColumn(name = "categoria_id", nullable = false)
    private Categoria categoria;

    @Column(nullable = false, length = 10)
    private String numero;

    @Enumerated(EnumType.STRING)
    @Column(nullable = false, length = 20)
    private StatusQuarto status = StatusQuarto.DISPONIVEL;

    @Column(precision = 10, scale = 2)
    private BigDecimal area;

    @ManyToMany
    @JoinTable(
            name = "quarto_comodidade",
            joinColumns = @JoinColumn(name = "quarto_id"),
            inverseJoinColumns = @JoinColumn(name = "comodidade_id")
    )
    private Set<Comodidade> comodidades = new HashSet<>();
}