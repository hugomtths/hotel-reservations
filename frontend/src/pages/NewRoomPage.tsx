import React, { useState, useRef, useEffect } from 'react';
import { useNavigate } from 'react-router-dom';
import styles from './NewRoomPage.module.css';
import toast from 'react-hot-toast';
import CategoryModal from '../components/room/CategoryModal';

interface Item {
  id: number;
  nome: string;
}

interface Categoria {
  id?: number;
  precoDiaria: number;
  nome: string;
  capacidade: number;
}

const NewRoomPage: React.FC = () => {
  const navigate = useNavigate();
  const editInputRef = useRef<HTMLInputElement>(null);
  const dropdownRef = useRef<HTMLDivElement>(null);

  // Dados
  const [categorias, setCategorias] = useState<Item[]>([
    { id: 1, nome: 'Standard Solo' },
    { id: 2, nome: 'Double Deluxe' }
  ]);
  const [comodidades, setComodidades] = useState<Item[]>([
    { id: 1, nome: 'Wi-Fi' },
    { id: 2, nome: 'Ar Condicionado' },
    { id: 3, nome: 'Frigobar' }
  ]);

  // Estados de Controle
  const [selectedCat, setSelectedCat] = useState<Item | null>(null);
  const [isSelectOpen, setIsSelectOpen] = useState(false);
  const [selectedComods, setSelectedComods] = useState<number[]>([]);
  const [isAddingComod, setIsAddingComod] = useState(false);
  const [isAddingCat, setIsAddingCat] = useState(false);
  const [editingItem, setEditingItem] = useState<{ tipo: 'cat' | 'com'; item: Item } | null>(null);

  // Fechar dropdown ao clicar fora
  useEffect(() => {
    const handleClickOutside = (event: MouseEvent) => {
      if (dropdownRef.current && !dropdownRef.current.contains(event.target as Node)) {
        setIsSelectOpen(false);
      }
    };
    document.addEventListener('mousedown', handleClickOutside);
    return () => document.removeEventListener('mousedown', handleClickOutside);
  }, []);

  const handleAddQuickComod = (nome: string) => {
    if (!nome.trim()) return;
    const novoItem = { id: Date.now(), nome };
    setComodidades([...comodidades, novoItem]);
    toast.success("Comodidade criada!");
  };

  const handleUpdate = () => {
    const novoNome = editInputRef.current?.value;
    if (!editingItem || !novoNome) return;

    if (editingItem.tipo === 'cat') {
      setCategorias(prev => prev.map(i => i.id === editingItem.item.id ? { ...i, nome: novoNome } : i));
      if (selectedCat?.id === editingItem.item.id) setSelectedCat({ ...editingItem.item, nome: novoNome });
    } else {
      setComodidades(prev => prev.map(i => i.id === editingItem.item.id ? { ...i, nome: novoNome } : i));
    }

    setEditingItem(null);
    toast.success("Atualizado com sucesso!");
  };

  const handleDeleteWithConfirm = (id: number, tipo: 'cat' | 'com') => {
    toast((t) => (
      <span className={styles.toastConfirm}>
        Excluir {tipo === 'cat' ? 'categoria' : 'comodidade'}?
        <button
          onClick={() => {
            if (tipo === 'cat') {
              setCategorias(prev => prev.filter(i => i.id !== id));
              if (selectedCat?.id === id) setSelectedCat(null);
            } else {
              setComodidades(prev => prev.filter(i => i.id !== id));
              setSelectedComods(prev => prev.filter(item => item !== id));
            }
            toast.dismiss(t.id);
            toast.error("Removido com sucesso");
          }}
          className={styles.toastBtnSim}
        > Sim </button>
        <button onClick={() => toast.dismiss(t.id)} className={styles.toastBtnNao}> Não </button>
      </span>
    ), { duration: 4000 });
  };

  const toggleComod = (id: number) => {
    setSelectedComods(prev => prev.includes(id) ? prev.filter(i => i !== id) : [...prev, id]);
  };

  const handleSubmit = (e: React.FormEvent<HTMLFormElement>) => {
    e.preventDefault();
    const formData = new FormData(e.currentTarget);

    const payload = {
      numero: formData.get('numero'),
      area: formData.get('area'),
      status: "DISPONIVEL",
      categoria: { id: selectedCat?.id },
      comodidades: selectedComods.map(id => ({ id }))
    };

    if (!payload.categoria.id || !payload.numero) {
      toast.error("Número e Categoria são obrigatórios!");
      return;
    }

    console.log("Payload Final:", payload);
    toast.success("Quarto cadastrado com sucesso!");
    navigate('/quartos');
  };

  const handleSaveCategory = async (novaCat: Categoria) => {
    const categoriaSalva = { id: Date.now(), nome: novaCat.nome };
    setCategorias([...categorias, categoriaSalva]);
    setIsAddingCat(false);
    toast.success("Categoria criada!");
  };

  return (
    <div className={styles.container}>
      <header className={styles.header}>
        <h1>Novo Quarto</h1>
      </header>

      <form className={styles.mainForm} onSubmit={handleSubmit}>
        <div className={styles.row}>
          <div className={styles.inputGroup}>
            <label>Número do Quarto</label>
            <input name="numero" type="text" placeholder="Ex: 101-A" required />
          </div>
          <div className={styles.inputGroup}>
            <label>Área (m²)</label>
            <input name="area" type="number" step="0.01" placeholder="0.00" />
          </div>
        </div>

        {/* SELECT CATEGORIA PERSONALIZADO */}
        <div className={styles.inputGroup}>
          <div className={styles.labelWithAction}>
            <label>Categoria</label>
            <button type="button" className={styles.textActionBtn} onClick={() => setIsAddingCat(true)}>
              + Nova Categoria
            </button>
          </div>

          <div className={styles.customSelectContainer} ref={dropdownRef}>
            <div
              className={`${styles.customSelectTrigger} ${isSelectOpen ? styles.open : ''}`}
              onClick={() => setIsSelectOpen(!isSelectOpen)}
            >
              <span>{selectedCat ? selectedCat.nome : "Selecione uma categoria..."}</span>
              <span className={styles.arrow}>{isSelectOpen ? '▲' : '▼'}</span>
            </div>

            {isSelectOpen && (
              <div className={styles.customOptionsList}>
                {categorias.map(cat => (
                  <div key={cat.id} className={styles.customOptionItem}>
                    <span
                      className={styles.optionText}
                      onClick={() => {
                        setSelectedCat(cat);
                        setIsSelectOpen(false);
                      }}
                    >
                      {cat.nome}
                    </span>
                    <div className={styles.optionActions}>
                      <button
                        type="button"
                        onClick={(e) => { e.stopPropagation(); setEditingItem({ tipo: 'cat', item: cat }); }}
                        className={styles.editIcon}
                      >
                        <svg 
                            width="14" height="14" viewBox="0 0 24 24" fill="none" 
                            stroke="currentColor" strokeWidth="2.5" strokeLinecap="round" strokeLinejoin="round"
                        >
                            <path d="M11 4H4a2 2 0 0 0-2 2v14a2 2 0 0 0 2 2h14a2 2 0 0 0 2-2v-7"></path>
                            <path d="M18.5 2.5a2.121 2.121 0 0 1 3 3L12 15l-4 1 1-4 9.5-9.5z"></path>
                        </svg>
                      </button>
                      
                      <button
                        type="button"
                        className={styles.deleteIcon}
                        onClick={(e) => {
                            e.stopPropagation();
                            handleDeleteWithConfirm(cat.id, 'cat');
                        }}
                        title="Excluir"
                        >
                        <svg 
                            xmlns="http://www.w3.org/2000/svg" 
                            width="16" 
                            height="16" 
                            viewBox="0 0 24 24" 
                            fill="none" 
                            stroke="currentColor" 
                            strokeWidth="2" 
                            strokeLinecap="round" 
                            strokeLinejoin="round"
                        >
                            <path d="M3 6h18"></path>
                            <path d="M19 6v14c0 1-1 2-2 2H7c-1 0-2-1-2-2V6"></path>
                            <path d="M8 6V4c0-1 1-2 2-2h4c1 0 2 1 2 2v2"></path>
                            <line x1="10" y1="11" x2="10" y2="17"></line>
                            <line x1="14" y1="11" x2="14" y2="17"></line>
                        </svg>
                        </button>
                    </div>
                  </div>
                ))}
              </div>
            )}
          </div>
        </div>

        {/* CHIPS DE COMODIDADES */}
        <div className={styles.inputGroup}>
          <label>Comodidades</label>
          <div className={styles.chipsGrid}>
            {comodidades.map(com => (
              <div
                key={com.id}
                className={`${styles.chipWrapper} ${selectedComods.includes(com.id) ? styles.chipSelected : ''}`}
              >
                <span className={styles.chipText} onClick={() => toggleComod(com.id)}>
                  {com.nome}
                </span>
                <div className={styles.chipActions}>
                    <button 
                        type="button" 
                        className={styles.editIcon}
                        onClick={() => setEditingItem({ tipo: 'com', item: com })}
                        title="Editar"
                    >
                        <svg 
                        width="14" height="14" viewBox="0 0 24 24" fill="none" 
                        stroke="currentColor" strokeWidth="2.5" strokeLinecap="round" strokeLinejoin="round"
                        >
                            <path d="M11 4H4a2 2 0 0 0-2 2v14a2 2 0 0 0 2 2h14a2 2 0 0 0 2-2v-7"></path>
                            <path d="M18.5 2.5a2.121 2.121 0 0 1 3 3L12 15l-4 1 1-4 9.5-9.5z"></path>
                        </svg>
                    </button>

                    {/* ÍCONE DE EXCLUSÃO (LIXEIRA) */}
                    <button 
                        type="button" 
                        className={styles.deleteIcon} 
                        onClick={() => handleDeleteWithConfirm(com.id, 'com')}
                        title="Excluir"
                    >
                        <svg 
                        width="14" height="14" viewBox="0 0 24 24" fill="none" 
                        stroke="currentColor" strokeWidth="2.5" strokeLinecap="round" strokeLinejoin="round"
                        >
                            <polyline points="3 6 5 6 21 6"></polyline>
                            <path d="M19 6v14a2 2 0 0 1-2 2H7a2 2 0 0 1-2-2V6m3 0V4a2 2 0 0 1 2-2h4a2 2 0 0 1 2 2v2"></path>
                            <line x1="10" y1="11" x2="10" y2="17"></line>
                            <line x1="14" y1="11" x2="14" y2="17"></line>
                        </svg>
                    </button>
                </div>
              </div>
            ))}

            {isAddingComod ? (
              <input
                className={styles.inlineInput}
                autoFocus
                onKeyDown={(e) => {
                  if (e.key === 'Enter') {
                    handleAddQuickComod(e.currentTarget.value);
                    setIsAddingComod(false);
                  }
                }}
                onBlur={() => setIsAddingComod(false)}
                placeholder="Nome..."
              />
            ) : (
              <button type="button" className={styles.addChipBtn} onClick={() => setIsAddingComod(true)}>
                + Adicionar
              </button>
            )}
          </div>
        </div>

        <div className={styles.formFooter}>
          <button type="submit" className={styles.saveBtn}>Cadastrar Quarto</button>
        </div>
      </form>

      {/* MODAL DE EDIÇÃO DE NOME */}
      {editingItem && (
        <div className={styles.overlay} onClick={() => setEditingItem(null)}>
          <div className={styles.miniDialog} onClick={e => e.stopPropagation()}>
            <p>Editar Nome</p>
            <input
              ref={editInputRef}
              autoFocus
              defaultValue={editingItem.item.nome}
              onKeyDown={(e) => e.key === 'Enter' && handleUpdate()}
            />
            <div className={styles.dialogBtns}>
              <button type="button" onClick={() => setEditingItem(null)}>Cancelar</button>
              <button type="button" className={styles.confirmBtn} onClick={handleUpdate}>Salvar</button>
            </div>
          </div>
        </div>
      )}

      {/* MODAL DE NOVA CATEGORIA (CAMPOS COMPLETOS) */}
      {isAddingCat && (
        <CategoryModal
          onClose={() => setIsAddingCat(false)}
          onSave={handleSaveCategory}
        />
      )}
    </div>
  );
};

export default NewRoomPage;