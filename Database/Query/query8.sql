-- Stampa del vincitore di un torneo dato il nome del torneo e l’anno in cui è avvenuto

SELECT G.Nome AS Nome_Vincitore, G.Cognome AS Cognome_Vincitore
FROM Partecipazione P
JOIN Giocatore G ON P.Giocatore = G.ID
JOIN Torneo T ON P.Torneo = T.ID
WHERE T.Nome = ? AND T.Anno = ? AND P.Posizione = 1;