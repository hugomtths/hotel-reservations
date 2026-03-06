package com.bd.hotel.reservations.web.mapper;

import com.bd.hotel.reservations.persistence.entity.Categoria;
import com.bd.hotel.reservations.persistence.entity.Quarto;
import com.bd.hotel.reservations.persistence.enums.StatusQuarto;
import com.bd.hotel.reservations.web.dto.request.QuartoRequest;
import com.bd.hotel.reservations.web.dto.response.CategoriaResponse;
import com.bd.hotel.reservations.web.dto.response.ComodidadeResponse;
import com.bd.hotel.reservations.web.dto.response.QuartoResponse;
import org.springframework.stereotype.Component;
import java.util.List;

@Component
public class QuartoMapper {

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

        List<ComodidadeResponse> comodidades = quarto.getComodidades() == null
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
                comodidades
        );
    }
}