import api from './api';

export interface RelatorioData {
  totalReservas: number;
  reservasAtivasHoje: number;
  receitaEstimadaTotal: number;
  receitaMesAtual: number;
  taxaOcupacaoHoje: number;
}

export const relatorioService = {
  obterRelatorioGeral: async (hotelId: number = 1): Promise<RelatorioData> => {
    const response = await api.get<RelatorioData>(`/relatorios/reservas?hotelId=${hotelId}`);
    return response.data;
  }
};