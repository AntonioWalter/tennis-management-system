-- Stampa del ranking(posizione e punti) delle giocatrici  del ATP e aggiornamento della posizione in ranking

WITH Classifica AS (
    SELECT R2.Giocatore, R2.Ente_organizzatore, EO.Anno,
        DENSE_RANK() OVER (ORDER BY (
            SELECT
                SUM(CASE WHEN P.Torneo IS NOT NULL THEN 100 ELSE 0 END) +
                SUM(CASE WHEN P.Posizione = 1 THEN T.Punti ELSE 0 END) +
                (
                    SELECT COUNT(*) * 50
                    FROM Incontro I2
                    WHERE I2.Giocatore = P.Giocatore AND I2.Vincitore = 1 AND I2.Torneo IN (SELECT ID FROM Torneo WHERE Ente_organizzatore = R2.Ente_organizzatore AND Anno = EO.Anno)
                )
            FROM Partecipazione P
            JOIN Torneo T ON P.Torneo = T.ID
            WHERE P.Giocatore = R2.Giocatore AND T.Ente_organizzatore = R2.Ente_organizzatore AND T.Anno = EO.Anno
        ) DESC) AS Posizione,
        (
            SELECT
                SUM(CASE WHEN P.Torneo IS NOT NULL THEN 100 ELSE 0 END) +
                SUM(CASE WHEN P.Posizione = 1 THEN T.Punti ELSE 0 END) +
                (
                    SELECT COUNT(*) * 50
                    FROM Incontro I2
                    WHERE I2.Giocatore = P.Giocatore AND I2.Vincitore = 1 AND I2.Torneo IN (SELECT ID FROM Torneo WHERE Ente_organizzatore = R2.Ente_organizzatore AND Anno = EO.Anno)
                )
            FROM Partecipazione P
            JOIN Torneo T ON P.Torneo = T.ID
            WHERE P.Giocatore = R2.Giocatore AND T.Ente_organizzatore = R2.Ente_organizzatore AND T.Anno = EO.Anno
        ) AS Punteggio
    FROM Ranking R2
    JOIN Ente_organizzatore EO ON R2.Ente_organizzatore = EO.ID
    WHERE EO.Nome = 'ATP' AND EO.Anno = 2025
)
UPDATE Ranking R
JOIN Classifica C ON R.Giocatore = C.Giocatore
                  AND R.Ente_organizzatore = C.Ente_organizzatore
SET R.Posizione = C.Posizione;

SELECT R.Giocatore, EO.Anno, R.Posizione,
    (
        SELECT
            SUM(CASE WHEN P.Torneo IS NOT NULL THEN 100 ELSE 0 END) +
            SUM(CASE WHEN P.Posizione = 1 THEN T.Punti ELSE 0 END) +
            (
                SELECT COUNT(*) * 50
                FROM Incontro I2
                WHERE I2.Giocatore = P.Giocatore AND I2.Vincitore = 1 AND I2.Torneo IN (SELECT ID FROM Torneo WHERE Ente_organizzatore = R.Ente_organizzatore AND Anno = EO.Anno)
            )
        FROM Partecipazione P
        JOIN Torneo T ON P.Torneo = T.ID
        WHERE P.Giocatore = R.Giocatore AND T.Ente_organizzatore = R.Ente_organizzatore AND T.Anno = EO.Anno
    ) AS Punteggio
FROM Ranking R
JOIN Ente_organizzatore EO ON R.Ente_organizzatore = EO.ID
WHERE EO.Nome = 'ATP' AND EO.Anno = 2025
ORDER BY R.Posizione ASC;



-- Versione JDBC dato che non possiamo realizzare una query che nello stesso momento compia un operazione di UPDATE e SELECT in java 
WITH Classifica AS (
    SELECT R2.Giocatore, R2.Ente_organizzatore, EO.Anno,
        DENSE_RANK() OVER (ORDER BY (
            SELECT
                SUM(CASE WHEN P.Torneo IS NOT NULL THEN 100 ELSE 0 END) +
                SUM(CASE WHEN P.Posizione = 1 THEN T.Punti ELSE 0 END) +
                (
                    SELECT COUNT() 50
                    FROM Incontro I2
                    WHERE I2.Giocatore = P.Giocatore AND I2.Vincitore = 1 AND I2.Torneo IN (SELECT ID FROM Torneo WHERE Ente_organizzatore = R2.Ente_organizzatore AND Anno = EO.Anno)
                )
            FROM Partecipazione P
            JOIN Torneo T ON P.Torneo = T.ID
            WHERE P.Giocatore = R2.Giocatore AND T.Ente_organizzatore = R2.Ente_organizzatore AND T.Anno = EO.Anno
        ) DESC) AS Posizione,
        (
            SELECT
                SUM(CASE WHEN P.Torneo IS NOT NULL THEN 100 ELSE 0 END) +
                SUM(CASE WHEN P.Posizione = 1 THEN T.Punti ELSE 0 END) +
                (
                    SELECT COUNT() 50
                    FROM Incontro I2
                    WHERE I2.Giocatore = P.Giocatore AND I2.Vincitore = 1 AND I2.Torneo IN (SELECT ID FROM Torneo WHERE Ente_organizzatore = R2.Ente_organizzatore AND Anno = EO.Anno)
                )
            FROM Partecipazione P
            JOIN Torneo T ON P.Torneo = T.ID
            WHERE P.Giocatore = R2.Giocatore AND T.Ente_organizzatore = R2.Ente_organizzatore AND T.Anno = EO.Anno
        ) AS Punteggio
    FROM Ranking R2
    JOIN Ente_organizzatore EO ON R2.Ente_organizzatore = EO.ID
    WHERE EO.Nome = 'ATP' AND EO.Anno = 2025
)
UPDATE Ranking R
JOIN Classifica C ON R.Giocatore = C.Giocatore
                  AND R.Ente_organizzatore = C.Ente_organizzatore
SET R.Posizione = C.Posizione;

-- ---------------------------------------------------------------

SELECT R.Giocatore, EO.Anno, R.Posizione,
    (
        SELECT
            SUM(CASE WHEN P.Torneo IS NOT NULL THEN 100 ELSE 0 END) +
            SUM(CASE WHEN P.Posizione = 1 THEN T.Punti ELSE 0 END) +
            (
                SELECT COUNT() 50
                FROM Incontro I2
                WHERE I2.Giocatore = P.Giocatore AND I2.Vincitore = 1 AND I2.Torneo IN (SELECT ID FROM Torneo WHERE Ente_organizzatore = R.Ente_organizzatore AND Anno = EO.Anno)
            )
        FROM Partecipazione P
        JOIN Torneo T ON P.Torneo = T.ID
        WHERE P.Giocatore = R.Giocatore AND T.Ente_organizzatore = R.Ente_organizzatore AND T.Anno = EO.Anno
    ) AS Punteggio
FROM Ranking R
JOIN Ente_organizzatore EO ON R.Ente_organizzatore = EO.ID
WHERE EO.Nome = 'ATP' AND EO.Anno = 2025
ORDER BY R.Posizione ASC;