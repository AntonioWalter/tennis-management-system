-- Inserimento dei punti ottenuti da ciascun giocatore nella sua carriera nell’attributo punti_ottenuti di Giocatore

-- In questa query dobbiamno disabilitare e poi riattivare il safe update mode per evitare che MySQLWorkbench ci impedisca di eseguire l'update per tutti gli elementi

SET SQL_SAFE_UPDATES = 0;  -- Disabilita il safe update mode

UPDATE Giocatore G
SET Punti_ottenuti = (
    SELECT COALESCE(
        SUM(CASE WHEN P.Torneo IS NOT NULL THEN 100 ELSE 0 END) +
        SUM(CASE WHEN P.Posizione = 1 THEN T.Punti ELSE 0 END) +
        (
            SELECT COUNT(*) * 50
            FROM Incontro I2
            WHERE I2.Giocatore = G.ID AND I2.Vincitore = 1
        ), 0)
    FROM Partecipazione P
    LEFT JOIN Torneo T ON P.Torneo = T.ID
    WHERE P.Giocatore = G.ID
);

SET SQL_SAFE_UPDATES = 1;  -- Riabilita il safe update mode
