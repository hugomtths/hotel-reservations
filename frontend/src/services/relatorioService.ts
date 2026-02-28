export interface RelatorioData {
  totalReservas: number;
  reservasAtivasHoje: number;
  receitaEstimadaTotal: number;
  receitaMesAtual: number;
  taxaOcupacaoHoje: number;
}

const API_URL = 'http://localhost:8080/relatorios'; 

export const relatorioService = {
  obterRelatorioGeral: async (): Promise<RelatorioData> => {
    const response = await fetch(`${API_URL}/reservas`);
    
    if (!response.ok) {
      throw new Error('Erro ao buscar os dados do relatório');
    }
    
    return response.json();
  }
};