package com.bd.hotel.reservations.application.service;

import com.bd.hotel.reservations.exception.notfound.ComodidadeNotFoundException;
import com.bd.hotel.reservations.persistence.entity.Comodidade;
import com.bd.hotel.reservations.persistence.repository.ComodidadeRepository;
import com.bd.hotel.reservations.web.dto.request.ComodidadeRequest;
import com.bd.hotel.reservations.web.dto.response.ComodidadeResponse;
import com.bd.hotel.reservations.web.mapper.ComodidadeMapper;
import lombok.RequiredArgsConstructor;
import java.util.List;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@RequiredArgsConstructor
public class ComodidadeService {

    private final ComodidadeRepository comodidadeRepository;
    private final ComodidadeMapper comodidadeMapper;

    @Transactional
    public ComodidadeResponse criar(ComodidadeRequest request) {
        Comodidade comodidade = comodidadeMapper.toEntity(request);
        Comodidade salva = comodidadeRepository.save(comodidade);
        return comodidadeMapper.toResponse(salva);
    }

    @Transactional(readOnly = true)
    public List<ComodidadeResponse> listarTodas() {
        List<Comodidade> comodidades = comodidadeRepository.findAll();
        return comodidadeMapper.toResponseList(comodidades);
    }

    @Transactional(readOnly = true)
    public ComodidadeResponse buscarPorId(Long id) {
        Comodidade comodidade = buscarEntidadePorId(id);
        return comodidadeMapper.toResponse(comodidade);
    }

    public Comodidade buscarEntidadePorId(Long id) {
        return comodidadeRepository.findById(id)
                .orElseThrow(() -> new ComodidadeNotFoundException(id));
    }

    @Transactional
    public ComodidadeResponse atualizar(Long id, ComodidadeRequest request) {
        Comodidade comodidade = buscarEntidadePorId(id);

        comodidade.atualizarNome(request.nome());

        Comodidade salva = comodidadeRepository.save(comodidade);
        return comodidadeMapper.toResponse(salva);
    }

    @Transactional
    public void deletar(Long id) {
        Comodidade comodidade = buscarEntidadePorId(id);
        comodidadeRepository.delete(comodidade);
    }
}