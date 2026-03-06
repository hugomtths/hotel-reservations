package com.bd.hotel.reservations.web.mapper;

import com.bd.hotel.reservations.persistence.entity.Comodidade;
import com.bd.hotel.reservations.web.dto.request.ComodidadeRequest;
import com.bd.hotel.reservations.web.dto.response.ComodidadeResponse;

import java.util.List;

import org.springframework.stereotype.Component;

@Component
public class ComodidadeMapper {

    public Comodidade toEntity(ComodidadeRequest request) {
        return Comodidade.builder()
                .nome(request.nome())
                .build();
    }

    public ComodidadeResponse toResponse(Comodidade entity) {
        return new ComodidadeResponse(
                entity.getId(),
                entity.getNome()
        );
    }

    public List<ComodidadeResponse> toResponseList(List<Comodidade> entities) {
        return entities.stream()
                .map(this::toResponse)
                .toList();
    }
}