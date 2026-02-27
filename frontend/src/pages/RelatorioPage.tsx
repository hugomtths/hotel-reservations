import React from 'react';
import { 
  TrendingUp, 
  CalendarCheck, 
  DollarSign, 
  CreditCard, 
  Percent 
} from 'lucide-react';
import styles from './RelatorioPage.module.css';

// Mock Data (temporário até conectar com backend)
const MOCK_METRICS = {
  totalReservas: 154,
  reservasAtivasHoje: 12,
  receitaEstimadaTotal: 45200.00,
  receitaMesAtual: 12500.00,
  taxaOcupacaoHoje: 65 // em porcentagem
};

const RelatorioPage: React.FC = () => {
  return (
    <div className={styles.container}>
      <header className={styles.header}>
        <h1 className={styles.title}>Relatório Geral</h1>
        <p className={styles.subtitle}>Visão geral das métricas do hotel</p>
      </header>

      <div className={styles.grid}>
        {/* Card 1: Total Reservas */}
        <div className={styles.card}>
          <div className={styles.cardHeader}>
            <span className={styles.cardTitle}>Total Reservas</span>
            <div className={`${styles.iconWrapper} ${styles.blue}`}>
              <CalendarCheck size={24} />
            </div>
          </div>
          <div className={styles.cardContent}>
            <span className={styles.metricValue}>{MOCK_METRICS.totalReservas}</span>
            <span className={styles.metricLabel}>reservas registradas</span>
          </div>
        </div>

        {/* Card 2: Reservas Ativas Hoje */}
        <div className={styles.card}>
          <div className={styles.cardHeader}>
            <span className={styles.cardTitle}>Reservas Ativas Hoje</span>
            <div className={`${styles.iconWrapper} ${styles.green}`}>
              <TrendingUp size={24} />
            </div>
          </div>
          <div className={styles.cardContent}>
            <span className={styles.metricValue}>{MOCK_METRICS.reservasAtivasHoje}</span>
            <span className={styles.metricLabel}>hóspedes presentes</span>
          </div>
        </div>

        {/* Card 3: Receita Estimada Total */}
        <div className={styles.card}>
          <div className={styles.cardHeader}>
            <span className={styles.cardTitle}>Receita Estimada Total</span>
            <div className={`${styles.iconWrapper} ${styles.purple}`}>
              <DollarSign size={24} />
            </div>
          </div>
          <div className={styles.cardContent}>
            <span className={styles.metricValue}>
              {new Intl.NumberFormat('pt-BR', { style: 'currency', currency: 'BRL' }).format(MOCK_METRICS.receitaEstimadaTotal)}
            </span>
            <span className={styles.metricLabel}>acumulado histórico</span>
          </div>
        </div>

        {/* Card 4: Receita Mês Atual */}
        <div className={styles.card}>
          <div className={styles.cardHeader}>
            <span className={styles.cardTitle}>Receita Mês Atual</span>
            <div className={`${styles.iconWrapper} ${styles.orange}`}>
              <CreditCard size={24} />
            </div>
          </div>
          <div className={styles.cardContent}>
            <span className={styles.metricValue}>
              {new Intl.NumberFormat('pt-BR', { style: 'currency', currency: 'BRL' }).format(MOCK_METRICS.receitaMesAtual)}
            </span>
            <span className={styles.metricLabel}>faturamento corrente</span>
          </div>
        </div>

        {/* Card 5: Taxa Ocupação Hoje */}
        <div className={styles.card}>
          <div className={styles.cardHeader}>
            <span className={styles.cardTitle}>Taxa Ocupação Hoje</span>
            <div className={`${styles.iconWrapper} ${styles.red}`}>
              <Percent size={24} />
            </div>
          </div>
          <div className={styles.cardContent}>
            <span className={styles.metricValue}>{MOCK_METRICS.taxaOcupacaoHoje}%</span>
            <div className={styles.progressBarBg}>
              <div 
                className={styles.progressBarFill} 
                style={{ width: `${MOCK_METRICS.taxaOcupacaoHoje}%` }}
              ></div>
            </div>
            <span className={styles.metricLabel}>dos quartos ocupados</span>
          </div>
        </div>
      </div>
    </div>
  );
};

export default RelatorioPage;
