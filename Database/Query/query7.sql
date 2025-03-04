-- Stampa annuale di nome, cognome, punti ottenuti e guadagno di ciascun giocatore

SELECT G.ID, G.Nome, G.Cognome, G.Punti_ottenuti,
    (SELECT COALESCE(SUM(R.Compenso), 0)
        FROM Rappresentazione R
        WHERE R.Giocatore = G.ID
    ) AS Guadagno_Sponsor_Annuale,
    COALESCE(SUM(T.Premio_in_denaro), 0) AS Guadagno_Tornei,                        -- Utilizzo Coalesce per evitare i valori NULL che potrebbero comportare errori nei calcoli successivi
    (
        (
            SELECT COALESCE(SUM(R.Compenso), 0)
            FROM Rappresentazione R
            WHERE R.Giocatore = G.ID
        ) + COALESCE(SUM(T.Premio_in_denaro), 0)
    ) AS Guadagno_Totale_Annuale
FROM Giocatore G
LEFT JOIN Partecipazione P ON G.ID = P.Giocatore
LEFT JOIN Torneo T ON P.Torneo = T.ID AND P.Posizione = 1
GROUP BY G.ID, G.Nome, G.Cognome, G.Punti_ottenuti
ORDER BY G.ID;