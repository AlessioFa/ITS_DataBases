accademia 6

-- 1.Quanti sono gli strutturati di ogni fascia ?

SELECT posizione, COUNT(posizione)
	FROM persona
	group by(posizione);

-- 2.Quanti sono gli strutturati con stipendio >= 40.000 ?

SELECT COUNT(posizione) AS Stipendio_medio
	FROM persona
	WHERE stipendio > 40000;

-- 3. Quanti sono i progetti già finiti che superano il budget di 50.000 ? 

SELECT COUNT(nome) AS Progetti_finiti
	FROM progetto
	WHERE fine < CURRENT_DATE
	AND budget > 50000;

-- 4. Qual'è la media, il massimo e il minimo delle ore dell'attività relativa
-- al progetto pegasus ?

SELECT
	ROUND(AVG(oredurata::numeric), 2) AS Media_ore,
	MAX(oredurata) AS Massimo_ore,
	MIN(oredurata) AS Min_ore
FROM attivitaprogetto AS ap, progetto AS p
WHERE ap.progetto = p.id
	AND p.nome = 'Pegasus';

-- 5. Quali sono le medie, i massimi, i minimi delle ore giornaliere
-- dedicate al progetto Pegasus da ogni singolo docente ?

SELECT ap.persona AS id_persona,
       nome, cognome,
       ROUND(AVG(oredurata::numeric), 2) AS Media_ore,
       MAX(oredurata) AS Massimo_ore,
       MIN(oredurata) AS Min_ore
FROM attivitaprogetto AS ap, progetto AS prog,
    persona AS p
WHERE ap.progetto = prog.id
    AND prog.nome = 'Pegasus'
    AND p.id = ap.persona
GROUP BY ap.persona, nome, cognome;
