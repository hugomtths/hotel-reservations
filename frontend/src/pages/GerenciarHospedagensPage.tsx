import { useState, useEffect } from 'react';
import { useNavigate } from 'react-router-dom';
import { Plus } from 'lucide-react';
import styles from './MinhasReservasPage.module.css';
import { getUserRole } from '../services/authService';
import HospedagemCard from '../components/reservations/HospedagemCard';
import { getHospedagens } from '../services/hostingService';

export default function GerenciarHospedagensPage() {
  const navigate = useNavigate();
  const isManager = getUserRole() === 'FUNCIONARIO';
  
  const [hospedagens, setHospedagens] = useState<any[]>([]); 
  const [filterType, setFilterType] = useState<'ALL' | 'WALK_IN' | 'RESERVATION'>('ALL');

  useEffect(() => {
    const fetchHospedagens = async () => {
      try {
        const dados = await getHospedagens();
    
        const formatadas = dados.map((h: any) => ({
          id: h.id,
          reservaId: h.reservaId,
          quartoId: h.quartoId,
          numeroQuarto: h.numeroQuarto,
          categoriaQuarto: h.categoriaQuarto,
          nomeCliente: h.nomeCliente,
          cpfCliente: h.cpfCliente,
          emailCliente: h.emailCliente,
          telefoneCliente: h.telefoneCliente,
          dataCheckinReal: h.dataCheckinReal,  
          dataCheckoutReal: h.dataCheckoutReal,
          status: h.pagamentos?.[0]?.statusPagamento || 'PENDENTE',
          valorTotal: h.pagamentos?.[0]?.valorTotal || 0
        }));
        
        setHospedagens(formatadas);
      } catch (error) {
        console.error("Erro ao buscar hospedagens", error);
      }
    };

    fetchHospedagens();
  }, []);

  // Lógica do Filtro
  const filteredHospedagens = hospedagens.filter(hosp => {
    if (filterType === 'ALL') return true;
    if (filterType === 'WALK_IN') return hosp.reservaId === null; // Walk-in
    if (filterType === 'RESERVATION') return hosp.reservaId !== null; // Veio de reserva
    return true;
  });

  return (
    <div className={styles.container}>
      <div className={styles.searchContainer}>
        <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center' }}>
          <h1 className={styles.title}>Gerenciar Hospedagens</h1>
          
          {/* Botão para Nova Hospedagem Avulsa (Só para funcionários) */}
          {isManager && (
            <button 
              className={styles.button} 
              style={{ width: 'auto', padding: '0 16px', display: 'flex', gap: '8px' }}
              onClick={() => navigate('/hospedagem')}
            >
              <Plus size={20} /> Nova Hospedagem
            </button>
          )}
        </div>

        {/* Filtros de Tipo */}
        <div className={styles.filterContainer} style={{ marginTop: '1rem' }}>
          {[
            { label: 'Todas', value: 'ALL' },
            { label: 'Avulsas (Walk-in)', value: 'WALK_IN' },
            { label: 'Por Reserva', value: 'RESERVATION' }
          ].map(option => (
            <button
              key={option.value}
              onClick={() => setFilterType(option.value as any)}
              className={`${styles.filterButton} ${filterType === option.value ? styles.filterButtonActive : ''}`}
            >
              {option.label}
            </button>
          ))}
        </div>
      </div>

      <div className={styles.resultsContainer}>
        {filteredHospedagens.length > 0 ? (
          filteredHospedagens.map(hosp => (
            <HospedagemCard key={hosp.id || hosp.quartoId} {...hosp} />
          ))
        ) : (
          <p className={styles.errorMessage}>Nenhuma hospedagem encontrada.</p>
        )}
      </div>
    </div>
  );
}