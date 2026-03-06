package com.bd.hotel.reservations.web.mapper;

import com.bd.hotel.reservations.persistence.entity.Categoria;
import com.bd.hotel.reservations.web.dto.request.CategoriaRequest;
import com.bd.hotel.reservations.web.dto.response.CategoriaResponse;
import org.springframework.stereotype.Component;

import java.util.List;

@Component
public class CategoriaMapper {

    public Categoria toEntity(CategoriaRequest request) {
        return Categoria.builder()
                .precoDiaria(request.precoDiaria())
                .nome(request.nome())
                .capacidade(request.capacidade())
                .build();
    }

    public CategoriaResponse toResponse(Categoria entity) {
        return new CategoriaResponse(
                entity.getId(),
                entity.getNome(),
                entity.getPrecoDiaria(),
                entity.getCapacidade()
        );
    }

    public List<CategoriaResponse> toResponseList(List<Categoria> entities) {
        return entities.stream()
                .map(this::toResponse)
                .toList();
    }
}