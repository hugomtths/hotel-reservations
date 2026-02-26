import { useState } from 'react';
import { Search } from 'lucide-react';
import styles from './MinhasReservasPage.module.css';
import ReservationCard, { type ReservationCardProps } from '../components/reservations/ReservationCard';
import { getReservationsByEmail, cancelReservationService } from '../services/reservationService';

export default function MinhasReservasPage() {
  const [email, setEmail] = useState('');
  const [loading, setLoading] = useState(false);
  const [reservations, setReservations] = useState<ReservationCardProps[]>([]);
  const [hasSearched, setHasSearched] = useState(false);
  const [error, setError] = useState('');

  const handleSearch = async (e: React.FormEvent) => {
    e.preventDefault();
    if (!email) return;
    
    setLoading(true);
    setHasSearched(false);
    setError('');
    setReservations([]);
    
    try {
      // Chama o serviço para buscar reservas
      // O serviço decide se usa MOCK ou API real baseado no .env
      const results = await getReservationsByEmail(email);
      setReservations(results);
      setHasSearched(true);
    } catch (error) {
      console.error('Erro ao buscar reservas:', error);
      setError('Não foi possível conectar ao servidor. Tente novamente mais tarde.');
    } finally {
      setLoading(false);
    }
  };

  const handleCancel = async (id: string) => {
    if (confirm(`Tem certeza que deseja cancelar a reserva ${id}?`)) {
      try {
        // Chama o serviço para cancelar reserva
        // O serviço decide se usa MOCK ou API real
        const success = await cancelReservationService(id);
        if (success) {
          setReservations(prev => prev.map(res => 
            res.id === id ? { ...res, status: 'Cancelada' as const } : res
          ));
        } else {
          alert('Não foi possível cancelar a reserva. Tente novamente.');
        }
      } catch (error) {
        console.error('Erro ao cancelar reserva:', error);
        alert('Erro ao processar o cancelamento.');
      }
    }
  };

  return (
    <div className={styles.container}>
      
      {/* Seção de Busca */}
      <div className={styles.searchContainer}>
        <h1 className={styles.title}>
          Consultar Histórico
        </h1>

        <form onSubmit={handleSearch} className={styles.form}>
          <div className={styles.inputWrapper}>
            <input
              type="email"
              placeholder="E-mail"
              value={email}
              onChange={(e) => setEmail(e.target.value)}
              className={styles.input}
            />
          </div>
          
          <button 
            type="submit"
            disabled={loading}
            className={styles.button}
          >
            <Search size={24} />
          </button>
        </form>

        {error && (
          <p className={styles.errorMessage} style={{ color: '#ef4444' }}>
            {error}
          </p>
        )}

        {!hasSearched && !loading && !error && (
          <p className={styles.errorMessage}>
            Digite o E-mail para consultar o histórico de reservas!
          </p>
        )}
        
        {hasSearched && reservations.length === 0 && !error && (
           <p className={styles.errorMessage}>
             Esse e-mail não possui nenhuma reserva.
           </p>
        )}
      </div>

      {/* Seção de Resultados */}
      {hasSearched && reservations.length > 0 && (
        <div className={styles.resultsContainer}>
          {reservations.map(res => (
            <ReservationCard 
              key={res.id}
              {...res}
              onCancel={handleCancel}
            />
          ))}
        </div>
      )}
    </div>
  );
}
