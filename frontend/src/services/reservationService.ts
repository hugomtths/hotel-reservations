import { type ReservationCardProps } from '../components/reservations/ReservationCard';
import api from './api';

export const getDetailedReservations = async (email?: string): Promise<ReservationCardProps[]> => {
  try {
    const url = email ? `/reservas/detalhadas?email=${email}` : '/reservas/detalhadas';
    const response = await api.get<ReservationCardProps[]>(url);
    return response.data;
  } catch (error) {
    console.error('Erro ao buscar reservas detalhadas:', error);
    throw error;
  }
};

export const getReservationsByEmail = async (email?: string): Promise<ReservationCardProps[]> => {
  try {
    const url = email ? `/reservas/detalhadas?email=${email}` : '/reservas/detalhadas';
    const response = await api.get<ReservationCardProps[]>(url);
    return response.data;
  } catch (error) {
    console.error('Erro ao buscar reservas:', error);
    throw error;
  }
};

export const cancelReservationService = async (id: string): Promise<boolean> => {
  try {
    await api.patch(`/reservas/${id}/cancelar`);
    return true;
  } catch (error) {
    console.error('Erro ao cancelar reserva:', error);
    return false;
  }
};

export const deleteReservationService = async (id: string): Promise<boolean> => {
    try {
        await api.delete(`/reservas/${id}`);
        return true;
    } catch (error) {
        console.error('Erro ao deletar reserva:', error);
        return false;
    }
};

export const updateReservationService = async (id: string, data: any): Promise<boolean> => {
  try {
    await api.put(`/reservas/${id}`, data);
    return true;
  } catch (error) {
    console.error('Erro ao atualizar reserva:', error);
    return false;
  }
};
