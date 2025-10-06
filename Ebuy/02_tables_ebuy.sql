-- Creazione tabelle

CREATE TABLE utente (
	username Stringa PRIMARY KEY,
	password Stringa NOT NULL,
	email Stringa UNIQUE NOT NULL
);

CREATE TABLE venditoreprof (
	utente Stringa PRIMARY KEY REFERENCES utente(username),
	partitaiva Stringa UNIQUE NOT NULL,
	nome_negozio Stringa NOT NULL
);

CREATE TABLE categoria (
	nome Stringa PRIMARY KEY,
	categoria_padre Stringa,
	FOREIGN KEY (categoria_padre) REFERENCES categoria(nome)
);

CREATE TABLE postoggetto (
	id IntGZ PRIMARY KEY,
	titolo Stringa NOT NULL,
	descrizione Stringa,
	foto URL,
	categoria Stringa NOT NULL,
	FOREIGN KEY (categoria) REFERENCES categoria(nome)
);

CREATE TABLE postoggettonuovo (
	postoggetto IntGZ PRIMARY KEY REFERENCES postoggetto(id),
	pubblica_nuovo Stringa NOT NULL,
	prezzo RealGZ NOT NULL,
	anni_garanzia IntGE2 NOT NULL,
	FOREIGN KEY (pubblica_nuovo) REFERENCES venditoreprof(utente)
);

CREATE TABLE postoggettousato (
	postoggetto IntGZ PRIMARY KEY REFERENCES postoggetto(id),
	pubblica_usato Stringa NOT NULL,
	prezzo RealGZ NOT NULL,
	condizione Condizione NOT NULL,
	FOREIGN KEY (pubblica_usato) REFERENCES utente(username)
);

CREATE TABLE postoggettoasta (
	postoggetto IntGZ PRIMARY KEY REFERENCES postoggetto(id),
	pubblica_asta Stringa NOT NULL,
	prezzo_base RealGEZ NOT NULL,
	data_inizio DATE NOT NULL,
	data_fine DATE NOT NULL,
	FOREIGN KEY (pubblica_asta) REFERENCES utente(username)
);

CREATE TABLE postoggettocompralosubito (
	postoggetto IntGZ PRIMARY KEY REFERENCES postoggetto(id),
	prezzo RealGZ NOT NULL,
	data_pubblicazione DATE NOT NULL
);

CREATE TABLE feedback (
	id IntGZ PRIMARY KEY,
	mittente Stringa NOT NULL,
	destinatario Stringa NOT NULL,
	voto Voto NOT NULL,
	commento Stringa,
	FOREIGN KEY (mittente) REFERENCES utente(username),
	FOREIGN KEY (destinatario) REFERENCES utente(username)
);

CREATE TABLE met_post (
    postoggetto IntGZ NOT NULL,
    metodo Stringa NOT NULL,
    FOREIGN KEY (postoggetto) REFERENCES postoggetto(id),
    FOREIGN KEY (metodo) REFERENCES metodopagamento(nome),
    PRIMARY KEY (postoggetto, metodo)
);
