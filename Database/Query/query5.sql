-- Stampa di tutti gli sponsor che vengono rappresentati dai giocatori allenati da un determinato allenatore

SELECT DISTINCT s.Nome, s.Tipologia, s.Motto, s.Colore
FROM Preparazione p
JOIN Giocatore g ON p.Giocatore = g.ID
JOIN Rappresentazione r ON g.ID = r.Giocatore
JOIN Sponsor s ON r.Sponsor = s.Nome
WHERE p.Allenatore = ?;