
ALTER TABLE attivitanonprogettuale
ADD COLUMN oreDurata NumeroOre NOT NULL;

ALTER TYPE causaassenza ADD VALUE 'Incontro Dipartimentale';


-- 1. Quali sono il nome, la data di inizio e la data di fine dei WP 
-- del progetto 'Pegasus' ?

SELECT wp.id, wp.nome, wp.inizio, wp.fine
FROM wp, progetto
WHERE wp.progetto = progetto.id
	AND progetto.nome = 'Pegasus';


-- 2. Quali sono il nome, il cognome e la posizione degli strutturati che hanno almeno
-- una attivita nel progetto 'Pegasus', ordinati per nome decrescente ?

SELECT DISTINCT persona.nome, persona.cognome, persona.posizione
FROM persona, attivitaprogetto AS ap, progetto
WHERE persona.id = ap.persona
  AND ap.progetto = progetto.id
  AND progetto.nome = 'Pegasus'
  AND persona.posizione IN (
    'Professore Ordinario',
    'Professore Associato',
    'Ricercatore'
  )
ORDER BY persona.nome DESC;


-- 3.Quali sono il nome, il cognome e la posizione degli strutturati che hanno più di
-- una attività nel progetto ‘Pegasus’ ?

SELECT DISTINCT p.nome, p.cognome, p.posizione
FROM persona AS p, attivitaprogetto AS ap1, attivitaprogetto AS ap2, progetto AS pr
WHERE p.id = ap1.persona
  AND p.id = ap2.persona
  AND ap1.id <> ap2.id
  AND ap1.progetto = pr.id
  AND ap2.progetto = pr.id
  AND pr.nome = 'Pegasus'
  AND p.posizione IN ('Professore Ordinario', 'Professore Associato', 'Ricercatore')
ORDER BY p.nome DESC;


-- 4.Quali sono il nome e il cognome dei Professori Ordinari che hanno fatto almeno un assenza per
-- malattia ?

SELECT DISTINCT p.nome, p.cognome
FROM persona AS p, assenza AS ass
WHERE p.id = ass.persona
  AND ass.tipo = 'Malattia'
  AND p.posizione IN ('Professore Ordinario');

-- 5.Quali sono il nome e il cognome dei Professori Ordinari che hanno fatto più di un assenza per malattia ?

SELECT p.id, p.nome, p.cognome
FROM persona AS p, assenza AS ass
WHERE p.id = ass.persona
  AND ass.tipo = 'Malattia'
  AND p.posizione = 'Professore Ordinario'
GROUP BY p.id, p.nome, p.cognome
HAVING COUNT(*) > 1;

-- 6. Quali sono il nome e il cognome dei Ricercatori che hanno almeno un impegno per didattica ? 

SELECT DISTINCT p.id, p.nome, p.cognome
FROM persona AS p, attivitanonprogettuale AS anp
WHERE p.id = anp.persona
  AND p.posizione = 'Ricercatore';


-- 7. Quali sono il nome e il cognome dei Ricercatori che hanno piu di un impegno per didattica ?

SELECT p.id, p.nome, p.cognome
FROM persona AS p, attivitanonprogettuale AS anp
WHERE p.id = anp.persona
  AND anp.tipo = 'Didattica'
  AND p.posizione = 'Ricercatore'
GROUP BY p.id, p.nome, p.cognome
HAVING COUNT(*) > 1;


-- 8. Quali sono il nome e il cognome degli strutturati che nello stesso giorno hanno sia attivita
-- progettuali che attivita non progettuali ?

SELECT p.id, p.nome, p.cognome
FROM persona AS p,  attivitaprogetto AS ap, attivitanonprogettuale as anp
WHERE p.id = ap.persona
  AND p.id = anp.persona
  AND p.posizione IN ('Professore Ordinario', 'Professore Associato', 'Ricercatore')
  AND ap.giorno = anp.giorno;


-- 9. Quali sono il nome e il cognome degli strutturati che nello stesso giorno hanno sia attività progettuali 
-- che attività non progettuali? Si richiede di restituire anche il giorno, il nome del progetto, il tipo dell’attività
-- non progettuale e la durata in ore di entrambe le attività.

SELECT p.id, p.nome, p.cognome, ap.giorno, ap.progetto, ap.oredurata AS h_prj,
       anp.tipo AS att_noprj, anp.oredurata AS h_noprj
FROM persona AS p, attivitaprogetto AS ap, attivitanonprogettuale AS anp
WHERE p.id = ap.persona
  AND p.id = anp.persona
  AND ap.giorno = anp.giorno
  AND p.posizione IN ('Professore Ordinario', 'Professore Associato', 'Ricercatore');


-- 10. Quali sono il nome e il cognome degli strutturati che nello stesso giorno sono assenti e hanno
-- attività progettuali?

SELECT p.id, p.nome, p.cognome
FROM persona as p, attivitaprogetto AS ap, assenza AS ass
WHERE p.id = ap.persona
AND ap.giorno = ass.giorno;


-- 11.Quali sono il nome e il cognome degli strutturati che nello stesso giorno sono assenti e hanno attività progettuali?
-- Si richiede anche di proiettare il giorno, il nome del progetto, la causa di assenza e la durata in ore dell’attività progettuale.

SELECT p.id AS id,p.nome AS nome,
       p.cognome AS cognome,
       ap.giorno AS giorno,
       anp.tipo AS causa_ass,
       ap.progetto AS progetto,
       ap.oredurata AS ore_att_prj
FROM persona AS p, attivitaprogetto AS ap, attivitanonprogettuale AS anp
WHERE p.id=ap.persona
  AND p.id=anp.persona
  AND ap.giorno=anp.giorno
  AND p.posizione IN ('Professore Ordinario','Professore Associato','Ricercatore');


-- 12. Quali sono i WP che hanno lo stesso nome ma apppartengono a progetti diversi ? 

SELECT nome
FROM wp
GROUP BY nome
HAVING COUNT(DISTINCT progetto) > 1;
