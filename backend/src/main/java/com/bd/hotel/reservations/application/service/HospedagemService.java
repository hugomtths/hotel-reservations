package com.bd.hotel.reservations.application.service;

import com.bd.hotel.reservations.persistence.entity.Cliente;
import com.bd.hotel.reservations.persistence.entity.Hospedagem;
import com.bd.hotel.reservations.persistence.entity.HospedagemServico;
import com.bd.hotel.reservations.persistence.entity.Pagamento;
import com.bd.hotel.reservations.persistence.entity.Reserva;
import com.bd.hotel.reservations.persistence.entity.ServicoAdicional;
import com.bd.hotel.reservations.persistence.repository.HospedagemRepository;
import com.bd.hotel.reservations.persistence.repository.ServicoAdicionalRepository;
import com.bd.hotel.reservations.web.dto.request.HospedagemRequest;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.Instant;
import java.util.List;

@Service
@RequiredArgsConstructor
public class HospedagemService {

    private final HospedagemRepository hospedagemRepository;
    private final ReservaService reservaService;
    private final ClienteService clienteService;
    private final ServicoAdicionalRepository servicoAdicionalRepository;

    @Transactional
    public Hospedagem salvarHospedagem(HospedagemRequest request) {
        Reserva reserva = reservaService.buscarEntidadePorId(request.reservaId());
        Cliente cliente = clienteService.buscarEntidadePorCpf(request.cpfCliente());

        Hospedagem hospedagem = criarHospedagem(reserva, cliente);

        Pagamento pagamento = criarPagamento(hospedagem, request);
        hospedagem.getPagamentos().add(pagamento);

        adicionarServicos(hospedagem, request.servicosAdicionaisIds());

        reserva.setHospedagem(hospedagem);

        return hospedagemRepository.save(hospedagem);
    }

    private Hospedagem criarHospedagem(Reserva reserva, Cliente cliente) {
        Hospedagem hospedagem = new Hospedagem();
        hospedagem.setReserva(reserva);
        hospedagem.setCliente(cliente);
        hospedagem.setQuarto(reserva.getQuarto());
        hospedagem.setDataCheckinReal(Instant.now());
        return hospedagem;
    }

    private Pagamento criarPagamento(Hospedagem hospedagem, HospedagemRequest request) {
        Pagamento pagamento = new Pagamento();
        pagamento.setHospedagem(hospedagem);
        pagamento.setReserva(null);
        pagamento.setValorTotal(request.pagamento().valorTotal());
        pagamento.setMetodoPagamento(request.pagamento().metodoPagamento());
        pagamento.setStatusPagamento(request.pagamento().statusPagamento());
        pagamento.setDataPagamento(Instant.now());
        return pagamento;
    }

    private void adicionarServicos(Hospedagem hospedagem, List<Long> servicosAdicionaisIds) {
        if (servicosAdicionaisIds == null || servicosAdicionaisIds.isEmpty()) {
            return;
        }

        List<ServicoAdicional> servicosAdicionais =
                servicoAdicionalRepository.findAllById(servicosAdicionaisIds);

        for (ServicoAdicional servicoAdicional : servicosAdicionais) {
            HospedagemServico hospedagemServico =
                    new HospedagemServico(hospedagem, servicoAdicional, 1L);

            hospedagem.getServicos().add(hospedagemServico);
        }
    }
}