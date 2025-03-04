-- Stampa di tutti gli sponsor rappresentati da un determinato giocatore;

SELECT s.Nome, s.Tipologia, s.Motto, s.Colore
FROM Rappresentazione r
JOIN Sponsor s ON r.Sponsor = s.Nome
WHERE r.Giocatore = ?;