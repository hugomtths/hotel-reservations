package com.bd.hotel.reservations.persistence.entity;


import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

import java.math.BigDecimal;

@Entity
@Table(name = "servico_adicional")
@Builder
@Getter
@AllArgsConstructor
@NoArgsConstructor
class ServicoAdicional {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "nome_servico", nullable = false, length = 100)
    private String nomeServico;

    @Lob
    private String descricao;

    @Column(nullable = false, precision = 10, scale = 2)
    private BigDecimal preco;

}
