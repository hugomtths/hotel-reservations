import { useParams, useNavigate, useSearchParams } from 'react-router-dom';
import { useState, useEffect } from 'react';
import toast from 'react-hot-toast';
import { Loader2 } from 'lucide-react';
import styles from './RoomPage.module.css';

interface QuartoResponse {
  id: number;
  numero: string;
  status: string;
  area: number;
  categoria: {
    nome: string;
    precoDiaria: number;
    capacidade: number;
  };
}

const RoomPage = () => {
  const { id } = useParams<{ id: string }>();
  const navigate = useNavigate();
  //const location = useLocation();
  const [searchParams] = useSearchParams();
  
  const [room, setRoom] = useState<QuartoResponse | null>(null);
  const [isLoading, setIsLoading] = useState(true);

  const checkIn = searchParams.get('checkIn');
  const checkOut = searchParams.get('checkOut');

  useEffect(() => {
    const fetchRoomDetails = async () => {
      try {
        const response = await fetch(`http://localhost:8080/quartos/${id}`);
        if (!response.ok) throw new Error("Quarto não encontrado");
        
        const data: QuartoResponse = await response.json();
        setRoom(data);
      } catch (error) {
        console.error(error);
        toast.error("Erro ao carregar detalhes do quarto.");
      } finally {
        setIsLoading(false);
      }
    };

    if (id) fetchRoomDetails();
  }, [id]);

  const handleBooking = () => {
    // 1. Validar se as datas estão presentes na URL
    if (!checkIn || !checkOut) {
      toast.error("Período de reserva não selecionado. Voltando para a Home.");
      navigate('/');
      return;
    }

    // 2. Verificar autenticação
    // const token = localStorage.getItem('token'); 
    const reservationState = { room, checkIn, checkOut };

    // if (!token) {
    //   toast.error("Você precisa estar logado para reservar!");
    //   // Salvamos a URL completa (com query params) para voltar exatamente para cá após o login
    //   const returnUrl = `${location.pathname}${location.search}`;
    //   navigate('/login', { state: { from: returnUrl, reservationState } });
    // } else {
    //   // Se logado, vai para a confirmação
    //   navigate(`/reserva/confirmacao/${id}`, { state: reservationState });
    // }
    navigate(`/reserva/confirmacao/${id}`, { state: reservationState });
  };

  if (isLoading) {
    return (
      <div className={styles.container} style={{ textAlign: 'center' }}>
        <Loader2 className={styles.spinner} size={48} />
        <p>Buscando informações do quarto...</p>
      </div>
    );
  }

  if (!room) return <div className={styles.container}><p>Quarto não encontrado.</p></div>;

  return (
    <div className={styles.container}>
      <div className={styles.grid}>
        <section className={styles.imageSection}>
          <img 
            src="https://images.unsplash.com/photo-1590490360182-c33d57733427" 
            alt={room.categoria.nome} 
          />
        </section>

        <section className={styles.infoSection}>
          <span className={styles.badge}>{room.status}</span>
          <h1 className={styles.title}>{room.categoria.nome}</h1>
          <p className={styles.roomNumber}>Quarto n° {room.numero}</p>
          
          <div className={styles.specs}>
            <p><strong>Área:</strong> {room.area} m²</p>
            <p><strong>Capacidade:</strong> Até {room.categoria.capacidade} hóspedes</p>
            <p><strong>Período selecionado:</strong> {checkIn} até {checkOut}</p>
          </div>

          <div className={styles.priceAction}>
            <span className={styles.price}>
              R$ {room.categoria.precoDiaria.toFixed(2)} / noite
            </span>
            <button 
              className={styles.bookButton} 
              onClick={handleBooking}
              disabled={room.status !== 'DISPONIVEL'}
            >
              {room.status === 'DISPONIVEL' ? 'RESERVAR AGORA' : 'INDISPONÍVEL'}
            </button>
          </div>
        </section>
      </div>
    </div>
  );
};

export default RoomPage;