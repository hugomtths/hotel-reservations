import React, { useState } from 'react';
import { useNavigate } from 'react-router-dom';
import RoomCard from '../components/room/RoomCard';
import styles from './RoomsListPage.module.css';
import toast from 'react-hot-toast';

interface CategoriaResponse {
  id: number;
  nome: string;
  capacidade: number;
  precoDiaria: number;
}

interface Room {
  id: number;
  numero: string;
  status: 'DISPONIVEL' | 'OCUPADO' | 'MANUTENCAO';
  area: number;
  hotelId: number;
  categoria: CategoriaResponse;
  image?: string;
}

const Rooms: React.FC = () => {
  const navigate = useNavigate();
  const [selectedRoom, setSelectedRoom] = useState<Room | null>(null);
  const [isEditMode, setIsEditMode] = useState(false);
  const [roomToDelete, setRoomToDelete] = useState<number | null>(null);

  // Mock atualizado para bater com a estrutura do seu Backend
  const [rooms, setRooms] = useState<Room[]>([
    { 
      id: 1, 
      numero: "101-A", 
      status: 'DISPONIVEL', 
      area: 25.5, 
      hotelId: 1, 
      categoria: { id: 1, nome: 'Standard Solo', capacidade: 1, precoDiaria: 200.00 },
      image: 'https://images.unsplash.com/photo-1566665797739-1674de7a421a?auto=format&fit=crop&w=600&q=80'
    },
    { 
      id: 2, 
      numero: "202-B", 
      status: 'OCUPADO', 
      area: 45.0, 
      hotelId: 1, 
      categoria: { id: 2, nome: 'Double Deluxe', capacidade: 2, precoDiaria: 450.00 },
      image: 'https://images.unsplash.com/photo-1590490360182-c33d57733427?auto=format&fit=crop&w=600&q=80'
    },
    { 
      id: 3, 
      numero: "303-C", 
      status: 'MANUTENCAO', 
      area: 80.0, 
      hotelId: 1, 
      categoria: { id: 3, nome: 'Suíte Master', capacidade: 4, precoDiaria: 800.00 },
      image: 'https://images.unsplash.com/photo-1582719478250-c89cae4dc85b?auto=format&fit=crop&w=600&q=80'
    },
  ]);

  const openDeletePrompt = (id: number) => {
    setRoomToDelete(id);
  };

  const confirmDelete = async () => {
    if (roomToDelete) {
      try {
        // Simulação de DELETE na API
        setRooms(rooms.filter(room => room.id !== roomToDelete));
        setRoomToDelete(null);
        toast.success("Quarto excluído com sucesso!");
      } catch (error) {
        console.error("Erro ao excluir:", error);
        toast.error("Erro ao conectar com o servidor.");
      }
    }
  };

  const openModal = (room: Room) => {
    setSelectedRoom(room);
    setIsEditMode(false);
  };

  const closeModal = () => {
    setSelectedRoom(null);
    setIsEditMode(false);
  };

  return (
    <div className={styles.container}>
      <header className={styles.header}>
        <div className={styles.titleGroup}>
          <h1>Gerenciamento de Quartos</h1>
          <p>{rooms.length} quartos cadastrados no sistema</p>
        </div>
        <button 
          className={styles.addButton} 
          onClick={() => navigate('/quartos/novo')}
        >
          + Novo Quarto
        </button>
      </header>

      <div className={styles.grid}>
        {rooms.map(room => (
          <RoomCard 
            key={room.id}
            id={room.id}
            type={room.categoria.nome}
            description={`Quarto ${room.numero} • ${room.area}m²`}
            price={`R$ ${room.categoria.precoDiaria.toFixed(2)} / noite`}
            image={room.image || "https://images.unsplash.com/photo-1566665797739-1674de7a421a?auto=format&fit=crop&w=600&q=80"}
            onCardClick={() => openModal(room)}
            onDelete={() => openDeletePrompt(room.id)}
          />
        ))}
      </div>

      {/* POPUP DE CONFIRMAÇÃO DE DELEÇÃO */}
      {roomToDelete && (
        <div className={styles.modalOverlay} onClick={() => setRoomToDelete(null)}>
          <div className={styles.deletePopup} onClick={e => e.stopPropagation()}>
            <div className={styles.warningIcon}>⚠️</div>
            <h3>Confirmar Exclusão</h3>
            <p>
              Tem certeza que deseja excluir o quarto <strong>#{roomToDelete}</strong>? 
              Esta ação removerá todos os registros associados.
            </p>
            <div className={styles.popupActions}>
              <button className={styles.cancelBtn} onClick={() => setRoomToDelete(null)}>
                Cancelar
              </button>
              <button className={styles.confirmDeleteBtn} onClick={confirmDelete}>
                Sim, Excluir
              </button>
            </div>
          </div>
        </div>
      )}

      {/* MODAL DE DETALHES / EDIÇÃO */}
      {selectedRoom && (
        <div className={styles.modalOverlay} onClick={closeModal}>
          <div className={`${styles.modalContent} ${isEditMode ? styles.editMode : ''}`} onClick={e => e.stopPropagation()}>
            <header className={styles.modalHeader}>
              <h2>{isEditMode ? `Editando Quarto ${selectedRoom.numero}` : `Detalhes do Quarto ${selectedRoom.numero}`}</h2>
              <span className={`${styles.badge} ${styles[selectedRoom.status.toLowerCase()]}`}>
                {selectedRoom.status}
              </span>
            </header>

            <div className={styles.modalBody}>
              {/* Foto sempre visível no topo (Visualização ou Edição) */}
              <div className={styles.modalImageContainer}>
                <img src={selectedRoom.image} alt="Quarto" className={styles.modalMainImage} />
              </div>

              {isEditMode ? (
                <form className={styles.editForm}>
                  <div className={styles.formRow}>
                    <div className={styles.inputGroup}>
                      <label>Número</label>
                      <input type="text" defaultValue={selectedRoom.numero} />
                    </div>
                    <div className={styles.inputGroup}>
                      <label>Área (m²)</label>
                      <input type="number" defaultValue={selectedRoom.area} />
                    </div>
                  </div>

                  <div className={styles.formRow}>
                    <div className={styles.inputGroup}>
                      <label>Status</label>
                      <select defaultValue={selectedRoom.status}>
                        <option value="DISPONIVEL">Disponível</option>
                        <option value="OCUPADO">Ocupado</option>
                        <option value="MANUTENCAO">Manutenção</option>
                      </select>
                    </div>
                    <div className={styles.inputGroup}>
                      <label>Categoria</label>
                      <select defaultValue={selectedRoom.categoria.id}>
                        <option value={selectedRoom.categoria.id}>{selectedRoom.categoria.nome}</option>
                      </select>
                    </div>
                  </div>
                </form>
              ) : (
                <div className={styles.viewDetails}>
                  <div className={styles.detailsGrid}>
                    <div className={styles.detailItem}><strong>Categoria</strong><span>{selectedRoom.categoria.nome}</span></div>
                    <div className={styles.detailItem}><strong>Área</strong><span>{selectedRoom.area} m²</span></div>
                    <div className={styles.detailItem}><strong>Capacidade</strong><span>{selectedRoom.categoria.capacidade} Pessoas</span></div>
                    <div className={styles.detailItem}><strong>Preço</strong><span className={styles.highlightPrice}>R$ {selectedRoom.categoria.precoDiaria.toFixed(2)}</span></div>
                  </div>
                </div>
              )}
            </div>

            <footer className={styles.modalFooter}>
              <button className={styles.secondaryBtn} onClick={() => setIsEditMode(!isEditMode)}>
                {isEditMode ? 'Cancelar' : 'Editar Dados'}
              </button>
              <button className={styles.primaryBtn} onClick={isEditMode ? () => { toast.success("Salvo!"); closeModal(); } : closeModal}>
                {isEditMode ? 'Salvar' : 'Fechar'}
              </button>
            </footer>
          </div>
        </div>
      )}
    </div>
  );
};

export default Rooms;