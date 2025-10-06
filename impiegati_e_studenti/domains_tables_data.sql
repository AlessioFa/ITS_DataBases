-- Creazione domini personalizzati

CREATE DOMAIN Stringa AS VARCHAR(150);


CREATE DOMAIN CodiceFiscale AS VARCHAR(16)
    CHECK(
    	VALUE ~'[A-Z]{6}[0-9]{2}[A-Z]{1}[0-9]{2}[A-Z]{1}[0-9]{3}[A-Z]{1}'
    	);

CREATE DOMAIN RealGEZ AS REAL
	CHECK(VALUE >= 0);


CREATE DOMAIN IntGEZ AS INT
	CHECK(VALUE >= 0);


CREATE DOMAIN n_matricola AS IntGEZ;


Create DOMAIN id_progetto AS IntGEZ;


-- Creazione tipo di dato composito personalizzato

CREATE TYPE tipo_impiegato AS ENUM(
	'Direttore', 'Progettista', 'Responsabile Progetto', 'Segretario');


-- Creazione tabelle

CREATE TABLE Persona(
	codice_fiscale CodiceFiscale PRIMARY KEY,
	nome Stringa NOT NULL,
	cognome Stringa NOT NULL,
	data_di_nascita Date
	);


CREATE TABLE Donna(
	codice_fiscale CodiceFiscale PRIMARY KEY,
	numero_maternità IntGEZ NOT NULL,
	FOREIGN KEY (codice_fiscale)
	REFERENCES Persona (codice_fiscale)
	);


CREATE TABLE Uomo(
	codice_fiscale CodiceFiscale PRIMARY KEY,
	posizione_militare Stringa NOT NULL,
	FOREIGN KEY (codice_fiscale)
	REFERENCES Persona (codice_fiscale)
	);


CREATE TABLE Studente(
	codice_fiscale CodiceFiscale PRIMARY KEY,
	n_matricola N_matricola UNIQUE NOT NULL,
	FOREIGN KEY (codice_fiscale)
	REFERENCES Persona(codice_fiscale)
	);


CREATE TABLE Impiegato(
	codice_fiscale CodiceFiscale PRIMARY KEY,
	stipendio RealGEZ NOT NULL,
	tipo_impiegato tipo_impiegato NOT NULL,
	FOREIGN KEY (codice_fiscale) REFERENCES Persona(codice_fiscale)
	);



CREATE TABLE Progetto(
	id_progetto IntGEZ PRIMARY KEY,
	nome Stringa
	);


CREATE TABLE ResponsabileProgetto(
	codice_fiscale_impiegato CodiceFiscale,
	id_progetto id_progetto NOT NULL,
	data_inizio DATE,
	data_fine DATE,
	PRIMARY KEY (codice_fiscale_impiegato, id_progetto),
	FOREIGN KEY (codice_fiscale_impiegato)
	REFERENCES Impiegato (codice_fiscale),
	FOREIGN KEY (id_progetto)
	REFERENCES Progetto(id_progetto)
	);



-- Popolamento Tabelle

-- Popolamento tabella Persona

INSERT INTO Persona (codice_fiscale, nome, cognome, data_di_nascita) VALUES
('RSSMRA85M01H501U', 'Mario', 'Rossi', '1985-01-01'),
('VRDLGI90F60H501P', 'Luigi', 'Verdi', '1990-06-20'),
('BNCLRA95D10H501R', 'Chiara', 'Bianchi', '1995-04-10'),
('NRIANN88A41H501Z', 'Anna', 'Neri', '1988-01-01');

-- Popolamento tabella Donna
INSERT INTO Donna (codice_fiscale, numero_maternità) VALUES
('BNCLRA95D10H501R', 1),
('NRIANN88A41H501Z', 2);

-- Popolamento tabella Uomo
INSERT INTO Uomo (codice_fiscale, posizione_militare) VALUES
('RSSMRA85M01H501U', 'Congedato'),
('VRDLGI90F60H501P', 'Esente');

-- Popolamento tabella Studente
INSERT INTO Studente (codice_fiscale, n_matricola) VALUES
('VRDLGI90F60H501P', 1001),
('BNCLRA95D10H501R', 1002);

-- Popolamento tabella Impiegato
INSERT INTO Impiegato (codice_fiscale, stipendio, tipo_impiegato) VALUES
('RSSMRA85M01H501U', 1800.50, 'Progettista'),
('NRIANN88A41H501Z', 2200.00, 'Responsabile Progetto');

-- Popolamento tabella Progetto
INSERT INTO Progetto (id_progetto, nome) VALUES
(1, 'Sistema di Sicurezza'),
(2, 'Portale Universitario');

-- Popolamento tabella ResponsabileProgetto
INSERT INTO ResponsabileProgetto (codice_fiscale_impiegato, id_progetto, data_inizio, data_fine) VALUES
('NRIANN88A41H501Z', 1, '2024-01-01', '2024-12-31'),
('RSSMRA85M01H501U', 2, '2024-02-01', NULL);