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

    public Quarto toEntity(QuartoRequest request, Hotel hotel, Categoria categoria, Set<Comodidade> comodidades) {
        if (request == null) {
            return null;
        }

        // Usando o Builder que você definiu na entidade Quarto
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

        CategoriaResponse categoriaResponse = null;
        if (quarto.getCategoria() != null) {
            Categoria categoria = quarto.getCategoria();
            categoriaResponse = new CategoriaResponse(
                    categoria.getId(),
                    categoria.getNome(),
                    categoria.getPrecoDiaria(),
                    categoria.getCapacidade()
            );
        }

        List<ComodidadeResponse> comodidadesResponse = quarto.getComodidades() == null
                ? List.of()
                : quarto.getComodidades().stream()
                .map(comodidade -> new ComodidadeResponse(
                        comodidade.getId(),
                        comodidade.getNome()
                ))
                .toList();

        return new QuartoResponse(
                quarto.getId(),
                quarto.getNumero(),
                quarto.getStatus(),
                quarto.getArea(),
                hotelId,
                categoriaResponse,
                comodidadesResponse
        );
    }
}