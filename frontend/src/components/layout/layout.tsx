import React from 'react';
import { Outlet } from 'react-router-dom';
import { Github, Globe, Hotel } from 'lucide-react';

const MainLayout: React.FC = () => {
  return (
    <div className="flex flex-col min-h-screen bg-white font-sans text-slate-900">
      
      {/* --- HEADER --- */}
      <header className="flex justify-between items-center px-8 py-4 bg-white border-b border-gray-100 sticky top-0 z-50 shadow-sm">
        
        <div className="flex items-center gap-3">
        {/* Logo */}
          <div className="p-2 rounded-lg shadow-lg">
            <Hotel size={40} className="text-[#1e293b]" strokeWidth={1.5} />
          </div>

          <div className="flex flex-col leading-none">
            <span className="text-4xl font-ahsing text-[#1e293b] tracking-wide">
              Horizon
            </span>
            <span className="text-[10px] font-bold tracking-[0.3em] uppercase text-slate-400 ml-1">
              Hotel & Resort
            </span>
          </div>
        </div>
      </header>
      
      <main className="grow">
        <Outlet />
      </main>

      {/* --- FOOTER --- */}
      <footer className="bg-[#1e293b] text-white px-12 py-2">
        {/* Parte Superior: Logo e Link Github */}
        <div className="max-w-full mx-auto flex flex-col md:flex-row justify-between items-end border-b border-slate-700 pb-6">
          
          {/* Lado Esquerdo: Logo e Slogan */}
          <div className="flex flex-col gap-2">
            <div className="flex items-center gap-3">
              <div className="p-2 rounded-lg bg-slate-800/50">
                <Hotel size={40} className="text-white" strokeWidth={1.5} />
              </div>
              <div className="flex flex-col leading-none">
                <span className="text-4xl font-ahsing text-white tracking-wide">
                  Horizon
                </span>
                <span className="text-[10px] font-bold tracking-[0.3em] uppercase text-slate-400 ml-1">
                  Hotel & Resort
                </span>
              </div>
            </div>
            <p className="text-slate-400 text-sm ml-1">
              Experiência de luxo e conforto em cada detalhe da sua estadia.
            </p>
          </div>

          {/* Lado Direito: Github Maior */}
          <div className="flex items-center">
            <a 
              href="https://github.com/LuisH07/hotel-reservations" 
              target="_blank" 
              rel="noopener noreferrer"
              className="hover:text-blue-400 transition-all flex flex-col items-center gap-1"
              title="GitHub"
            >
              <Github size={40} />
              <span className="text-[9px] font-bold tracking-widest">GITHUB</span>
            </a>
          </div>
        </div>

        {/* Parte Inferior: Copyright (Menos espaço superior) */}
        <div className="max-w-full mx-auto mt-4 flex flex-col md:flex-row justify-between text-slate-500 text-[11px] uppercase tracking-wider">
          <p>© 2026 Horizon Hotel Group. Todos os direitos reservados.</p>
          
          <div className="flex gap-6 mt-3 md:mt-0 items-center">
            <div className="flex items-center gap-1.5 ml-2 border-l border-slate-700 pl-6">
              <Globe size={14} />
              <span>Português (BR)</span>
            </div>
          </div>
        </div>
      </footer>
    </div>
  );
};

export default MainLayout;