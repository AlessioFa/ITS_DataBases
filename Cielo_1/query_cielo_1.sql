-- 1. Quali sono i voli (codice e nome della compagnia) la cui durata supera le 3 ore?

SELECT codice, nome
FROM volo
WHERE durataminuti > 180;


-- 2. Quali sono le compagnie che hanno voli che superano le 3 ore?

SELECT DISTINCT nome
FROM volo
WHERE durataminuti > 180;

-- 3. Quali sono i voli (codice e nome della compagnia) che partono dall’aeroporto con
-- codice ‘CIA’ ?

SELECT codice, comp
FROM arrpart
WHERE partenza = 'CIA';


-- 4. Quali sono le compagnie che hanno voli che arrivano all’aeroporto con codice
-- ‘FCO’ ?

SELECT comp
FROM arrpart
WHERE arrivo = 'FCO'

-- 5. Quali sono i voli (codice e nome della compagnia) che partono dall’aeroporto ‘FCO’
-- e arrivano all’aeroporto ‘JFK’ ?

SELECT codice, comp
FROM arrpart
WHERE partenza = 'FCO'
	AND arrivo = 'JFK';

-- 6. Quali sono le compagnie che hanno voli che partono dall’aeroporto ‘FCO’ e atter-
-- rano all’aeroporto ‘JFK’ ?

SELECT comp
FROM arrpart
WHERE partenza = 'FCO'
	AND arrivo = 'JFK';

-- 7. Quali sono i nomi delle compagnie che hanno voli diretti dalla città di ‘Roma’ alla
città di ‘New York’ ?

SELECT DISTINCT ap.comp
FROM arrpart AS ap, luogoaeroporto AS l1, luogoaeroporto AS l2
WHERE ap.partenza = l1.aeroporto
	AND ap.arrivo = l2.aeroporto
	AND l1.citta = 'Roma'
	AND l2.citta = 'New York';


-- 8. Quali sono gli aeroporti (con codice IATA, nome e luogo) nei quali partono voli
-- della compagnia di nome ‘MagicFly’ ?

SELECT DISTINCT a.codice, a.nome, l.citta
FROM aeroporto AS a, luogoaeroporto AS l, arrpart AS ap
WHERE ap.comp = 'MagicFly'
	AND ap.partenza = a.codice
	AND l.aeroporto = a.codice;


-- 9. Quali sono i voli che partono da un qualunque aeroporto dalla citta di 'Roma' e atterrano
-- ad un qualunque aeroporto della città di 'New York' ? 
-- Restituire: codice del volo, nome della compagnia e aeroporti di partenza e arrivo.

SELECT ap.codice AS codice_volo, ap.comp, ap.partenza, ap.arrivo
FROM arrpart AS ap, luogoaeroporto AS l1, luogoaeroporto AS l2
WHERE ap.partenza = l1.aeroporto
	AND ap.arrivo = l2.aeroporto
	AND l1.citta = 'Roma'
	AND l2.citta = 'New York';                                                               


-- 10. Quali sono i possibili piani di volo esattamente con un cambio (utilizzando solo i voli della stessa compagnia)
-- da un qualunque aeroporto della città di 'Roma' ad un qualunque aeroporto della citta di 'New York'?
-- Restituire: nome della compagnia, codici dei voli, e aeroporti di partenza, scalo e arrivo.

SELECT DISTINCT 
    v1.comp AS compagnia,
    v1.codice AS codice_volo_1,
    v1.partenza AS partenza,
    v1.arrivo AS scalo,
    v2.codice AS codice_volo_2,
    v2.arrivo AS arrivo

FROM arrpart AS v1, arrpart AS v2, luogoaeroporto AS l1, luogoaeroporto AS l2
WHERE 
	v1.arrivo = v2.partenza
    AND v1.comp = v2.comp
    AND v1.codice <> v2.codice
    AND v1.partenza = l1.aeroporto
    AND l1.citta = 'Roma'
    AND v2.arrivo = l2.aeroporto
    AND l2.citta = 'New York';


-- 11. Quali sono le compagnie che hanno voli che partono dall' aeroporto 'FCO' atterrano all' aeroporto
-- 'JFK', e di cui si conosce l' anno di fondazione ? 

SELECT DISTINCT ap.comp
FROM arrpart AS ap , compagnia as co
WHERE ap.partenza = 'FCO'
	AND ap.arrivo = 'JFK'
	AND ap.comp = co.nome
	AND co.annofondaz IS NOT NULL;
