import React from 'react';
import styles from '../reservations/ReservationCard.module.css';

export interface HospedagemCardProps {
  id?: number;
  reservaId: number | null;
  quartoId: number;
  numeroQuarto?: string; 
  categoriaQuarto?: string; 
  nomeCliente?: string; 
  cpfCliente: string; 
  emailCliente?: string; 
  telefoneCliente?: string; 
  dataCheckinReal: string; 
  dataCheckoutReal: string; 
  status: string;
  valorTotal: number;
}

const HospedagemCard: React.FC<HospedagemCardProps> = (props) => {
  const {
    id, reservaId, quartoId, numeroQuarto, categoriaQuarto,
    nomeCliente, cpfCliente, emailCliente, telefoneCliente,
    dataCheckinReal, dataCheckoutReal, status, valorTotal
  } = props;

  const isWalkIn = reservaId === null;

  const formatCurrency = (value: number) => {
    return new Intl.NumberFormat('pt-BR', { style: 'currency', currency: 'BRL' }).format(value);
  };

  const getStatusColor = () => {
    switch (status) {
      case 'ATIVO': case 'CONCLUIDO': return styles.statusActive;
      case 'FINALIZADO': return styles.statusCompleted;
      case 'CANCELADO': return styles.statusCancelled;
      default: return styles.statusActive;
    }
  };

  return (
    <div className={styles.card}>
      {/* --- Dados do Cliente --- */}
      <div className={styles.headerRow}>
        <div className={styles.clientGrid}>
          <div style={{ gridColumn: '1 / -1' }}>
            <h3 className={styles.title}>Dados do Hóspede</h3>
          </div>
          <div className={styles.infoBlock}><span className={styles.label}>Nome</span><span className={styles.value}>{nomeCliente || 'N/A'}</span></div>
          <div className={styles.infoBlock}><span className={styles.label}>CPF</span><span className={styles.value}>{cpfCliente}</span></div>
          <div className={styles.infoBlock}><span className={styles.label}>E-mail</span><span className={styles.value}>{emailCliente || 'N/A'}</span></div>
          <div className={styles.infoBlock}><span className={styles.label}>Telefone</span><span className={styles.value}>{telefoneCliente || 'N/A'}</span></div>
        </div>

        <div className={styles.statusContainer}>
          <div className={styles.statusTitle}>Pagamento</div>
          <div className={`${styles.statusValue} ${getStatusColor()}`}>{status}</div>
        </div>
      </div>

      {/* --- Quarto e Custos (Check-in/Check-out junto com o Total) --- */}
      <div className={styles.middleRow}>
        <div className={styles.roomSection}>
          <h3 className={styles.title}>Informações do Quarto</h3>
          <div className={styles.roomGrid}>
            <div className={styles.infoBlock}><span className={styles.label}>Número</span><span className={styles.value}>{numeroQuarto || quartoId}</span></div>
            <div className={styles.infoBlock}><span className={styles.label}>Categoria</span><span className={styles.value}>{categoriaQuarto || 'Comum'}</span></div>
          </div>
        </div>

        <div className={styles.costSection}>
          <h3 className={styles.title}>Período e Valores</h3>
          <div className={styles.costGrid} style={{ gridTemplateColumns: 'repeat(3, 1fr)' }}>
            <div className={styles.infoBlock}><span className={styles.label}>Check-in</span><span className={styles.value}>{dataCheckinReal}</span></div>
            <div className={styles.infoBlock}><span className={styles.label}>Check-out</span><span className={styles.value}>{dataCheckoutReal}</span></div>
            <div className={styles.infoBlock}><span className={styles.label}>Total Pago</span><span className={styles.value}>{formatCurrency(valorTotal)}</span></div>
          </div>
        </div>
      </div>

      {/* --- Identificadores da Hospedagem --- */}
      <div className={styles.bottomRow}>
        <div style={{ flex: 1 }}>
          <h3 className={styles.title}>Identificação do Registro</h3>
          <div className={styles.reservationGrid}>
            <div className={styles.infoBlock}><span className={styles.label}>ID Hospedagem</span><span className={styles.value}>#{id || 'N/A'}</span></div>
            <div className={styles.infoBlock}><span className={styles.label}>Origem</span><span className={styles.value}>{isWalkIn ? 'Avulsa (Walk-in)' : `Reserva #${reservaId}`}</span></div>
          </div>
        </div>
      </div>
    </div>
  );
};

export default HospedagemCard;