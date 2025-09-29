CREATE DOMAIN PosInteger AS INT
CHECK (VALUE >= 0);

CREATE DOMAIN StringaM AS VARCHAR(100);

CREATE DOMAIN CodIATA AS CHAR (3);


BEGIN TRANSACTION;

SET CONSTRAINTS ALL DEFERRED;


CREATE TABLE Compagnia (
    nome StringaM PRIMARY KEY,
    annoFondaz PosInteger
);


CREATE TABLE Aeroporto (
    codice CodIATA PRIMARY KEY,
    nome StringaM NOT NULL
);


CREATE TABLE LuogoAeroporto (
    aeroporto CodIATA PRIMARY KEY,
    citta StringaM NOT NULL,
    nazione StringaM NOT NULL,
    FOREIGN KEY (aeroporto) REFERENCES Aeroporto(codice) DEFERRABLE
);


ALTER TABLE Aeroporto
    ADD FOREIGN KEY (codice) REFERENCES LuogoAeroporto(aeroporto) DEFERRABLE;


CREATE TABLE ArrPart (
    codice PosInteger NOT NULL,
    comp StringaM NOT NULL,
    arrivo CodIATA NOT NULL,
    partenza CodIATA NOT NULL,
    PRIMARY KEY (codice, comp),
    FOREIGN KEY (arrivo) REFERENCES Aeroporto(codice) DEFERRABLE,
    FOREIGN KEY (partenza) REFERENCES Aeroporto(codice) DEFERRABLE
);


CREATE TABLE Volo (
    codice PosInteger NOT NULL,
    comp StringaM NOT NULL,
    durataMinuti PosInteger NOT NULL,
    PRIMARY KEY (codice, comp),
    FOREIGN KEY (comp) REFERENCES Compagnia(nome) DEFERRABLE,
    FOREIGN KEY (codice, comp) REFERENCES ArrPart(codice, comp) DEFERRABLE
);


ALTER TABLE ArrPart
    ADD FOREIGN KEY (codice, comp) REFERENCES Volo(codice,comp)  DEFERRABLE;

COMMIT;
