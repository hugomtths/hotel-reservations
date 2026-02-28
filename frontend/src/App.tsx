import { BrowserRouter, Routes, Route } from 'react-router-dom';
import { Toaster } from 'react-hot-toast';

import MainLayout from './components/layout/layout';
import Home from './pages/HomePage';
import MinhasReservasPage from './pages/MinhasReservasPage';
import LoginPage from './pages/LoginPage';
import CadastroPage from './pages/CadastroPage';
import RoomPage from './pages/RoomPage';
import ReservationConfirm from './components/reservations/ReservationConfirm';
import RelatorioPage from './pages/RelatorioPage';

function App() {
  return (
    <BrowserRouter>
      <Toaster 
        position="bottom-right" 
        toastOptions={{
          error: {
            className: 'horizon-toast',
            duration: 5000,
            iconTheme: {
              primary: '#c53030',
              secondary: '#fff',
            },
          },
        }}
      />

      <Routes>
        <Route path="/" element={<LoginPage />} />
        <Route path="/cadastro" element={<CadastroPage />} />
        
        <Route element={<MainLayout />}>
          
          <Route path="/home" index element={<Home />} />
          
          <Route path="home/reservas" element={<MinhasReservasPage />} />

          <Route path="quarto/:id" element={<RoomPage />} />

          <Route path="reserva/confirmacao/:id" element={<ReservationConfirm />} />

          <Route path="home/relatorios" element={<RelatorioPage />} />
          
        </Route>
      </Routes>
    </BrowserRouter>
  );
}

export default App;