-- Stampa di tutti i tornei a cui ha partecipato un giocatore
SELECT T.Nome
FROM Partecipazione P
JOIN Torneo T ON P.Torneo = T.ID
WHERE P.Giocatore = ?  
ORDER BY T.Nome;