-- utente
INSERT INTO utente (username, password, email)
VALUES
    ('U1101', 'pass123', 'u1101@example.com'),
    ('U1102', 'pass234', 'u1102@example.com'),
    ('U1103', 'pass345', 'u1103@example.com');

-- venditoreprof
INSERT INTO venditoreprof (utente, partitaiva, nome_negozio)
VALUES
    ('U1101', 'IT12345678901', 'TechStore'),
    ('U1102', 'IT23456789012', 'LaptopHouse');

-- categoria
INSERT INTO categoria (nome, categoria_padre)
VALUES
    ('Elettronica', NULL),
    ('Informatica', 'Elettronica'),
    ('Laptop', 'Informatica'),
    ('Casa e giardino', NULL),
    ('Arredamento', 'Casa e giardino'),
    ('Giardino', 'Casa e giardino');

-- metodopagamento
INSERT INTO metodopagamento (nome)
VALUES
    ('Carta di credito'),
    ('Bonifico'),
    ('PayPal'),
    ('Carta regalo');

-- postoggetto
INSERT INTO postoggetto (id, titolo, descrizione, foto, categoria)
VALUES
    (1, 'Laptop Lenovo ThinkPad', 'Notebook usato in ottime condizioni', 'https://example.com/thinkpad.jpg', 'Laptop'),
    (2, 'Set Arredamento Giardino', 'Tavolo e sedie da giardino', 'https://example.com/giardino.jpg', 'Giardino');

-- met_post
INSERT INTO met_post (postoggetto, metodo)
VALUES
    (1, 'Carta di credito'),
    (1, 'Bonifico'),
    (2, 'Bonifico');

-- postoggettonuovo
INSERT INTO postoggettonuovo (postoggetto, pubblica_nuovo, prezzo, anni_garanzia)
VALUES
    (1, 'U1101', 850.00, 2),
    (2, 'U1102', 300.00, 2);

-- postoggettousato
INSERT INTO postoggettousato (postoggetto, pubblica_usato, prezzo, condizione)
VALUES
    (2, 'U1103', 280.00, 'Buono');

-- postoggettoasta
INSERT INTO postoggettoasta (postoggetto, pubblica_asta, prezzo_base, data_inizio, data_fine)
VALUES
    (2, 'U1102', 250.00, '2025-10-06', '2025-10-16');

-- postoggettocompralosubito
INSERT INTO postoggettocompralosubito (postoggetto, prezzo, data_pubblicazione)
VALUES
    (1, 850.00, '2025-10-06');

-- feedback
INSERT INTO feedback (id, mittente, destinatario, voto, commento)
VALUES
    (1, 'U1103', 'U1101', 5, 'Venditore molto affidabile!'),
    (2, 'U1103', 'U1102', 4, 'Prodotto buono, spedizione veloce.');
