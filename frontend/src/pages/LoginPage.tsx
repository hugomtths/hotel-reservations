import React from 'react';
import LoginForm from '../components/LoginForm';
import styles from './LoginPage.module.css';

// Imagem de placeholder pois o arquivo local não foi encontrado
const bgImage = "https://images.unsplash.com/photo-1566073771259-6a8506099945?ixlib=rb-4.0.3&auto=format&fit=crop&w=1920&q=80";

const LoginPage: React.FC = () => {
  // Esta página é um container visual.
  // A lógica de conexão com o backend está no componente <LoginForm />
  // que utiliza o authService.ts
  return (
    <div 
      className={styles.container}
      style={{ backgroundImage: `url(${bgImage})` }}
    >
      <div className={styles.content}>
        <LoginForm />
      </div>
    </div>
  );
};

export default LoginPage;