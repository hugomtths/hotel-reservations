import { useState, useEffect } from 'react';
import { useParams, useLocation, useNavigate } from 'react-router-dom';
import toast from 'react-hot-toast';
import { updateReservationService } from '../services/reservationService';
import type { ReservationCardProps } from '../components/reservations/ReservationCard';

export default function EditReservationPage() {
  const { id } = useParams<{ id: string }>();
  const location = useLocation();
  const navigate = useNavigate();
  const reservation = location.state as ReservationCardProps;

  const [startDate, setStartDate] = useState('');
  const [endDate, setEndDate] = useState('');
  const [loading, setLoading] = useState(false);

  useEffect(() => {
    if (reservation) {
      // Need to parse dates "dd/MM/yyyy" to "yyyy-MM-dd" for input type="date"
      const parseDate = (dateStr: string) => {
          if(!dateStr) return '';
          // Assuming format dd/MM/yyyy from the mapper
          const parts = dateStr.split('/');
          if (parts.length === 3) {
            const [day, month, year] = parts;
            return `${year}-${month}-${day}`;
          }
          return dateStr;
      };
      setStartDate(parseDate(reservation.startDate));
      setEndDate(parseDate(reservation.endDate));
    } else {
       toast.error('Reserva não encontrada. Por favor, acesse através da lista de reservas.');
       navigate('/home/reservas');
    }
  }, [reservation, navigate]);

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    if (!id) return;
    
    // Check if roomId is present. If not, we can't update using the current backend endpoint requirement
    // unless the backend allows omitting quartoIds (which it doesn't seem to).
    if (!reservation.roomId) {
        toast.error('Erro: ID do quarto não disponível para esta reserva.');
        return;
    }
    
    setLoading(true);
    
    const payload = {
        dataCheckinPrevisto: startDate,
        dataCheckoutPrevisto: endDate,
        quartoIds: [reservation.roomId]
    };

    const success = await updateReservationService(id, payload);
    
    setLoading(false);
    
    if (success) {
        toast.success('Reserva atualizada com sucesso!');
        navigate('/home/reservas');
    } else {
        toast.error('Erro ao atualizar reserva. Verifique as datas e tente novamente.');
    }
  };

  if (!reservation) return null;

  return (
    <div style={{ maxWidth: '600px', margin: '2rem auto', padding: '2rem', backgroundColor: 'white', borderRadius: '8px', boxShadow: '0 4px 6px -1px rgba(0, 0, 0, 0.1)' }}>
        <h1 style={{ fontSize: '1.5rem', fontWeight: 'bold', marginBottom: '1.5rem', color: '#1e3a8a' }}>Editar Reserva #{id}</h1>
        
        <div style={{ marginBottom: '1.5rem', padding: '1rem', backgroundColor: '#f3f4f6', borderRadius: '0.5rem' }}>
            <p><strong>Cliente:</strong> {reservation.clientName}</p>
            <p><strong>Quarto:</strong> {reservation.roomNumber} - {reservation.roomCategory}</p>
        </div>

        <form onSubmit={handleSubmit} style={{ display: 'flex', flexDirection: 'column', gap: '1.5rem' }}>
            <div>
                <label style={{ display: 'block', marginBottom: '0.5rem', fontWeight: '600', color: '#4b5563' }}>Data Check-in</label>
                <input 
                    type="date" 
                    value={startDate} 
                    onChange={e => setStartDate(e.target.value)}
                    required
                    style={{ width: '100%', padding: '0.75rem', borderRadius: '0.375rem', border: '1px solid #d1d5db' }}
                />
            </div>
            <div>
                <label style={{ display: 'block', marginBottom: '0.5rem', fontWeight: '600', color: '#4b5563' }}>Data Check-out</label>
                <input 
                    type="date" 
                    value={endDate} 
                    onChange={e => setEndDate(e.target.value)}
                    required
                    style={{ width: '100%', padding: '0.75rem', borderRadius: '0.375rem', border: '1px solid #d1d5db' }}
                />
            </div>
            
            <div style={{ display: 'flex', gap: '1rem', marginTop: '1rem' }}>
                <button 
                    type="button" 
                    onClick={() => navigate('/home/reservas')} 
                    style={{ flex: 1, padding: '0.75rem', backgroundColor: 'transparent', border: '1px solid #d1d5db', borderRadius: '0.5rem', cursor: 'pointer', fontWeight: '600', color: '#4b5563' }}
                >
                    Cancelar
                </button>
                <button 
                    type="submit" 
                    disabled={loading} 
                    style={{ flex: 1, padding: '0.75rem', backgroundColor: '#3b82f6', color: 'white', border: 'none', borderRadius: '0.5rem', cursor: 'pointer', fontWeight: '600', opacity: loading ? 0.7 : 1 }}
                >
                    {loading ? 'Salvando...' : 'Salvar Alterações'}
                </button>
            </div>
        </form>
    </div>
  );
}
