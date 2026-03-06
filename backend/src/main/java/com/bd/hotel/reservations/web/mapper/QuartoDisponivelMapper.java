package com.bd.hotel.reservations.web.mapper;

import com.bd.hotel.reservations.web.dto.request.QuartosDisponiveisViewRowDto;
import com.bd.hotel.reservations.web.dto.response.QuartoDisponivelResponse;
import org.springframework.stereotype.Component;

@Component
public class QuartoDisponivelMapper {

    private static final String DEFAULT_IMAGE =
            "https://images.unsplash.com/photo-1566665797739-1674de7a421a";

    public QuartoDisponivelResponse toResponse(
            QuartosDisponiveisViewRowDto row,
            String dataExibicao
    ) {
        if (row == null) return null;

        return new QuartoDisponivelResponse(
                row.quartoId(),
                row.numero(),
                row.tipo(),
                row.capacidade(),
                row.preco(),
                dataExibicao,
                DEFAULT_IMAGE
        );
    }
}