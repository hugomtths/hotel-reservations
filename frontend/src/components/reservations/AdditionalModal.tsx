import React from 'react';
import styles from './AdditionalModal.module.css';

export interface AdditionalServiceData {
  id?: number;
  nomeServico: string;
  descricao: string;
  preco: number;
}

interface AdditionalServiceModalProps {
  onClose: () => void;
  onSave: (servico: AdditionalServiceData) => void;
  initialData?: AdditionalServiceData | null;
}

const AdditionalServiceModal: React.FC<AdditionalServiceModalProps> = ({ onClose, onSave, initialData }) => {
  const isEditing = !!initialData;

  const handleSubmit = (e: React.FormEvent<HTMLFormElement>) => {
    e.preventDefault();
    const formData = new FormData(e.currentTarget);
    
    onSave({
      id: initialData?.id,
      nomeServico: formData.get('nomeServico') as string,
      descricao: formData.get('descricao') as string,
      preco: Number(formData.get('preco')),
    });
  };

  return (
    <div className={styles.overlay} onClick={onClose}>
      <div 
        className={styles.miniDialog} 
        style={{ width: '450px' }} 
        onClick={e => e.stopPropagation()}
      >
        <h3 style={{ marginBottom: '1.5rem', color: '#1e293b' }}>
          {isEditing ? 'Editar Serviço Adicional' : 'Novo Serviço Adicional'}
        </h3>
        
        <form onSubmit={handleSubmit}>
          <div className={styles.inputGroup}>
            <label>Nome do Serviço</label>
            <input 
              name="nomeServico" 
              type="text" 
              placeholder="Ex: Frigobar Completo, Lavanderia" 
              defaultValue={initialData?.nomeServico} 
              required 
            />
          </div>

          <div className={styles.inputGroup}>
            <label>Descrição</label>
            <textarea 
              name="descricao" 
              placeholder="Descreva o que está incluso no serviço..." 
              defaultValue={initialData?.descricao}
              required
              style={{ 
                width: '100%', 
                minHeight: '80px', 
                padding: '0.5rem', 
                borderRadius: '4px', 
                border: '1px solid #cbd5e1',
                fontFamily: 'inherit'
              }}
            />
          </div>

          <div className={styles.inputGroup}>
            <label>Preço (R$)</label>
            <input 
              name="preco" 
              type="number" 
              step="0.01" 
              placeholder="0.00" 
              defaultValue={initialData?.preco} 
              required 
            />
          </div>

          <div className={styles.dialogBtns} style={{ marginTop: '1.5rem' }}>
            <button type="button" onClick={onClose}>Cancelar</button>
            <button type="submit" className={styles.confirmBtn}>
              {isEditing ? 'Salvar Alterações' : 'Cadastrar Serviço'}
            </button>
          </div>
        </form>
      </div>
    </div>
  );
};

export default AdditionalServiceModal;