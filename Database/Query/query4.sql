-- Stampa di tutti i giocatori allenati da un determinato allenatore

SELECT g.ID, g.Nome, g.Cognome, g.Età, g.Punti_ottenuti, g.Sesso
FROM Preparazione p
JOIN Giocatore g ON p.Giocatore = g.ID
WHERE p.Allenatore = ?;