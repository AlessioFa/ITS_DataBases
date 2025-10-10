-- Accademia 6

-- 1.Quanti sono gli strutturati di ogni fascia ?

SELECT DISTINCT
	posizione, COUNT(posizione)
FROM 
	persona
GROUP BY
	(posizione);

-- 2.Quanti sono gli strutturati con stipendio >= 40.000 ?

SELECT 
	COUNT(posizione) AS Stipendio_medio
FROM 
	persona
WHERE 
	stipendio > 40000;

-- 3. Quanti sono i progetti già finiti che superano il budget di 50.000 ? 

SELECT
	COUNT(nome) AS Progetti_finiti
FROM 
	progetto
WHERE 
	fine < CURRENT_DATE
	AND budget > 50000;

-- 4. Qual'è la media, il massimo e il minimo delle ore dell'attività relativa
-- al progetto pegasus ?

SELECT
	ROUND(AVG(oredurata::numeric), 2) AS Media_ore,
	MAX(oredurata) AS Massimo_ore,
	MIN(oredurata) AS Min_ore
FROM
	attivitaprogetto AS ap, progetto AS p
WHERE
	ap.progetto = p.id
	AND p.nome = 'Pegasus';

-- 5. Quali sono le medie, i massimi, i minimi delle ore giornaliere
-- dedicate al progetto Pegasus da ogni singolo docente ?

SELECT
	ap.persona AS id_persona,
    p.nome, cognome,
    ROUND(AVG(oredurata::numeric), 2) AS Media_ore,
    MAX(oredurata) AS Massimo_ore,
    MIN(oredurata) AS Min_ore
FROM
	attivitaprogetto AS ap, progetto AS prog,
    persona AS p
WHERE
	ap.progetto = prog.id
    AND prog.nome = 'Pegasus'
    AND p.id = ap.persona
GROUP BY
	ap.persona, p.nome, p.cognome;


-- 6. Qual è il numero totale di ore dedicate alla didattica da ogni docente?

SELECT DISTINCT
	p.id AS id_persona, p.nome,
	p.cognome,oredurata AS ore_didattica
FROM
	attivitanonprogettuale AS anp,
	persona AS p
WHERE
	anp.persona = p.id
	AND anp.tipo = 'Didattica';

-- 7. Qual è la media, il massimo e il minimo degli stipendi dei ricercatori?

SELECT
	ROUND(AVG(stipendio::numeric), 2) AS media_stipendio,
	MAX(stipendio) AS massimo,
	min(stipendio) AS minimo
FROM
	persona AS p
WHERE
	p.posizione = 'Ricercatore';

-- 8. Quali sono le medie, i massimi e i minimi degli stipendi dei ricercatori, dei professori
-- associati e dei professori ordinari?

SELECT
	p.posizione,
	ROUND(AVG(stipendio::numeric),2) AS media_stipendio,
	MAX(stipendio) AS massimo,
	MIN(stipendio) AS minimo
FROM
	persona AS p
WHERE
	p.posizione IN ('Ricercatore', 'Professore Associato', 'Professore Ordinario')
GROUP BY
	p.posizione;

-- 9. Quante ore ‘Ginevra Riva’ ha dedicato ad ogni progetto nel quale ha lavorato?
-- id_progetto, nome_progetto, totale_ore

SELECT
    prog.id AS id_progetto,
    prog.nome AS progetto,
    ap.oredurata AS totale_ore
FROM
    progetto AS prog,
    persona AS p,
    attivitaprogetto AS ap
WHERE
    prog.id = ap.progetto
    AND p.id = ap.persona
    AND p.nome = 'Ginevra'
    AND p.cognome = 'Riva';

-- 10. Qual è il nome dei progetti su cui lavorano più di due strutturati?

SELECT
	prog.id AS id_progetto ,
	prog.nome AS nome_progetto
FROM
	progetto AS prog,
	attivitaprogetto AS AP
WHERE
	prog.id = ap.progetto
GROUP BY
	prog.id, prog.nome
HAVING
	COUNT(DISTINCT ap.persona) > 2;

-- 11. Quali sono i professori associati che hanno lavorato su più di un progetto?

SELECT
	p.id, p.nome, p.cognome
FROM
	persona AS p,
	attivitaprogetto AS ap
WHERE
	p.id = ap.persona
	AND p.posizione = 'Professore Associato'
GROUP BY
	p.id, p.nome, p.cognome
HAVING 
	COUNT(DISTINCT ap.progetto) > 1;
