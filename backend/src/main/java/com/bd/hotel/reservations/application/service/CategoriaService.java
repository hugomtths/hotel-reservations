package com.bd.hotel.reservations.application.service;

import com.bd.hotel.reservations.exception.notfound.CategoriaNotFoundException;
import com.bd.hotel.reservations.persistence.entity.Categoria;
import com.bd.hotel.reservations.persistence.repository.CategoriaRepository;
import com.bd.hotel.reservations.web.dto.request.CategoriaRequest;
import com.bd.hotel.reservations.web.dto.response.CategoriaResponse;
import com.bd.hotel.reservations.web.mapper.CategoriaMapper;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@RequiredArgsConstructor
public class CategoriaService {

    private final CategoriaRepository categoriaRepository;
    private final CategoriaMapper categoriaMapper;

    @Transactional
    public CategoriaResponse criar(CategoriaRequest request) {
        Categoria categoria = categoriaMapper.toEntity(request);
        Categoria salva = categoriaRepository.save(categoria);
        return categoriaMapper.toResponse(salva);
    }

    @Transactional(readOnly = true)
    public List<CategoriaResponse> listarTodas() {
        List<Categoria> categorias = categoriaRepository.findAll();
        return categoriaMapper.toResponseList(categorias);
    }

    @Transactional(readOnly = true)
    public CategoriaResponse buscarPorId(Long id) {
        Categoria categoria = buscarEntidadePorId(id);
        return categoriaMapper.toResponse(categoria);
    }

    public Categoria buscarEntidadePorId(Long id) {
        return categoriaRepository.findById(id)
                .orElseThrow(() -> new CategoriaNotFoundException(id));
    }

    @Transactional
    public CategoriaResponse atualizar(Long id, CategoriaRequest request) {
        Categoria categoria = buscarEntidadePorId(id);

        categoria.atualizar(request.precoDiaria(), request.nome(), request.capacidade());

        Categoria salva = categoriaRepository.save(categoria);
        return categoriaMapper.toResponse(salva);
    }

    @Transactional
    public void deletar(Long id) {
        Categoria categoria =  buscarEntidadePorId(id);
        categoriaRepository.delete(categoria);
    }
}