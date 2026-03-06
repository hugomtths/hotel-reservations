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
public class ServicoAdicional {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "nome_servico", nullable = false, length = 100)
    private String nomeServico;

    @Column(columnDefinition = "text")
    private String descricao;

    @Column(nullable = false, precision = 10, scale = 2)
    private BigDecimal preco;

    public void atualizar(String nomeServico, String descricao, BigDecimal preco) {
        this.nomeServico = nomeServico;
        this.descricao = descricao;
        this.preco = preco;
    }
}