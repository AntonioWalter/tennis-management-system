-- Aggiornamento del primo classificato per tutti gli enti

-- Disattiva la modalità Safe Update
SET SQL_SAFE_UPDATES = 0;
UPDATE Ente_organizzatore EO
SET EO.Primo_classificato = (
    SELECT GiocatoreID
    FROM (
        SELECT
            P.Giocatore AS GiocatoreID,
            SUM(CASE WHEN P.Torneo IS NOT NULL THEN 100 ELSE 0 END) +
            SUM(CASE WHEN P.Posizione = 1 THEN T.Punti ELSE 0 END) +
            (
                SELECT COUNT(*) * 50  
                FROM Incontro I2
                WHERE I2.Giocatore = P.Giocatore AND I2.Vincitore = 1 
                      AND I2.Torneo IN (
                          SELECT ID FROM Torneo WHERE Ente_organizzatore = EO.ID AND Anno = EO.Anno
                      )
            ) AS Punteggio_Totale
        FROM Partecipazione P
        JOIN Torneo T ON P.Torneo = T.ID
        WHERE T.Ente_organizzatore = EO.ID AND T.Anno = EO.Anno
        GROUP BY P.Giocatore
        ORDER BY Punteggio_Totale DESC, GiocatoreID ASC 
        LIMIT 1
    ) AS PrimoClassificato
);

-- Riattiva la modalità Safe Update
SET SQL_SAFE_UPDATES = 1;