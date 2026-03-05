package com.bd.hotel.reservations.web.mapper;

import com.bd.hotel.reservations.persistence.repository.ReservasDetalhadasViewRowDto;
import com.bd.hotel.reservations.web.dto.response.ReservasDetalhadasResponse;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Component;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.time.temporal.ChronoUnit;

@Component
@RequiredArgsConstructor
public class ReservaDetalhadaMapper {

    private final ObjectMapper objectMapper;

    private static final DateTimeFormatter BR_DATE = DateTimeFormatter.ofPattern("dd/MM/yyyy");

    public ReservasDetalhadasResponse toResponse(ReservasDetalhadasViewRowDto row, String clientEmail) {
        LocalDate start = row.dataCheckinPrevisto();
        LocalDate end = row.dataCheckoutPrevisto();

        long nights = 0;
        if (start != null && end != null) {
            nights = ChronoUnit.DAYS.between(start, end);
            if (nights < 0) nights = 0;
        }

        JsonNode quartos = safeReadArray(row.quartos());
        JsonNode servicos = safeReadArray(row.servicos());

        BigDecimal totalValue = calcularTotal(quartos, servicos, nights);

        String paddedId = padId(row.reservaId());              // <-- evita ternário aninhado em IDEs
        String mappedStatus = mapStatus(row.statusReserva());  // <-- idem

        return new ReservasDetalhadasResponse(
                paddedId,
                mappedStatus,
                row.clienteNome(),
                clientEmail,
                formatCpf(row.clienteCpf()),
                formatPhone(row.clienteTelefone()),
                extrairRoomId(quartos),
                extrairRoomNumber(quartos),
                extrairRoomCategory(quartos),
                extrairRoomCapacity(quartos),
                extrairPricePerNight(quartos),
                totalValue,
                nights + " Noites",
                formatDate(start),
                formatDate(end)
        );
    }

    private JsonNode safeReadArray(String json) {
        if (json == null || json.isBlank()) return objectMapper.createArrayNode();
        try {
            JsonNode node = objectMapper.readTree(json);
            return (node != null && node.isArray()) ? node : objectMapper.createArrayNode();
        } catch (Exception e) {
            return objectMapper.createArrayNode();
        }
    }

    private BigDecimal calcularTotal(JsonNode quartos, JsonNode servicos, long nights) {
        BigDecimal totalDiarias = BigDecimal.ZERO;
        if (quartos != null && quartos.isArray()) {
            for (JsonNode q : quartos) {
                BigDecimal preco = asBigDecimalOrZero(q.get("preco_diaria"));
                totalDiarias = totalDiarias.add(preco.multiply(BigDecimal.valueOf(nights)));
            }
        }

        BigDecimal totalServicos = BigDecimal.ZERO;
        if (servicos != null && servicos.isArray()) {
            for (JsonNode s : servicos) {
                BigDecimal preco = asBigDecimalOrZero(s.get("preco"));
                long qtd = asLongOrZero(s.get("quantidade"));
                totalServicos = totalServicos.add(preco.multiply(BigDecimal.valueOf(qtd)));
            }
        }

        return totalDiarias.add(totalServicos);
    }

    private String extrairRoomNumber(JsonNode quartos) {
        if (quartos == null || !quartos.isArray() || quartos.isEmpty()) return null;
        JsonNode n = quartos.get(0).get("numero");
        return (n == null || n.isNull()) ? null : n.asText();
    }

    private Long extrairRoomId(JsonNode quartos) {
        if (quartos == null || !quartos.isArray() || quartos.isEmpty()) return null;
        JsonNode n = quartos.get(0).get("quarto_id");
        return (n == null || n.isNull()) ? null : n.asLong();
    }

    private String extrairRoomCategory(JsonNode quartos) {
        if (quartos == null || !quartos.isArray() || quartos.isEmpty()) return null;
        JsonNode n = quartos.get(0).get("categoria_nome");
        return (n == null || n.isNull()) ? null : n.asText();
    }

    private Integer extrairRoomCapacity(JsonNode quartos) {
        if (quartos == null || !quartos.isArray() || quartos.isEmpty()) return null;
        JsonNode n = quartos.get(0).get("capacidade");
        return (n == null || n.isNull()) ? null : n.asInt();
    }

    private BigDecimal extrairPricePerNight(JsonNode quartos) {
        if (quartos == null || !quartos.isArray() || quartos.isEmpty()) return null;
        return asBigDecimalOrZero(quartos.get(0).get("preco_diaria"));
    }

    private BigDecimal asBigDecimalOrZero(JsonNode node) {
        if (node == null || node.isNull()) return BigDecimal.ZERO;
        try {
            return new BigDecimal(node.asText());
        } catch (Exception e) {
            return BigDecimal.ZERO;
        }
    }

    private long asLongOrZero(JsonNode node) {
        if (node == null || node.isNull()) return 0L;
        return node.asLong(0L);
    }

    private String padId(Long id) {
        if (id == null) return null;
        return String.format("%06d", id);
    }

    private String mapStatus(String status) {
        if (status == null) return null;
        return switch (status) {
            case "PENDENTE", "CONFIRMADA" -> "Ativa";
            case "CONCLUIDA" -> "Concluída";
            case "CANCELADA" -> "Cancelada";
            default -> status;
        };
    }

    private String formatCpf(String cpf) {
        if (cpf == null) return null;
        String s = cpf.replaceAll("\\D", "");
        if (s.length() != 11) return cpf;
        return s.substring(0, 3) + "." + s.substring(3, 6) + "." + s.substring(6, 9) + "-" + s.substring(9, 11);
    }

    private String formatPhone(String phone) {
        return phone;
    }

    private String formatDate(LocalDate d) {
        return d == null ? null : d.format(BR_DATE);
    }
}