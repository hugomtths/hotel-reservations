import api from './api';

// Defina VITE_USE_MOCK=false no arquivo .env para usar o backend real
const USE_MOCK = import.meta.env.VITE_USE_MOCK === 'true';

export const loginService = async (email: string, password: string): Promise<boolean> => {
  if (USE_MOCK) {
    return new Promise((resolve, reject) => {
      console.log('Login attempt (MOCK):', { email, password });
      
      // Simulação de delay de rede
      setTimeout(() => {
        if (email && password) {
          // Sucesso
          resolve(true);
        } else {
          // Falha
          reject(new Error('Por favor, preencha todos os campos.'));
        }
      }, 800);
    });
  }

  // Integração real com o backend
  // Se não estiver usando Mock, tenta conexão real com a API
  try {
    // Ajuste a rota '/auth/login' conforme sua API
    // Faz a chamada POST para o endpoint de login
    const response = await api.post<LoginResponse>('/auth/login', { email, password });
    
    // Se receber um token, salva no localStorage para autenticação futura
    if (response.data.accessToken) {
      localStorage.setItem('token', response.data.accessToken);
    }
    
    return true;
  } catch (error: any) {
    // Tratamento de erro da API
    console.error('Erro no login:', error);
    throw new Error(error.response?.data?.message || 'Falha ao realizar login');
  }
};

interface LoginResponse {
  accessToken: string;
  tokenType: string;
  expiresIn: number;
}

export interface RegisterData {
  nome: string;
  dataNascimento: string;
  cpf: string;
  email: string;
  telefone: string;
  senha?: string;
}

export const registerService = async (data: RegisterData): Promise<boolean> => {
  if (USE_MOCK) {
    return new Promise((resolve, reject) => {
      console.log('Register attempt (MOCK):', data);
      
      setTimeout(() => {
        if (data.nome && data.cpf && data.email && data.senha) {
          resolve(true);
        } else {
          reject(new Error('Por favor, preencha todos os campos obrigatórios.'));
        }
      }, 800);
    });
  }

  try {
    const payload = {
      email: data.email,
      password: data.senha,
      nome: data.nome,
      cpf: data.cpf.replace(/\D/g, ''), // Remove formatação (pontos e traços)
      celular: data.telefone.replace(/\D/g, '') // Remove formatação do telefone
    };
    await api.post('/auth/register', payload);
    return true;
  } catch (error: any) {
    console.error('Erro no cadastro:', error);
    throw new Error(error.response?.data?.message || 'Falha ao realizar cadastro');
  }
};

export const getUserRole = (): 'CLIENTE' | 'GERENTE' | null => {
  const token = localStorage.getItem('token');
  if (!token) return null;
  
  try {
    const payloadBase64 = token.split('.')[1];
    const decodedJson = atob(payloadBase64);
    const decoded = JSON.parse(decodedJson);
    return decoded.role || decoded.authorities?.[0] || 'CLIENTE';
  } catch (e) {
    return null;
  }
};

export const getUserEmail = (): string | null => {
  const token = localStorage.getItem('token');
  if (!token) return null;
  
  try {
    const payloadBase64 = token.split('.')[1];
    const decodedJson = atob(payloadBase64);
    const decoded = JSON.parse(decodedJson);
    return decoded.sub || decoded.email || null;
  } catch (e) {
    return null;
  }
};
