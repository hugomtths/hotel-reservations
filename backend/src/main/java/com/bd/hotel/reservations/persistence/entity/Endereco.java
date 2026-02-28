package com.bd.hotel.reservations.persistence.entity;

import jakarta.persistence.*;

@Entity
@Table(name = "endereco")
class Endereco {
    @Id
    @Column(name = "hotelId")
    private Long hotelId;

    @MapsId
    @OneToOne(optional = false, fetch = FetchType.LAZY)
    @JoinColumn(name = "hotelId", foreignKey = @ForeignKey(name = "fk_endereco_hotel"))
    private Hotel hotel;

    @Column(length = 10)
    private String cep;

    @Column(length = 150)
    private String rua;

    @Column(length = 20)
    private String numero;

    @Column(length = 100)
    private String bairro;

    @Column(length = 100)
    private String cidade;

    @Column(length = 2)
    private String estado;
}