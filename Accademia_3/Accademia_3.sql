CREATE TYPE Strutturato as enum('Ricercatore', 'Professore Associato', 'Professore Ordinario');

CREATE TYPE LavoroProgetto as enum('Ricerca e Sviluppo', 'Dimostrazione', 'Management', 'Altro');

CREATE TYPE LavoroNonProgettuale as enum('Didattica', 'Ricerca', 'Missione', 'Incontro Dipartimentale', 'Incontro
Accademico', 'Altro');

CREATE TYPE CausaAssenza as enum('Chiusura Universitaria', 'Maternita', 'Malattia');


CREATE DOMAIN PosInteger as INT
	CHECK(VALUE >= 0);

CREATE DOMAIN StringaM as VARCHAR(100);

CREATE DOMAIN NumeroOre as INT
	CHECK(VALUE BETWEEN 0 AND 8);

CREATE DOMAIN Denaro as REAL
	CHECK(VALUE >= 0);


CREATE TABLE Persona(
	id PosInteger PRIMARY KEY,
	nome StringaM NOT NULL,
	cognome StringaM NOT NULL,
	posizione strutturato NOT NULL,
	stipendio Denaro NOT NULL
);

CREATE TABLE Progetto(
	id PosInteger PRIMARY KEY,
	nome StringaM NOT NULL UNIQUE,
	inizio DATE NOT NULL,
	fine DATE NOT NULL,
	CHECK(inizio < fine),
	budget Denaro NOT NULL
);

CREATE TABLE WP(
	progetto PosInteger,
	id PosInteger,
	PRIMARY KEY(progetto, id),
	nome StringaM NOT NULL,
	UNIQUE(progetto, nome),
	inizio DATE NOT NULL,
	fine DATE NOT NULL,
	CHECK(inizio < fine),
	FOREIGN KEY (progetto) REFERENCES Progetto(id)
);

CREATE TABLE AttivistaProgetto(
	id PosInteger PRIMARY KEY,
	persona PosInteger NOT NULL,
	progetto PosInteger NOT NULL,
	wp PosInteger NOT NULL,
	giorno DATE NOT NULL,
	tipo LavoroProgetto NOT NULL,
	oreDurata NumeroOre NOT NULL,
	FOREIGN KEY (persona) REFERENCES Persona(id),
	FOREIGN KEY (progetto,wp) REFERENCES WP(progetto, id)
);

CREATE TABLE AttivitaNonProgettuale(
  id PosInteger PRIMARY KEY,
  persona PosInteger NOT NULL,
  tipo CausaAssenza NOT NULL,
  giorno DATE NOT NULL,
  UNIQUE(persona, giorno),
  FOREIGN KEY(persona) REFERENCES Persona(id)
);


INSERT INTO Persona(id, nome, cognome, posizione, stipendio)
VALUES (1, 'Luisa', 'Barelli', 'Ricercatore', 1995.89);

INSERT INTO Persona(id, nome, cognome, posizione, stipendio)
VALUES (2, 'Federico', 'Varri', 'Professore Associato', 1480.77);




INSERT INTO Progetto(id, nome, inizio, fine, budget)
VALUES (1, 'CyberSec Lab', '2025-01-10', '2025-12-31', 150000);

INSERT INTO Progetto(id, nome, inizio, fine, budget)
VALUES (2, 'AI Research', '2025-02-01', '2025-11-15', 95000);



INSERT INTO WP(progetto, id, nome, inizio, fine)
VALUES 
(1, 1, 'Analisi vulnerabilità', '2025-01-15', '2025-03-31'),
(1, 2, 'Penetration test', '2025-04-01', '2025-06-30'),
(2, 1, 'Modellazione NLP', '2025-02-10', '2025-05-10');



INSERT INTO AttivistaProgetto(id, persona, progetto, wp, giorno, tipo, oreDurata)
VALUES (1, 1, 1, 1, '2025-01-20', 'Ricerca e Sviluppo', 6);

INSERT INTO AttivistaProgetto(id, persona, progetto, wp, giorno, tipo, oreDurata)
VALUES (2, 2, 1, 2, '2025-04-15', 'Management', 4);

INSERT INTO AttivistaProgetto(id, persona, progetto, wp, giorno, tipo, oreDurata)
VALUES (3, 2, 2, 1, '2025-02-15', 'Dimostrazione', 5);



INSERT INTO AttivitaNonProgettuale(id, persona, tipo, giorno)
VALUES
  (1, 1, 'Malattia', '2025-07-03'),
  (2, 2, 'Maternita', '2025-07-04');

