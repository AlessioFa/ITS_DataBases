-- 1. Quali sono i voli (codice e nome della compagnia) la cui durata supera le 3 ore?

SELECT codice, comp
FROM volo
WHERE durataminuti > 180;

-- 2 Quali sono le compagnie che hanno voli che superano le 3 ore?

SELECT DISTINCT comp
FROM volo
WHERE durataminuti > 180;

-- 3. Quali sono i voli (codice e nome della compagnia) che partono dall’aeroporto con codice ‘CIA’ ?

SELECT codice, comp
FROM arrpart
WHERE partenza = 'CIA';

-- 4 Quali sono le compagnie che hanno voli che arrivano all’aeroporto con codice 'FCO' ?

SELECT DISTINCT comp
FROM arrpart
WHERE arrivo = 'FCO';

-- 5. Quali sono i voli (codice e nome della compagnia) che partono dall’aeroporto ‘FCO’
--    e arrivano all’aeroporto ‘JFK’ ?

SELECT codice, comp
FROM arrpart
WHERE partenza = 'FCO' 
AND arrivo = 'JFK';

-- 6. Quali sono le compagnie che hanno voli che partono dall’aeroporto ‘FCO’ e atter-
-- 	  rano all’aeroporto ‘JFK’ ?

SELECT 	DISTINCT comp
FROM arrpart
WHERE partenza = 'FCO' 
AND arrivo = 'JFK';

-- 7. Quali sono i nomi delle compagnie che hanno voli diretti dalla città di ‘Roma’ alla
--    città di ‘New York’ ? 

SELECT DISTINCT a.comp
FROM arrpart as a
JOIN luogoaeroporto AS l1 ON a.partenza = l1.aeroporto
JOIN luogoaeroporto AS l2 ON a.arrivo = l2.aeroporto
WHERE l1.citta = 'Roma'
AND l2.citta = 'New York';

-- 8. Quali sono gli aeroporti (con codice IATA, nome e luogo) nei quali partono voli dalla compagnia di nome 'MagicFly'?

SELECT DISTINCT a.codice, a.nome, l.citta
FROM arrpart AS ap
JOIN aeroporto AS a ON ap.partenza = a.codice
JOIN luogoaeroporto AS l ON a.codice = l.aeroporto
WHERE ap.comp = 'MagicFly';

-- 9. Quali sono i voli che partono da un qualunque aeroporto della città di 'Roma' e atterrano ad un qualunque aeroporto 
--    della città di 'New York' ?
--    Restituire: codice del volo, nome della compagnia e aeroporti di partenza e arrivo.

SELECT DISTINCT ap.codice, ap.nome, ap.partenza, ap.arrivo
FROM arrpart AS ap
JOIN luogoaeroporto AS l1 ON ap.partenza = l1.aeroporto
JOIN luogoaeroporto AS l2 ON ap.arrivo = l2.aeroporto
WHERE l1.citta = 'Roma'
AND l2.citta = 'New York';

-- 10  Quali sono i possibili piani di volo con esattamente un cambio (utilizzando solo voli della stessa compagnia) da un qualunque 
--     aeroporto della città di ‘Roma’ ad un qualunque aeroporto della città di ‘New York’?
--     Restituire: nome della compagnia, codici dei voli, e aeroporti di partenza, scalo e arrivo.


-- 11. Quali sono le compagnie che hanno voli che partono dall 'aeroporto 'FCO', atterrano all' aeroporto 'JFK',
--     e di cui si conosce l'anno di fondazione ? 

SELECT DISTINCT c.nome
FROM compagnia AS c
JOIN arrpart AS a1 on  c.nome = a1.comp
WHERE a1.partenza = 'FCO' AND
	  a1.arrivo = 'JFK'
	  AND c.annofondaz IS NOT NULL; 

