import React from 'react';
import { useState, useEffect } from 'react';
import { useNavigate } from 'react-router-dom';
import { 
  TrendingUp, 
  CalendarCheck, 
  DollarSign, 
  CreditCard, 
  Percent,
  Ban,
  Clock,
  TrendingDown,
  Users
} from 'lucide-react';
import styles from './RelatorioPage.module.css';

import { relatorioService, type RelatorioData } from '../services/relatorioService';
import { getDetailedReservations, cancelReservationService, deleteReservationService } from '../services/reservationService';
import ReservationCard, { type ReservationCardProps } from '../components/reservations/ReservationCard';

const RelatorioPage: React.FC = () => {
  const navigate = useNavigate();
  const [dados, setDados] = useState<RelatorioData | null>(null);
  const [reservations, setReservations] = useState<ReservationCardProps[]>([]);
  const [loading, setLoading] = useState(true);
  const [erro, setErro] = useState<string | null>(null);

  useEffect(() => {
    const buscarDados = async () => {
      try {
        const [relatorio, listaReservas] = await Promise.all([
          relatorioService.obterRelatorioGeral(),
          getDetailedReservations()
        ]);
        setDados(relatorio);
        setReservations(listaReservas);
      } catch (error) {
        setErro('Erro ao carregar o relatório e dados.' + error);
      } finally {
        setLoading(false);
      }
    };

    buscarDados();
  }, []);
  
  const handleEdit = (id: string) => {
    const reservation = reservations.find(r => r.id === id);
    if (reservation) {
      navigate(`/reserva/editar/${id}`, { state: reservation });
    }
  };

  const handleCancel = async (id: string) => {
    if (confirm(`Tem certeza que deseja cancelar a reserva ${id}?`)) {
      try {
        const success = await cancelReservationService(id);
        if (success) {
          setReservations(prev => prev.map(res => 
            res.id === id ? { ...res, status: 'Cancelada' as const } : res
          ));
          const novoRelatorio = await relatorioService.obterRelatorioGeral();
          setDados(novoRelatorio);
        } else {
          alert('Não foi possível cancelar a reserva. Tente novamente.');
        }
      } catch (error) {
        console.error('Erro ao cancelar reserva:', error);
        alert('Erro ao processar o cancelamento.');
      }
    }
  };

  const handleDelete = async (id: string) => {
    if (confirm(`Tem certeza que deseja apagar a reserva ${id}? Esta ação não pode ser desfeita.`)) {
      try {
        const success = await deleteReservationService(id);
        if (success) {
          setReservations(prev => prev.filter(res => res.id !== id));
          const novoRelatorio = await relatorioService.obterRelatorioGeral();
          setDados(novoRelatorio);
        } else {
          alert('Não foi possível apagar a reserva. Tente novamente.');
        }
      } catch (error) {
        console.error('Erro ao apagar reserva:', error);
        alert('Erro ao processar a exclusão.');
      }
    }
  };

  if (loading) return <div className={styles.container}>Carregando métricas...</div>;
  if (erro) return <div className={styles.container}>{erro}</div>;
  if (!dados) return null;

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
            <span className={styles.metricValue}>{dados.totalReservas}</span>
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
            <span className={styles.metricValue}>{dados.reservasAtivasHoje}</span>
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
              {new Intl.NumberFormat('pt-BR', { style: 'currency', currency: 'BRL' }).format(dados.receitaEstimadaTotal)}
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
              {new Intl.NumberFormat('pt-BR', { style: 'currency', currency: 'BRL' }).format(dados.receitaMesAtual)}
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
            <span className={styles.metricValue}>{dados.taxaOcupacaoHoje}%</span>
            <div className={styles.progressBarBg}>
              <div 
                className={styles.progressBarFill} 
                style={{ width: `${dados.taxaOcupacaoHoje}%` }}
              ></div>
            </div>
            <span className={styles.metricLabel}>dos quartos ocupados</span>
          </div>
        </div>

        {/* Card 6: Taxa de Cancelamento no Mês */}
        <div className={styles.card}>
          <div className={styles.cardHeader}>
            <span className={styles.cardTitle}>Taxa de Cancelamento</span>
            <div className={`${styles.iconWrapper} ${styles.red}`}>
              <Ban size={24} />
            </div>
          </div>
          <div className={styles.cardContent}>
            <span className={styles.metricValue}>{dados.taxaCancelamentoMesPct}%</span>
            <span className={styles.metricLabel}>das reservas deste mês</span>
          </div>
        </div>

        {/* Card 7: Média de Permanência */}
        <div className={styles.card}>
          <div className={styles.cardHeader}>
            <span className={styles.cardTitle}>Média de Permanência</span>
            <div className={`${styles.iconWrapper} ${styles.blue}`}>
              <Clock size={24} />
            </div>
          </div>
          <div className={styles.cardContent}>
            <span className={styles.metricValue}>{dados.mediaPermanenciaMesDias}</span>
            <span className={styles.metricLabel}>dias por reserva no mês</span>
          </div>
        </div>

        {/* Card 8: Valor Perdido (Cancelamentos) */}
        <div className={styles.card}>
          <div className={styles.cardHeader}>
            <span className={styles.cardTitle}>Perda com Cancelamentos</span>
            <div className={`${styles.iconWrapper} ${styles.orange}`}>
              <TrendingDown size={24} />
            </div>
          </div>
          <div className={styles.cardContent}>
            <span className={styles.metricValue}>
              {new Intl.NumberFormat('pt-BR', { style: 'currency', currency: 'BRL' }).format(dados.valorPerdidoCancelamentosMes)}
            </span>
            <span className={styles.metricLabel}>deixou de entrar no mês</span>
          </div>
        </div>

        {/* Card 9: Ticket Médio por Cliente */}
        <div className={styles.card}>
          <div className={styles.cardHeader}>
            <span className={styles.cardTitle}>Ticket Médio</span>
            <div className={`${styles.iconWrapper} ${styles.green}`}>
              <Users size={24} />
            </div>
          </div>
          <div className={styles.cardContent}>
            <span className={styles.metricValue}>
              {new Intl.NumberFormat('pt-BR', { style: 'currency', currency: 'BRL' }).format(dados.ticketMedioClienteMes)}
            </span>
            <span className={styles.metricLabel}>gasto médio por cliente</span>
          </div>
        </div>
      </div>

      <div style={{ marginTop: '3rem' }}>
        <h2 className={styles.title} style={{ fontSize: '1.5rem', marginBottom: '1.5rem' }}>Detalhes das Reservas</h2>
        {reservations.length > 0 ? (
          <div style={{ display: 'flex', flexDirection: 'column', gap: '1rem' }}>
            {reservations.map(res => (
              <ReservationCard 
                key={res.id}
                {...res}
                onCancel={handleCancel}
                onEdit={handleEdit}
                onDelete={handleDelete}
              />
            ))}
          </div>
        ) : (
          <p className={styles.subtitle}>Nenhuma reserva encontrada para exibir.</p>
        )}
      </div>
    </div>
  );
};

export default RelatorioPage;
