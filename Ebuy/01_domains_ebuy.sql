-- Creazione domini personalizzati 

CREATE DOMAIN Stringa AS VARCHAR;

CREATE DOMAIN URL AS TEXT
	CHECK(
        VALUE ~* '^https?://[A-Za-z0-9.-]+(\:[0-9]+)?(/.*)?$'
    );

CREATE DOMAIN Voto AS INTEGER
	CHECK (VALUE BETWEEN 0 AND 5);

CREATE DOMAIN IntGEZ AS INTEGER
	CHECK (VALUE >= 0);

CREATE DOMAIN IntGZ AS INTEGER
	CHECK (VALUE > 0);

CREATE DOMAIN IntGE2 AS INTEGER
	CHECK (VALUE >= 2);

CREATE DOMAIN RealGEZ AS REAL
	CHECK (VALUE >= 0);

CREATE DOMAIN RealGZ AS REAL
	CHECK (VALUE > 0);

-- Creazione tipo personalizzato 

CREATE TYPE Condizione AS ENUM (
    'Ottimo',
    'Buono',
    'Discreto',
    'Da sistemare'
);
