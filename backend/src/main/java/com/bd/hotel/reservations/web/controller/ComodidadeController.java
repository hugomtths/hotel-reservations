package com.bd.hotel.reservations.web.controller;

import com.bd.hotel.reservations.web.dto.request.ComodidadeRequest;
import com.bd.hotel.reservations.web.dto.response.ComodidadeResponse;
import com.bd.hotel.reservations.application.service.ComodidadeService;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/comodidades")
@RequiredArgsConstructor
public class ComodidadeController {

    private final ComodidadeService comodidadeService;

    @PostMapping
    public ResponseEntity<ComodidadeResponse> criar(@RequestBody @Valid ComodidadeRequest request) {
        ComodidadeResponse response = comodidadeService.criar(request);
        return ResponseEntity.status(HttpStatus.CREATED).body(response);
    }

    @GetMapping
    public ResponseEntity<List<ComodidadeResponse>> listarTodas() {
        return ResponseEntity.ok(comodidadeService.listarTodas());
    }

    @GetMapping("/{id}")
    public ResponseEntity<ComodidadeResponse> buscarPorId(@PathVariable Long id) {
        return ResponseEntity.ok(comodidadeService.buscarPorId(id));
    }

    @PutMapping("/{id}")
    public ResponseEntity<ComodidadeResponse> atualizar(@PathVariable Long id, @RequestBody @Valid ComodidadeRequest request) {
        return ResponseEntity.ok(comodidadeService.atualizar(id, request));
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deletar(@PathVariable Long id) {
        comodidadeService.deletar(id);
        return ResponseEntity.noContent().build();
    }
}