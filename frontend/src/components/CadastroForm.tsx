import React, { useState } from 'react';
import { Link, useNavigate } from 'react-router-dom';
import { registerService, type RegisterData } from '../services/authService';
import TextInput from './ui/Text';
import DateInput from './ui/Date';
import CpfInput from './ui/Cpf';
import EmailInput from './ui/Email';
import PasswordInput from './ui/Password';
import styles from './CadastroForm.module.css';

const CadastroForm: React.FC = () => {
  const [formData, setFormData] = useState<RegisterData>({
    nome: '',
    dataNascimento: '',
    cpf: '',
    email: '',
    telefone: '',
    senha: ''
  });
  const [confirmSenha, setConfirmSenha] = useState('');
  const [error, setError] = useState('');
  const [loading, setLoading] = useState(false);
  const navigate = useNavigate();

  const handleChange = (e: { target: { name: string; value: string } }) => {
    const { name, value } = e.target;
    setFormData(prev => ({ ...prev, [name]: value }));
  };

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    setError('');
    
    if (formData.senha !== confirmSenha) {
      setError('As senhas não coincidem.');
      return;
    }

    setLoading(true);

    try {
      // Chama o serviço de registro passando os dados do formulário
      // Se VITE_USE_MOCK=false, enviará um POST para /auth/register
      await registerService(formData);
      
      // Se cadastro for bem sucedido, redireciona para o login
      navigate('/');
    } catch (err: any) {
      // Captura erros do backend (ex: "Email já cadastrado")
      setError(err.message || 'Falha ao realizar cadastro.');
    } finally {
      setLoading(false);
    }
  };

  return (
    <div className={styles.formContainer}>
      <div className={styles.header}>
        <h2 className={styles.title}>Crie sua conta</h2>
        <p className={styles.subtitle}>Preencha seus dados para começar</p>
      </div>

      {error && <div className={styles.error}>{error}</div>}

      <form onSubmit={handleSubmit}>
        <div className={styles.inputsGroup}>
          <TextInput
            label="Nome Completo"
            name="nome"
            value={formData.nome}
            onChange={handleChange}
            message="Digite seu nome completo"
            required
            disabled={loading}
          />
          
          <DateInput
            label="Data de Nascimento"
            name="dataNascimento"
            value={formData.dataNascimento}
            onChange={handleChange}
            message="Selecione sua data de nascimento"
            required
            disabled={loading}
          />

          <CpfInput
            label="CPF"
            name="cpf"
            value={formData.cpf}
            onChange={handleChange}
            message="000.000.000-00"
            required
            disabled={loading}
          />

          <TextInput
            label="Telefone"
            name="telefone"
            value={formData.telefone}
            onChange={handleChange}
            message="(00) 00000-0000"
            required
            disabled={loading}
          />

          <EmailInput
            label="Email"
            name="email"
            value={formData.email}
            onChange={handleChange}
            message="seu@email.com"
            required
            disabled={loading}
          />

          <PasswordInput
            label="Senha"
            name="senha"
            value={formData.senha || ''}
            onChange={handleChange}
            message="Crie uma senha segura"
            required
            disabled={loading}
          />

          <PasswordInput
            label="Confirmar Senha"
            name="confirmSenha"
            value={confirmSenha}
            onChange={(e) => setConfirmSenha(e.target.value)}
            message="Confirme sua senha"
            required
            disabled={loading}
          />
        </div>

        <button 
          type="submit" 
          className={styles.submitButton}
          disabled={loading}
        >
          {loading ? 'Cadastrando...' : 'Criar Conta'}
        </button>

        <div className={styles.footer}>
          Já tem uma conta?{' '}
          <Link to="/" className={styles.link}>
            Faça login
          </Link>
        </div>
      </form>
    </div>
  );
};

export default CadastroForm;
