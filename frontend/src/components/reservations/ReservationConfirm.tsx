import styles from './ReservationConfirm.module.css';
import { ChevronLeft, CheckCircle } from 'lucide-react';

const ReservationConfirm = () => {
  console.log("Estilos carregados:", styles);
  return (
    <div className={styles.container}>
      <header className={styles.header}>
        <button className={styles.backButton}>
          <ChevronLeft size={24} />
          Confirmar reserva
        </button>
      </header>

      <div className={styles.contentGrid}>
        {/* COLUNA ESQUERDA - FORMULÁRIO E INFOS */}
        <section className={styles.detailsColumn}>
          <div className={styles.section}>
            <h2 className={styles.sectionTitle}>Sua viagem</h2>
            <div className={styles.tripInfo}>
              <div>
                <p className={styles.label}>Datas</p>
                <p className={styles.value}>23 - 28 de mar.</p>
              </div>
              <div>
                <p className={styles.label}>Tempo de estadia</p>
                <p className={styles.value}>6 noites</p>
              </div>
              <div>
                <p className={styles.label}>Hóspedes</p>
                <p className={styles.value}>2 hóspedes</p>
              </div>
            </div>
          </div>
          
          {/* Políticas de Cancelamento e Regras conforme design */}
        </section>

        {/* COLUNA DIREITA - CARD DE PREÇO */}
        <aside className={styles.priceCard}>
          <div className={styles.roomPreview}>
            <img src="https://images.unsplash.com/photo-1590490360182-c33d57733427" alt="Quarto" />
            <div>
              <h3>Standart</h3>
              <p>Cama única de casal</p>
              <p>Número do quarto: 10</p>
            </div>
          </div>

          <hr />

          <div className={styles.priceDetails}>
            <h4>Informações de preço</h4>
            <div className={styles.priceRow}>
              <span>R$ 200,00 x 6 noites</span>
              <span>R$ 1.200,00</span>
            </div>
            <div className={styles.priceRow}>
              <span>Taxa de limpeza</span>
              <span>R$ 120,00</span>
            </div>
            <div className={styles.priceRow}>
              <span>Taxa de serviço</span>
              <span>R$ 230,00</span>
            </div>
            <hr />
            <div className={`${styles.priceRow} ${styles.total}`}>
              <span>Total (BRL)</span>
              <span>R$ 1.350,00</span>
            </div>
          </div>

          <button className={styles.confirmButton}>
            <CheckCircle size={20} />
            Confirmar a reserva
          </button>
        </aside>
      </div>
    </div>
  );
};

export default ReservationConfirm;