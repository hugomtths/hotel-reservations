package com.bd.hotel.reservations.persistence.entity;

import com.bd.hotel.reservations.persistence.enums.CargoFuncionario;
import com.bd.hotel.reservations.persistence.enums.MetodoPagamento;
import jakarta.persistence.*;
import lombok.*;

import java.math.BigDecimal;

@Entity
@Table(name="funcionario")
@Getter
@Builder
@NoArgsConstructor(access = AccessLevel.PROTECTED)
@AllArgsConstructor(access = AccessLevel.PRIVATE)
public class Funcionario {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @OneToOne(optional=false)
    @JoinColumn(name="usuario_id", nullable=false, unique=true)
    private User user;

    @Column(nullable=false)
    private String nome;

    @ManyToOne(optional = false, fetch = FetchType.LAZY)
    @JoinColumn(name = "hotel_id", nullable = false,
            foreignKey = @ForeignKey(name = "fk_funcionario_hotel"))
    private Hotel hotel;

    @Enumerated(EnumType.STRING)
    @Column(nullable = false, length = 30)
    private CargoFuncionario cargo;

    @Column(precision = 10, scale = 2)
    private BigDecimal salario;
}