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

import java.util.HashSet;
import java.util.List;
import java.util.Set;

@Component
public class QuartoMapper {

    public Quarto toEntity(
            QuartoRequest request,
            Hotel hotel,
            Categoria categoria,
            Set<Comodidade> comodidades
    ) {
        return Quarto.builder()
                .hotel(hotel)
                .categoria(categoria)
                .numero(request.numero())
                .area(request.area())
                .status(request.status() != null ? request.status() : StatusQuarto.DISPONIVEL)
                .comodidades(comodidades != null ? comodidades : new HashSet<>())
                .build();
    }

    public QuartoResponse toResponse(Quarto quarto) {
        Long hotelId = quarto.getHotel() != null ? quarto.getHotel().getId() : null;

        return new QuartoResponse(
                quarto.getId(),
                quarto.getNumero(),
                quarto.getStatus(),
                quarto.getArea(),
                hotelId,
                toCategoriaResponse(quarto.getCategoria()),
                toComodidadeResponseList(quarto.getComodidades())
        );
    }

    public List<QuartoResponse> toResponseList(List<Quarto> quartos) {
        return quartos.stream()
                .map(this::toResponse)
                .toList();
    }

    private CategoriaResponse toCategoriaResponse(Categoria categoria) {
        if (categoria == null) {
            return null;
        }

        return new CategoriaResponse(
                categoria.getId(),
                categoria.getNome(),
                categoria.getPrecoDiaria(),
                categoria.getCapacidade()
        );
    }

    private List<ComodidadeResponse> toComodidadeResponseList(Set<Comodidade> comodidades) {
        if (comodidades == null || comodidades.isEmpty()) {
            return List.of();
        }

        return comodidades.stream()
                .map(this::toComodidadeResponse)
                .toList();
    }

    private ComodidadeResponse toComodidadeResponse(Comodidade comodidade) {
        return new ComodidadeResponse(
                comodidade.getId(),
                comodidade.getNome()
        );
    }
}