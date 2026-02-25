-- Hotel e Dados Básicos
INSERT INTO hotel (nome, cnpj) VALUES ('Horizon Luxury Resort', '27164580000109');

WITH hotel_base AS (
  SELECT id FROM hotel WHERE cnpj = '27164580000109'
)
INSERT INTO endereco (hotel_id, cep, rua, numero, bairro, cidade, estado)
SELECT id, '55290000', 'Av. Rui Barbosa', '1000', 'Heliópolis', 'Garanhuns', 'PE'
FROM hotel_base;

WITH hotel_base AS (
  SELECT id FROM hotel WHERE cnpj = '27164580000109'
)
INSERT INTO email_hotel (hotel_id, email)
SELECT id, 'reservas@horizon.com.br'
FROM hotel_base;

WITH hotel_base AS (
  SELECT id FROM hotel WHERE cnpj = '27164580000109'
)
INSERT INTO email_hotel (hotel_id, email)
SELECT id, 'admin@horizon.com.br'
FROM hotel_base;

WITH hotel_base AS (
  SELECT id FROM hotel WHERE cnpj = '27164580000109'
)
INSERT INTO telefone_hotel (hotel_id, telefone)
SELECT id, '8737620000'
FROM hotel_base;

WITH hotel_base AS (
  SELECT id FROM hotel WHERE cnpj = '27164580000109'
)
INSERT INTO telefone_hotel (hotel_id, telefone)
SELECT id, '87999998888'
FROM hotel_base;

INSERT INTO categoria (preco_diaria, capacidade) VALUES (150.0, 2);
INSERT INTO categoria (preco_diaria, capacidade) VALUES (250.0, 3);
INSERT INTO categoria (preco_diaria, capacidade) VALUES (450.0, 4);
INSERT INTO categoria (preco_diaria, capacidade) VALUES (1200.0, 5);
INSERT INTO comodidade (nome) VALUES ('Wi-Fi');
INSERT INTO comodidade (nome) VALUES ('Ar Condicionado');
INSERT INTO comodidade (nome) VALUES ('Frigobar');
INSERT INTO comodidade (nome) VALUES ('Smart TV');
INSERT INTO comodidade (nome) VALUES ('Banheira');
INSERT INTO comodidade (nome) VALUES ('Vista Mar');
INSERT INTO comodidade (nome) VALUES ('Cofre');
INSERT INTO comodidade (nome) VALUES ('Varanda');
INSERT INTO servico_adicional (nome_servico, descricao, preco) VALUES ('Café da Manhã no Quarto', 'Completo', 50.0);
INSERT INTO servico_adicional (nome_servico, descricao, preco) VALUES ('Massagem Relaxante', '1 hora', 120.0);
INSERT INTO servico_adicional (nome_servico, descricao, preco) VALUES ('Translado Aeroporto', 'Ida e volta', 80.0);
INSERT INTO servico_adicional (nome_servico, descricao, preco) VALUES ('Jantar Romântico', 'Vinho incluso', 300.0);
INSERT INTO servico_adicional (nome_servico, descricao, preco) VALUES ('Lavanderia Express', 'Por peça', 15.0);

-- Quartos
WITH hotel_base AS (
  SELECT id FROM hotel WHERE cnpj = '27164580000109'
), categoria_base AS (
  SELECT id FROM categoria WHERE preco_diaria = 450.00 AND capacidade = 4
)
INSERT INTO quarto (hotel_id, categoria_id, numero, status, area)
SELECT h.id, c.id, '101', 'Limpeza', 26.00
FROM hotel_base h, categoria_base c;
WITH comodidade_base AS (
  SELECT id FROM comodidade WHERE nome = 'Frigobar'
), quarto_base AS (
  SELECT q.id
  FROM quarto q
  JOIN hotel h ON q.hotel_id = h.id
  WHERE q.numero = '101' AND h.cnpj = '27164580000109'
)
INSERT INTO quarto_comodidade (quarto_id, comodidade_id)
SELECT q.id, c.id
FROM quarto_base q
CROSS JOIN comodidade_base c;

WITH comodidade_base AS (
  SELECT id FROM comodidade WHERE nome = 'Banheira'
), quarto_base AS (
  SELECT q.id
  FROM quarto q
  JOIN hotel h ON q.hotel_id = h.id
  WHERE q.numero = '101' AND h.cnpj = '27164580000109'
)
INSERT INTO quarto_comodidade (quarto_id, comodidade_id)
SELECT q.id, c.id
FROM quarto_base q
CROSS JOIN comodidade_base c;

WITH comodidade_base AS (
  SELECT id FROM comodidade WHERE nome = 'Varanda'
), quarto_base AS (
  SELECT q.id
  FROM quarto q
  JOIN hotel h ON q.hotel_id = h.id
  WHERE q.numero = '101' AND h.cnpj = '27164580000109'
)
INSERT INTO quarto_comodidade (quarto_id, comodidade_id)
SELECT q.id, c.id
FROM quarto_base q
CROSS JOIN comodidade_base c;
WITH hotel_base AS (
  SELECT id FROM hotel WHERE cnpj = '27164580000109'
), categoria_base AS (
  SELECT id FROM categoria WHERE preco_diaria = 150.00 AND capacidade = 2
)
INSERT INTO quarto (hotel_id, categoria_id, numero, status, area)
SELECT h.id, c.id, '102', 'Disponível', 22.00
FROM hotel_base h, categoria_base c;
WITH comodidade_base AS (
  SELECT id FROM comodidade WHERE nome = 'Banheira'
), quarto_base AS (
  SELECT q.id
  FROM quarto q
  JOIN hotel h ON q.hotel_id = h.id
  WHERE q.numero = '102' AND h.cnpj = '27164580000109'
)
INSERT INTO quarto_comodidade (quarto_id, comodidade_id)
SELECT q.id, c.id
FROM quarto_base q
CROSS JOIN comodidade_base c;

WITH comodidade_base AS (
  SELECT id FROM comodidade WHERE nome = 'Wi-Fi'
), quarto_base AS (
  SELECT q.id
  FROM quarto q
  JOIN hotel h ON q.hotel_id = h.id
  WHERE q.numero = '102' AND h.cnpj = '27164580000109'
)
INSERT INTO quarto_comodidade (quarto_id, comodidade_id)
SELECT q.id, c.id
FROM quarto_base q
CROSS JOIN comodidade_base c;
WITH hotel_base AS (
  SELECT id FROM hotel WHERE cnpj = '27164580000109'
), categoria_base AS (
  SELECT id FROM categoria WHERE preco_diaria = 1200.00 AND capacidade = 5
)
INSERT INTO quarto (hotel_id, categoria_id, numero, status, area)
SELECT h.id, c.id, '103', 'Ocupado', 55.00
FROM hotel_base h, categoria_base c;
WITH comodidade_base AS (
  SELECT id FROM comodidade WHERE nome = 'Wi-Fi'
), quarto_base AS (
  SELECT q.id
  FROM quarto q
  JOIN hotel h ON q.hotel_id = h.id
  WHERE q.numero = '103' AND h.cnpj = '27164580000109'
)
INSERT INTO quarto_comodidade (quarto_id, comodidade_id)
SELECT q.id, c.id
FROM quarto_base q
CROSS JOIN comodidade_base c;

WITH comodidade_base AS (
  SELECT id FROM comodidade WHERE nome = 'Ar Condicionado'
), quarto_base AS (
  SELECT q.id
  FROM quarto q
  JOIN hotel h ON q.hotel_id = h.id
  WHERE q.numero = '103' AND h.cnpj = '27164580000109'
)
INSERT INTO quarto_comodidade (quarto_id, comodidade_id)
SELECT q.id, c.id
FROM quarto_base q
CROSS JOIN comodidade_base c;
WITH hotel_base AS (
  SELECT id FROM hotel WHERE cnpj = '27164580000109'
), categoria_base AS (
  SELECT id FROM categoria WHERE preco_diaria = 150.00 AND capacidade = 2
)
INSERT INTO quarto (hotel_id, categoria_id, numero, status, area)
SELECT h.id, c.id, '104', 'Disponível', 39.00
FROM hotel_base h, categoria_base c;
WITH comodidade_base AS (
  SELECT id FROM comodidade WHERE nome = 'Banheira'
), quarto_base AS (
  SELECT q.id
  FROM quarto q
  JOIN hotel h ON q.hotel_id = h.id
  WHERE q.numero = '104' AND h.cnpj = '27164580000109'
)
INSERT INTO quarto_comodidade (quarto_id, comodidade_id)
SELECT q.id, c.id
FROM quarto_base q
CROSS JOIN comodidade_base c;

WITH comodidade_base AS (
  SELECT id FROM comodidade WHERE nome = 'Varanda'
), quarto_base AS (
  SELECT q.id
  FROM quarto q
  JOIN hotel h ON q.hotel_id = h.id
  WHERE q.numero = '104' AND h.cnpj = '27164580000109'
)
INSERT INTO quarto_comodidade (quarto_id, comodidade_id)
SELECT q.id, c.id
FROM quarto_base q
CROSS JOIN comodidade_base c;
WITH hotel_base AS (
  SELECT id FROM hotel WHERE cnpj = '27164580000109'
), categoria_base AS (
  SELECT id FROM categoria WHERE preco_diaria = 150.00 AND capacidade = 2
)
INSERT INTO quarto (hotel_id, categoria_id, numero, status, area)
SELECT h.id, c.id, '105', 'Disponível', 36.00
FROM hotel_base h, categoria_base c;
WITH comodidade_base AS (
  SELECT id FROM comodidade WHERE nome = 'Wi-Fi'
), quarto_base AS (
  SELECT q.id
  FROM quarto q
  JOIN hotel h ON q.hotel_id = h.id
  WHERE q.numero = '105' AND h.cnpj = '27164580000109'
)
INSERT INTO quarto_comodidade (quarto_id, comodidade_id)
SELECT q.id, c.id
FROM quarto_base q
CROSS JOIN comodidade_base c;
WITH hotel_base AS (
  SELECT id FROM hotel WHERE cnpj = '27164580000109'
), categoria_base AS (
  SELECT id FROM categoria WHERE preco_diaria = 150.00 AND capacidade = 2
)
INSERT INTO quarto (hotel_id, categoria_id, numero, status, area)
SELECT h.id, c.id, '106', 'Ocupado', 25.00
FROM hotel_base h, categoria_base c;
WITH comodidade_base AS (
  SELECT id FROM comodidade WHERE nome = 'Banheira'
), quarto_base AS (
  SELECT q.id
  FROM quarto q
  JOIN hotel h ON q.hotel_id = h.id
  WHERE q.numero = '106' AND h.cnpj = '27164580000109'
)
INSERT INTO quarto_comodidade (quarto_id, comodidade_id)
SELECT q.id, c.id
FROM quarto_base q
CROSS JOIN comodidade_base c;

WITH comodidade_base AS (
  SELECT id FROM comodidade WHERE nome = 'Ar Condicionado'
), quarto_base AS (
  SELECT q.id
  FROM quarto q
  JOIN hotel h ON q.hotel_id = h.id
  WHERE q.numero = '106' AND h.cnpj = '27164580000109'
)
INSERT INTO quarto_comodidade (quarto_id, comodidade_id)
SELECT q.id, c.id
FROM quarto_base q
CROSS JOIN comodidade_base c;
WITH hotel_base AS (
  SELECT id FROM hotel WHERE cnpj = '27164580000109'
), categoria_base AS (
  SELECT id FROM categoria WHERE preco_diaria = 450.00 AND capacidade = 4
)
INSERT INTO quarto (hotel_id, categoria_id, numero, status, area)
SELECT h.id, c.id, '107', 'Disponível', 39.00
FROM hotel_base h, categoria_base c;
WITH comodidade_base AS (
  SELECT id FROM comodidade WHERE nome = 'Ar Condicionado'
), quarto_base AS (
  SELECT q.id
  FROM quarto q
  JOIN hotel h ON q.hotel_id = h.id
  WHERE q.numero = '107' AND h.cnpj = '27164580000109'
)
INSERT INTO quarto_comodidade (quarto_id, comodidade_id)
SELECT q.id, c.id
FROM quarto_base q
CROSS JOIN comodidade_base c;

WITH comodidade_base AS (
  SELECT id FROM comodidade WHERE nome = 'Vista Mar'
), quarto_base AS (
  SELECT q.id
  FROM quarto q
  JOIN hotel h ON q.hotel_id = h.id
  WHERE q.numero = '107' AND h.cnpj = '27164580000109'
)
INSERT INTO quarto_comodidade (quarto_id, comodidade_id)
SELECT q.id, c.id
FROM quarto_base q
CROSS JOIN comodidade_base c;
WITH hotel_base AS (
  SELECT id FROM hotel WHERE cnpj = '27164580000109'
), categoria_base AS (
  SELECT id FROM categoria WHERE preco_diaria = 1200.00 AND capacidade = 5
)
INSERT INTO quarto (hotel_id, categoria_id, numero, status, area)
SELECT h.id, c.id, '108', 'Limpeza', 42.00
FROM hotel_base h, categoria_base c;
WITH comodidade_base AS (
  SELECT id FROM comodidade WHERE nome = 'Vista Mar'
), quarto_base AS (
  SELECT q.id
  FROM quarto q
  JOIN hotel h ON q.hotel_id = h.id
  WHERE q.numero = '108' AND h.cnpj = '27164580000109'
)
INSERT INTO quarto_comodidade (quarto_id, comodidade_id)
SELECT q.id, c.id
FROM quarto_base q
CROSS JOIN comodidade_base c;

WITH comodidade_base AS (
  SELECT id FROM comodidade WHERE nome = 'Smart TV'
), quarto_base AS (
  SELECT q.id
  FROM quarto q
  JOIN hotel h ON q.hotel_id = h.id
  WHERE q.numero = '108' AND h.cnpj = '27164580000109'
)
INSERT INTO quarto_comodidade (quarto_id, comodidade_id)
SELECT q.id, c.id
FROM quarto_base q
CROSS JOIN comodidade_base c;

WITH comodidade_base AS (
  SELECT id FROM comodidade WHERE nome = 'Varanda'
), quarto_base AS (
  SELECT q.id
  FROM quarto q
  JOIN hotel h ON q.hotel_id = h.id
  WHERE q.numero = '108' AND h.cnpj = '27164580000109'
)
INSERT INTO quarto_comodidade (quarto_id, comodidade_id)
SELECT q.id, c.id
FROM quarto_base q
CROSS JOIN comodidade_base c;
WITH hotel_base AS (
  SELECT id FROM hotel WHERE cnpj = '27164580000109'
), categoria_base AS (
  SELECT id FROM categoria WHERE preco_diaria = 1200.00 AND capacidade = 5
)
INSERT INTO quarto (hotel_id, categoria_id, numero, status, area)
SELECT h.id, c.id, '109', 'Ocupado', 34.00
FROM hotel_base h, categoria_base c;
WITH comodidade_base AS (
  SELECT id FROM comodidade WHERE nome = 'Wi-Fi'
), quarto_base AS (
  SELECT q.id
  FROM quarto q
  JOIN hotel h ON q.hotel_id = h.id
  WHERE q.numero = '109' AND h.cnpj = '27164580000109'
)
INSERT INTO quarto_comodidade (quarto_id, comodidade_id)
SELECT q.id, c.id
FROM quarto_base q
CROSS JOIN comodidade_base c;

WITH comodidade_base AS (
  SELECT id FROM comodidade WHERE nome = 'Vista Mar'
), quarto_base AS (
  SELECT q.id
  FROM quarto q
  JOIN hotel h ON q.hotel_id = h.id
  WHERE q.numero = '109' AND h.cnpj = '27164580000109'
)
INSERT INTO quarto_comodidade (quarto_id, comodidade_id)
SELECT q.id, c.id
FROM quarto_base q
CROSS JOIN comodidade_base c;
WITH hotel_base AS (
  SELECT id FROM hotel WHERE cnpj = '27164580000109'
), categoria_base AS (
  SELECT id FROM categoria WHERE preco_diaria = 150.00 AND capacidade = 2
)
INSERT INTO quarto (hotel_id, categoria_id, numero, status, area)
SELECT h.id, c.id, '110', 'Disponível', 29.00
FROM hotel_base h, categoria_base c;
WITH comodidade_base AS (
  SELECT id FROM comodidade WHERE nome = 'Ar Condicionado'
), quarto_base AS (
  SELECT q.id
  FROM quarto q
  JOIN hotel h ON q.hotel_id = h.id
  WHERE q.numero = '110' AND h.cnpj = '27164580000109'
)
INSERT INTO quarto_comodidade (quarto_id, comodidade_id)
SELECT q.id, c.id
FROM quarto_base q
CROSS JOIN comodidade_base c;

WITH comodidade_base AS (
  SELECT id FROM comodidade WHERE nome = 'Wi-Fi'
), quarto_base AS (
  SELECT q.id
  FROM quarto q
  JOIN hotel h ON q.hotel_id = h.id
  WHERE q.numero = '110' AND h.cnpj = '27164580000109'
)
INSERT INTO quarto_comodidade (quarto_id, comodidade_id)
SELECT q.id, c.id
FROM quarto_base q
CROSS JOIN comodidade_base c;

WITH comodidade_base AS (
  SELECT id FROM comodidade WHERE nome = 'Vista Mar'
), quarto_base AS (
  SELECT q.id
  FROM quarto q
  JOIN hotel h ON q.hotel_id = h.id
  WHERE q.numero = '110' AND h.cnpj = '27164580000109'
)
INSERT INTO quarto_comodidade (quarto_id, comodidade_id)
SELECT q.id, c.id
FROM quarto_base q
CROSS JOIN comodidade_base c;

WITH comodidade_base AS (
  SELECT id FROM comodidade WHERE nome = 'Smart TV'
), quarto_base AS (
  SELECT q.id
  FROM quarto q
  JOIN hotel h ON q.hotel_id = h.id
  WHERE q.numero = '110' AND h.cnpj = '27164580000109'
)
INSERT INTO quarto_comodidade (quarto_id, comodidade_id)
SELECT q.id, c.id
FROM quarto_base q
CROSS JOIN comodidade_base c;
WITH hotel_base AS (
  SELECT id FROM hotel WHERE cnpj = '27164580000109'
), categoria_base AS (
  SELECT id FROM categoria WHERE preco_diaria = 1200.00 AND capacidade = 5
)
INSERT INTO quarto (hotel_id, categoria_id, numero, status, area)
SELECT h.id, c.id, '111', 'Limpeza', 45.00
FROM hotel_base h, categoria_base c;
WITH comodidade_base AS (
  SELECT id FROM comodidade WHERE nome = 'Frigobar'
), quarto_base AS (
  SELECT q.id
  FROM quarto q
  JOIN hotel h ON q.hotel_id = h.id
  WHERE q.numero = '111' AND h.cnpj = '27164580000109'
)
INSERT INTO quarto_comodidade (quarto_id, comodidade_id)
SELECT q.id, c.id
FROM quarto_base q
CROSS JOIN comodidade_base c;
WITH hotel_base AS (
  SELECT id FROM hotel WHERE cnpj = '27164580000109'
), categoria_base AS (
  SELECT id FROM categoria WHERE preco_diaria = 150.00 AND capacidade = 2
)
INSERT INTO quarto (hotel_id, categoria_id, numero, status, area)
SELECT h.id, c.id, '112', 'Ocupado', 46.00
FROM hotel_base h, categoria_base c;
WITH comodidade_base AS (
  SELECT id FROM comodidade WHERE nome = 'Frigobar'
), quarto_base AS (
  SELECT q.id
  FROM quarto q
  JOIN hotel h ON q.hotel_id = h.id
  WHERE q.numero = '112' AND h.cnpj = '27164580000109'
)
INSERT INTO quarto_comodidade (quarto_id, comodidade_id)
SELECT q.id, c.id
FROM quarto_base q
CROSS JOIN comodidade_base c;

WITH comodidade_base AS (
  SELECT id FROM comodidade WHERE nome = 'Wi-Fi'
), quarto_base AS (
  SELECT q.id
  FROM quarto q
  JOIN hotel h ON q.hotel_id = h.id
  WHERE q.numero = '112' AND h.cnpj = '27164580000109'
)
INSERT INTO quarto_comodidade (quarto_id, comodidade_id)
SELECT q.id, c.id
FROM quarto_base q
CROSS JOIN comodidade_base c;
WITH hotel_base AS (
  SELECT id FROM hotel WHERE cnpj = '27164580000109'
), categoria_base AS (
  SELECT id FROM categoria WHERE preco_diaria = 450.00 AND capacidade = 4
)
INSERT INTO quarto (hotel_id, categoria_id, numero, status, area)
SELECT h.id, c.id, '113', 'Limpeza', 57.00
FROM hotel_base h, categoria_base c;
WITH comodidade_base AS (
  SELECT id FROM comodidade WHERE nome = 'Ar Condicionado'
), quarto_base AS (
  SELECT q.id
  FROM quarto q
  JOIN hotel h ON q.hotel_id = h.id
  WHERE q.numero = '113' AND h.cnpj = '27164580000109'
)
INSERT INTO quarto_comodidade (quarto_id, comodidade_id)
SELECT q.id, c.id
FROM quarto_base q
CROSS JOIN comodidade_base c;

WITH comodidade_base AS (
  SELECT id FROM comodidade WHERE nome = 'Varanda'
), quarto_base AS (
  SELECT q.id
  FROM quarto q
  JOIN hotel h ON q.hotel_id = h.id
  WHERE q.numero = '113' AND h.cnpj = '27164580000109'
)
INSERT INTO quarto_comodidade (quarto_id, comodidade_id)
SELECT q.id, c.id
FROM quarto_base q
CROSS JOIN comodidade_base c;
WITH hotel_base AS (
  SELECT id FROM hotel WHERE cnpj = '27164580000109'
), categoria_base AS (
  SELECT id FROM categoria WHERE preco_diaria = 1200.00 AND capacidade = 5
)
INSERT INTO quarto (hotel_id, categoria_id, numero, status, area)
SELECT h.id, c.id, '114', 'Disponível', 36.00
FROM hotel_base h, categoria_base c;
WITH comodidade_base AS (
  SELECT id FROM comodidade WHERE nome = 'Varanda'
), quarto_base AS (
  SELECT q.id
  FROM quarto q
  JOIN hotel h ON q.hotel_id = h.id
  WHERE q.numero = '114' AND h.cnpj = '27164580000109'
)
INSERT INTO quarto_comodidade (quarto_id, comodidade_id)
SELECT q.id, c.id
FROM quarto_base q
CROSS JOIN comodidade_base c;

WITH comodidade_base AS (
  SELECT id FROM comodidade WHERE nome = 'Banheira'
), quarto_base AS (
  SELECT q.id
  FROM quarto q
  JOIN hotel h ON q.hotel_id = h.id
  WHERE q.numero = '114' AND h.cnpj = '27164580000109'
)
INSERT INTO quarto_comodidade (quarto_id, comodidade_id)
SELECT q.id, c.id
FROM quarto_base q
CROSS JOIN comodidade_base c;

WITH comodidade_base AS (
  SELECT id FROM comodidade WHERE nome = 'Ar Condicionado'
), quarto_base AS (
  SELECT q.id
  FROM quarto q
  JOIN hotel h ON q.hotel_id = h.id
  WHERE q.numero = '114' AND h.cnpj = '27164580000109'
)
INSERT INTO quarto_comodidade (quarto_id, comodidade_id)
SELECT q.id, c.id
FROM quarto_base q
CROSS JOIN comodidade_base c;
WITH hotel_base AS (
  SELECT id FROM hotel WHERE cnpj = '27164580000109'
), categoria_base AS (
  SELECT id FROM categoria WHERE preco_diaria = 150.00 AND capacidade = 2
)
INSERT INTO quarto (hotel_id, categoria_id, numero, status, area)
SELECT h.id, c.id, '115', 'Disponível', 60.00
FROM hotel_base h, categoria_base c;
WITH comodidade_base AS (
  SELECT id FROM comodidade WHERE nome = 'Frigobar'
), quarto_base AS (
  SELECT q.id
  FROM quarto q
  JOIN hotel h ON q.hotel_id = h.id
  WHERE q.numero = '115' AND h.cnpj = '27164580000109'
)
INSERT INTO quarto_comodidade (quarto_id, comodidade_id)
SELECT q.id, c.id
FROM quarto_base q
CROSS JOIN comodidade_base c;

WITH comodidade_base AS (
  SELECT id FROM comodidade WHERE nome = 'Smart TV'
), quarto_base AS (
  SELECT q.id
  FROM quarto q
  JOIN hotel h ON q.hotel_id = h.id
  WHERE q.numero = '115' AND h.cnpj = '27164580000109'
)
INSERT INTO quarto_comodidade (quarto_id, comodidade_id)
SELECT q.id, c.id
FROM quarto_base q
CROSS JOIN comodidade_base c;

WITH comodidade_base AS (
  SELECT id FROM comodidade WHERE nome = 'Wi-Fi'
), quarto_base AS (
  SELECT q.id
  FROM quarto q
  JOIN hotel h ON q.hotel_id = h.id
  WHERE q.numero = '115' AND h.cnpj = '27164580000109'
)
INSERT INTO quarto_comodidade (quarto_id, comodidade_id)
SELECT q.id, c.id
FROM quarto_base q
CROSS JOIN comodidade_base c;
WITH hotel_base AS (
  SELECT id FROM hotel WHERE cnpj = '27164580000109'
), categoria_base AS (
  SELECT id FROM categoria WHERE preco_diaria = 250.00 AND capacidade = 3
)
INSERT INTO quarto (hotel_id, categoria_id, numero, status, area)
SELECT h.id, c.id, '116', 'Disponível', 43.00
FROM hotel_base h, categoria_base c;
WITH comodidade_base AS (
  SELECT id FROM comodidade WHERE nome = 'Frigobar'
), quarto_base AS (
  SELECT q.id
  FROM quarto q
  JOIN hotel h ON q.hotel_id = h.id
  WHERE q.numero = '116' AND h.cnpj = '27164580000109'
)
INSERT INTO quarto_comodidade (quarto_id, comodidade_id)
SELECT q.id, c.id
FROM quarto_base q
CROSS JOIN comodidade_base c;

WITH comodidade_base AS (
  SELECT id FROM comodidade WHERE nome = 'Vista Mar'
), quarto_base AS (
  SELECT q.id
  FROM quarto q
  JOIN hotel h ON q.hotel_id = h.id
  WHERE q.numero = '116' AND h.cnpj = '27164580000109'
)
INSERT INTO quarto_comodidade (quarto_id, comodidade_id)
SELECT q.id, c.id
FROM quarto_base q
CROSS JOIN comodidade_base c;
WITH hotel_base AS (
  SELECT id FROM hotel WHERE cnpj = '27164580000109'
), categoria_base AS (
  SELECT id FROM categoria WHERE preco_diaria = 1200.00 AND capacidade = 5
)
INSERT INTO quarto (hotel_id, categoria_id, numero, status, area)
SELECT h.id, c.id, '117', 'Disponível', 40.00
FROM hotel_base h, categoria_base c;
WITH comodidade_base AS (
  SELECT id FROM comodidade WHERE nome = 'Cofre'
), quarto_base AS (
  SELECT q.id
  FROM quarto q
  JOIN hotel h ON q.hotel_id = h.id
  WHERE q.numero = '117' AND h.cnpj = '27164580000109'
)
INSERT INTO quarto_comodidade (quarto_id, comodidade_id)
SELECT q.id, c.id
FROM quarto_base q
CROSS JOIN comodidade_base c;
WITH hotel_base AS (
  SELECT id FROM hotel WHERE cnpj = '27164580000109'
), categoria_base AS (
  SELECT id FROM categoria WHERE preco_diaria = 1200.00 AND capacidade = 5
)
INSERT INTO quarto (hotel_id, categoria_id, numero, status, area)
SELECT h.id, c.id, '118', 'Disponível', 25.00
FROM hotel_base h, categoria_base c;
WITH comodidade_base AS (
  SELECT id FROM comodidade WHERE nome = 'Frigobar'
), quarto_base AS (
  SELECT q.id
  FROM quarto q
  JOIN hotel h ON q.hotel_id = h.id
  WHERE q.numero = '118' AND h.cnpj = '27164580000109'
)
INSERT INTO quarto_comodidade (quarto_id, comodidade_id)
SELECT q.id, c.id
FROM quarto_base q
CROSS JOIN comodidade_base c;

WITH comodidade_base AS (
  SELECT id FROM comodidade WHERE nome = 'Smart TV'
), quarto_base AS (
  SELECT q.id
  FROM quarto q
  JOIN hotel h ON q.hotel_id = h.id
  WHERE q.numero = '118' AND h.cnpj = '27164580000109'
)
INSERT INTO quarto_comodidade (quarto_id, comodidade_id)
SELECT q.id, c.id
FROM quarto_base q
CROSS JOIN comodidade_base c;
WITH hotel_base AS (
  SELECT id FROM hotel WHERE cnpj = '27164580000109'
), categoria_base AS (
  SELECT id FROM categoria WHERE preco_diaria = 1200.00 AND capacidade = 5
)
INSERT INTO quarto (hotel_id, categoria_id, numero, status, area)
SELECT h.id, c.id, '119', 'Ocupado', 30.00
FROM hotel_base h, categoria_base c;
WITH comodidade_base AS (
  SELECT id FROM comodidade WHERE nome = 'Banheira'
), quarto_base AS (
  SELECT q.id
  FROM quarto q
  JOIN hotel h ON q.hotel_id = h.id
  WHERE q.numero = '119' AND h.cnpj = '27164580000109'
)
INSERT INTO quarto_comodidade (quarto_id, comodidade_id)
SELECT q.id, c.id
FROM quarto_base q
CROSS JOIN comodidade_base c;
WITH hotel_base AS (
  SELECT id FROM hotel WHERE cnpj = '27164580000109'
), categoria_base AS (
  SELECT id FROM categoria WHERE preco_diaria = 450.00 AND capacidade = 4
)
INSERT INTO quarto (hotel_id, categoria_id, numero, status, area)
SELECT h.id, c.id, '120', 'Disponível', 28.00
FROM hotel_base h, categoria_base c;
WITH comodidade_base AS (
  SELECT id FROM comodidade WHERE nome = 'Frigobar'
), quarto_base AS (
  SELECT q.id
  FROM quarto q
  JOIN hotel h ON q.hotel_id = h.id
  WHERE q.numero = '120' AND h.cnpj = '27164580000109'
)
INSERT INTO quarto_comodidade (quarto_id, comodidade_id)
SELECT q.id, c.id
FROM quarto_base q
CROSS JOIN comodidade_base c;

WITH comodidade_base AS (
  SELECT id FROM comodidade WHERE nome = 'Vista Mar'
), quarto_base AS (
  SELECT q.id
  FROM quarto q
  JOIN hotel h ON q.hotel_id = h.id
  WHERE q.numero = '120' AND h.cnpj = '27164580000109'
)
INSERT INTO quarto_comodidade (quarto_id, comodidade_id)
SELECT q.id, c.id
FROM quarto_base q
CROSS JOIN comodidade_base c;

WITH comodidade_base AS (
  SELECT id FROM comodidade WHERE nome = 'Varanda'
), quarto_base AS (
  SELECT q.id
  FROM quarto q
  JOIN hotel h ON q.hotel_id = h.id
  WHERE q.numero = '120' AND h.cnpj = '27164580000109'
)
INSERT INTO quarto_comodidade (quarto_id, comodidade_id)
SELECT q.id, c.id
FROM quarto_base q
CROSS JOIN comodidade_base c;
WITH hotel_base AS (
  SELECT id FROM hotel WHERE cnpj = '27164580000109'
), categoria_base AS (
  SELECT id FROM categoria WHERE preco_diaria = 250.00 AND capacidade = 3
)
INSERT INTO quarto (hotel_id, categoria_id, numero, status, area)
SELECT h.id, c.id, '121', 'Disponível', 29.00
FROM hotel_base h, categoria_base c;
WITH comodidade_base AS (
  SELECT id FROM comodidade WHERE nome = 'Vista Mar'
), quarto_base AS (
  SELECT q.id
  FROM quarto q
  JOIN hotel h ON q.hotel_id = h.id
  WHERE q.numero = '121' AND h.cnpj = '27164580000109'
)
INSERT INTO quarto_comodidade (quarto_id, comodidade_id)
SELECT q.id, c.id
FROM quarto_base q
CROSS JOIN comodidade_base c;
WITH hotel_base AS (
  SELECT id FROM hotel WHERE cnpj = '27164580000109'
), categoria_base AS (
  SELECT id FROM categoria WHERE preco_diaria = 1200.00 AND capacidade = 5
)
INSERT INTO quarto (hotel_id, categoria_id, numero, status, area)
SELECT h.id, c.id, '122', 'Limpeza', 41.00
FROM hotel_base h, categoria_base c;
WITH comodidade_base AS (
  SELECT id FROM comodidade WHERE nome = 'Frigobar'
), quarto_base AS (
  SELECT q.id
  FROM quarto q
  JOIN hotel h ON q.hotel_id = h.id
  WHERE q.numero = '122' AND h.cnpj = '27164580000109'
)
INSERT INTO quarto_comodidade (quarto_id, comodidade_id)
SELECT q.id, c.id
FROM quarto_base q
CROSS JOIN comodidade_base c;
WITH hotel_base AS (
  SELECT id FROM hotel WHERE cnpj = '27164580000109'
), categoria_base AS (
  SELECT id FROM categoria WHERE preco_diaria = 450.00 AND capacidade = 4
)
INSERT INTO quarto (hotel_id, categoria_id, numero, status, area)
SELECT h.id, c.id, '123', 'Ocupado', 52.00
FROM hotel_base h, categoria_base c;
WITH comodidade_base AS (
  SELECT id FROM comodidade WHERE nome = 'Vista Mar'
), quarto_base AS (
  SELECT q.id
  FROM quarto q
  JOIN hotel h ON q.hotel_id = h.id
  WHERE q.numero = '123' AND h.cnpj = '27164580000109'
)
INSERT INTO quarto_comodidade (quarto_id, comodidade_id)
SELECT q.id, c.id
FROM quarto_base q
CROSS JOIN comodidade_base c;

WITH comodidade_base AS (
  SELECT id FROM comodidade WHERE nome = 'Cofre'
), quarto_base AS (
  SELECT q.id
  FROM quarto q
  JOIN hotel h ON q.hotel_id = h.id
  WHERE q.numero = '123' AND h.cnpj = '27164580000109'
)
INSERT INTO quarto_comodidade (quarto_id, comodidade_id)
SELECT q.id, c.id
FROM quarto_base q
CROSS JOIN comodidade_base c;

WITH comodidade_base AS (
  SELECT id FROM comodidade WHERE nome = 'Varanda'
), quarto_base AS (
  SELECT q.id
  FROM quarto q
  JOIN hotel h ON q.hotel_id = h.id
  WHERE q.numero = '123' AND h.cnpj = '27164580000109'
)
INSERT INTO quarto_comodidade (quarto_id, comodidade_id)
SELECT q.id, c.id
FROM quarto_base q
CROSS JOIN comodidade_base c;

WITH comodidade_base AS (
  SELECT id FROM comodidade WHERE nome = 'Banheira'
), quarto_base AS (
  SELECT q.id
  FROM quarto q
  JOIN hotel h ON q.hotel_id = h.id
  WHERE q.numero = '123' AND h.cnpj = '27164580000109'
)
INSERT INTO quarto_comodidade (quarto_id, comodidade_id)
SELECT q.id, c.id
FROM quarto_base q
CROSS JOIN comodidade_base c;
WITH hotel_base AS (
  SELECT id FROM hotel WHERE cnpj = '27164580000109'
), categoria_base AS (
  SELECT id FROM categoria WHERE preco_diaria = 450.00 AND capacidade = 4
)
INSERT INTO quarto (hotel_id, categoria_id, numero, status, area)
SELECT h.id, c.id, '124', 'Limpeza', 40.00
FROM hotel_base h, categoria_base c;
WITH comodidade_base AS (
  SELECT id FROM comodidade WHERE nome = 'Frigobar'
), quarto_base AS (
  SELECT q.id
  FROM quarto q
  JOIN hotel h ON q.hotel_id = h.id
  WHERE q.numero = '124' AND h.cnpj = '27164580000109'
)
INSERT INTO quarto_comodidade (quarto_id, comodidade_id)
SELECT q.id, c.id
FROM quarto_base q
CROSS JOIN comodidade_base c;

WITH comodidade_base AS (
  SELECT id FROM comodidade WHERE nome = 'Smart TV'
), quarto_base AS (
  SELECT q.id
  FROM quarto q
  JOIN hotel h ON q.hotel_id = h.id
  WHERE q.numero = '124' AND h.cnpj = '27164580000109'
)
INSERT INTO quarto_comodidade (quarto_id, comodidade_id)
SELECT q.id, c.id
FROM quarto_base q
CROSS JOIN comodidade_base c;

WITH comodidade_base AS (
  SELECT id FROM comodidade WHERE nome = 'Cofre'
), quarto_base AS (
  SELECT q.id
  FROM quarto q
  JOIN hotel h ON q.hotel_id = h.id
  WHERE q.numero = '124' AND h.cnpj = '27164580000109'
)
INSERT INTO quarto_comodidade (quarto_id, comodidade_id)
SELECT q.id, c.id
FROM quarto_base q
CROSS JOIN comodidade_base c;

WITH comodidade_base AS (
  SELECT id FROM comodidade WHERE nome = 'Vista Mar'
), quarto_base AS (
  SELECT q.id
  FROM quarto q
  JOIN hotel h ON q.hotel_id = h.id
  WHERE q.numero = '124' AND h.cnpj = '27164580000109'
)
INSERT INTO quarto_comodidade (quarto_id, comodidade_id)
SELECT q.id, c.id
FROM quarto_base q
CROSS JOIN comodidade_base c;
WITH hotel_base AS (
  SELECT id FROM hotel WHERE cnpj = '27164580000109'
), categoria_base AS (
  SELECT id FROM categoria WHERE preco_diaria = 1200.00 AND capacidade = 5
)
INSERT INTO quarto (hotel_id, categoria_id, numero, status, area)
SELECT h.id, c.id, '125', 'Limpeza', 37.00
FROM hotel_base h, categoria_base c;
WITH comodidade_base AS (
  SELECT id FROM comodidade WHERE nome = 'Ar Condicionado'
), quarto_base AS (
  SELECT q.id
  FROM quarto q
  JOIN hotel h ON q.hotel_id = h.id
  WHERE q.numero = '125' AND h.cnpj = '27164580000109'
)
INSERT INTO quarto_comodidade (quarto_id, comodidade_id)
SELECT q.id, c.id
FROM quarto_base q
CROSS JOIN comodidade_base c;

WITH comodidade_base AS (
  SELECT id FROM comodidade WHERE nome = 'Banheira'
), quarto_base AS (
  SELECT q.id
  FROM quarto q
  JOIN hotel h ON q.hotel_id = h.id
  WHERE q.numero = '125' AND h.cnpj = '27164580000109'
)
INSERT INTO quarto_comodidade (quarto_id, comodidade_id)
SELECT q.id, c.id
FROM quarto_base q
CROSS JOIN comodidade_base c;

WITH comodidade_base AS (
  SELECT id FROM comodidade WHERE nome = 'Smart TV'
), quarto_base AS (
  SELECT q.id
  FROM quarto q
  JOIN hotel h ON q.hotel_id = h.id
  WHERE q.numero = '125' AND h.cnpj = '27164580000109'
)
INSERT INTO quarto_comodidade (quarto_id, comodidade_id)
SELECT q.id, c.id
FROM quarto_base q
CROSS JOIN comodidade_base c;

WITH comodidade_base AS (
  SELECT id FROM comodidade WHERE nome = 'Vista Mar'
), quarto_base AS (
  SELECT q.id
  FROM quarto q
  JOIN hotel h ON q.hotel_id = h.id
  WHERE q.numero = '125' AND h.cnpj = '27164580000109'
)
INSERT INTO quarto_comodidade (quarto_id, comodidade_id)
SELECT q.id, c.id
FROM quarto_base q
CROSS JOIN comodidade_base c;
WITH hotel_base AS (
  SELECT id FROM hotel WHERE cnpj = '27164580000109'
), categoria_base AS (
  SELECT id FROM categoria WHERE preco_diaria = 450.00 AND capacidade = 4
)
INSERT INTO quarto (hotel_id, categoria_id, numero, status, area)
SELECT h.id, c.id, '126', 'Ocupado', 22.00
FROM hotel_base h, categoria_base c;
WITH comodidade_base AS (
  SELECT id FROM comodidade WHERE nome = 'Wi-Fi'
), quarto_base AS (
  SELECT q.id
  FROM quarto q
  JOIN hotel h ON q.hotel_id = h.id
  WHERE q.numero = '126' AND h.cnpj = '27164580000109'
)
INSERT INTO quarto_comodidade (quarto_id, comodidade_id)
SELECT q.id, c.id
FROM quarto_base q
CROSS JOIN comodidade_base c;
WITH hotel_base AS (
  SELECT id FROM hotel WHERE cnpj = '27164580000109'
), categoria_base AS (
  SELECT id FROM categoria WHERE preco_diaria = 250.00 AND capacidade = 3
)
INSERT INTO quarto (hotel_id, categoria_id, numero, status, area)
SELECT h.id, c.id, '127', 'Disponível', 39.00
FROM hotel_base h, categoria_base c;
WITH comodidade_base AS (
  SELECT id FROM comodidade WHERE nome = 'Varanda'
), quarto_base AS (
  SELECT q.id
  FROM quarto q
  JOIN hotel h ON q.hotel_id = h.id
  WHERE q.numero = '127' AND h.cnpj = '27164580000109'
)
INSERT INTO quarto_comodidade (quarto_id, comodidade_id)
SELECT q.id, c.id
FROM quarto_base q
CROSS JOIN comodidade_base c;

WITH comodidade_base AS (
  SELECT id FROM comodidade WHERE nome = 'Frigobar'
), quarto_base AS (
  SELECT q.id
  FROM quarto q
  JOIN hotel h ON q.hotel_id = h.id
  WHERE q.numero = '127' AND h.cnpj = '27164580000109'
)
INSERT INTO quarto_comodidade (quarto_id, comodidade_id)
SELECT q.id, c.id
FROM quarto_base q
CROSS JOIN comodidade_base c;

WITH comodidade_base AS (
  SELECT id FROM comodidade WHERE nome = 'Vista Mar'
), quarto_base AS (
  SELECT q.id
  FROM quarto q
  JOIN hotel h ON q.hotel_id = h.id
  WHERE q.numero = '127' AND h.cnpj = '27164580000109'
)
INSERT INTO quarto_comodidade (quarto_id, comodidade_id)
SELECT q.id, c.id
FROM quarto_base q
CROSS JOIN comodidade_base c;
WITH hotel_base AS (
  SELECT id FROM hotel WHERE cnpj = '27164580000109'
), categoria_base AS (
  SELECT id FROM categoria WHERE preco_diaria = 450.00 AND capacidade = 4
)
INSERT INTO quarto (hotel_id, categoria_id, numero, status, area)
SELECT h.id, c.id, '128', 'Disponível', 55.00
FROM hotel_base h, categoria_base c;
WITH comodidade_base AS (
  SELECT id FROM comodidade WHERE nome = 'Smart TV'
), quarto_base AS (
  SELECT q.id
  FROM quarto q
  JOIN hotel h ON q.hotel_id = h.id
  WHERE q.numero = '128' AND h.cnpj = '27164580000109'
)
INSERT INTO quarto_comodidade (quarto_id, comodidade_id)
SELECT q.id, c.id
FROM quarto_base q
CROSS JOIN comodidade_base c;
WITH hotel_base AS (
  SELECT id FROM hotel WHERE cnpj = '27164580000109'
), categoria_base AS (
  SELECT id FROM categoria WHERE preco_diaria = 1200.00 AND capacidade = 5
)
INSERT INTO quarto (hotel_id, categoria_id, numero, status, area)
SELECT h.id, c.id, '129', 'Limpeza', 34.00
FROM hotel_base h, categoria_base c;
WITH comodidade_base AS (
  SELECT id FROM comodidade WHERE nome = 'Wi-Fi'
), quarto_base AS (
  SELECT q.id
  FROM quarto q
  JOIN hotel h ON q.hotel_id = h.id
  WHERE q.numero = '129' AND h.cnpj = '27164580000109'
)
INSERT INTO quarto_comodidade (quarto_id, comodidade_id)
SELECT q.id, c.id
FROM quarto_base q
CROSS JOIN comodidade_base c;
WITH hotel_base AS (
  SELECT id FROM hotel WHERE cnpj = '27164580000109'
), categoria_base AS (
  SELECT id FROM categoria WHERE preco_diaria = 1200.00 AND capacidade = 5
)
INSERT INTO quarto (hotel_id, categoria_id, numero, status, area)
SELECT h.id, c.id, '130', 'Ocupado', 43.00
FROM hotel_base h, categoria_base c;
WITH comodidade_base AS (
  SELECT id FROM comodidade WHERE nome = 'Banheira'
), quarto_base AS (
  SELECT q.id
  FROM quarto q
  JOIN hotel h ON q.hotel_id = h.id
  WHERE q.numero = '130' AND h.cnpj = '27164580000109'
)
INSERT INTO quarto_comodidade (quarto_id, comodidade_id)
SELECT q.id, c.id
FROM quarto_base q
CROSS JOIN comodidade_base c;

WITH comodidade_base AS (
  SELECT id FROM comodidade WHERE nome = 'Smart TV'
), quarto_base AS (
  SELECT q.id
  FROM quarto q
  JOIN hotel h ON q.hotel_id = h.id
  WHERE q.numero = '130' AND h.cnpj = '27164580000109'
)
INSERT INTO quarto_comodidade (quarto_id, comodidade_id)
SELECT q.id, c.id
FROM quarto_base q
CROSS JOIN comodidade_base c;

WITH hotel_base AS (
  SELECT id FROM hotel WHERE cnpj = '27164580000109'
)
INSERT INTO funcionario (cpf, hotel_id, nome, email, cargo, salario)
SELECT '40836152905', id, 'Ana Júlia Macedo', 'davi-luiz25@example.org', 'Concierge', 2429.00
FROM hotel_base;

WITH hotel_base AS (
  SELECT id FROM hotel WHERE cnpj = '27164580000109'
)
INSERT INTO funcionario (cpf, hotel_id, nome, email, cargo, salario)
SELECT '73052968130', id, 'Manuella da Paz', 'tsiqueira@example.com', 'Recepcionista', 3103.00
FROM hotel_base;

WITH hotel_base AS (
  SELECT id FROM hotel WHERE cnpj = '27164580000109'
)
INSERT INTO funcionario (cpf, hotel_id, nome, email, cargo, salario)
SELECT '76052849347', id, 'Luiz Gustavo Lopes', 'jpinto@example.com', 'Camareira', 1767.00
FROM hotel_base;

WITH hotel_base AS (
  SELECT id FROM hotel WHERE cnpj = '27164580000109'
)
INSERT INTO funcionario (cpf, hotel_id, nome, email, cargo, salario)
SELECT '93625018721', id, 'Liz Leão', 'sofiaalbuquerque@example.com', 'Concierge', 2435.00
FROM hotel_base;

WITH hotel_base AS (
  SELECT id FROM hotel WHERE cnpj = '27164580000109'
)
INSERT INTO funcionario (cpf, hotel_id, nome, email, cargo, salario)
SELECT '90184735610', id, 'Srta. Amanda Azevedo', 'vargasbenjamim@example.com', 'Concierge', 4051.00
FROM hotel_base;

-- Clientes
INSERT INTO cliente (cpf, nome, data_nascimento, email, telefone) VALUES ('03624197878', 'Gael Aparecida', '1994-02-19', 'qmoraes@example.org', '+55043963817115');
INSERT INTO cliente (cpf, nome, data_nascimento, email, telefone) VALUES ('31724968050', 'Sr. Lucca Peixoto', '1988-02-19', 'ana-ceciliaribeiro@example.com', '+5590922866300');
INSERT INTO cliente (cpf, nome, data_nascimento, email, telefone) VALUES ('16853794273', 'Bruno Aragão', '1965-09-06', 'pda-luz@example.net', '+5546972993161');
INSERT INTO cliente (cpf, nome, data_nascimento, email, telefone) VALUES ('51834096251', 'Erick Montenegro', '1961-04-15', 'avieira@example.org', '+5547920250675');
INSERT INTO cliente (cpf, nome, data_nascimento, email, telefone) VALUES ('24810957667', 'Francisco Silva', '1961-07-26', 'sousamaria-helena@example.net', '+5543950199988');
INSERT INTO cliente (cpf, nome, data_nascimento, email, telefone) VALUES ('64537082992', 'Bruno Ferreira', '2006-10-11', 'qcavalcanti@example.com', '+5580999297947');
INSERT INTO cliente (cpf, nome, data_nascimento, email, telefone) VALUES ('57891026467', 'Ana Beatriz Teixeira', '1962-03-17', 'leandro04@example.org', '+5593943439548');
INSERT INTO cliente (cpf, nome, data_nascimento, email, telefone) VALUES ('13259068759', 'Sra. Laura Albuquerque', '1965-06-02', 'lucas-gabriel93@example.org', '+55023967939940');
INSERT INTO cliente (cpf, nome, data_nascimento, email, telefone) VALUES ('75640839210', 'Liam Rezende', '2003-09-09', 'gviana@example.org', '+5525944341244');
INSERT INTO cliente (cpf, nome, data_nascimento, email, telefone) VALUES ('60213794896', 'Luiz Felipe Siqueira', '1965-02-08', 'silvaravi@example.net', '+5556920586167');
INSERT INTO cliente (cpf, nome, data_nascimento, email, telefone) VALUES ('79210643534', 'Dr. Vitor Hugo Guerra', '1963-02-23', 'camarajade@example.com', '+5551988274844');
INSERT INTO cliente (cpf, nome, data_nascimento, email, telefone) VALUES ('93106527480', 'João Lucas da Rocha', '1996-05-16', 'raquel06@example.net', '+5559947457464');
INSERT INTO cliente (cpf, nome, data_nascimento, email, telefone) VALUES ('47328901640', 'Sr. Raul Novaes', '1980-03-31', 'paulo21@example.com', '+5532921146594');
INSERT INTO cliente (cpf, nome, data_nascimento, email, telefone) VALUES ('08137259414', 'Isis Vieira', '2006-02-24', 'cunhavitor-hugo@example.com', '+5564963537443');
INSERT INTO cliente (cpf, nome, data_nascimento, email, telefone) VALUES ('67493012822', 'Heitor Almeida', '1958-01-29', 'carlos-eduardocirino@example.org', '+5538934657161');
INSERT INTO cliente (cpf, nome, data_nascimento, email, telefone) VALUES ('51348629070', 'Henrique Camargo', '1971-06-04', 'natalia16@example.net', '+5585961000509');
INSERT INTO cliente (cpf, nome, data_nascimento, email, telefone) VALUES ('28450179360', 'Sabrina Cunha', '1981-08-01', 'claricemelo@example.com', '+5596978170836');
INSERT INTO cliente (cpf, nome, data_nascimento, email, telefone) VALUES ('12385709414', 'Maria Luísa Barbosa', '1995-04-08', 'rmartins@example.org', '+5527987536016');
INSERT INTO cliente (cpf, nome, data_nascimento, email, telefone) VALUES ('41386572900', 'Maria Liz da Rocha', '1950-09-05', 'biancamendes@example.net', '+5515947782476');
INSERT INTO cliente (cpf, nome, data_nascimento, email, telefone) VALUES ('70564982130', 'Dr. Anthony Gabriel Nogueira', '1985-06-17', 'valentimmarques@example.org', '+5562915020505');
INSERT INTO cliente (cpf, nome, data_nascimento, email, telefone) VALUES ('50624713970', 'Luigi Porto', '1964-01-03', 'ravi-luccavargas@example.org', '+5502974484005');
INSERT INTO cliente (cpf, nome, data_nascimento, email, telefone) VALUES ('15397284637', 'Sr. Caio Vargas', '1967-08-10', 'pintomanuela@example.com', '+5531963442991');
INSERT INTO cliente (cpf, nome, data_nascimento, email, telefone) VALUES ('58264970176', 'Natália Sá', '2002-08-23', 'giovannamonteiro@example.com', '+5531911129820');
INSERT INTO cliente (cpf, nome, data_nascimento, email, telefone) VALUES ('47196850300', 'Daniel Souza', '1973-02-18', 'mariana77@example.com', '+5564938003173');
INSERT INTO cliente (cpf, nome, data_nascimento, email, telefone) VALUES ('52430179652', 'Maria Julia Montenegro', '1991-12-27', 'ana-cecilia35@example.com', '+5588946458617');
INSERT INTO cliente (cpf, nome, data_nascimento, email, telefone) VALUES ('84639015739', 'Sra. Daniela Casa Grande', '1985-04-15', 'mariacorreia@example.org', '+5518978225400');
INSERT INTO cliente (cpf, nome, data_nascimento, email, telefone) VALUES ('18057293497', 'José Pedro Duarte', '1948-04-19', 'pachecoanthony-gabriel@example.net', '+55064909956209');
INSERT INTO cliente (cpf, nome, data_nascimento, email, telefone) VALUES ('31457892600', 'Leonardo da Luz', '1957-04-25', 'carvalhopietro@example.net', '+55090994833414');
INSERT INTO cliente (cpf, nome, data_nascimento, email, telefone) VALUES ('84295317004', 'Yasmin Montenegro', '2003-04-13', 'maria-sophiada-cunha@example.org', '+5506925279527');
INSERT INTO cliente (cpf, nome, data_nascimento, email, telefone) VALUES ('53106284790', 'Aurora da Luz', '2006-10-22', 'sampaiobreno@example.com', '+5556954100852');
INSERT INTO cliente (cpf, nome, data_nascimento, email, telefone) VALUES ('18063974557', 'Rhavi Siqueira', '1960-01-11', 'brendafogaca@example.com', '+5570999861991');
INSERT INTO cliente (cpf, nome, data_nascimento, email, telefone) VALUES ('13590267461', 'Dra. Maria Júlia Albuquerque', '1967-11-21', 'rmontenegro@example.com', '+5526984198147');
INSERT INTO cliente (cpf, nome, data_nascimento, email, telefone) VALUES ('31790682568', 'Maria Isis Ramos', '1970-08-19', 'marianamoraes@example.org', '+5524976274046');
INSERT INTO cliente (cpf, nome, data_nascimento, email, telefone) VALUES ('40852137680', 'Vinícius Pires', '1963-04-01', 'cirinopedro@example.net', '+5586943340837');
INSERT INTO cliente (cpf, nome, data_nascimento, email, telefone) VALUES ('09516823424', 'Laura Castro', '1983-07-24', 'joao-vitorda-costa@example.com', '+5511942096008');
INSERT INTO cliente (cpf, nome, data_nascimento, email, telefone) VALUES ('49637052810', 'Ravi Rodrigues', '1979-11-11', 'zsa@example.com', '+5552981839785');
INSERT INTO cliente (cpf, nome, data_nascimento, email, telefone) VALUES ('47251896346', 'João Peixoto', '1973-10-23', 'valbuquerque@example.net', '+5549958962561');
INSERT INTO cliente (cpf, nome, data_nascimento, email, telefone) VALUES ('67251409399', 'Dra. Giovanna Pinto', '1966-03-11', 'emilly91@example.net', '+5571984737842');
INSERT INTO cliente (cpf, nome, data_nascimento, email, telefone) VALUES ('42598170601', 'Kamilly Caldeira', '1964-07-10', 'alexandreda-rosa@example.net', '+5517960996133');
INSERT INTO cliente (cpf, nome, data_nascimento, email, telefone) VALUES ('91568403224', 'Enrico Teixeira', '1961-11-06', 'vasconcelosenzo@example.org', '+55040939164196');
INSERT INTO cliente (cpf, nome, data_nascimento, email, telefone) VALUES ('35164089289', 'Ana Vitória Rezende', '1957-04-14', 'xfernandes@example.org', '+5532955056263');
INSERT INTO cliente (cpf, nome, data_nascimento, email, telefone) VALUES ('01956873457', 'Felipe Abreu', '1971-06-27', 'luan49@example.com', '+5511977090404');
INSERT INTO cliente (cpf, nome, data_nascimento, email, telefone) VALUES ('52039617434', 'Ana Laura Vasconcelos', '1972-05-20', 'ravy79@example.net', '+5561986993714');
INSERT INTO cliente (cpf, nome, data_nascimento, email, telefone) VALUES ('72938516002', 'Lucas Pastor', '1987-04-26', 'uduarte@example.org', '+5508939050488');
INSERT INTO cliente (cpf, nome, data_nascimento, email, telefone) VALUES ('07541923850', 'Théo Monteiro', '1997-06-18', 'bento84@example.org', '+5557925798974');
INSERT INTO cliente (cpf, nome, data_nascimento, email, telefone) VALUES ('47586130957', 'Thales Machado', '1988-07-17', 'kcavalcante@example.com', '+5592941558013');
INSERT INTO cliente (cpf, nome, data_nascimento, email, telefone) VALUES ('93401685260', 'Gustavo Henrique Moreira', '1946-02-09', 'ayllaramos@example.org', '+5530943840660');
INSERT INTO cliente (cpf, nome, data_nascimento, email, telefone) VALUES ('65249801749', 'Isabella Campos', '2007-10-24', 'luigi88@example.net', '+5519911507262');
INSERT INTO cliente (cpf, nome, data_nascimento, email, telefone) VALUES ('59201476876', 'Luiz Felipe Rezende', '1998-09-21', 'aragaomaria-sophia@example.net', '+5568979557274');
INSERT INTO cliente (cpf, nome, data_nascimento, email, telefone) VALUES ('18504972658', 'Eduardo Andrade', '1970-08-08', 'danilopastor@example.com', '+55066995902889');

-- Reservas
INSERT INTO reserva (cpf_cliente, data_reserva, data_checkin_previsto, data_checkout_previsto, status_reserva) VALUES ('31457892600', '2026-01-09', '2026-01-19', '2026-01-27', 'Concluída');
WITH reserva_base AS (
  SELECT id FROM reserva WHERE cpf_cliente = '31457892600' AND data_reserva = '2026-01-09'
), quarto_base AS (
  SELECT q.id
  FROM quarto q
  JOIN hotel h ON q.hotel_id = h.id
  WHERE q.numero = '109' AND h.cnpj = '27164580000109'
)
INSERT INTO reserva_quarto (reserva_id, quarto_id)
SELECT r.id, q.id
FROM reserva_base r
CROSS JOIN quarto_base q;
INSERT INTO reserva (cpf_cliente, data_reserva, data_checkin_previsto, data_checkout_previsto, status_reserva) VALUES ('13590267461', '2026-01-03', '2026-01-12', '2026-01-18', 'Cancelada');
WITH reserva_base AS (
  SELECT id FROM reserva WHERE cpf_cliente = '13590267461' AND data_reserva = '2026-01-03'
), quarto_base AS (
  SELECT q.id
  FROM quarto q
  JOIN hotel h ON q.hotel_id = h.id
  WHERE q.numero = '130' AND h.cnpj = '27164580000109'
)
INSERT INTO reserva_quarto (reserva_id, quarto_id)
SELECT r.id, q.id
FROM reserva_base r
CROSS JOIN quarto_base q;
WITH servico_base AS (
  SELECT id FROM servico_adicional WHERE nome_servico = 'Lavanderia Express'
), reserva_base AS (
  SELECT id FROM reserva WHERE cpf_cliente = '13590267461' AND data_reserva = '2026-01-03'
)
INSERT INTO reserva_servico (reserva_id, servico_adicional_id, quantidade)
SELECT r.id, s.id, 2
FROM reserva_base r
CROSS JOIN servico_base s;
INSERT INTO reserva (cpf_cliente, data_reserva, data_checkin_previsto, data_checkout_previsto, status_reserva) VALUES ('41386572900', '2026-01-26', '2026-01-31', '2026-02-05', 'Concluída');
WITH reserva_base AS (
  SELECT id FROM reserva WHERE cpf_cliente = '41386572900' AND data_reserva = '2026-01-26'
), quarto_base AS (
  SELECT q.id
  FROM quarto q
  JOIN hotel h ON q.hotel_id = h.id
  WHERE q.numero = '123' AND h.cnpj = '27164580000109'
)
INSERT INTO reserva_quarto (reserva_id, quarto_id)
SELECT r.id, q.id
FROM reserva_base r
CROSS JOIN quarto_base q;
INSERT INTO reserva (cpf_cliente, data_reserva, data_checkin_previsto, data_checkout_previsto, status_reserva) VALUES ('24810957667', '2026-03-07', '2026-03-12', '2026-03-15', 'Pendente');
WITH reserva_base AS (
  SELECT id FROM reserva WHERE cpf_cliente = '24810957667' AND data_reserva = '2026-03-07'
), quarto_base AS (
  SELECT q.id
  FROM quarto q
  JOIN hotel h ON q.hotel_id = h.id
  WHERE q.numero = '102' AND h.cnpj = '27164580000109'
)
INSERT INTO reserva_quarto (reserva_id, quarto_id)
SELECT r.id, q.id
FROM reserva_base r
CROSS JOIN quarto_base q;
WITH servico_base AS (
  SELECT id FROM servico_adicional WHERE nome_servico = 'Lavanderia Express'
), reserva_base AS (
  SELECT id FROM reserva WHERE cpf_cliente = '24810957667' AND data_reserva = '2026-03-07'
)
INSERT INTO reserva_servico (reserva_id, servico_adicional_id, quantidade)
SELECT r.id, s.id, 1
FROM reserva_base r
CROSS JOIN servico_base s;
INSERT INTO reserva (cpf_cliente, data_reserva, data_checkin_previsto, data_checkout_previsto, status_reserva) VALUES ('18063974557', '2026-01-09', '2026-01-18', '2026-01-19', 'Concluída');
WITH reserva_base AS (
  SELECT id FROM reserva WHERE cpf_cliente = '18063974557' AND data_reserva = '2026-01-09'
), quarto_base AS (
  SELECT q.id
  FROM quarto q
  JOIN hotel h ON q.hotel_id = h.id
  WHERE q.numero = '106' AND h.cnpj = '27164580000109'
)
INSERT INTO reserva_quarto (reserva_id, quarto_id)
SELECT r.id, q.id
FROM reserva_base r
CROSS JOIN quarto_base q;
WITH servico_base AS (
  SELECT id FROM servico_adicional WHERE nome_servico = 'Jantar Romântico'
), reserva_base AS (
  SELECT id FROM reserva WHERE cpf_cliente = '18063974557' AND data_reserva = '2026-01-09'
)
INSERT INTO reserva_servico (reserva_id, servico_adicional_id, quantidade)
SELECT r.id, s.id, 1
FROM reserva_base r
CROSS JOIN servico_base s;
INSERT INTO reserva (cpf_cliente, data_reserva, data_checkin_previsto, data_checkout_previsto, status_reserva) VALUES ('13259068759', '2026-01-17', '2026-01-22', '2026-01-23', 'Concluída');
WITH reserva_base AS (
  SELECT id FROM reserva WHERE cpf_cliente = '13259068759' AND data_reserva = '2026-01-17'
), quarto_base AS (
  SELECT q.id
  FROM quarto q
  JOIN hotel h ON q.hotel_id = h.id
  WHERE q.numero = '110' AND h.cnpj = '27164580000109'
)
INSERT INTO reserva_quarto (reserva_id, quarto_id)
SELECT r.id, q.id
FROM reserva_base r
CROSS JOIN quarto_base q;

WITH reserva_base AS (
  SELECT id FROM reserva WHERE cpf_cliente = '13259068759' AND data_reserva = '2026-01-17'
), quarto_base AS (
  SELECT q.id
  FROM quarto q
  JOIN hotel h ON q.hotel_id = h.id
  WHERE q.numero = '123' AND h.cnpj = '27164580000109'
)
INSERT INTO reserva_quarto (reserva_id, quarto_id)
SELECT r.id, q.id
FROM reserva_base r
CROSS JOIN quarto_base q;
INSERT INTO reserva (cpf_cliente, data_reserva, data_checkin_previsto, data_checkout_previsto, status_reserva) VALUES ('28450179360', '2026-02-25', '2026-03-04', '2026-03-07', 'Pendente');
WITH reserva_base AS (
  SELECT id FROM reserva WHERE cpf_cliente = '28450179360' AND data_reserva = '2026-02-25'
), quarto_base AS (
  SELECT q.id
  FROM quarto q
  JOIN hotel h ON q.hotel_id = h.id
  WHERE q.numero = '114' AND h.cnpj = '27164580000109'
)
INSERT INTO reserva_quarto (reserva_id, quarto_id)
SELECT r.id, q.id
FROM reserva_base r
CROSS JOIN quarto_base q;
WITH servico_base AS (
  SELECT id FROM servico_adicional WHERE nome_servico = 'Jantar Romântico'
), reserva_base AS (
  SELECT id FROM reserva WHERE cpf_cliente = '28450179360' AND data_reserva = '2026-02-25'
)
INSERT INTO reserva_servico (reserva_id, servico_adicional_id, quantidade)
SELECT r.id, s.id, 2
FROM reserva_base r
CROSS JOIN servico_base s;
INSERT INTO reserva (cpf_cliente, data_reserva, data_checkin_previsto, data_checkout_previsto, status_reserva) VALUES ('08137259414', '2026-03-12', '2026-03-13', '2026-03-22', 'Pendente');
WITH reserva_base AS (
  SELECT id FROM reserva WHERE cpf_cliente = '08137259414' AND data_reserva = '2026-03-12'
), quarto_base AS (
  SELECT q.id
  FROM quarto q
  JOIN hotel h ON q.hotel_id = h.id
  WHERE q.numero = '130' AND h.cnpj = '27164580000109'
)
INSERT INTO reserva_quarto (reserva_id, quarto_id)
SELECT r.id, q.id
FROM reserva_base r
CROSS JOIN quarto_base q;
INSERT INTO reserva (cpf_cliente, data_reserva, data_checkin_previsto, data_checkout_previsto, status_reserva) VALUES ('01956873457', '2026-01-24', '2026-02-03', '2026-02-11', 'Concluída');
WITH reserva_base AS (
  SELECT id FROM reserva WHERE cpf_cliente = '01956873457' AND data_reserva = '2026-01-24'
), quarto_base AS (
  SELECT q.id
  FROM quarto q
  JOIN hotel h ON q.hotel_id = h.id
  WHERE q.numero = '115' AND h.cnpj = '27164580000109'
)
INSERT INTO reserva_quarto (reserva_id, quarto_id)
SELECT r.id, q.id
FROM reserva_base r
CROSS JOIN quarto_base q;

WITH reserva_base AS (
  SELECT id FROM reserva WHERE cpf_cliente = '01956873457' AND data_reserva = '2026-01-24'
), quarto_base AS (
  SELECT q.id
  FROM quarto q
  JOIN hotel h ON q.hotel_id = h.id
  WHERE q.numero = '124' AND h.cnpj = '27164580000109'
)
INSERT INTO reserva_quarto (reserva_id, quarto_id)
SELECT r.id, q.id
FROM reserva_base r
CROSS JOIN quarto_base q;
WITH servico_base AS (
  SELECT id FROM servico_adicional WHERE nome_servico = 'Translado Aeroporto'
), reserva_base AS (
  SELECT id FROM reserva WHERE cpf_cliente = '01956873457' AND data_reserva = '2026-01-24'
)
INSERT INTO reserva_servico (reserva_id, servico_adicional_id, quantidade)
SELECT r.id, s.id, 2
FROM reserva_base r
CROSS JOIN servico_base s;
INSERT INTO reserva (cpf_cliente, data_reserva, data_checkin_previsto, data_checkout_previsto, status_reserva) VALUES ('28450179360', '2026-04-03', '2026-04-05', '2026-04-08', 'Confirmada');
WITH reserva_base AS (
  SELECT id FROM reserva WHERE cpf_cliente = '28450179360' AND data_reserva = '2026-04-03'
), quarto_base AS (
  SELECT q.id
  FROM quarto q
  JOIN hotel h ON q.hotel_id = h.id
  WHERE q.numero = '109' AND h.cnpj = '27164580000109'
)
INSERT INTO reserva_quarto (reserva_id, quarto_id)
SELECT r.id, q.id
FROM reserva_base r
CROSS JOIN quarto_base q;
WITH servico_base AS (
  SELECT id FROM servico_adicional WHERE nome_servico = 'Café da Manhã no Quarto'
), reserva_base AS (
  SELECT id FROM reserva WHERE cpf_cliente = '28450179360' AND data_reserva = '2026-04-03'
)
INSERT INTO reserva_servico (reserva_id, servico_adicional_id, quantidade)
SELECT r.id, s.id, 1
FROM reserva_base r
CROSS JOIN servico_base s;
INSERT INTO reserva (cpf_cliente, data_reserva, data_checkin_previsto, data_checkout_previsto, status_reserva) VALUES ('67251409399', '2026-01-07', '2026-01-11', '2026-01-13', 'Concluída');
WITH reserva_base AS (
  SELECT id FROM reserva WHERE cpf_cliente = '67251409399' AND data_reserva = '2026-01-07'
), quarto_base AS (
  SELECT q.id
  FROM quarto q
  JOIN hotel h ON q.hotel_id = h.id
  WHERE q.numero = '104' AND h.cnpj = '27164580000109'
)
INSERT INTO reserva_quarto (reserva_id, quarto_id)
SELECT r.id, q.id
FROM reserva_base r
CROSS JOIN quarto_base q;
INSERT INTO reserva (cpf_cliente, data_reserva, data_checkin_previsto, data_checkout_previsto, status_reserva) VALUES ('03624197878', '2026-01-30', '2026-02-05', '2026-02-12', 'Concluída');
WITH reserva_base AS (
  SELECT id FROM reserva WHERE cpf_cliente = '03624197878' AND data_reserva = '2026-01-30'
), quarto_base AS (
  SELECT q.id
  FROM quarto q
  JOIN hotel h ON q.hotel_id = h.id
  WHERE q.numero = '123' AND h.cnpj = '27164580000109'
)
INSERT INTO reserva_quarto (reserva_id, quarto_id)
SELECT r.id, q.id
FROM reserva_base r
CROSS JOIN quarto_base q;

WITH reserva_base AS (
  SELECT id FROM reserva WHERE cpf_cliente = '03624197878' AND data_reserva = '2026-01-30'
), quarto_base AS (
  SELECT q.id
  FROM quarto q
  JOIN hotel h ON q.hotel_id = h.id
  WHERE q.numero = '129' AND h.cnpj = '27164580000109'
)
INSERT INTO reserva_quarto (reserva_id, quarto_id)
SELECT r.id, q.id
FROM reserva_base r
CROSS JOIN quarto_base q;
WITH servico_base AS (
  SELECT id FROM servico_adicional WHERE nome_servico = 'Lavanderia Express'
), reserva_base AS (
  SELECT id FROM reserva WHERE cpf_cliente = '03624197878' AND data_reserva = '2026-01-30'
)
INSERT INTO reserva_servico (reserva_id, servico_adicional_id, quantidade)
SELECT r.id, s.id, 2
FROM reserva_base r
CROSS JOIN servico_base s;
INSERT INTO reserva (cpf_cliente, data_reserva, data_checkin_previsto, data_checkout_previsto, status_reserva) VALUES ('41386572900', '2026-01-28', '2026-02-03', '2026-02-06', 'Concluída');
WITH reserva_base AS (
  SELECT id FROM reserva WHERE cpf_cliente = '41386572900' AND data_reserva = '2026-01-28'
), quarto_base AS (
  SELECT q.id
  FROM quarto q
  JOIN hotel h ON q.hotel_id = h.id
  WHERE q.numero = '127' AND h.cnpj = '27164580000109'
)
INSERT INTO reserva_quarto (reserva_id, quarto_id)
SELECT r.id, q.id
FROM reserva_base r
CROSS JOIN quarto_base q;

WITH reserva_base AS (
  SELECT id FROM reserva WHERE cpf_cliente = '41386572900' AND data_reserva = '2026-01-28'
), quarto_base AS (
  SELECT q.id
  FROM quarto q
  JOIN hotel h ON q.hotel_id = h.id
  WHERE q.numero = '119' AND h.cnpj = '27164580000109'
)
INSERT INTO reserva_quarto (reserva_id, quarto_id)
SELECT r.id, q.id
FROM reserva_base r
CROSS JOIN quarto_base q;
WITH servico_base AS (
  SELECT id FROM servico_adicional WHERE nome_servico = 'Jantar Romântico'
), reserva_base AS (
  SELECT id FROM reserva WHERE cpf_cliente = '41386572900' AND data_reserva = '2026-01-28'
)
INSERT INTO reserva_servico (reserva_id, servico_adicional_id, quantidade)
SELECT r.id, s.id, 1
FROM reserva_base r
CROSS JOIN servico_base s;
INSERT INTO reserva (cpf_cliente, data_reserva, data_checkin_previsto, data_checkout_previsto, status_reserva) VALUES ('52430179652', '2026-02-06', '2026-02-15', '2026-02-25', 'Confirmada');
WITH reserva_base AS (
  SELECT id FROM reserva WHERE cpf_cliente = '52430179652' AND data_reserva = '2026-02-06'
), quarto_base AS (
  SELECT q.id
  FROM quarto q
  JOIN hotel h ON q.hotel_id = h.id
  WHERE q.numero = '123' AND h.cnpj = '27164580000109'
)
INSERT INTO reserva_quarto (reserva_id, quarto_id)
SELECT r.id, q.id
FROM reserva_base r
CROSS JOIN quarto_base q;
WITH servico_base AS (
  SELECT id FROM servico_adicional WHERE nome_servico = 'Jantar Romântico'
), reserva_base AS (
  SELECT id FROM reserva WHERE cpf_cliente = '52430179652' AND data_reserva = '2026-02-06'
)
INSERT INTO reserva_servico (reserva_id, servico_adicional_id, quantidade)
SELECT r.id, s.id, 2
FROM reserva_base r
CROSS JOIN servico_base s;
INSERT INTO reserva (cpf_cliente, data_reserva, data_checkin_previsto, data_checkout_previsto, status_reserva) VALUES ('31790682568', '2026-03-18', '2026-03-23', '2026-03-30', 'Confirmada');
WITH reserva_base AS (
  SELECT id FROM reserva WHERE cpf_cliente = '31790682568' AND data_reserva = '2026-03-18'
), quarto_base AS (
  SELECT q.id
  FROM quarto q
  JOIN hotel h ON q.hotel_id = h.id
  WHERE q.numero = '109' AND h.cnpj = '27164580000109'
)
INSERT INTO reserva_quarto (reserva_id, quarto_id)
SELECT r.id, q.id
FROM reserva_base r
CROSS JOIN quarto_base q;
WITH servico_base AS (
  SELECT id FROM servico_adicional WHERE nome_servico = 'Massagem Relaxante'
), reserva_base AS (
  SELECT id FROM reserva WHERE cpf_cliente = '31790682568' AND data_reserva = '2026-03-18'
)
INSERT INTO reserva_servico (reserva_id, servico_adicional_id, quantidade)
SELECT r.id, s.id, 1
FROM reserva_base r
CROSS JOIN servico_base s;
INSERT INTO reserva (cpf_cliente, data_reserva, data_checkin_previsto, data_checkout_previsto, status_reserva) VALUES ('65249801749', '2026-03-06', '2026-03-15', '2026-03-20', 'Pendente');
WITH reserva_base AS (
  SELECT id FROM reserva WHERE cpf_cliente = '65249801749' AND data_reserva = '2026-03-06'
), quarto_base AS (
  SELECT q.id
  FROM quarto q
  JOIN hotel h ON q.hotel_id = h.id
  WHERE q.numero = '116' AND h.cnpj = '27164580000109'
)
INSERT INTO reserva_quarto (reserva_id, quarto_id)
SELECT r.id, q.id
FROM reserva_base r
CROSS JOIN quarto_base q;
WITH servico_base AS (
  SELECT id FROM servico_adicional WHERE nome_servico = 'Lavanderia Express'
), reserva_base AS (
  SELECT id FROM reserva WHERE cpf_cliente = '65249801749' AND data_reserva = '2026-03-06'
)
INSERT INTO reserva_servico (reserva_id, servico_adicional_id, quantidade)
SELECT r.id, s.id, 2
FROM reserva_base r
CROSS JOIN servico_base s;
INSERT INTO reserva (cpf_cliente, data_reserva, data_checkin_previsto, data_checkout_previsto, status_reserva) VALUES ('72938516002', '2026-04-03', '2026-04-07', '2026-04-14', 'Confirmada');
WITH reserva_base AS (
  SELECT id FROM reserva WHERE cpf_cliente = '72938516002' AND data_reserva = '2026-04-03'
), quarto_base AS (
  SELECT q.id
  FROM quarto q
  JOIN hotel h ON q.hotel_id = h.id
  WHERE q.numero = '110' AND h.cnpj = '27164580000109'
)
INSERT INTO reserva_quarto (reserva_id, quarto_id)
SELECT r.id, q.id
FROM reserva_base r
CROSS JOIN quarto_base q;

WITH reserva_base AS (
  SELECT id FROM reserva WHERE cpf_cliente = '72938516002' AND data_reserva = '2026-04-03'
), quarto_base AS (
  SELECT q.id
  FROM quarto q
  JOIN hotel h ON q.hotel_id = h.id
  WHERE q.numero = '122' AND h.cnpj = '27164580000109'
)
INSERT INTO reserva_quarto (reserva_id, quarto_id)
SELECT r.id, q.id
FROM reserva_base r
CROSS JOIN quarto_base q;
WITH servico_base AS (
  SELECT id FROM servico_adicional WHERE nome_servico = 'Translado Aeroporto'
), reserva_base AS (
  SELECT id FROM reserva WHERE cpf_cliente = '72938516002' AND data_reserva = '2026-04-03'
)
INSERT INTO reserva_servico (reserva_id, servico_adicional_id, quantidade)
SELECT r.id, s.id, 1
FROM reserva_base r
CROSS JOIN servico_base s;
INSERT INTO reserva (cpf_cliente, data_reserva, data_checkin_previsto, data_checkout_previsto, status_reserva) VALUES ('09516823424', '2026-03-10', '2026-03-20', '2026-03-23', 'Pendente');
WITH reserva_base AS (
  SELECT id FROM reserva WHERE cpf_cliente = '09516823424' AND data_reserva = '2026-03-10'
), quarto_base AS (
  SELECT q.id
  FROM quarto q
  JOIN hotel h ON q.hotel_id = h.id
  WHERE q.numero = '120' AND h.cnpj = '27164580000109'
)
INSERT INTO reserva_quarto (reserva_id, quarto_id)
SELECT r.id, q.id
FROM reserva_base r
CROSS JOIN quarto_base q;

WITH reserva_base AS (
  SELECT id FROM reserva WHERE cpf_cliente = '09516823424' AND data_reserva = '2026-03-10'
), quarto_base AS (
  SELECT q.id
  FROM quarto q
  JOIN hotel h ON q.hotel_id = h.id
  WHERE q.numero = '115' AND h.cnpj = '27164580000109'
)
INSERT INTO reserva_quarto (reserva_id, quarto_id)
SELECT r.id, q.id
FROM reserva_base r
CROSS JOIN quarto_base q;
INSERT INTO reserva (cpf_cliente, data_reserva, data_checkin_previsto, data_checkout_previsto, status_reserva) VALUES ('93106527480', '2026-03-02', '2026-03-09', '2026-03-16', 'Confirmada');
WITH reserva_base AS (
  SELECT id FROM reserva WHERE cpf_cliente = '93106527480' AND data_reserva = '2026-03-02'
), quarto_base AS (
  SELECT q.id
  FROM quarto q
  JOIN hotel h ON q.hotel_id = h.id
  WHERE q.numero = '102' AND h.cnpj = '27164580000109'
)
INSERT INTO reserva_quarto (reserva_id, quarto_id)
SELECT r.id, q.id
FROM reserva_base r
CROSS JOIN quarto_base q;

WITH reserva_base AS (
  SELECT id FROM reserva WHERE cpf_cliente = '93106527480' AND data_reserva = '2026-03-02'
), quarto_base AS (
  SELECT q.id
  FROM quarto q
  JOIN hotel h ON q.hotel_id = h.id
  WHERE q.numero = '126' AND h.cnpj = '27164580000109'
)
INSERT INTO reserva_quarto (reserva_id, quarto_id)
SELECT r.id, q.id
FROM reserva_base r
CROSS JOIN quarto_base q;
INSERT INTO reserva (cpf_cliente, data_reserva, data_checkin_previsto, data_checkout_previsto, status_reserva) VALUES ('91568403224', '2026-02-22', '2026-02-26', '2026-03-07', 'Confirmada');
WITH reserva_base AS (
  SELECT id FROM reserva WHERE cpf_cliente = '91568403224' AND data_reserva = '2026-02-22'
), quarto_base AS (
  SELECT q.id
  FROM quarto q
  JOIN hotel h ON q.hotel_id = h.id
  WHERE q.numero = '106' AND h.cnpj = '27164580000109'
)
INSERT INTO reserva_quarto (reserva_id, quarto_id)
SELECT r.id, q.id
FROM reserva_base r
CROSS JOIN quarto_base q;
INSERT INTO reserva (cpf_cliente, data_reserva, data_checkin_previsto, data_checkout_previsto, status_reserva) VALUES ('47251896346', '2026-02-17', '2026-02-19', '2026-02-23', 'Confirmada');
WITH reserva_base AS (
  SELECT id FROM reserva WHERE cpf_cliente = '47251896346' AND data_reserva = '2026-02-17'
), quarto_base AS (
  SELECT q.id
  FROM quarto q
  JOIN hotel h ON q.hotel_id = h.id
  WHERE q.numero = '110' AND h.cnpj = '27164580000109'
)
INSERT INTO reserva_quarto (reserva_id, quarto_id)
SELECT r.id, q.id
FROM reserva_base r
CROSS JOIN quarto_base q;

WITH reserva_base AS (
  SELECT id FROM reserva WHERE cpf_cliente = '47251896346' AND data_reserva = '2026-02-17'
), quarto_base AS (
  SELECT q.id
  FROM quarto q
  JOIN hotel h ON q.hotel_id = h.id
  WHERE q.numero = '112' AND h.cnpj = '27164580000109'
)
INSERT INTO reserva_quarto (reserva_id, quarto_id)
SELECT r.id, q.id
FROM reserva_base r
CROSS JOIN quarto_base q;
INSERT INTO reserva (cpf_cliente, data_reserva, data_checkin_previsto, data_checkout_previsto, status_reserva) VALUES ('18504972658', '2026-02-15', '2026-02-19', '2026-02-20', 'Pendente');
WITH reserva_base AS (
  SELECT id FROM reserva WHERE cpf_cliente = '18504972658' AND data_reserva = '2026-02-15'
), quarto_base AS (
  SELECT q.id
  FROM quarto q
  JOIN hotel h ON q.hotel_id = h.id
  WHERE q.numero = '128' AND h.cnpj = '27164580000109'
)
INSERT INTO reserva_quarto (reserva_id, quarto_id)
SELECT r.id, q.id
FROM reserva_base r
CROSS JOIN quarto_base q;

WITH reserva_base AS (
  SELECT id FROM reserva WHERE cpf_cliente = '18504972658' AND data_reserva = '2026-02-15'
), quarto_base AS (
  SELECT q.id
  FROM quarto q
  JOIN hotel h ON q.hotel_id = h.id
  WHERE q.numero = '121' AND h.cnpj = '27164580000109'
)
INSERT INTO reserva_quarto (reserva_id, quarto_id)
SELECT r.id, q.id
FROM reserva_base r
CROSS JOIN quarto_base q;
INSERT INTO reserva (cpf_cliente, data_reserva, data_checkin_previsto, data_checkout_previsto, status_reserva) VALUES ('67493012822', '2026-02-05', '2026-02-12', '2026-02-14', 'Confirmada');
WITH reserva_base AS (
  SELECT id FROM reserva WHERE cpf_cliente = '67493012822' AND data_reserva = '2026-02-05'
), quarto_base AS (
  SELECT q.id
  FROM quarto q
  JOIN hotel h ON q.hotel_id = h.id
  WHERE q.numero = '125' AND h.cnpj = '27164580000109'
)
INSERT INTO reserva_quarto (reserva_id, quarto_id)
SELECT r.id, q.id
FROM reserva_base r
CROSS JOIN quarto_base q;
WITH servico_base AS (
  SELECT id FROM servico_adicional WHERE nome_servico = 'Café da Manhã no Quarto'
), reserva_base AS (
  SELECT id FROM reserva WHERE cpf_cliente = '67493012822' AND data_reserva = '2026-02-05'
)
INSERT INTO reserva_servico (reserva_id, servico_adicional_id, quantidade)
SELECT r.id, s.id, 2
FROM reserva_base r
CROSS JOIN servico_base s;
INSERT INTO reserva (cpf_cliente, data_reserva, data_checkin_previsto, data_checkout_previsto, status_reserva) VALUES ('18063974557', '2026-03-20', '2026-03-21', '2026-03-31', 'Confirmada');
WITH reserva_base AS (
  SELECT id FROM reserva WHERE cpf_cliente = '18063974557' AND data_reserva = '2026-03-20'
), quarto_base AS (
  SELECT q.id
  FROM quarto q
  JOIN hotel h ON q.hotel_id = h.id
  WHERE q.numero = '105' AND h.cnpj = '27164580000109'
)
INSERT INTO reserva_quarto (reserva_id, quarto_id)
SELECT r.id, q.id
FROM reserva_base r
CROSS JOIN quarto_base q;
INSERT INTO reserva (cpf_cliente, data_reserva, data_checkin_previsto, data_checkout_previsto, status_reserva) VALUES ('52039617434', '2026-01-28', '2026-02-04', '2026-02-07', 'Concluída');
WITH reserva_base AS (
  SELECT id FROM reserva WHERE cpf_cliente = '52039617434' AND data_reserva = '2026-01-28'
), quarto_base AS (
  SELECT q.id
  FROM quarto q
  JOIN hotel h ON q.hotel_id = h.id
  WHERE q.numero = '111' AND h.cnpj = '27164580000109'
)
INSERT INTO reserva_quarto (reserva_id, quarto_id)
SELECT r.id, q.id
FROM reserva_base r
CROSS JOIN quarto_base q;
INSERT INTO reserva (cpf_cliente, data_reserva, data_checkin_previsto, data_checkout_previsto, status_reserva) VALUES ('31457892600', '2026-03-22', '2026-03-26', '2026-04-05', 'Confirmada');
WITH reserva_base AS (
  SELECT id FROM reserva WHERE cpf_cliente = '31457892600' AND data_reserva = '2026-03-22'
), quarto_base AS (
  SELECT q.id
  FROM quarto q
  JOIN hotel h ON q.hotel_id = h.id
  WHERE q.numero = '121' AND h.cnpj = '27164580000109'
)
INSERT INTO reserva_quarto (reserva_id, quarto_id)
SELECT r.id, q.id
FROM reserva_base r
CROSS JOIN quarto_base q;
INSERT INTO reserva (cpf_cliente, data_reserva, data_checkin_previsto, data_checkout_previsto, status_reserva) VALUES ('41386572900', '2026-02-05', '2026-02-07', '2026-02-08', 'Pendente');
WITH reserva_base AS (
  SELECT id FROM reserva WHERE cpf_cliente = '41386572900' AND data_reserva = '2026-02-05'
), quarto_base AS (
  SELECT q.id
  FROM quarto q
  JOIN hotel h ON q.hotel_id = h.id
  WHERE q.numero = '112' AND h.cnpj = '27164580000109'
)
INSERT INTO reserva_quarto (reserva_id, quarto_id)
SELECT r.id, q.id
FROM reserva_base r
CROSS JOIN quarto_base q;
INSERT INTO reserva (cpf_cliente, data_reserva, data_checkin_previsto, data_checkout_previsto, status_reserva) VALUES ('93106527480', '2026-02-07', '2026-02-11', '2026-02-17', 'Pendente');
WITH reserva_base AS (
  SELECT id FROM reserva WHERE cpf_cliente = '93106527480' AND data_reserva = '2026-02-07'
), quarto_base AS (
  SELECT q.id
  FROM quarto q
  JOIN hotel h ON q.hotel_id = h.id
  WHERE q.numero = '107' AND h.cnpj = '27164580000109'
)
INSERT INTO reserva_quarto (reserva_id, quarto_id)
SELECT r.id, q.id
FROM reserva_base r
CROSS JOIN quarto_base q;

WITH reserva_base AS (
  SELECT id FROM reserva WHERE cpf_cliente = '93106527480' AND data_reserva = '2026-02-07'
), quarto_base AS (
  SELECT q.id
  FROM quarto q
  JOIN hotel h ON q.hotel_id = h.id
  WHERE q.numero = '124' AND h.cnpj = '27164580000109'
)
INSERT INTO reserva_quarto (reserva_id, quarto_id)
SELECT r.id, q.id
FROM reserva_base r
CROSS JOIN quarto_base q;
INSERT INTO reserva (cpf_cliente, data_reserva, data_checkin_previsto, data_checkout_previsto, status_reserva) VALUES ('31724968050', '2026-03-12', '2026-03-19', '2026-03-28', 'Confirmada');
WITH reserva_base AS (
  SELECT id FROM reserva WHERE cpf_cliente = '31724968050' AND data_reserva = '2026-03-12'
), quarto_base AS (
  SELECT q.id
  FROM quarto q
  JOIN hotel h ON q.hotel_id = h.id
  WHERE q.numero = '116' AND h.cnpj = '27164580000109'
)
INSERT INTO reserva_quarto (reserva_id, quarto_id)
SELECT r.id, q.id
FROM reserva_base r
CROSS JOIN quarto_base q;

WITH reserva_base AS (
  SELECT id FROM reserva WHERE cpf_cliente = '31724968050' AND data_reserva = '2026-03-12'
), quarto_base AS (
  SELECT q.id
  FROM quarto q
  JOIN hotel h ON q.hotel_id = h.id
  WHERE q.numero = '113' AND h.cnpj = '27164580000109'
)
INSERT INTO reserva_quarto (reserva_id, quarto_id)
SELECT r.id, q.id
FROM reserva_base r
CROSS JOIN quarto_base q;
WITH servico_base AS (
  SELECT id FROM servico_adicional WHERE nome_servico = 'Café da Manhã no Quarto'
), reserva_base AS (
  SELECT id FROM reserva WHERE cpf_cliente = '31724968050' AND data_reserva = '2026-03-12'
)
INSERT INTO reserva_servico (reserva_id, servico_adicional_id, quantidade)
SELECT r.id, s.id, 2
FROM reserva_base r
CROSS JOIN servico_base s;
INSERT INTO reserva (cpf_cliente, data_reserva, data_checkin_previsto, data_checkout_previsto, status_reserva) VALUES ('47586130957', '2026-01-22', '2026-01-26', '2026-02-01', 'Concluída');
WITH reserva_base AS (
  SELECT id FROM reserva WHERE cpf_cliente = '47586130957' AND data_reserva = '2026-01-22'
), quarto_base AS (
  SELECT q.id
  FROM quarto q
  JOIN hotel h ON q.hotel_id = h.id
  WHERE q.numero = '104' AND h.cnpj = '27164580000109'
)
INSERT INTO reserva_quarto (reserva_id, quarto_id)
SELECT r.id, q.id
FROM reserva_base r
CROSS JOIN quarto_base q;
WITH servico_base AS (
  SELECT id FROM servico_adicional WHERE nome_servico = 'Lavanderia Express'
), reserva_base AS (
  SELECT id FROM reserva WHERE cpf_cliente = '47586130957' AND data_reserva = '2026-01-22'
)
INSERT INTO reserva_servico (reserva_id, servico_adicional_id, quantidade)
SELECT r.id, s.id, 1
FROM reserva_base r
CROSS JOIN servico_base s;
INSERT INTO reserva (cpf_cliente, data_reserva, data_checkin_previsto, data_checkout_previsto, status_reserva) VALUES ('31790682568', '2026-02-18', '2026-02-22', '2026-03-02', 'Confirmada');
WITH reserva_base AS (
  SELECT id FROM reserva WHERE cpf_cliente = '31790682568' AND data_reserva = '2026-02-18'
), quarto_base AS (
  SELECT q.id
  FROM quarto q
  JOIN hotel h ON q.hotel_id = h.id
  WHERE q.numero = '117' AND h.cnpj = '27164580000109'
)
INSERT INTO reserva_quarto (reserva_id, quarto_id)
SELECT r.id, q.id
FROM reserva_base r
CROSS JOIN quarto_base q;
WITH servico_base AS (
  SELECT id FROM servico_adicional WHERE nome_servico = 'Café da Manhã no Quarto'
), reserva_base AS (
  SELECT id FROM reserva WHERE cpf_cliente = '31790682568' AND data_reserva = '2026-02-18'
)
INSERT INTO reserva_servico (reserva_id, servico_adicional_id, quantidade)
SELECT r.id, s.id, 2
FROM reserva_base r
CROSS JOIN servico_base s;
INSERT INTO reserva (cpf_cliente, data_reserva, data_checkin_previsto, data_checkout_previsto, status_reserva) VALUES ('35164089289', '2026-03-05', '2026-03-13', '2026-03-15', 'Confirmada');
WITH reserva_base AS (
  SELECT id FROM reserva WHERE cpf_cliente = '35164089289' AND data_reserva = '2026-03-05'
), quarto_base AS (
  SELECT q.id
  FROM quarto q
  JOIN hotel h ON q.hotel_id = h.id
  WHERE q.numero = '102' AND h.cnpj = '27164580000109'
)
INSERT INTO reserva_quarto (reserva_id, quarto_id)
SELECT r.id, q.id
FROM reserva_base r
CROSS JOIN quarto_base q;
INSERT INTO reserva (cpf_cliente, data_reserva, data_checkin_previsto, data_checkout_previsto, status_reserva) VALUES ('18063974557', '2026-02-20', '2026-02-28', '2026-03-08', 'Pendente');
WITH reserva_base AS (
  SELECT id FROM reserva WHERE cpf_cliente = '18063974557' AND data_reserva = '2026-02-20'
), quarto_base AS (
  SELECT q.id
  FROM quarto q
  JOIN hotel h ON q.hotel_id = h.id
  WHERE q.numero = '115' AND h.cnpj = '27164580000109'
)
INSERT INTO reserva_quarto (reserva_id, quarto_id)
SELECT r.id, q.id
FROM reserva_base r
CROSS JOIN quarto_base q;
WITH servico_base AS (
  SELECT id FROM servico_adicional WHERE nome_servico = 'Café da Manhã no Quarto'
), reserva_base AS (
  SELECT id FROM reserva WHERE cpf_cliente = '18063974557' AND data_reserva = '2026-02-20'
)
INSERT INTO reserva_servico (reserva_id, servico_adicional_id, quantidade)
SELECT r.id, s.id, 2
FROM reserva_base r
CROSS JOIN servico_base s;
INSERT INTO reserva (cpf_cliente, data_reserva, data_checkin_previsto, data_checkout_previsto, status_reserva) VALUES ('13259068759', '2026-02-08', '2026-02-12', '2026-02-18', 'Pendente');
WITH reserva_base AS (
  SELECT id FROM reserva WHERE cpf_cliente = '13259068759' AND data_reserva = '2026-02-08'
), quarto_base AS (
  SELECT q.id
  FROM quarto q
  JOIN hotel h ON q.hotel_id = h.id
  WHERE q.numero = '107' AND h.cnpj = '27164580000109'
)
INSERT INTO reserva_quarto (reserva_id, quarto_id)
SELECT r.id, q.id
FROM reserva_base r
CROSS JOIN quarto_base q;
WITH servico_base AS (
  SELECT id FROM servico_adicional WHERE nome_servico = 'Jantar Romântico'
), reserva_base AS (
  SELECT id FROM reserva WHERE cpf_cliente = '13259068759' AND data_reserva = '2026-02-08'
)
INSERT INTO reserva_servico (reserva_id, servico_adicional_id, quantidade)
SELECT r.id, s.id, 1
FROM reserva_base r
CROSS JOIN servico_base s;
INSERT INTO reserva (cpf_cliente, data_reserva, data_checkin_previsto, data_checkout_previsto, status_reserva) VALUES ('59201476876', '2026-03-14', '2026-03-20', '2026-03-25', 'Pendente');
WITH reserva_base AS (
  SELECT id FROM reserva WHERE cpf_cliente = '59201476876' AND data_reserva = '2026-03-14'
), quarto_base AS (
  SELECT q.id
  FROM quarto q
  JOIN hotel h ON q.hotel_id = h.id
  WHERE q.numero = '111' AND h.cnpj = '27164580000109'
)
INSERT INTO reserva_quarto (reserva_id, quarto_id)
SELECT r.id, q.id
FROM reserva_base r
CROSS JOIN quarto_base q;
INSERT INTO reserva (cpf_cliente, data_reserva, data_checkin_previsto, data_checkout_previsto, status_reserva) VALUES ('72938516002', '2026-03-22', '2026-04-01', '2026-04-05', 'Confirmada');
WITH reserva_base AS (
  SELECT id FROM reserva WHERE cpf_cliente = '72938516002' AND data_reserva = '2026-03-22'
), quarto_base AS (
  SELECT q.id
  FROM quarto q
  JOIN hotel h ON q.hotel_id = h.id
  WHERE q.numero = '104' AND h.cnpj = '27164580000109'
)
INSERT INTO reserva_quarto (reserva_id, quarto_id)
SELECT r.id, q.id
FROM reserva_base r
CROSS JOIN quarto_base q;

WITH reserva_base AS (
  SELECT id FROM reserva WHERE cpf_cliente = '72938516002' AND data_reserva = '2026-03-22'
), quarto_base AS (
  SELECT q.id
  FROM quarto q
  JOIN hotel h ON q.hotel_id = h.id
  WHERE q.numero = '112' AND h.cnpj = '27164580000109'
)
INSERT INTO reserva_quarto (reserva_id, quarto_id)
SELECT r.id, q.id
FROM reserva_base r
CROSS JOIN quarto_base q;
WITH servico_base AS (
  SELECT id FROM servico_adicional WHERE nome_servico = 'Lavanderia Express'
), reserva_base AS (
  SELECT id FROM reserva WHERE cpf_cliente = '72938516002' AND data_reserva = '2026-03-22'
)
INSERT INTO reserva_servico (reserva_id, servico_adicional_id, quantidade)
SELECT r.id, s.id, 1
FROM reserva_base r
CROSS JOIN servico_base s;
INSERT INTO reserva (cpf_cliente, data_reserva, data_checkin_previsto, data_checkout_previsto, status_reserva) VALUES ('75640839210', '2026-03-18', '2026-03-19', '2026-03-20', 'Pendente');
WITH reserva_base AS (
  SELECT id FROM reserva WHERE cpf_cliente = '75640839210' AND data_reserva = '2026-03-18'
), quarto_base AS (
  SELECT q.id
  FROM quarto q
  JOIN hotel h ON q.hotel_id = h.id
  WHERE q.numero = '108' AND h.cnpj = '27164580000109'
)
INSERT INTO reserva_quarto (reserva_id, quarto_id)
SELECT r.id, q.id
FROM reserva_base r
CROSS JOIN quarto_base q;
WITH servico_base AS (
  SELECT id FROM servico_adicional WHERE nome_servico = 'Lavanderia Express'
), reserva_base AS (
  SELECT id FROM reserva WHERE cpf_cliente = '75640839210' AND data_reserva = '2026-03-18'
)
INSERT INTO reserva_servico (reserva_id, servico_adicional_id, quantidade)
SELECT r.id, s.id, 1
FROM reserva_base r
CROSS JOIN servico_base s;
INSERT INTO reserva (cpf_cliente, data_reserva, data_checkin_previsto, data_checkout_previsto, status_reserva) VALUES ('31724968050', '2026-02-10', '2026-02-14', '2026-02-15', 'Confirmada');
WITH reserva_base AS (
  SELECT id FROM reserva WHERE cpf_cliente = '31724968050' AND data_reserva = '2026-02-10'
), quarto_base AS (
  SELECT q.id
  FROM quarto q
  JOIN hotel h ON q.hotel_id = h.id
  WHERE q.numero = '116' AND h.cnpj = '27164580000109'
)
INSERT INTO reserva_quarto (reserva_id, quarto_id)
SELECT r.id, q.id
FROM reserva_base r
CROSS JOIN quarto_base q;
WITH servico_base AS (
  SELECT id FROM servico_adicional WHERE nome_servico = 'Jantar Romântico'
), reserva_base AS (
  SELECT id FROM reserva WHERE cpf_cliente = '31724968050' AND data_reserva = '2026-02-10'
)
INSERT INTO reserva_servico (reserva_id, servico_adicional_id, quantidade)
SELECT r.id, s.id, 2
FROM reserva_base r
CROSS JOIN servico_base s;
INSERT INTO reserva (cpf_cliente, data_reserva, data_checkin_previsto, data_checkout_previsto, status_reserva) VALUES ('31457892600', '2026-01-19', '2026-01-26', '2026-01-28', 'Cancelada');
WITH reserva_base AS (
  SELECT id FROM reserva WHERE cpf_cliente = '31457892600' AND data_reserva = '2026-01-19'
), quarto_base AS (
  SELECT q.id
  FROM quarto q
  JOIN hotel h ON q.hotel_id = h.id
  WHERE q.numero = '121' AND h.cnpj = '27164580000109'
)
INSERT INTO reserva_quarto (reserva_id, quarto_id)
SELECT r.id, q.id
FROM reserva_base r
CROSS JOIN quarto_base q;
WITH servico_base AS (
  SELECT id FROM servico_adicional WHERE nome_servico = 'Jantar Romântico'
), reserva_base AS (
  SELECT id FROM reserva WHERE cpf_cliente = '31457892600' AND data_reserva = '2026-01-19'
)
INSERT INTO reserva_servico (reserva_id, servico_adicional_id, quantidade)
SELECT r.id, s.id, 1
FROM reserva_base r
CROSS JOIN servico_base s;
INSERT INTO reserva (cpf_cliente, data_reserva, data_checkin_previsto, data_checkout_previsto, status_reserva) VALUES ('53106284790', '2026-03-30', '2026-04-06', '2026-04-12', 'Confirmada');
WITH reserva_base AS (
  SELECT id FROM reserva WHERE cpf_cliente = '53106284790' AND data_reserva = '2026-03-30'
), quarto_base AS (
  SELECT q.id
  FROM quarto q
  JOIN hotel h ON q.hotel_id = h.id
  WHERE q.numero = '129' AND h.cnpj = '27164580000109'
)
INSERT INTO reserva_quarto (reserva_id, quarto_id)
SELECT r.id, q.id
FROM reserva_base r
CROSS JOIN quarto_base q;
WITH servico_base AS (
  SELECT id FROM servico_adicional WHERE nome_servico = 'Jantar Romântico'
), reserva_base AS (
  SELECT id FROM reserva WHERE cpf_cliente = '53106284790' AND data_reserva = '2026-03-30'
)
INSERT INTO reserva_servico (reserva_id, servico_adicional_id, quantidade)
SELECT r.id, s.id, 2
FROM reserva_base r
CROSS JOIN servico_base s;

-- Hospedagens
WITH reserva_base AS (
  SELECT id FROM reserva WHERE cpf_cliente = '31457892600' AND data_reserva = '2026-01-09'
)
INSERT INTO hospedagem (reserva_id, cpf_cliente, data_checkin_real, data_checkout_real)
SELECT r.id, '31457892600', '2026-01-19', '2026-01-20' FROM reserva_base r;
WITH hospedagem_base AS (
  SELECT h.id FROM hospedagem h
  WHERE h.reserva_id IN (SELECT id FROM reserva WHERE cpf_cliente = '31457892600' AND data_reserva = '2026-01-09')
    AND h.data_checkin_real = '2026-01-19'
), quarto_base AS (
  SELECT q.id FROM quarto q JOIN hotel h2 ON q.hotel_id = h2.id WHERE q.numero = '109' AND h2.cnpj = '27164580000109'
)
INSERT INTO hospedagem_quarto (hospedagem_id, quarto_id)
SELECT h.id, q.id FROM hospedagem_base h CROSS JOIN quarto_base q;
WITH servico_base AS (
  SELECT id FROM servico_adicional WHERE nome_servico = 'Massagem Relaxante'
), hospedagem_base AS (
  SELECT h.id FROM hospedagem h
  WHERE h.reserva_id IN (SELECT id FROM reserva WHERE cpf_cliente = '31457892600' AND data_reserva = '2026-01-09')
    AND h.data_checkin_real = '2026-01-19'
)
INSERT INTO hospedagem_servico (hospedagem_id, servico_adicional_id, quantidade, data_solicitacao)
SELECT h.id, s.id, 5, '2026-01-19 20:00:00' FROM hospedagem_base h CROSS JOIN servico_base s;
WITH hospedagem_base AS (
  SELECT h.id FROM hospedagem h
  WHERE h.reserva_id IN (SELECT id FROM reserva WHERE cpf_cliente = '31457892600' AND data_reserva = '2026-01-09')
    AND h.data_checkin_real = '2026-01-19'
)
INSERT INTO pagamento (hospedagem_id, valor_total, metodo_pagamento, status_pagamento)
SELECT h.id, 1030.5, 'Pix', 'Concluído' FROM hospedagem_base h;

WITH reserva_base AS (
  SELECT id FROM reserva WHERE cpf_cliente = '41386572900' AND data_reserva = '2026-01-26'
)
INSERT INTO hospedagem (reserva_id, cpf_cliente, data_checkin_real, data_checkout_real)
SELECT r.id, '41386572900', '2026-01-31', '2026-02-04' FROM reserva_base r;
WITH hospedagem_base AS (
  SELECT h.id FROM hospedagem h
  WHERE h.reserva_id IN (SELECT id FROM reserva WHERE cpf_cliente = '41386572900' AND data_reserva = '2026-01-26')
    AND h.data_checkin_real = '2026-01-31'
), quarto_base AS (
  SELECT q.id FROM quarto q JOIN hotel h2 ON q.hotel_id = h2.id WHERE q.numero = '123' AND h2.cnpj = '27164580000109'
)
INSERT INTO hospedagem_quarto (hospedagem_id, quarto_id)
SELECT h.id, q.id FROM hospedagem_base h CROSS JOIN quarto_base q;
WITH servico_base AS (
  SELECT id FROM servico_adicional WHERE nome_servico = 'Lavanderia Express'
), hospedagem_base AS (
  SELECT h.id FROM hospedagem h
  WHERE h.reserva_id IN (SELECT id FROM reserva WHERE cpf_cliente = '41386572900' AND data_reserva = '2026-01-26')
    AND h.data_checkin_real = '2026-01-31'
)
INSERT INTO hospedagem_servico (hospedagem_id, servico_adicional_id, quantidade, data_solicitacao)
SELECT h.id, s.id, 4, '2026-01-31 20:00:00' FROM hospedagem_base h CROSS JOIN servico_base s;
WITH hospedagem_base AS (
  SELECT h.id FROM hospedagem h
  WHERE h.reserva_id IN (SELECT id FROM reserva WHERE cpf_cliente = '41386572900' AND data_reserva = '2026-01-26')
    AND h.data_checkin_real = '2026-01-31'
)
INSERT INTO pagamento (hospedagem_id, valor_total, metodo_pagamento, status_pagamento)
SELECT h.id, 364.5, 'Pix', 'Concluído' FROM hospedagem_base h;

WITH reserva_base AS (
  SELECT id FROM reserva WHERE cpf_cliente = '18063974557' AND data_reserva = '2026-01-09'
)
INSERT INTO hospedagem (reserva_id, cpf_cliente, data_checkin_real, data_checkout_real)
SELECT r.id, '18063974557', '2026-01-18', '2026-01-22' FROM reserva_base r;
WITH hospedagem_base AS (
  SELECT h.id FROM hospedagem h
  WHERE h.reserva_id IN (SELECT id FROM reserva WHERE cpf_cliente = '18063974557' AND data_reserva = '2026-01-09')
    AND h.data_checkin_real = '2026-01-18'
), quarto_base AS (
  SELECT q.id FROM quarto q JOIN hotel h2 ON q.hotel_id = h2.id WHERE q.numero = '106' AND h2.cnpj = '27164580000109'
)
INSERT INTO hospedagem_quarto (hospedagem_id, quarto_id)
SELECT h.id, q.id FROM hospedagem_base h CROSS JOIN quarto_base q;
WITH servico_base AS (
  SELECT id FROM servico_adicional WHERE nome_servico = 'Massagem Relaxante'
), hospedagem_base AS (
  SELECT h.id FROM hospedagem h
  WHERE h.reserva_id IN (SELECT id FROM reserva WHERE cpf_cliente = '18063974557' AND data_reserva = '2026-01-09')
    AND h.data_checkin_real = '2026-01-18'
)
INSERT INTO hospedagem_servico (hospedagem_id, servico_adicional_id, quantidade, data_solicitacao)
SELECT h.id, s.id, 3, '2026-01-18 20:00:00' FROM hospedagem_base h CROSS JOIN servico_base s;
WITH hospedagem_base AS (
  SELECT h.id FROM hospedagem h
  WHERE h.reserva_id IN (SELECT id FROM reserva WHERE cpf_cliente = '18063974557' AND data_reserva = '2026-01-09')
    AND h.data_checkin_real = '2026-01-18'
)
INSERT INTO pagamento (hospedagem_id, valor_total, metodo_pagamento, status_pagamento)
SELECT h.id, 943.5, 'Cartão Crédito', 'Concluído' FROM hospedagem_base h;

WITH reserva_base AS (
  SELECT id FROM reserva WHERE cpf_cliente = '13259068759' AND data_reserva = '2026-01-17'
)
INSERT INTO hospedagem (reserva_id, cpf_cliente, data_checkin_real, data_checkout_real)
SELECT r.id, '13259068759', '2026-01-22', '2026-01-23' FROM reserva_base r;
WITH hospedagem_base AS (
  SELECT h.id FROM hospedagem h
  WHERE h.reserva_id IN (SELECT id FROM reserva WHERE cpf_cliente = '13259068759' AND data_reserva = '2026-01-17')
    AND h.data_checkin_real = '2026-01-22'
), quarto_base1 AS (
  SELECT q.id FROM quarto q JOIN hotel h2 ON q.hotel_id = h2.id WHERE q.numero = '110' AND h2.cnpj = '27164580000109'
), quarto_base2 AS (
  SELECT q.id FROM quarto q JOIN hotel h2 ON q.hotel_id = h2.id WHERE q.numero = '123' AND h2.cnpj = '27164580000109'
)
INSERT INTO hospedagem_quarto (hospedagem_id, quarto_id)
SELECT h.id, q.id FROM hospedagem_base h CROSS JOIN quarto_base1 q;
WITH hospedagem_base AS (
  SELECT h.id FROM hospedagem h
  WHERE h.reserva_id IN (SELECT id FROM reserva WHERE cpf_cliente = '13259068759' AND data_reserva = '2026-01-17')
    AND h.data_checkin_real = '2026-01-22'
), quarto_base AS (
  SELECT q.id FROM quarto q JOIN hotel h2 ON q.hotel_id = h2.id WHERE q.numero = '123' AND h2.cnpj = '27164580000109'
)
INSERT INTO hospedagem_quarto (hospedagem_id, quarto_id)
SELECT h.id, q.id FROM hospedagem_base h CROSS JOIN quarto_base q;
WITH servico_base AS (
  SELECT id FROM servico_adicional WHERE nome_servico = 'Jantar Romântico'
), hospedagem_base AS (
  SELECT h.id FROM hospedagem h
  WHERE h.reserva_id IN (SELECT id FROM reserva WHERE cpf_cliente = '13259068759' AND data_reserva = '2026-01-17')
    AND h.data_checkin_real = '2026-01-22'
)
INSERT INTO hospedagem_servico (hospedagem_id, servico_adicional_id, quantidade, data_solicitacao)
SELECT h.id, s.id, 3, '2026-01-22 20:00:00' FROM hospedagem_base h CROSS JOIN servico_base s;
WITH hospedagem_base AS (
  SELECT h.id FROM hospedagem h
  WHERE h.reserva_id IN (SELECT id FROM reserva WHERE cpf_cliente = '13259068759' AND data_reserva = '2026-01-17')
    AND h.data_checkin_real = '2026-01-22'
)
INSERT INTO pagamento (hospedagem_id, valor_total, metodo_pagamento, status_pagamento)
SELECT h.id, 1091.5, 'Pix', 'Concluído' FROM hospedagem_base h;

WITH reserva_base AS (
  SELECT id FROM reserva WHERE cpf_cliente = '01956873457' AND data_reserva = '2026-01-24'
)
INSERT INTO hospedagem (reserva_id, cpf_cliente, data_checkin_real, data_checkout_real)
SELECT r.id, '01956873457', '2026-02-03', '2026-02-05' FROM reserva_base r;
WITH hospedagem_base AS (
  SELECT h.id FROM hospedagem h
  WHERE h.reserva_id IN (SELECT id FROM reserva WHERE cpf_cliente = '01956873457' AND data_reserva = '2026-01-24')
    AND h.data_checkin_real = '2026-02-03'
), quarto_base1 AS (
  SELECT q.id FROM quarto q JOIN hotel h2 ON q.hotel_id = h2.id WHERE q.numero = '115' AND h2.cnpj = '27164580000109'
), quarto_base2 AS (
  SELECT q.id FROM quarto q JOIN hotel h2 ON q.hotel_id = h2.id WHERE q.numero = '124' AND h2.cnpj = '27164580000109'
)
INSERT INTO hospedagem_quarto (hospedagem_id, quarto_id)
SELECT h.id, q.id FROM hospedagem_base h CROSS JOIN quarto_base1 q;
WITH hospedagem_base AS (
  SELECT h.id FROM hospedagem h
  WHERE h.reserva_id IN (SELECT id FROM reserva WHERE cpf_cliente = '01956873457' AND data_reserva = '2026-01-24')
    AND h.data_checkin_real = '2026-02-03'
), quarto_base AS (
  SELECT q.id FROM quarto q JOIN hotel h2 ON q.hotel_id = h2.id WHERE q.numero = '124' AND h2.cnpj = '27164580000109'
)
INSERT INTO hospedagem_quarto (hospedagem_id, quarto_id)
SELECT h.id, q.id FROM hospedagem_base h CROSS JOIN quarto_base q;
WITH servico_base AS (
  SELECT id FROM servico_adicional WHERE nome_servico = 'Jantar Romântico'
), hospedagem_base AS (
  SELECT h.id FROM hospedagem h
  WHERE h.reserva_id IN (SELECT id FROM reserva WHERE cpf_cliente = '01956873457' AND data_reserva = '2026-01-24')
    AND h.data_checkin_real = '2026-02-03'
)
INSERT INTO hospedagem_servico (hospedagem_id, servico_adicional_id, quantidade, data_solicitacao)
SELECT h.id, s.id, 4, '2026-02-03 20:00:00' FROM hospedagem_base h CROSS JOIN servico_base s;
WITH hospedagem_base AS (
  SELECT h.id FROM hospedagem h
  WHERE h.reserva_id IN (SELECT id FROM reserva WHERE cpf_cliente = '01956873457' AND data_reserva = '2026-01-24')
    AND h.data_checkin_real = '2026-02-03'
)
INSERT INTO pagamento (hospedagem_id, valor_total, metodo_pagamento, status_pagamento)
SELECT h.id, 1918.5, 'Pix', 'Concluído' FROM hospedagem_base h;

WITH reserva_base AS (
  SELECT id FROM reserva WHERE cpf_cliente = '67251409399' AND data_reserva = '2026-01-07'
)
INSERT INTO hospedagem (reserva_id, cpf_cliente, data_checkin_real, data_checkout_real)
SELECT r.id, '67251409399', '2026-01-11', '2026-01-13' FROM reserva_base r;
WITH hospedagem_base AS (
  SELECT h.id FROM hospedagem h
  WHERE h.reserva_id IN (SELECT id FROM reserva WHERE cpf_cliente = '67251409399' AND data_reserva = '2026-01-07')
    AND h.data_checkin_real = '2026-01-11'
), quarto_base AS (
  SELECT q.id FROM quarto q JOIN hotel h2 ON q.hotel_id = h2.id WHERE q.numero = '104' AND h2.cnpj = '27164580000109'
)
INSERT INTO hospedagem_quarto (hospedagem_id, quarto_id)
SELECT h.id, q.id FROM hospedagem_base h CROSS JOIN quarto_base q;
WITH hospedagem_base AS (
  SELECT h.id FROM hospedagem h
  WHERE h.reserva_id IN (SELECT id FROM reserva WHERE cpf_cliente = '67251409399' AND data_reserva = '2026-01-07')
    AND h.data_checkin_real = '2026-01-11'
)
INSERT INTO pagamento (hospedagem_id, valor_total, metodo_pagamento, status_pagamento)
SELECT h.id, 1027.5, 'Cartão Crédito', 'Concluído' FROM hospedagem_base h;

WITH reserva_base AS (
  SELECT id FROM reserva WHERE cpf_cliente = '03624197878' AND data_reserva = '2026-01-30'
)
INSERT INTO hospedagem (reserva_id, cpf_cliente, data_checkin_real, data_checkout_real)
SELECT r.id, '03624197878', '2026-02-05', '2026-02-06' FROM reserva_base r;
WITH hospedagem_base AS (
  SELECT h.id FROM hospedagem h
  WHERE h.reserva_id IN (SELECT id FROM reserva WHERE cpf_cliente = '03624197878' AND data_reserva = '2026-01-30')
    AND h.data_checkin_real = '2026-02-05'
), quarto_base1 AS (
  SELECT q.id FROM quarto q JOIN hotel h2 ON q.hotel_id = h2.id WHERE q.numero = '123' AND h2.cnpj = '27164580000109'
), quarto_base2 AS (
  SELECT q.id FROM quarto q JOIN hotel h2 ON q.hotel_id = h2.id WHERE q.numero = '129' AND h2.cnpj = '27164580000109'
)
INSERT INTO hospedagem_quarto (hospedagem_id, quarto_id)
SELECT h.id, q.id FROM hospedagem_base h CROSS JOIN quarto_base1 q;
WITH hospedagem_base AS (
  SELECT h.id FROM hospedagem h
  WHERE h.reserva_id IN (SELECT id FROM reserva WHERE cpf_cliente = '03624197878' AND data_reserva = '2026-01-30')
    AND h.data_checkin_real = '2026-02-05'
), quarto_base AS (
  SELECT q.id FROM quarto q JOIN hotel h2 ON q.hotel_id = h2.id WHERE q.numero = '129' AND h2.cnpj = '27164580000109'
)
INSERT INTO hospedagem_quarto (hospedagem_id, quarto_id)
SELECT h.id, q.id FROM hospedagem_base h CROSS JOIN quarto_base q;
WITH servico_base AS (
  SELECT id FROM servico_adicional WHERE nome_servico = 'Massagem Relaxante'
), hospedagem_base AS (
  SELECT h.id FROM hospedagem h
  WHERE h.reserva_id IN (SELECT id FROM reserva WHERE cpf_cliente = '03624197878' AND data_reserva = '2026-01-30')
    AND h.data_checkin_real = '2026-02-05'
)
INSERT INTO hospedagem_servico (hospedagem_id, servico_adicional_id, quantidade, data_solicitacao)
SELECT h.id, s.id, 5, '2026-02-05 20:00:00' FROM hospedagem_base h CROSS JOIN servico_base s;
WITH hospedagem_base AS (
  SELECT h.id FROM hospedagem h
  WHERE h.reserva_id IN (SELECT id FROM reserva WHERE cpf_cliente = '03624197878' AND data_reserva = '2026-01-30')
    AND h.data_checkin_real = '2026-02-05'
)
INSERT INTO pagamento (hospedagem_id, valor_total, metodo_pagamento, status_pagamento)
SELECT h.id, 1207.5, 'Cartão Crédito', 'Concluído' FROM hospedagem_base h;

WITH reserva_base AS (
  SELECT id FROM reserva WHERE cpf_cliente = '41386572900' AND data_reserva = '2026-01-28'
)
INSERT INTO hospedagem (reserva_id, cpf_cliente, data_checkin_real, data_checkout_real)
SELECT r.id, '41386572900', '2026-02-03', '2026-02-05' FROM reserva_base r;
WITH hospedagem_base AS (
  SELECT h.id FROM hospedagem h
  WHERE h.reserva_id IN (SELECT id FROM reserva WHERE cpf_cliente = '41386572900' AND data_reserva = '2026-01-28')
    AND h.data_checkin_real = '2026-02-03'
), quarto_base1 AS (
  SELECT q.id FROM quarto q JOIN hotel h2 ON q.hotel_id = h2.id WHERE q.numero = '127' AND h2.cnpj = '27164580000109'
), quarto_base2 AS (
  SELECT q.id FROM quarto q JOIN hotel h2 ON q.hotel_id = h2.id WHERE q.numero = '119' AND h2.cnpj = '27164580000109'
)
INSERT INTO hospedagem_quarto (hospedagem_id, quarto_id)
SELECT h.id, q.id FROM hospedagem_base h CROSS JOIN quarto_base1 q;
WITH hospedagem_base AS (
  SELECT h.id FROM hospedagem h
  WHERE h.reserva_id IN (SELECT id FROM reserva WHERE cpf_cliente = '41386572900' AND data_reserva = '2026-01-28')
    AND h.data_checkin_real = '2026-02-03'
), quarto_base AS (
  SELECT q.id FROM quarto q JOIN hotel h2 ON q.hotel_id = h2.id WHERE q.numero = '119' AND h2.cnpj = '27164580000109'
)
INSERT INTO hospedagem_quarto (hospedagem_id, quarto_id)
SELECT h.id, q.id FROM hospedagem_base h CROSS JOIN quarto_base q;
WITH hospedagem_base AS (
  SELECT h.id FROM hospedagem h
  WHERE h.reserva_id IN (SELECT id FROM reserva WHERE cpf_cliente = '41386572900' AND data_reserva = '2026-01-28')
    AND h.data_checkin_real = '2026-02-03'
)
INSERT INTO pagamento (hospedagem_id, valor_total, metodo_pagamento, status_pagamento)
SELECT h.id, 295.5, 'Cartão Crédito', 'Concluído' FROM hospedagem_base h;

WITH reserva_base AS (
  SELECT id FROM reserva WHERE cpf_cliente = '52039617434' AND data_reserva = '2026-01-28'
)
INSERT INTO hospedagem (reserva_id, cpf_cliente, data_checkin_real, data_checkout_real)
SELECT r.id, '52039617434', '2026-02-04', '2026-02-09' FROM reserva_base r;
WITH hospedagem_base AS (
  SELECT h.id FROM hospedagem h
  WHERE h.reserva_id IN (SELECT id FROM reserva WHERE cpf_cliente = '52039617434' AND data_reserva = '2026-01-28')
    AND h.data_checkin_real = '2026-02-04'
), quarto_base AS (
  SELECT q.id FROM quarto q JOIN hotel h2 ON q.hotel_id = h2.id WHERE q.numero = '111' AND h2.cnpj = '27164580000109'
)
INSERT INTO hospedagem_quarto (hospedagem_id, quarto_id)
SELECT h.id, q.id FROM hospedagem_base h CROSS JOIN quarto_base q;
WITH servico_base AS (
  SELECT id FROM servico_adicional WHERE nome_servico = 'Translado Aeroporto'
), hospedagem_base AS (
  SELECT h.id FROM hospedagem h
  WHERE h.reserva_id IN (SELECT id FROM reserva WHERE cpf_cliente = '52039617434' AND data_reserva = '2026-01-28')
    AND h.data_checkin_real = '2026-02-04'
)
INSERT INTO hospedagem_servico (hospedagem_id, servico_adicional_id, quantidade, data_solicitacao)
SELECT h.id, s.id, 5, '2026-02-04 20:00:00' FROM hospedagem_base h CROSS JOIN servico_base s;
WITH hospedagem_base AS (
  SELECT h.id FROM hospedagem h
  WHERE h.reserva_id IN (SELECT id FROM reserva WHERE cpf_cliente = '52039617434' AND data_reserva = '2026-01-28')
    AND h.data_checkin_real = '2026-02-04'
)
INSERT INTO pagamento (hospedagem_id, valor_total, metodo_pagamento, status_pagamento)
SELECT h.id, 1209.5, 'Pix', 'Concluído' FROM hospedagem_base h;

WITH reserva_base AS (
  SELECT id FROM reserva WHERE cpf_cliente = '47586130957' AND data_reserva = '2026-01-22'
)
INSERT INTO hospedagem (reserva_id, cpf_cliente, data_checkin_real, data_checkout_real)
SELECT r.id, '47586130957', '2026-01-26', '2026-01-27' FROM reserva_base r;
WITH hospedagem_base AS (
  SELECT h.id FROM hospedagem h
  WHERE h.reserva_id IN (SELECT id FROM reserva WHERE cpf_cliente = '47586130957' AND data_reserva = '2026-01-22')
    AND h.data_checkin_real = '2026-01-26'
), quarto_base AS (
  SELECT q.id FROM quarto q JOIN hotel h2 ON q.hotel_id = h2.id WHERE q.numero = '104' AND h2.cnpj = '27164580000109'
)
INSERT INTO hospedagem_quarto (hospedagem_id, quarto_id)
SELECT h.id, q.id FROM hospedagem_base h CROSS JOIN quarto_base q;
WITH servico_base AS (
  SELECT id FROM servico_adicional WHERE nome_servico = 'Massagem Relaxante'
), hospedagem_base AS (
  SELECT h.id FROM hospedagem h
  WHERE h.reserva_id IN (SELECT id FROM reserva WHERE cpf_cliente = '47586130957' AND data_reserva = '2026-01-22')
    AND h.data_checkin_real = '2026-01-26'
)
INSERT INTO hospedagem_servico (hospedagem_id, servico_adicional_id, quantidade, data_solicitacao)
SELECT h.id, s.id, 4, '2026-01-26 20:00:00' FROM hospedagem_base h CROSS JOIN servico_base s;
WITH hospedagem_base AS (
  SELECT h.id FROM hospedagem h
  WHERE h.reserva_id IN (SELECT id FROM reserva WHERE cpf_cliente = '47586130957' AND data_reserva = '2026-01-22')
    AND h.data_checkin_real = '2026-01-26'
)
INSERT INTO pagamento (hospedagem_id, valor_total, metodo_pagamento, status_pagamento)
SELECT h.id, 500.5, 'Pix', 'Concluído' FROM hospedagem_base h;

INSERT INTO hospedagem (reserva_id, cpf_cliente, data_checkin_real) VALUES (NULL, '09516823424', now());
WITH hospedagem_base AS (
  SELECT h.id FROM hospedagem h WHERE h.reserva_id IS NULL AND h.cpf_cliente = '09516823424' ORDER BY h.id DESC LIMIT 1
), quarto_base AS (
  SELECT q.id FROM quarto q JOIN hotel h2 ON q.hotel_id = h2.id WHERE q.numero = '109' AND h2.cnpj = '27164580000109'
)
INSERT INTO hospedagem_quarto (hospedagem_id, quarto_id)
SELECT h.id, q.id FROM hospedagem_base h CROSS JOIN quarto_base q;

INSERT INTO hospedagem (reserva_id, cpf_cliente, data_checkin_real) VALUES (NULL, '60213794896', now());
WITH hospedagem_base AS (
  SELECT h.id FROM hospedagem h WHERE h.reserva_id IS NULL AND h.cpf_cliente = '60213794896' ORDER BY h.id DESC LIMIT 1
), quarto_base AS (
  SELECT q.id FROM quarto q JOIN hotel h2 ON q.hotel_id = h2.id WHERE q.numero = '128' AND h2.cnpj = '27164580000109'
)
INSERT INTO hospedagem_quarto (hospedagem_id, quarto_id)
SELECT h.id, q.id FROM hospedagem_base h CROSS JOIN quarto_base q;

INSERT INTO hospedagem (reserva_id, cpf_cliente, data_checkin_real) VALUES (NULL, '18057293497', now());
WITH hospedagem_base AS (
  SELECT h.id FROM hospedagem h WHERE h.reserva_id IS NULL AND h.cpf_cliente = '18057293497' ORDER BY h.id DESC LIMIT 1
), quarto_base AS (
  SELECT q.id FROM quarto q JOIN hotel h2 ON q.hotel_id = h2.id WHERE q.numero = '107' AND h2.cnpj = '27164580000109'
)
INSERT INTO hospedagem_quarto (hospedagem_id, quarto_id)
SELECT h.id, q.id FROM hospedagem_base h CROSS JOIN quarto_base q;

INSERT INTO hospedagem (reserva_id, cpf_cliente, data_checkin_real) VALUES (NULL, '03624197878', now());
WITH hospedagem_base AS (
  SELECT h.id FROM hospedagem h WHERE h.reserva_id IS NULL AND h.cpf_cliente = '03624197878' ORDER BY h.id DESC LIMIT 1
), quarto_base AS (
  SELECT q.id FROM quarto q JOIN hotel h2 ON q.hotel_id = h2.id WHERE q.numero = '129' AND h2.cnpj = '27164580000109'
)
INSERT INTO hospedagem_quarto (hospedagem_id, quarto_id)
SELECT h.id, q.id FROM hospedagem_base h CROSS JOIN quarto_base q;

INSERT INTO hospedagem (reserva_id, cpf_cliente, data_checkin_real) VALUES (NULL, '31790682568', now());
WITH hospedagem_base AS (
  SELECT h.id FROM hospedagem h WHERE h.reserva_id IS NULL AND h.cpf_cliente = '31790682568' ORDER BY h.id DESC LIMIT 1
), quarto_base AS (
  SELECT q.id FROM quarto q JOIN hotel h2 ON q.hotel_id = h2.id WHERE q.numero = '126' AND h2.cnpj = '27164580000109'
)
INSERT INTO hospedagem_quarto (hospedagem_id, quarto_id)
SELECT h.id, q.id FROM hospedagem_base h CROSS JOIN quarto_base q;
