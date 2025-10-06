BEGIN TRANSACTION;

-- Creazione dei domini e tipi personalizzati

CREATE TYPE Strutturato AS 
  ENUM('Ricercatore', 'Professore Associato', 'Professore Ordinario');

CREATE TYPE LavoroProgetto AS 
  ENUM('Ricerca e Sviluppo', 'Dimostrazione', 'Management', 'Altro');

CREATE TYPE LavoroNonProgettuale AS 
  ENUM('Didattica', 'Ricerca', 'Missione', 
    'Incontro Dipartimentale', 
    'Incontro Accademico', 'Altro');

CREATE TYPE CausaAssenza AS 
  ENUM('Chiusura Universitaria', 'Maternita', 'Malattia');

CREATE DOMAIN PosInteger AS INTEGER CHECK (value >= 0);

CREATE DOMAIN StringaM AS varchar(100);

CREATE DOMAIN NumeroOre AS
  INTEGER CHECK (value >= 0 and value <= 8);

CREATE DOMAIN Denaro AS
  REAL CHECK (value >= 0);


-- Creazione tabelle

CREATE TABLE Persona (
  id PosInteger NOT NULL,
  nome StringaM NOT NULL,
  cognome StringaM NOT NULL,
  posizione strutturato NOT NULL,
  stipendio Denaro NOT NULL,
  PRIMARY KEY (id)  
);

CREATE TABLE Progetto (
  id PosInteger NOT NULL,
  nome StringaM NOT NULL,
  inizio DATE NOT NULL,
  fine DATE NOT NULL,
  budget Denaro NOT NULL,
  PRIMARY KEY (id),
  UNIQUE (nome),
  CHECK (inizio < fine)
);

CREATE TABLE WP (
  progetto PosInteger NOT NULL,
  id PosInteger NOT NULL,  
  nome StringaM NOT NULL,
  inizio DATE NOT NULL,
  fine DATE NOT NULL,
  PRIMARY KEY (progetto, id),
  UNIQUE (progetto, nome),
  CHECK (inizio < fine),  
  FOREIGN KEY (progetto) REFERENCES Progetto(id) DEFERRABLE
);

CREATE TABLE AttivitaProgetto (
  id PosInteger NOT NULL,
  persona PosInteger NOT NULL,
  progetto PosInteger NOT NULL,
  wp PosInteger NOT NULL,
  giorno DATE NOT NULL,
  tipo LavoroProgetto NOT NULL,
  oreDurata NumeroOre NOT NULL,
  PRIMARY KEY (id),
  FOREIGN KEY (persona) REFERENCES Persona(id) DEFERRABLE,
  FOREIGN KEY (progetto, wp) REFERENCES WP(progetto, id) DEFERRABLE
);

CREATE TABLE AttivitaNonProgettuale (
  id PosInteger NOT NULL,
  persona PosInteger NOT NULL,
  tipo LavoroNonProgettuale NOT NULL,
  giorno DATE NOT NULL,
  oreDurata NumeroOre NOT NULL,
  PRIMARY KEY (id),
  FOREIGN KEY (persona) REFERENCES Persona(id) DEFERRABLE
);

CREATE TABLE Assenza (
  id PosInteger NOT NULL,
  persona PosInteger NOT NULL,
  tipo CausaAssenza NOT NULL,
  giorno DATE NOT NULL,
  PRIMARY KEY (id),
  UNIQUE (persona, giorno),
  FOREIGN KEY (persona) REFERENCES Persona(id) DEFERRABLE
);

COMMIT;
