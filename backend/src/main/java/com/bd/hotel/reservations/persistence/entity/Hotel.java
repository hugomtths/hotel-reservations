package com.bd.hotel.reservations.persistence.entity;


import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

import java.util.HashSet;
import java.util.Set;

@Entity
@Table(name = "hotel")
@Builder
@Getter
@NoArgsConstructor
@AllArgsConstructor
public class Hotel {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = false, length = 255)
    private String nome;

    @Column(nullable = false, length = 14)
    private String cnpj;

    @OneToOne(mappedBy = "hotel", cascade = CascadeType.ALL, orphanRemoval = true)
    private Endereco endereco;

    @ElementCollection
    @CollectionTable(name = "email_hotel",
            joinColumns = @JoinColumn(name = "hotelId", foreignKey = @ForeignKey(name = "fk_email_hotel_hotel")))
    @Column(name = "email", nullable = false, length = 150)
    private Set<String> emails = new HashSet<>();

    @ElementCollection
    @CollectionTable(name = "telefone_hotel",
            joinColumns = @JoinColumn(name = "hotelId", foreignKey = @ForeignKey(name = "fk_telefone_hotel_hotel")))
    @Column(name = "telefone", nullable = false, length = 20)
    private Set<String> telefones = new HashSet<>();

}