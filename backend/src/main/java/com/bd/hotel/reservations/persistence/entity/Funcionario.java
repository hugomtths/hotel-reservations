package com.bd.hotel.reservations.persistence.entity;

import jakarta.persistence.*;
import lombok.*;

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

    @Column(unique=true)
    private String matricula;
}