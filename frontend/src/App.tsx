import { BrowserRouter, Routes, Route } from 'react-router-dom';
import MainLayout from './components/layout/layout';
import MinhasReservasPage from './pages/MinhasReservasPage';
import LoginPage from './pages/LoginPage';
import CadastroPage from './pages/CadastroPage';

const Home = () => (
  <div className="p-10">
    <div className="text-2xl font-bold text-slate-900">Bem-vindo à Homepage do Horizon!</div>
  </div>
);

function App() {
  return (
    <BrowserRouter>
      <Routes>
        <Route path="/" element={<LoginPage />} />
        <Route path="/cadastro" element={<CadastroPage />} />
        
        <Route path="/home" element={<MainLayout />}>
          
          <Route index element={<Home />} />

          <Route path="reservas" element={<MinhasReservasPage />} />
          
        </Route>
      </Routes>
    </BrowserRouter>
  );
}

export default App;