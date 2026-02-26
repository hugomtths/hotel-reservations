import { useState } from "react";
import DateInput from "../components/ui/Date";
import { Search } from "lucide-react";
import styles from "./HomePage.module.css";
import RoomCard from "../components/room/RoomCard";
import toast from "react-hot-toast";

const MOCK_ROOMS = [
  { id: 1, type: "Standart", description: "Cama única de solteiro", date: "21 - 27 de mar.", price: "R$150 noite", image: "https://images.unsplash.com/photo-1566665797739-1674de7a421a?auto=format&fit=crop&w=600&q=80" },
  { id: 2, type: "Suíte", description: "Duas camas de casal", date: "23 de mar. - 25 de mar.", price: "R$400 noite", image: "https://images.unsplash.com/photo-1590490360182-c33d57733427?auto=format&fit=crop&w=600&q=80" },
  { id: 3, type: "Suíte", description: "Cama única de casal e duas camas de solteiro", date: "31 de mar. - 17 de abr.", price: "R$420 noite", image: "https://images.unsplash.com/photo-1582719478250-c89cae4dc85b?auto=format&fit=crop&w=600&q=80" },
  { id: 4, type: "Standart", description: "Cama única de casal", date: "20 - 29 de mar.", price: "R$200 noite", image: "https://images.unsplash.com/photo-1611892440504-42a792e24d32?auto=format&fit=crop&w=600&q=80" },
  { id: 5, type: "Standart", description: "Duas camas de solteiro", date: "22 de mar. - 05 de abr.", price: "R$220 noite", image: "https://images.unsplash.com/photo-1595576508898-0ad5c879a061?auto=format&fit=crop&w=600&q=80" },
  { id: 6, type: "Standart", description: "Cama única de casal", date: "02 de abr. - 25 abr.", price: "R$200 noite", image: "https://images.unsplash.com/photo-1560185127-6ed189bf02f4?auto=format&fit=crop&w=600&q=80" },
];

const HomePage = () => {
  const [booking, setBooking] = useState({
    checkIn: "",
    checkOut: "",
  });

  const [showCatalog, setShowCatalog] = useState(false);

  const handleChange = (event: { target: { name: string; value: string } }) => {
    const { name, value } = event.target;
    setBooking((prev) => ({ ...prev, [name]: value }));
    
    if (showCatalog) setShowCatalog(false);
  };

  const handleSearch = () => {
    const { checkIn, checkOut } = booking;

    if (!checkIn || !checkOut) {
      toast.error("Por favor, preencha as datas de entrada e saída.", 
      );
      return;
    }

    const today = new Date();
    today.setHours(0, 0, 0, 0);
    const dateIn = new Date(checkIn);
    const dateOut = new Date(checkOut);

    if (dateIn < today) {
      toast.error("A data de entrada não pode ser no passado!");
      return;
    }

    if (dateOut <= dateIn) {
      toast.error("A data de saída deve ser posterior à entrada.");
      return;
    }

    setShowCatalog(true);
  };

  const today = new Date().toISOString().split('T')[0];

  return (
    <div className={styles.homeContainer}>
      <section className={styles.heroSection}>
        <img
          src="https://images.unsplash.com/photo-1566073771259-6a8506099945?ixlib=rb-4.0.3&auto=format&fit=crop&w=1920&q=80"
          alt="Horizon Hotel Exterior"
          className={styles.heroImage}
        />
        <div className={styles.heroOverlay}></div>
      </section>

      <section className={styles.searchSection}>
        <div className={styles.searchContent}>
          <h2 className={styles.title}>Período da Acomodação</h2>

          <div className={styles.formGroup}>
            <div className={styles.inputWrapper}>
              <DateInput
                label="Entrada"
                name="checkIn"
                value={booking.checkIn}
                onChange={handleChange}
                message="Data de Entrada"
                required={false}
                disabled={false}
                min={today}
              />
            </div>

            <div className={styles.inputWrapper}>
              <DateInput
                label="Saída"
                name="checkOut"
                value={booking.checkOut}
                onChange={handleChange}
                message="Data de Saída"
                required={false}
                disabled={false}
                min={booking.checkIn || today}
              />
            </div>

            <button 
              className={styles.searchButton} 
              aria-label="Buscar disponibilidade"
              onClick={handleSearch}
            >
              <Search size={24} strokeWidth={2.5} />
            </button>
          </div>
          
          {!showCatalog && (!booking.checkIn || !booking.checkOut) && (
            <p className={styles.helperText}>
              Digite a data para consultar os quartos disponíveis!
            </p>
          )}
        </div>
      </section>

      {showCatalog && (
        <main className={styles.catalogSection}>
          <header className={styles.catalogHeader}>
            <h1 className={styles.catalogTitle}>Catálogo de Quartos</h1>
            <p className={styles.catalogSubtitle}>Quartos disponíveis</p>
          </header>

          <div className={styles.roomsGrid}>
            {MOCK_ROOMS.map((room) => (
              <RoomCard 
                key={room.id}
                type={room.type}
                description={room.description}
                date={room.date}
                price={room.price}
                image={room.image}
              />
            ))}
          </div>
        </main>
      )}
      
      <div className={styles.spacer}></div>
    </div>
  );
};

export default HomePage;