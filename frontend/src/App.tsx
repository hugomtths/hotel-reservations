import { BrowserRouter, Routes, Route } from 'react-router-dom';
import MainLayout from './components/layout/layout';
import Register from './pages/Register';
import Home from './pages/Home';
import MinhasReservasPage from './pages/MinhasReservasPage';
import LoginPage from './pages/LoginPage';
import CadastroPage from './pages/CadastroPage';

function App() {
  return (
    <BrowserRouter>
      <Routes>
        <Route path="/" element={<LoginPage />} />
        <Route path="/cadastro" element={<CadastroPage />} />
        
        <Route path="/home" element={<MainLayout />}>
          
          <Route index element={<Home />} />
          
          <Route path="cadastro" element={<Register />} />

          <Route path="reservas" element={<MinhasReservasPage />} />
          
        </Route>
      </Routes>
    </BrowserRouter>
  );
}

export default App;