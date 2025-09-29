-- Creazione domini personalizzati

CREATE DOMAIN Stringa AS VARCHAR(150);

CREATE DOMAIN Cap AS CHAR(5);

CREATE DOMAIN Telefono AS Stringa;

CREATE DOMAIN IntGez AS INT
CHECK(VALUE >= 0);

CREATE DOMAIN RealZO AS REAL
CHECK(VALUE >= 0 AND VALUE <= 1);

CREATE DOMAIN RealGEZ AS REAL
CHECK(VALUE >=0);

CREATE DOMAIN Email AS Stringa
CHECK(
    VALUE ~* '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$'
);

CREATE DOMAIN PartitaIVA AS CHAR(11)
CHECK(
    VALUE ~ '^\d{11}$'
);

CREATE DOMAIN CodiceFiscale AS CHAR(16)
CHECK(
    VALUE ~ '^[A-Z0-9]{16}$'
);


-- Creazione tipo di dato composito personalizzato

CREATE TYPE Indirizzo AS(
via Stringa,
civico Stringa,
cap Cap);



-- Creazione tabelle

CREATE TABLE Nazione(
nome Stringa PRIMARY KEY
);

CREATE TABLE Regione(
nome Stringa PRIMARY KEY,
nazione Stringa NOT NULL,
UNIQUE(nome, nazione),
FOREIGN KEY (nazione) REFERENCES nazione(nome)
);


CREATE TABLE Citta(
id_citta SERIAL PRIMARY KEY,
nome Stringa NOT NULL,
regione Stringa NOT NULL,
nazione Stringa NOT NULL,
UNIQUE(nome, regione, nazione),
FOREIGN KEY (regione, nazione)
REFERENCES Regione(nome, nazione)
);


CREATE TABLE Direttore(
id_direttore CodiceFiscale PRIMARY KEY,
nome Stringa NOT NULL,
cognome Stringa NOT NULL,
anni_servizio "IntGez" NOT NULL,
data_nascita Date NOT NULL,
id_citta INT NOT NULL,
FOREIGN KEY (id_citta) REFERENCES Citta(id_citta)
);


CREATE TABLE Dipartimento(
nome Stringa PRIMARY KEY,
indirizzo Indirizzo NOT NULL,
id_citta INT NOT NULL,
id_direttore CodiceFiscale NOT NULL,
FOREIGN KEY (id_citta) REFERENCES Citta(id_citta),
FOREIGN KEY (id_direttore) REFERENCES Direttore(id_direttore)
);


CREATE TABLE Fornitore(
partita_iva PartitaIVA PRIMARY KEY,
ragione_sociale Stringa NOT NULL,
indirizzo Indirizzo NOT NULL,
telefono Telefono NOT NULL,
email Email NOT NULL,
id_citta INT NOT NULL,
FOREIGN KEY (id_citta) REFERENCES Citta(id_citta)
);


CREATE TABLE StatoOrdine(
id_stato_ordine SERIAL PRIMARY KEY,
nome Stringa NOT NULL
);


CREATE TABLE Ordine(
id_ordine SERIAL PRIMARY KEY,
data_stipula Date NOT NULL,
imponibile RealGez NOT NULL,
aliquota RealZO NOT NULL,
descrizione Stringa NOT NULL,
id_fornitore PartitaIVA NOT NULL,
id_stato_ordine INT NOT NULL,
id_dipartimento Stringa NOT NULL,
FOREIGN KEY (id_fornitore) REFERENCES Fornitore(partita_iva),
FOREIGN KEY (id_stato_ordine) REFERENCES StatoOrdine(id_stato_ordine),
FOREIGN KEY (id_dipartimento) REFERENCES Dipartimento(nome)
);



-- Popolamento delle tabelle

-- Nazione
INSERT INTO Nazione(nome) VALUES
('Italia'),
('Francia');


-- Regione
INSERT INTO Regione(nome, nazione) VALUES
('Lombardia', 'Italia'),
('Piemonte', 'Italia'),
('Provenza', 'Francia');


-- Città
INSERT INTO Citta(nome, regione, nazione) VALUES
('Milano', 'Lombardia', 'Italia'),
('Torino', 'Piemonte', 'Italia'),
('Marsiglia', 'Provenza', 'Francia');


-- Direttore
INSERT INTO Direttore(id_direttore, nome, cognome, anni_servizio, data_nascita, id_citta) VALUES
('RSSMRA85M01H501Z', 'Mario', 'Rossi', 10, '1985-03-01', 1),
('BNCLDA90L15F205X', 'Luca', 'Bianchi', 5, '1990-07-15', 2);



-- Dipartimento
INSERT INTO Dipartimento(nome, indirizzo, id_citta, id_direttore) VALUES
(
  'IT',
  ROW('Via Roma', '12', '20100')::Indirizzo,
  1,
  'RSSMRA85M01H501Z'
),
(
  'HR',
  ROW('Via Torino', '5A', '10100')::Indirizzo,
  2,
  'BNCLDA90L15F205X'
);


-- Fornitore
INSERT INTO Fornitore(partita_iva, ragione_sociale, indirizzo, telefono, email, id_citta) VALUES
(
  '12345678901',
  'Forniture Srl',
  ROW('Via Milano', '20', '20100')::Indirizzo,
  '0245567890',
  'info@forniture.it',
  1
),
(
  '09876543210',
  'Forniture Paris',
  ROW('Rue de Paris', '10', '75001')::Indirizzo,
  '0145678901',
  'contact@forniture.fr',
  3
);


-- StatoOrdine
INSERT INTO StatoOrdine(nome) VALUES
('In lavorazione'),
('Completato'),
('Annullato');


-- Ordine
INSERT INTO Ordine(data_stipula, imponibile, aliquota, descrizione, id_fornitore, id_stato_ordine, id_dipartimento) VALUES
('2025-07-01', 1000.00, 0.22, 'Ordine materiali IT', '12345678901', 1, 'IT'),
('2025-07-02', 500.00, 0.22, 'Ordine materiali HR', '09876543210', 2, 'HR');