import React from 'react';
import Swal from 'sweetalert2';
import styles from './ReservationCard.module.css';

export interface ReservationCardProps {
  id: string;
  status: 'Ativa' | 'Concluída' | 'Cancelada' | 'PENDENTE' | 'CONFIRMADA' | 'CONCLUIDA' | 'CANCELADA';
  clientName: string;
  clientEmail: string;
  clientCpf: string;
  clientPhone: string;
  roomNumber: string;
  roomCategory: string;
  roomCapacity: string | number;
  pricePerNight: number;
  totalValue: number;
  stayDuration: string;
  startDate: string;
  endDate: string;
  roomId?: number;
  servicosAdicionaisIds?: number[];
  onCancel?: (id: string) => void;
  onCheckIn?: (data: any) => void;
}

const ReservationCard: React.FC<ReservationCardProps> = (props) => {
  const {
    id, status, clientName, clientEmail, clientCpf, clientPhone,
    roomNumber, roomCategory, pricePerNight,
    totalValue, startDate, endDate,
    onCancel, onCheckIn
  } = props;

  const getStatusColor = () => {
    switch (status) {
      case 'Ativa': case 'PENDENTE': case 'CONFIRMADA': return styles.statusActive;
      case 'Concluída': case 'CONCLUIDA': return styles.statusCompleted;
      case 'Cancelada': case 'CANCELADA': return styles.statusCancelled;
      default: return '';
    }
  };

  const formatCurrency = (value: number) => {
    return new Intl.NumberFormat('pt-BR', { style: 'currency', currency: 'BRL' }).format(value);
  };

  const isReservationActive = ['Ativa', 'PENDENTE', 'CONFIRMADA'].includes(status);

  // Implementação do SweetAlert2
  // No handleCancelClick, o Swal.fire já substitui completamente o navegador.
  const handleCancelClick = () => {
    if (!onCancel) return;

    Swal.fire({
      title: 'Confirmar Cancelamento',
      text: `Tem certeza que deseja cancelar a reserva #${id}?`,
      icon: 'warning',
      showCancelButton: true,
      confirmButtonColor: '#ef4444', // Vermelho do seu botão de cancelar
      cancelButtonColor: '#94a3b8',  // Slate-400 (cor da borda do seu card)
      confirmButtonText: 'Sim, cancelar!',
      cancelButtonText: 'Voltar',
      reverseButtons: true,
      // Customização de classes para bater com seu CSS
      customClass: {
        popup: styles.swalPopup,
        title: styles.swalTitle,
        confirmButton: styles.swalConfirmBtn,
        cancelButton: styles.swalCancelBtn
      }
    }).then((result) => {
      if (result.isConfirmed) {
        onCancel(id);
        
        Swal.fire({
          title: 'Sucesso!',
          text: 'A reserva foi cancelada.',
          icon: 'success',
          timer: 1500,
          showConfirmButton: false,
          customClass: {
            popup: styles.swalPopup
          }
        });
      }
    });
  };

  return (
    <div className={styles.card}>
      {/* --- Dados do Cliente --- */}
      <div className={styles.headerRow}>
        <div className={styles.clientGrid}>
          <div style={{ gridColumn: '1 / -1' }}>
            <h3 className={styles.title}>Dados do Cliente</h3>
          </div>
          <div className={styles.infoBlock}><span className={styles.label}>Nome</span><span className={styles.value}>{clientName}</span></div>
          <div className={styles.infoBlock}><span className={styles.label}>CPF</span><span className={styles.value}>{clientCpf}</span></div>
          <div className={styles.infoBlock}><span className={styles.label}>E-mail</span><span className={styles.value}>{clientEmail}</span></div>
          <div className={styles.infoBlock}><span className={styles.label}>Telefone</span><span className={styles.value}>{clientPhone}</span></div>
        </div>

        <div className={styles.statusContainer}>
          <div className={styles.statusTitle}>Status</div>
          <div className={`${styles.statusValue} ${getStatusColor()}`}>{status}</div>
        </div>
      </div>

      {/* --- Quarto e Custos --- */}
      <div className={styles.middleRow}>
        <div className={styles.roomSection}>
          <h3 className={styles.title}>Informações do Quarto</h3>
          <div className={styles.roomGrid}>
            <div className={styles.infoBlock}><span className={styles.label}>Número</span><span className={styles.value}>{roomNumber}</span></div>
            <div className={styles.infoBlock}><span className={styles.label}>Categoria</span><span className={styles.value}>{roomCategory}</span></div>
          </div>
        </div>

        <div className={styles.costSection}>
          <h3 className={styles.title}>Informações de Custos</h3>
          <div className={styles.costGrid}>
            <div className={styles.infoBlock}><span className={styles.label}>Per Noite</span><span className={styles.value}>{formatCurrency(pricePerNight)}</span></div>
            <div className={styles.infoBlock}><span className={styles.label}>Valor Total</span><span className={styles.value}>{formatCurrency(totalValue)}</span></div>
          </div>
        </div>
      </div>

      {/* --- Datas e Ações --- */}
      <div className={styles.bottomRow}>
        <div style={{ flex: 1 }}>
          <h3 className={styles.title}>Informações da Reserva</h3>
          <div className={styles.reservationGrid}>
            <div className={styles.infoBlock}><span className={styles.label}>ID</span><span className={styles.value}>{id}</span></div>
            <div className={styles.infoBlock}><span className={styles.label}>Início</span><span className={styles.value}>{startDate}</span></div>
            <div className={styles.infoBlock}><span className={styles.label}>Término</span><span className={styles.value}>{endDate}</span></div>
          </div>
        </div>

        <div className={styles.actions}>
            {isReservationActive && onCancel && (
              <button className={styles.cancelStatusButton} onClick={handleCancelClick}>
                Cancelar Reserva
              </button>
            )}

            {isReservationActive && onCheckIn && (
              <button 
                className={styles.checkInButton}
                onClick={() => {
                  const { onCancel, onCheckIn, ...reservationData } = props;
                  onCheckIn(reservationData);
                }}
              >
                Iniciar Hospedagem
              </button>
            )}
        </div>
      </div>
    </div>
  );
};

export default ReservationCard;