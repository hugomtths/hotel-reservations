import { BrowserRouter, Routes, Route } from 'react-router-dom';
import MainLayout from './components/layout/layout';

const Home = () => <div className="p-10 text-2xl font-bold">Bem-vindo à Homepage do Horizon!</div>;
const Cadastro = () => <div className="p-10 text-2xl font-bold">Tela de Cadastro de Usuário</div>;

function App() {
  return (
    <BrowserRouter>
      <Routes>
        <Route path="/" element={<MainLayout />}>
          
          <Route index element={<Home />} />
          
          <Route path="cadastro" element={<Cadastro />} />
          
        </Route>
      </Routes>
    </BrowserRouter>
  );
}

export default App;