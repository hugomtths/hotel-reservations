import React from 'react';
import { Link } from 'react-router-dom';
import styles from './RoomCard.module.css';

interface RoomCardProps {
  id: number; 
  type: string;
  description: string;
  checkIn: string; 
  checkOut: string; 
  price: string;
  image: string;
}

const RoomCard: React.FC<RoomCardProps> = ({ id, type, description, checkIn, checkOut, price, image }) => {
  // Monta a URL com os Query Params para persistência (F5 e navegação)
  const roomUrl = `/quarto/${id}?checkIn=${checkIn}&checkOut=${checkOut}`;

  return (
    <Link to={roomUrl} className={styles.cardLink}>
      <article className={styles.roomCard}>
        <img src={image} alt={type} className={styles.roomImage} />
        <div className={styles.roomInfo}>
          <h3 className={styles.roomType}>{type}</h3>
          <p className={styles.roomDescription}>{description}</p>
          
          {/* Exibição visual do período para o usuário */}
          <span className={styles.roomDate}>
            {checkIn} até {checkOut}
          </span>
          
          <span className={styles.roomPrice}>{price}</span>
        </div>
      </article>
    </Link>
  );
};

export default RoomCard;