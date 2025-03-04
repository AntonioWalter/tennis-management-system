-- Stampa dei punti ottenuti da un giocatore nell’ultimo anno

SELECT G.ID, G.Nome, G.Cognome, 
    SUM(CASE WHEN P.Torneo IS NOT NULL THEN 100 ELSE 0 END) AS Punti_Partecipazione,
    SUM(CASE WHEN P.Posizione = 1 THEN T.Punti ELSE 0 END) AS Punti_Vittoria_Torneo,
    (SELECT COUNT(*) * 50
        FROM Incontro I2
        WHERE I2.Giocatore = G.ID AND I2.Vincitore = 1 AND I2.Torneo IN (SELECT ID FROM Torneo WHERE Anno = 2025)
    ) AS Punti_Partite_Vinte,
    (   SUM(CASE WHEN P.Torneo IS NOT NULL THEN 100 ELSE 0 END) +
        SUM(CASE WHEN P.Posizione = 1 THEN T.Punti ELSE 0 END) +
        (
            SELECT COUNT(*) * 50
            FROM Incontro I2
            WHERE I2.Giocatore = G.ID AND I2.Vincitore = 1 AND I2.Torneo IN (SELECT ID FROM Torneo WHERE Anno = 2025)
        )
    ) AS Punteggio_Totale
FROM Giocatore G
LEFT JOIN Partecipazione P ON G.ID = P.Giocatore
LEFT JOIN Torneo T ON P.Torneo = T.ID AND T.Anno = 2025
WHERE G.ID = ?  
GROUP BY G.ID, G.Nome, G.Cognome
ORDER BY G.ID;