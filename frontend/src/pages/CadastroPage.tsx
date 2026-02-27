import React from 'react';
import CadastroForm from '../components/CadastroForm';
import styles from './CadastroPage.module.css';

// Reutilizando a mesma imagem de fundo do Login para consistência
const bgImage = "https://images.unsplash.com/photo-1566073771259-6a8506099945?ixlib=rb-4.0.3&auto=format&fit=crop&w=1920&q=80";

const CadastroPage: React.FC = () => {
  // Esta página é um container visual.
  // A lógica de cadastro e conexão com backend está no componente <CadastroForm />
  // que utiliza o authService.ts
  return (
    <div 
      className={styles.container}
      style={{ backgroundImage: `url(${bgImage})` }}
    >
      <div className={styles.content}>
        <CadastroForm />
      </div>
    </div>
  );
};

export default CadastroPage;
