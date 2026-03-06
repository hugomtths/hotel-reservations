import React, { useState, useEffect } from 'react';
import { useLocation, useNavigate } from 'react-router-dom';
import { UserPlus, Search, ArrowLeft, CheckCircle } from 'lucide-react';
import styles from './HospedagemFormPage.module.css';
import toast from 'react-hot-toast';
import { 
  getQuartosDisponiveis, 
  getClienteByCpf, 
  createHospedagem, 
  type CriarHospedagemRequest,
  type QuartoDisponivel 
} from '../services/hostingService';

export const HospedagemFormPage: React.FC = () => {
  const location = useLocation();
  const navigate = useNavigate();
  const reservationData = location.state?.reservation;

  const [quartosDisponiveis, setQuartosDisponiveis] = useState<QuartoDisponivel[]>([]);
  const [loadingSearch, setLoadingSearch] = useState(false);
  const [loadingQuartos, setLoadingQuartos] = useState(false);

  const [formData, setFormData] = useState({
    cpf: reservationData?.clientCpf || '',
    nome: reservationData?.clientName || '',
    reservaId: reservationData?.id || '',
    quartoId: reservationData?.roomId || '',
    dataEntrada: new Date().toISOString().split('T')[0],
    dataSaida: reservationData?.endDate || '',
    metodoPagamento: '',
    valorTotal: reservationData?.totalValue || 0,
  });

  const isFromReservation = !!reservationData;

  useEffect(() => {
    const carregarQuartos = async () => {
      if (formData.dataEntrada && formData.dataSaida && !isFromReservation) {
        setLoadingQuartos(true);
        try {
          const data = await getQuartosDisponiveis(formData.dataEntrada, formData.dataSaida);
          setQuartosDisponiveis(data);
          
          if (!data.find(q => q.id === Number(formData.quartoId))) {
            setFormData(prev => ({ ...prev, quartoId: '' }));
          }
        } catch (error) {
         console.log("Erro ao buscar: ", error)
          toast.error("Erro ao buscar quartos para este período.");
        } finally {
          setLoadingQuartos(false);
        }
      }
    };

    carregarQuartos();
  }, [formData.dataEntrada, formData.dataSaida, isFromReservation, formData.quartoId]);

  const handleBuscarCliente = async () => {
    if (!formData.cpf) return toast.error("Digite um CPF para buscar");
    setLoadingSearch(true);
    try {
      const cliente = await getClienteByCpf(formData.cpf);
      setFormData(prev => ({ ...prev, nome: cliente.nome }));
      toast.success("Cliente localizado!");
    } catch (err) {
      toast.error("Cliente não encontrado: " + err);
      setFormData(prev => ({ ...prev, nome: '' }));
    } finally {
      setLoadingSearch(false);
    }
  };

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();

    if (!formData.nome) return toast.error("Busque um hóspede primeiro.");
    if (!formData.quartoId) return toast.error("Selecione um quarto.");

    const payload: CriarHospedagemRequest = {
      reservaId: formData.reservaId ? Number(formData.reservaId) : null,
      quartoId: Number(formData.quartoId),
      clienteCpf: formData.cpf,
      dataEntrada: formData.dataEntrada,
      dataSaida: formData.dataSaida,
      pagamento: {
        metodoPagamento: formData.metodoPagamento,
        status: 'PAGO',
        valorTotal: formData.valorTotal,
        dataPagamento: new Date().toISOString()
      }
    };

    try {
      await createHospedagem(payload);
      toast.success("Hospedagem iniciada com sucesso!");
      navigate('/reservas'); 
    } catch (error) {
        console.log("Erro ao salvar hospedagem: ", error)
      toast.error("Erro ao salvar hospedagem.");
    }
  };

  const isQuartoDisabled = isFromReservation || !formData.dataEntrada || !formData.dataSaida;

  return (
    <div className={styles.container}>
      <header className={styles.header}>
        <div className={styles.titleArea}>
          <h1>{isFromReservation ? 'Check-in de Reserva' : 'Nova Hospedagem Avulsa'}</h1>
          {isFromReservation && <span className={styles.badgeReserva}>Reserva Ativa</span>}
        </div>
        <p className={styles.subtitle}>Defina o período para visualizar os quartos disponíveis.</p>
      </header>
      
      <form onSubmit={handleSubmit} className={styles.formCard}>
        <section className={styles.section}>
          <h3 className={styles.sectionTitle}>Dados do Hóspede</h3>
          <div className={styles.row}>
            <div className={styles.inputGroup}>
              <label>CPF do Cliente</label>
              <div className={styles.inputWrapper}>
                <input 
                  type="text" 
                  value={formData.cpf} 
                  disabled={isFromReservation}
                  onChange={(e) => setFormData({...formData, cpf: e.target.value})}
                  placeholder="000.000.000-00"
                  required
                />
                {!isFromReservation && (
                  <>
                    <button type="button" className={styles.searchBtn} onClick={handleBuscarCliente} disabled={loadingSearch}>
                      <Search size={16} />
                    </button>
                    <button type="button" className={styles.addClientBtn} onClick={() => navigate('/cadastro')}>
                      <UserPlus size={16} />
                    </button>
                  </>
                )}
              </div>
            </div>
            <div className={styles.inputGroup}>
              <label>Nome Completo</label>
              <input type="text" value={formData.nome} disabled placeholder="Identifique o cliente..." />
            </div>
          </div>
        </section>

        <section className={styles.section}>
          <h3 className={styles.sectionTitle}>Informações da Estadia</h3>
          <div className={styles.row}>
            <div className={styles.inputGroup}>
              <label>Data de Entrada</label>
              <input 
                type="date" 
                value={formData.dataEntrada} 
                onChange={(e) => setFormData({...formData, dataEntrada: e.target.value})}
                required
              />
            </div>
            <div className={styles.inputGroup}>
              <label>Data de Saída</label>
              <input 
                type="date" 
                value={formData.dataSaida} 
                onChange={(e) => setFormData({...formData, dataSaida: e.target.value})}
                required
              />
            </div>
          </div>

          <div className={styles.row} style={{marginTop: '1.5rem'}}>
            <div className={styles.inputGroup}>
              <label>
                Quarto 
                {isQuartoDisabled && !isFromReservation && <span style={{fontSize: '0.7rem', color: '#e53e3e', marginLeft: '5px'}}>(Selecione as datas)</span>}
              </label>
              <select 
                value={formData.quartoId} 
                disabled={isQuartoDisabled || loadingQuartos}
                onChange={(e) => setFormData({...formData, quartoId: e.target.value})}
                required
              >
                {loadingQuartos ? (
                  <option>Buscando quartos...</option>
                ) : (
                  <>
                    <option value="">Selecione um quarto...</option>
                    {isFromReservation && (
                       <option value={formData.quartoId}>Quarto Reservado (ID: {formData.quartoId})</option>
                    )}
                    {quartosDisponiveis.map(q => (
                      <option key={q.id} value={q.id}>
                        Quarto {q.numero} - {q.tipo || 'Comum'}
                      </option>
                    ))}
                  </>
                )}
              </select>
            </div>
            <div className={styles.inputGroup}>
              <label>ID da Reserva</label>
              <input type="text" value={formData.reservaId || "Sem reserva prévia"} disabled />
            </div>
          </div>
        </section>

        <section className={styles.section}>
          <h3 className={styles.sectionTitle}>Pagamento</h3>
          <div className={styles.row}>
            <div className={styles.inputGroup}>
              <label>Método de Pagamento</label>
              <select 
                value={formData.metodoPagamento}
                onChange={(e) => setFormData({...formData, metodoPagamento: e.target.value})}
                required
              >
                <option value="">Selecione...</option>
                <option value="PIX">PIX</option>
                <option value="DINHEIRO">Dinheiro</option>
                <option value="CARTAO_CREDITO">Cartão de Crédito</option>
                <option value="CARTAO_DEBITO">Cartão de Débito</option>
              </select>
            </div>
            <div className={styles.inputGroup}>
              <label>Valor Total</label>
              <div className={styles.priceInputWrapper}>
                <span>R$</span>
                <input 
                  type="number" 
                  value={formData.valorTotal} 
                  onChange={(e) => setFormData({...formData, valorTotal: Number(e.target.value)})}
                  step="0.01"
                  required
                />
              </div>
            </div>
          </div>
        </section>

        <div className={styles.actions}>
          <button type="button" className={styles.cancelBtn} onClick={() => navigate(-1)}>
            <ArrowLeft size={18} />
            Voltar
          </button>
          <button type="submit" className={styles.confirmBtn}>
            <CheckCircle size={18} />
            Finalizar Hospedagem
          </button>
        </div>
      </form>
    </div>
  );
};

export default HospedagemFormPage;