package com.bd.hotel.reservations.web.mapper;

import com.bd.hotel.reservations.persistence.entity.ServicoAdicional;
import com.bd.hotel.reservations.web.dto.request.ServicoAdicionalRequest;
import com.bd.hotel.reservations.web.dto.response.ServicoAdicionalResponse;
import org.springframework.stereotype.Component;

import java.util.List;

@Component
public class ServicoAdicionalMapper {

    public ServicoAdicional toEntity(ServicoAdicionalRequest request) {
        return ServicoAdicional.builder()
                .nomeServico(request.nomeServico())
                .descricao(request.descricao())
                .preco(request.preco())
                .build();
    }

    public ServicoAdicionalResponse toResponse(ServicoAdicional entity) {
        return new ServicoAdicionalResponse(
                entity.getId(),
                entity.getNomeServico(),
                entity.getDescricao(),
                entity.getPreco()
        );
    }

    public List<ServicoAdicionalResponse> toResponseList(List<ServicoAdicional> entities) {
        return entities.stream()
                .map(this::toResponse)
                .toList();
    }
}