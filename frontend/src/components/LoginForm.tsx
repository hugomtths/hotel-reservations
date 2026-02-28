import React, { useState } from 'react';
import EmailInput from '../components/ui/Email';
import PasswordInput from '../components/ui/Password';
import { Link, useNavigate } from 'react-router-dom';
import styles from './LoginForm.module.css';
import { loginService } from '../services/authService';

const LoginForm: React.FC = () => {
  const navigate = useNavigate();
  const [formData, setFormData] = useState({
    email: '',
    password: ''
  });
  const [error, setError] = useState('');
  const [isLoading, setIsLoading] = useState(false);

  const handleChange = (e: { target: { name: string; value: string } }) => {
    const { name, value } = e.target;
    setFormData(prev => ({ ...prev, [name]: value }));
  };

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    setError('');
    setIsLoading(true);
    
    try {
      // Tenta realizar o login chamando o serviço de autenticação
      // Se VITE_USE_MOCK=false no .env, fará uma chamada POST real para /auth/login
      await loginService(formData.email, formData.password);
      
      // Se login for bem sucedido, redireciona para a Home
      navigate('/home', { replace: true });
    } catch (err) {
      // Captura erros do backend (ex: "Credenciais inválidas")
      setError(err instanceof Error ? err.message : 'Falha no login');
    } finally {
      setIsLoading(false);
    }
  };

  return (
    <form onSubmit={handleSubmit} className={styles.formContainer}>
      <div className={styles.header}>
        <h2 className={styles.title}>Bem-vindo de volta</h2>
        <p className={styles.subtitle}>Faça login para acessar sua conta</p>
      </div>

      {error && (
        <div className={styles.error}>
          {error}
        </div>
      )}

      <div className={styles.inputsGroup}>
        <EmailInput 
          name="email"
          label="E-mail"
          value={formData.email}
          onChange={handleChange}
          required={true}
          message="seu@email.com"
          disabled={false}
        />

        <PasswordInput 
          name="password"
          label="Senha"
          value={formData.password}
          onChange={handleChange}
          required={true}
          message="********"
          disabled={false}
        />
      </div>

      <button 
        type="submit" 
        className={styles.submitButton}
        disabled={isLoading}
      >
        {isLoading ? 'Entrando...' : 'Entrar'}
      </button>

      <div className={styles.footer}>
        Não tem uma conta?{' '}
        <Link to="/cadastro" className={styles.link}>
          Cadastre-se
        </Link>
      </div>
    </form>
  );
};

export default LoginForm;