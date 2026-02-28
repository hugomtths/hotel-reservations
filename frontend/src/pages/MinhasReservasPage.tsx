import { useState, useEffect } from 'react';
import { Search } from 'lucide-react';
import styles from './MinhasReservasPage.module.css';
import ReservationCard, { type ReservationCardProps } from '../components/reservations/ReservationCard';
import { getReservationsByEmail, cancelReservationService } from '../services/reservationService';
import { getUserRole, getUserEmail } from '../services/authService';

export default function MinhasReservasPage() {
  const [email, setEmail] = useState('');
  const [loading, setLoading] = useState(false);
  const [reservations, setReservations] = useState<ReservationCardProps[]>([]);
  const [hasSearched, setHasSearched] = useState(false);
  const [error, setError] = useState('');
  
  const userRole = getUserRole();
  const userEmail = getUserEmail();
  const isManager = userRole === 'FUNCIONARIO';

  // Efeito para carregar reservas automaticamente ao montar a página
  useEffect(() => {
    const loadInitialReservations = async () => {
      setLoading(true);
      setError('');
      try {
        if (isManager) {
          // Gerente: carrega todas as reservas inicialmente
          const results = await getReservationsByEmail(); // Sem email = todas
          setReservations(results);
          setHasSearched(true);
        } else if (userEmail) {
          // Cliente: carrega apenas suas reservas
          const results = await getReservationsByEmail(userEmail);
          setReservations(results);
          setHasSearched(true);
        }
      } catch (err) {
        console.error('Erro ao carregar reservas:', err);
        setError('Não foi possível carregar as reservas.');
      } finally {
        setLoading(false);
      }
    };

    loadInitialReservations();
  }, [isManager, userEmail]);

  const handleSearch = async (e: React.FormEvent) => {
    e.preventDefault();
    if (!email && !isManager) return; // Cliente precisa ter email (mas aqui o form nem deve aparecer)
    
    setLoading(true);
    setHasSearched(false);
    setError('');
    setReservations([]);
    
    try {
      // Se for gerente e o campo de busca estiver vazio, busca todas novamente
      // Se tiver email preenchido, busca específicas
      const searchEmail = email || undefined;
      const results = await getReservationsByEmail(searchEmail);
      
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
      
      <div className={styles.searchContainer}>
        <h1 className={styles.title}>
          {isManager ? 'Gerenciar Reservas' : 'Minhas Reservas'}
        </h1>

        {/* Formulário de busca visível APENAS para Gerentes */}
        {isManager && (
          <form onSubmit={handleSearch} className={styles.form}>
            <div className={styles.inputWrapper}>
              <input
                type="email"
                placeholder="Buscar por e-mail (deixe vazio para ver todas)"
                value={email}
                onChange={(e) => setEmail(e.target.value)}
                className={styles.input}
              />
            </div>
            
            <button 
              type="submit"
              disabled={loading}
              className={styles.button}
              title="Buscar"
            >
              <Search size={24} />
            </button>
          </form>
        )}

        {error && (
          <p className={styles.errorMessage} style={{ color: '#ef4444' }}>
            {error}
          </p>
        )}
        
        {hasSearched && reservations.length === 0 && !error && (
           <p className={styles.errorMessage}>
             Nenhuma reserva encontrada.
           </p>
        )}
      </div>

      {/* Seção de Resultados */}
      {reservations.length > 0 && (
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
