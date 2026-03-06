package com.bd.hotel.reservations.web.mapper;

import com.bd.hotel.reservations.persistence.entity.Categoria;
import com.bd.hotel.reservations.persistence.entity.Comodidade;
import com.bd.hotel.reservations.persistence.entity.Hotel;
import com.bd.hotel.reservations.persistence.entity.Quarto;
import com.bd.hotel.reservations.persistence.enums.StatusQuarto;
import com.bd.hotel.reservations.web.dto.request.QuartoRequest;
import com.bd.hotel.reservations.web.dto.response.CategoriaResponse;
import com.bd.hotel.reservations.web.dto.response.ComodidadeResponse;
import com.bd.hotel.reservations.web.dto.response.QuartoResponse;
import org.springframework.stereotype.Component;

import java.util.Set;
import java.util.stream.Collectors;

@Component
public class QuartoMapper {

    public QuartoResponse toResponse(Quarto quarto) {

        Categoria cat = quarto.getCategoria();

        CategoriaResponse categoriaResponse = CategoriaResponse.builder()
                .id(cat.getId())
                .nome(cat.getNome())
                .precoDiaria(cat.getPrecoDiaria())
                .capacidade(cat.getCapacidade())
                .build();

        Set<ComodidadeResponse> comodidadesResponse = null;
        if (quarto.getComodidades() != null) {
            comodidadesResponse = quarto.getComodidades().stream()
                    .map(c -> ComodidadeResponse.builder()
                            .id(c.getId())
                            .nome(c.getNome())
                            .build())
                    .collect(Collectors.toSet());
        }

        return QuartoResponse.builder()
                .id(quarto.getId())
                .numero(quarto.getNumero())
                .status(quarto.getStatus())
                .area(quarto.getArea())
                .hotelId(quarto.getHotel().getId())
                .categoria(categoriaResponse)
                .comodidades(comodidadesResponse)
                .build();       
    }

    public Quarto toEntity(QuartoRequest request, Hotel hotel, Categoria categoria, Set<Comodidade> comodidades) {
        return Quarto.builder()
                .hotel(hotel)
                .categoria(categoria)
                .numero(request.getNumero())
                .status(request.getStatus() != null ? request.getStatus() : StatusQuarto.DISPONIVEL)
                .area(request.getArea())
                .comodidades(comodidades)
                .build();
    }
}