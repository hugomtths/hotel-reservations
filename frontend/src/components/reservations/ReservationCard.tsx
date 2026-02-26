import React from 'react';
import styles from './ReservationCard.module.css';

export interface ReservationCardProps {
  id: string;
  status: 'Ativa' | 'Concluída' | 'Cancelada';
  clientName: string;
  clientEmail: string;
  clientCpf: string;
  clientPhone: string;
  roomNumber: string;
  roomCategory: string;
  roomCapacity: string;
  pricePerNight: number;
  totalValue: number;
  stayDuration: string;
  startDate: string;
  endDate: string;
  onCancel?: (id: string) => void;
}

const ReservationCard: React.FC<ReservationCardProps> = ({
  id,
  status,
  clientName,
  clientEmail,
  clientCpf,
  clientPhone,
  roomNumber,
  roomCategory,
  roomCapacity,
  pricePerNight,
  totalValue,
  stayDuration,
  startDate,
  endDate,
  onCancel
}) => {
  
  const getStatusColor = () => {
    switch (status) {
      case 'Ativa': return styles.statusActive;
      case 'Concluída': return styles.statusCompleted;
      case 'Cancelada': return styles.statusCancelled;
      default: return '';
    }
  };

  const formatCurrency = (value: number) => {
    return new Intl.NumberFormat('pt-BR', {
      style: 'currency',
      currency: 'BRL'
    }).format(value);
  };

  return (
    <div className={styles.card}>
      
      {/* --- Header Row: Client Data + Status --- */}
      <div className={styles.headerRow}>
        <div className={styles.clientGrid}>
          <div style={{ gridColumn: '1 / -1' }}>
            <h3 className={styles.title}>Dados do Cliente</h3>
          </div>
          
          <div className={styles.infoBlock}>
            <span className={styles.label}>Nome</span>
            <span className={styles.value}>{clientName}</span>
          </div>
          
          <div className={styles.infoBlock}>
            <span className={styles.label}>CPF</span>
            <span className={styles.value}>{clientCpf}</span>
          </div>
          
          <div className={styles.infoBlock}>
            <span className={styles.label}>E-mail</span>
            <span className={styles.value}>{clientEmail}</span>
          </div>
          
          <div className={styles.infoBlock}>
            <span className={styles.label}>Telefone</span>
            <span className={styles.value}>{clientPhone}</span>
          </div>
        </div>

        <div className={styles.statusContainer}>
          <div className={styles.statusTitle}>Status</div>
          <div className={`${styles.statusValue} ${getStatusColor()}`}>
            {status}
          </div>
        </div>
      </div>

      {/* --- Middle Row: Room Info + Cost Info --- */}
      <div className={styles.middleRow}>
        
        {/* Room Info */}
        <div className={styles.roomSection}>
          <h3 className={styles.title}>Informações do Quarto</h3>
          <div className={styles.roomGrid}>
            <div className={styles.infoBlock}>
              <span className={styles.label}>Número</span>
              <span className={styles.value}>{roomNumber}</span>
            </div>
            
            <div className={styles.infoBlock}>
              <span className={styles.label}>Categoria</span>
              <span className={styles.value}>{roomCategory}</span>
            </div>
            
            <div className={styles.infoBlock} style={{ gridColumn: '1 / -1' }}>
              <span className={styles.label}>Capacidade</span>
              <span className={styles.value}>{roomCapacity}</span>
            </div>
          </div>
        </div>

        {/* Cost Info */}
        <div className={styles.costSection}>
          <h3 className={styles.title}>Informações de Custos</h3>
          <div className={styles.costGrid}>
            <div className={styles.infoBlock}>
              <span className={styles.label}>Per Noite</span>
              <span className={styles.value}>{formatCurrency(pricePerNight)}</span>
            </div>
            
            <div className={styles.infoBlock}>
              <span className={styles.label}>Valor Total</span>
              <span className={styles.value}>{formatCurrency(totalValue)}</span>
            </div>
          </div>
        </div>
      </div>

      {/* --- Bottom Row: Reservation Info + Cancel Button --- */}
      <div className={styles.bottomRow}>
        
        <div style={{ flex: 1 }}>
          <h3 className={styles.title}>Informações da Reserva</h3>
          <div className={styles.reservationGrid}>
            <div className={styles.infoBlock}>
              <span className={styles.label}>ID</span>
              <span className={styles.value}>{id}</span>
            </div>
            
            <div className={styles.infoBlock}>
              <span className={styles.label}>Tempo de Estadia</span>
              <span className={styles.value}>{stayDuration}</span>
            </div>
            
            <div className={styles.infoBlock}>
              <span className={styles.label}>Data de Início</span>
              <span className={styles.value}>{startDate}</span>
            </div>
            
            <div className={styles.infoBlock}>
              <span className={styles.label}>Data de Término</span>
              <span className={styles.value}>{endDate}</span>
            </div>
          </div>
        </div>

        {status === 'Ativa' && (
          <button 
            className={styles.cancelButton}
            onClick={() => onCancel && onCancel(id)}
          >
            Cancelar
          </button>
        )}
      </div>

    </div>
  );
};

export default ReservationCard;
