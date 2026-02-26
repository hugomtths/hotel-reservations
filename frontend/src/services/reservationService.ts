import { type ReservationCardProps } from '../components/reservations/ReservationCard';
import api from './api';

const USE_MOCK = import.meta.env.VITE_USE_MOCK === 'true';

// Mock Data - Mantendo em memória para persistir alterações durante a sessão
let MOCK_RESERVATIONS: ReservationCardProps[] = [
  {
    id: '000009',
    status: 'Ativa',
    clientName: 'Arlindo cruz dos Santos Ramos',
    clientEmail: 'arlindocruzsantos4949@gmail.com',
    clientCpf: '150.879.400-66',
    clientPhone: '(87) 9 8109-9404',
    roomNumber: '01',
    roomCategory: 'Suíte',
    roomCapacity: 'Duas camas de casal',
    pricePerNight: 400.00,
    totalValue: 2000.00,
    stayDuration: '5 Dias',
    startDate: '08/04/2025',
    endDate: '12/04/2025'
  },
  {
    id: '000010',
    status: 'Concluída',
    clientName: 'Arlindo cruz dos Santos Ramos',
    clientEmail: 'arlindocruzsantos4949@gmail.com',
    clientCpf: '150.879.400-66',
    clientPhone: '(87) 9 8109-9404',
    roomNumber: '02',
    roomCategory: 'Standart',
    roomCapacity: 'Duas camas de solteiro',
    pricePerNight: 270.00,
    totalValue: 810.00,
    stayDuration: '3 Dias',
    startDate: '01/03/2025',
    endDate: '04/03/2025'
  }
];

export const getReservationsByEmail = async (email: string): Promise<ReservationCardProps[]> => {
  if (USE_MOCK) {
    return new Promise((resolve) => {
      setTimeout(() => {
        console.log('Buscando reservas para (MOCK):', email);
        // Filtra as reservas pelo e-mail
        const filtered = MOCK_RESERVATIONS.filter(res => res.clientEmail === email);
        // Retorna uma cópia para evitar mutações diretas acidentais
        resolve([...filtered]);
      }, 1000);
    });
  }

  // Se não estiver usando Mock, faz a requisição real
  try {
    // Busca as reservas na API filtrando por email
    // Espera receber um array de objetos ReservationCardProps
    const response = await api.get<ReservationCardProps[]>(`/reservations?email=${email}`);
    return response.data;
  } catch (error) {
    // Em caso de erro, loga e repassa o erro para o componente tratar
    console.error('Erro ao buscar reservas:', error);
    throw error;
  }
};

export const cancelReservationService = async (id: string): Promise<boolean> => {
  if (USE_MOCK) {
    return new Promise((resolve) => {
      setTimeout(() => {
        // Atualiza o status na "base de dados" mockada
        MOCK_RESERVATIONS = MOCK_RESERVATIONS.map(res => 
          res.id === id ? { ...res, status: 'Cancelada' as const } : res
        );
        resolve(true);
      }, 500);
    });
  }

  // Se não estiver usando Mock, envia comando de exclusão para o backend
  try {
    // Chama a API com o verbo DELETE passando o ID
    await api.delete(`/reservations/${id}`);
    return true; // Retorna true se sucesso (200/204)
  } catch (error) {
    // Em caso de falha na API
    console.error('Erro ao cancelar reserva:', error);
    return false;
  }
};
