package com.bd.hotel.reservations.web.mapper;

import com.bd.hotel.reservations.persistence.entity.Cliente;
import com.bd.hotel.reservations.persistence.entity.Hospedagem;
import com.bd.hotel.reservations.persistence.entity.Quarto;
import com.bd.hotel.reservations.web.dto.response.HospedagemResponse;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Component;

import java.time.Instant;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.time.format.DateTimeFormatter;
import java.util.List;
import java.util.stream.Collectors;

@Component
@RequiredArgsConstructor
public class HospedagemMapper {

    private static final DateTimeFormatter BR_DATE = DateTimeFormatter.ofPattern("dd/MM/yyyy");

    public HospedagemResponse toResponse(Hospedagem h, String emailCliente) {
        
        List<HospedagemResponse.PagamentoResponse> pagamentos = h.getPagamentos() == null ? List.of() : 
            h.getPagamentos().stream()
                .map(p -> new HospedagemResponse.PagamentoResponse(
                        p.getId(),
                        p.getMetodoPagamento() != null ? p.getMetodoPagamento().name() : "N/A",
                        p.getStatusPagamento() != null ? p.getStatusPagamento().name() : "N/A",
                        p.getValorTotal()
                )).collect(Collectors.toList());

        Cliente cliente = h.getCliente();
        Quarto quarto = h.getQuarto();
        
        Long reservaId = h.getReserva() != null ? h.getReserva().getId() : null;
        
        String nomeCliente = cliente != null ? cliente.getNome() : "Cliente não identificado";
        String cpfCliente = cliente != null ? formatCpf(cliente.getCpf()) : null;
        String telefoneCliente = cliente != null ? formatPhone(cliente.getTelefone()) : "Não informado";
        
        Long quartoId = quarto != null ? quarto.getId() : null;
        String numeroQuarto = quarto != null ? quarto.getNumero() : "N/A";
        String categoriaQuarto = (quarto != null && quarto.getCategoria() != null) ? quarto.getCategoria().getNome() : "Comum";

        return new HospedagemResponse(
                h.getId(),
                reservaId,
                quartoId,
                numeroQuarto,
                categoriaQuarto,
                nomeCliente,
                cpfCliente,
                emailCliente,
                telefoneCliente,
                formatInstant(h.getDataCheckinReal()),
                formatInstant(h.getDataCheckoutReal()),
                pagamentos
        );
    }

    private String formatCpf(String cpf) {
        if (cpf == null || cpf.isBlank()) return null;
        String s = cpf.replaceAll("\\D", ""); 
        if (s.length() != 11) return cpf;
        return s.replaceFirst("(\\d{3})(\\d{3})(\\d{3})(\\d{2})", "$1.$2.$3-$4");
    }

    private String formatPhone(String phone) {
        if (phone == null || phone.isBlank()) return "Não informado";
        String s = phone.replaceAll("\\D", "");
        if (s.length() == 11) return s.replaceFirst("(\\d{2})(\\d{5})(\\d{4})", "($1) $2-$3");
        if (s.length() == 10) return s.replaceFirst("(\\d{2})(\\d{4})(\\d{4})", "($1) $2-$3");
        return phone;
    }

    private String formatInstant(Instant instant) {
        if (instant == null) return "Em andamento"; 
        return LocalDateTime.ofInstant(instant, ZoneId.systemDefault()).format(BR_DATE);
    }
}