import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

// Classe per la completa gestione ed esecuzione delle query
public class QueryManager {
    private static Object executeQuery(Connection conn, String query, Object... params) throws SQLException {      // Metodo personalizzato per l'esecuzione delle query
        PreparedStatement stmt = conn.prepareStatement(query);         // Preparazione della query e inserimento dei parametri
            for (int i = 0; i < params.length; i++) {
                stmt.setObject(i + 1, params[i]);
            }
            if (query.toUpperCase().startsWith("SELECT")) {         // Distinzione tra query di interrogazione e di update
                return stmt.executeQuery();
            } else {
                return stmt.executeUpdate();
            }

    }

    // Sequenza di tutti i metodi per ciascuna query
    public static Object inserisciAllenatore(Connection conn, Object... params) throws SQLException {
        return executeQuery(conn, "INSERT INTO Allenatore (Nome, Cognome, Ex_giocatore)  \n" +
                "VALUES (?, ?, ?);", params);
    }

    public static Object inserisciRappresentazione(Connection conn, Object... params) throws SQLException {
        return executeQuery(conn, "INSERT INTO Rappresentazione (Giocatore, Sponsor, Durata_contratto, Compenso)\n" +
                "VALUES (?, ?, ?, ?);", params);
    }

    public static ResultSet visualizzaSponsorDiGiocatore(Connection conn, Object... params) throws SQLException {
        return (ResultSet) executeQuery(conn, "SELECT s.Nome, s.Tipologia, s.Motto, s.Colore\n" +
                "FROM Rappresentazione r\n" +
                "JOIN Sponsor s ON r.Sponsor = s.Nome\n" +
                "WHERE r.Giocatore = ?;", params);
    }

    public static ResultSet giocatoriDiUnAllenatore(Connection conn, Object... params) throws SQLException {
        return (ResultSet) executeQuery(conn, "SELECT g.ID, g.Nome, g.Cognome, g.Età, g.Punti_ottenuti, g.Sesso\n" +
                "FROM Preparazione p\n" +
                "JOIN Giocatore g ON p.Giocatore = g.ID\n" +
                "WHERE p.Allenatore = ?;", params);
    }

    public static ResultSet sponsorDiGiocatoriAllenati(Connection conn, Object... params) throws SQLException {
        return (ResultSet) executeQuery(conn, "SELECT DISTINCT s.Nome, s.Tipologia, s.Motto, s.Colore\n" +
                "FROM Preparazione p\n" +
                "JOIN Giocatore g ON p.Giocatore = g.ID\n" +
                "JOIN Rappresentazione r ON g.ID = r.Giocatore\n" +
                "JOIN Sponsor s ON r.Sponsor = s.Nome\n" +
                "WHERE p.Allenatore = ?;", params);
    }

    public static Object creaTorneo(Connection conn, Object... params) throws SQLException {
        return executeQuery(conn, "INSERT INTO Torneo (Nome, Tipologia, Punti, Anno, Premio_in_denaro, Ente_organizzatore)\n" +
                "VALUES (?, ?, ?, ?, ?, ?);", params);
    }

    public static ResultSet guadagnoAnnualeGiocatore(Connection conn, Object... params) throws SQLException {
        return (ResultSet) executeQuery(conn, "SELECT\n" +
                "    G.ID,\n" +
                "    G.Nome,\n" +
                "    G.Cognome,\n" +
                "    G.Punti_ottenuti,\n" +
                "    (\n" +
                "        SELECT COALESCE(SUM(R.Compenso), 0)\n" +
                "        FROM Rappresentazione R\n" +
                "        WHERE R.Giocatore = G.ID\n" +
                "    ) AS Guadagno_Sponsor_Annuale,\n" +
                "    COALESCE(SUM(T.Premio_in_denaro), 0) AS Guadagno_Tornei,\n" +
                "    (\n" +
                "        (\n" +
                "            SELECT COALESCE(SUM(R.Compenso), 0)\n" +
                "            FROM Rappresentazione R\n" +
                "            WHERE R.Giocatore = G.ID\n" +
                "        ) + COALESCE(SUM(T.Premio_in_denaro), 0)\n" +
                "    ) AS Guadagno_Totale_Annuale\n" +
                "FROM\n" +
                "    Giocatore G\n" +
                "LEFT JOIN\n" +
                "    Partecipazione P ON G.ID = P.Giocatore\n" +
                "LEFT JOIN\n" +
                "    Torneo T ON P.Torneo = T.ID AND P.Posizione = 1\n" +
                "GROUP BY\n" +
                "    G.ID, G.Nome, G.Cognome, G.Punti_ottenuti\n" +
                "ORDER BY\n" +
                "    G.ID;", params);
    }

    public static ResultSet vincitoreTorneo(Connection conn, Object... params) throws SQLException {
        return (ResultSet) executeQuery(conn, "SELECT\n" +
                "    G.Nome AS Nome_Vincitore,\n" +
                "    G.Cognome AS Cognome_Vincitore\n" +
                "FROM\n" +
                "    Partecipazione P\n" +
                "JOIN\n" +
                "    Giocatore G ON P.Giocatore = G.ID\n" +
                "JOIN\n" +
                "    Torneo T ON P.Torneo = T.ID\n" +
                "WHERE\n" +
                "    T.Nome = ? AND T.Anno = ? AND P.Posizione = 1;", params);
    }

    public static ResultSet puntiUltimoAnno(Connection conn, Object... params) throws SQLException {
        return (ResultSet) executeQuery(conn, "SELECT\n" +
                "    G.ID, G.Nome, G.Cognome,\n" +
                "    SUM(CASE WHEN P.Torneo IS NOT NULL THEN 100 ELSE 0 END) AS Punti_Partecipazione,\n" +
                "    SUM(CASE WHEN P.Posizione = 1 THEN T.Punti ELSE 0 END) AS Punti_Vittoria_Torneo,\n" +
                "    (\n" +
                "        SELECT COUNT(*) * 50\n" +
                "        FROM Incontro I2\n" +
                "        WHERE I2.Giocatore = G.ID AND I2.Vincitore = 1 AND I2.Torneo IN (SELECT ID FROM Torneo WHERE Anno = 2025)\n" +
                "    ) AS Punti_Partite_Vinte,\n" +
                "    (\n" +
                "        SUM(CASE WHEN P.Torneo IS NOT NULL THEN 100 ELSE 0 END) +\n" +
                "        SUM(CASE WHEN P.Posizione = 1 THEN T.Punti ELSE 0 END) +\n" +
                "        (\n" +
                "            SELECT COUNT(*) * 50\n" +
                "            FROM Incontro I2\n" +
                "            WHERE I2.Giocatore = G.ID AND I2.Vincitore = 1 AND I2.Torneo IN (SELECT ID FROM Torneo WHERE Anno = 2025)\n" +
                "        )\n" +
                "    ) AS Punteggio_Totale\n" +
                "FROM\n" +
                "    Giocatore G\n" +
                "LEFT JOIN\n" +
                "    Partecipazione P ON G.ID = P.Giocatore\n" +
                "LEFT JOIN\n" +
                "    Torneo T ON P.Torneo = T.ID AND T.Anno = 2025\n" +
                "WHERE\n" +
                "    G.ID = ?  \n" +
                "GROUP BY\n" +
                "    G.ID, G.Nome, G.Cognome\n" +
                "ORDER BY\n" +
                "    G.ID;", params);
    }

    public static Object aggiornaPuntiGiocatori(Connection conn) throws SQLException {
        return executeQuery(conn, "UPDATE Giocatore G\n" +
                "SET Punti_ottenuti = (\n" +
                "    SELECT COALESCE(\n" +
                "        SUM(CASE WHEN P.Torneo IS NOT NULL THEN 100 ELSE 0 END) +\n" +
                "        SUM(CASE WHEN P.Posizione = 1 THEN T.Punti ELSE 0 END) +\n" +
                "        (\n" +
                "            SELECT COUNT(*) * 50\n" +
                "            FROM Incontro I2\n" +
                "            WHERE I2.Giocatore = G.ID AND I2.Vincitore = 1\n" +
                "        ), 0)\n" +
                "    FROM Partecipazione P\n" +
                "    LEFT JOIN Torneo T ON P.Torneo = T.ID\n" +
                "    WHERE P.Giocatore = G.ID\n" +
                ");");
    }

    public static Object aggiornaPrimoClassificatoEnti(Connection conn) throws SQLException {
        return executeQuery(conn, "UPDATE Ente_organizzatore EO\n" +
                "SET EO.Primo_classificato = (\n" +
                "    SELECT GiocatoreID\n" +
                "    FROM (\n" +
                "        SELECT\n" +
                "            P.Giocatore AS GiocatoreID,\n" +
                "            SUM(CASE WHEN P.Torneo IS NOT NULL THEN 100 ELSE 0 END) +\n" +
                "            SUM(CASE WHEN P.Posizione = 1 THEN T.Punti ELSE 0 END) +\n" +
                "            (\n" +
                "                SELECT COUNT(*) *50 \n" +
                "                FROM Incontro I2\n" +
                "                WHERE I2.Giocatore = P.Giocatore AND I2.Vincitore = 1 \n" +
                "                      AND I2.Torneo IN (\n" +
                "                          SELECT ID FROM Torneo WHERE Ente_organizzatore = EO.ID AND Anno = EO.Anno\n" +
                "                      )\n" +
                "            ) AS Punteggio_Totale\n" +
                "        FROM Partecipazione P\n" +
                "        JOIN Torneo T ON P.Torneo = T.ID\n" +
                "        WHERE T.Ente_organizzatore = EO.ID AND T.Anno = EO.Anno\n" +
                "        GROUP BY P.Giocatore\n" +
                "        ORDER BY Punteggio_Totale DESC, GiocatoreID ASC \n" +
                "        LIMIT 1\n" +
                "    ) AS PrimoClassificato\n" +
                ");");
    }

    public static Object stampaRankingATP(Connection conn) throws SQLException {
        executeQuery(conn, "WITH Classifica AS (\n" +
                "    SELECT\n" +
                "        R2.Giocatore,\n" +
                "        R2.Ente_organizzatore,\n" +
                "        EO.Anno,\n" +
                "        DENSE_RANK() OVER (ORDER BY (\n" +
                "            SELECT\n" +
                "                SUM(CASE WHEN P.Torneo IS NOT NULL THEN 100 ELSE 0 END) +\n" +
                "                SUM(CASE WHEN P.Posizione = 1 THEN T.Punti ELSE 0 END) +\n" +
                "                (\n" +
                "                    SELECT COUNT(*) * 50\n" +
                "                    FROM Incontro I2\n" +
                "                    WHERE I2.Giocatore = P.Giocatore AND I2.Vincitore = 1 AND I2.Torneo IN (SELECT ID FROM Torneo WHERE Ente_organizzatore = R2.Ente_organizzatore AND Anno = EO.Anno)\n" +
                "                )\n" +
                "            FROM Partecipazione P\n" +
                "            JOIN Torneo T ON P.Torneo = T.ID\n" +
                "            WHERE P.Giocatore = R2.Giocatore AND T.Ente_organizzatore = R2.Ente_organizzatore AND T.Anno = EO.Anno\n" +
                "        ) DESC) AS Posizione,\n" +
                "        (\n" +
                "            SELECT\n" +
                "                SUM(CASE WHEN P.Torneo IS NOT NULL THEN 100 ELSE 0 END) +\n" +
                "                SUM(CASE WHEN P.Posizione = 1 THEN T.Punti ELSE 0 END) +\n" +
                "                (\n" +
                "                    SELECT COUNT(*) * 50\n" +
                "                    FROM Incontro I2\n" +
                "                    WHERE I2.Giocatore = P.Giocatore AND I2.Vincitore = 1 AND I2.Torneo IN (SELECT ID FROM Torneo WHERE Ente_organizzatore = R2.Ente_organizzatore AND Anno = EO.Anno)\n" +
                "                )\n" +
                "            FROM Partecipazione P\n" +
                "            JOIN Torneo T ON P.Torneo = T.ID\n" +
                "            WHERE P.Giocatore = R2.Giocatore AND T.Ente_organizzatore = R2.Ente_organizzatore AND T.Anno = EO.Anno\n" +
                "        ) AS Punteggio\n" +
                "    FROM Ranking R2\n" +
                "    JOIN Ente_organizzatore EO ON R2.Ente_organizzatore = EO.ID\n" +
                "    WHERE EO.Nome = 'ATP' AND EO.Anno = 2025\n" +
                ")\n" +
                "UPDATE Ranking R\n" +
                "JOIN Classifica C ON R.Giocatore = C.Giocatore\n" +
                "                  AND R.Ente_organizzatore = C.Ente_organizzatore\n" +
                "SET R.Posizione = C.Posizione;");


        return executeQuery(conn, "SELECT\n" +
                "    R.Giocatore,\n" +
                "    EO.Anno,\n" +
                "    R.Posizione,\n" +
                "    (\n" +
                "        SELECT\n" +
                "            SUM(CASE WHEN P.Torneo IS NOT NULL THEN 100 ELSE 0 END) +\n" +
                "            SUM(CASE WHEN P.Posizione = 1 THEN T.Punti ELSE 0 END) +\n" +
                "            (\n" +
                "                SELECT COUNT(*) * 50\n" +
                "                FROM Incontro I2\n" +
                "                WHERE I2.Giocatore = P.Giocatore AND I2.Vincitore = 1 AND I2.Torneo IN (SELECT ID FROM Torneo WHERE Ente_organizzatore = R.Ente_organizzatore AND Anno = EO.Anno)\n" +
                "            )\n" +
                "        FROM Partecipazione P\n" +
                "        JOIN Torneo T ON P.Torneo = T.ID\n" +
                "        WHERE P.Giocatore = R.Giocatore AND T.Ente_organizzatore = R.Ente_organizzatore AND T.Anno = EO.Anno\n" +
                "    ) AS Punteggio\n" +
                "FROM Ranking R\n" +
                "JOIN Ente_organizzatore EO ON R.Ente_organizzatore = EO.ID\n" +
                "WHERE EO.Nome = 'ATP' AND EO.Anno = 2025\n" +
                "ORDER BY R.Posizione ASC;");
    }

    public static Object stampaRankingWTA(Connection conn) throws SQLException {
        executeQuery(conn, "WITH Classifica AS (\n" +
                "    SELECT\n" +
                "        R2.Giocatore,\n" +
                "        R2.Ente_organizzatore,\n" +
                "        EO.Anno,\n" +
                "        DENSE_RANK() OVER (ORDER BY (\n" +
                "            SELECT\n" +
                "                SUM(CASE WHEN P.Torneo IS NOT NULL THEN 100 ELSE 0 END) +\n" +
                "                SUM(CASE WHEN P.Posizione = 1 THEN T.Punti ELSE 0 END) +\n" +
                "                (\n" +
                "                    SELECT COUNT(*) * 50\n" +
                "                    FROM Incontro I2\n" +
                "                    WHERE I2.Giocatore = P.Giocatore AND I2.Vincitore = 1 AND I2.Torneo IN (SELECT ID FROM Torneo WHERE Ente_organizzatore = R2.Ente_organizzatore AND Anno = EO.Anno)\n" +
                "                )\n" +
                "            FROM Partecipazione P\n" +
                "            JOIN Torneo T ON P.Torneo = T.ID\n" +
                "            WHERE P.Giocatore = R2.Giocatore AND T.Ente_organizzatore = R2.Ente_organizzatore AND T.Anno = EO.Anno\n" +
                "        ) DESC) AS Posizione,\n" +
                "        (\n" +
                "            SELECT\n" +
                "                SUM(CASE WHEN P.Torneo IS NOT NULL THEN 100 ELSE 0 END) +\n" +
                "                SUM(CASE WHEN P.Posizione = 1 THEN T.Punti ELSE 0 END) +\n" +
                "                (\n" +
                "                    SELECT COUNT(*) * 50\n" +
                "                    FROM Incontro I2\n" +
                "                    WHERE I2.Giocatore = P.Giocatore AND I2.Vincitore = 1 AND I2.Torneo IN (SELECT ID FROM Torneo WHERE Ente_organizzatore = R2.Ente_organizzatore AND Anno = EO.Anno)\n" +
                "                )\n" +
                "            FROM Partecipazione P\n" +
                "            JOIN Torneo T ON P.Torneo = T.ID\n" +
                "            WHERE P.Giocatore = R2.Giocatore AND T.Ente_organizzatore = R2.Ente_organizzatore AND T.Anno = EO.Anno\n" +
                "        ) AS Punteggio\n" +
                "    FROM Ranking R2\n" +
                "    JOIN Ente_organizzatore EO ON R2.Ente_organizzatore = EO.ID\n" +
                "    WHERE EO.Nome = 'WTA' AND EO.Anno = 2025\n" +
                ")\n" +
                "UPDATE Ranking R\n" +
                "JOIN Classifica C ON R.Giocatore = C.Giocatore\n" +
                "                  AND R.Ente_organizzatore = C.Ente_organizzatore\n" +
                "SET R.Posizione = C.Posizione;");


        return executeQuery(conn, "SELECT\n" +
                "    R.Giocatore,\n" +
                "    EO.Anno,\n" +
                "    R.Posizione,\n" +
                "    (\n" +
                "        SELECT\n" +
                "            SUM(CASE WHEN P.Torneo IS NOT NULL THEN 100 ELSE 0 END) +\n" +
                "            SUM(CASE WHEN P.Posizione = 1 THEN T.Punti ELSE 0 END) +\n" +
                "            (\n" +
                "                SELECT COUNT(*) * 50\n" +
                "                FROM Incontro I2\n" +
                "                WHERE I2.Giocatore = P.Giocatore AND I2.Vincitore = 1 AND I2.Torneo IN (SELECT ID FROM Torneo WHERE Ente_organizzatore = R.Ente_organizzatore AND Anno = EO.Anno)\n" +
                "            )\n" +
                "        FROM Partecipazione P\n" +
                "        JOIN Torneo T ON P.Torneo = T.ID\n" +
                "        WHERE P.Giocatore = R.Giocatore AND T.Ente_organizzatore = R.Ente_organizzatore AND T.Anno = EO.Anno\n" +
                "    ) AS Punteggio\n" +
                "FROM Ranking R\n" +
                "JOIN Ente_organizzatore EO ON R.Ente_organizzatore = EO.ID\n" +
                "WHERE EO.Nome = 'WTA' AND EO.Anno = 2025\n" +
                "ORDER BY R.Posizione ASC;");
    }

    public static Object stampaRankingITF(Connection conn) throws SQLException {
        executeQuery(conn, "WITH Classifica AS (\n" +
                "    SELECT\n" +
                "        R2.Giocatore,\n" +
                "        R2.Ente_organizzatore,\n" +
                "        EO.Anno,\n" +
                "        DENSE_RANK() OVER (ORDER BY (\n" +
                "            SELECT\n" +
                "                SUM(CASE WHEN P.Torneo IS NOT NULL THEN 100 ELSE 0 END) +\n" +
                "                SUM(CASE WHEN P.Posizione = 1 THEN T.Punti ELSE 0 END) +\n" +
                "                (\n" +
                "                    SELECT COUNT(*) * 50\n" +
                "                    FROM Incontro I2\n" +
                "                    WHERE I2.Giocatore = P.Giocatore AND I2.Vincitore = 1 AND I2.Torneo IN (SELECT ID FROM Torneo WHERE Ente_organizzatore = R2.Ente_organizzatore AND Anno = EO.Anno)\n" +
                "                )\n" +
                "            FROM Partecipazione P\n" +
                "            JOIN Torneo T ON P.Torneo = T.ID\n" +
                "            WHERE P.Giocatore = R2.Giocatore AND T.Ente_organizzatore = R2.Ente_organizzatore AND T.Anno = EO.Anno\n" +
                "        ) DESC) AS Posizione,\n" +
                "        (\n" +
                "            SELECT\n" +
                "                SUM(CASE WHEN P.Torneo IS NOT NULL THEN 100 ELSE 0 END) +\n" +
                "                SUM(CASE WHEN P.Posizione = 1 THEN T.Punti ELSE 0 END) +\n" +
                "                (\n" +
                "                    SELECT COUNT(*) * 50\n" +
                "                    FROM Incontro I2\n" +
                "                    WHERE I2.Giocatore = P.Giocatore AND I2.Vincitore = 1 AND I2.Torneo IN (SELECT ID FROM Torneo WHERE Ente_organizzatore = R2.Ente_organizzatore AND Anno = EO.Anno)\n" +
                "                )\n" +
                "            FROM Partecipazione P\n" +
                "            JOIN Torneo T ON P.Torneo = T.ID\n" +
                "            WHERE P.Giocatore = R2.Giocatore AND T.Ente_organizzatore = R2.Ente_organizzatore AND T.Anno = EO.Anno\n" +
                "        ) AS Punteggio\n" +
                "    FROM Ranking R2\n" +
                "    JOIN Ente_organizzatore EO ON R2.Ente_organizzatore = EO.ID\n" +
                "    WHERE EO.Nome = 'ITF' AND EO.Anno = 2025\n" +
                ")\n" +
                "UPDATE Ranking R\n" +
                "JOIN Classifica C ON R.Giocatore = C.Giocatore\n" +
                "                  AND R.Ente_organizzatore = C.Ente_organizzatore\n" +
                "SET R.Posizione = C.Posizione;");


        return executeQuery(conn, "SELECT\n" +
                "    R.Giocatore,\n" +
                "    EO.Anno,\n" +
                "    R.Posizione,\n" +
                "    (\n" +
                "        SELECT\n" +
                "            SUM(CASE WHEN P.Torneo IS NOT NULL THEN 100 ELSE 0 END) +\n" +
                "            SUM(CASE WHEN P.Posizione = 1 THEN T.Punti ELSE 0 END) +\n" +
                "            (\n" +
                "                SELECT COUNT(*) * 50\n" +
                "                FROM Incontro I2\n" +
                "                WHERE I2.Giocatore = P.Giocatore AND I2.Vincitore = 1 AND I2.Torneo IN (SELECT ID FROM Torneo WHERE Ente_organizzatore = R.Ente_organizzatore AND Anno = EO.Anno)\n" +
                "            )\n" +
                "        FROM Partecipazione P\n" +
                "        JOIN Torneo T ON P.Torneo = T.ID\n" +
                "        WHERE P.Giocatore = R.Giocatore AND T.Ente_organizzatore = R.Ente_organizzatore AND T.Anno = EO.Anno\n" +
                "    ) AS Punteggio\n" +
                "FROM Ranking R\n" +
                "JOIN Ente_organizzatore EO ON R.Ente_organizzatore = EO.ID\n" +
                "WHERE EO.Nome = 'ITF' AND EO.Anno = 2025\n" +
                "ORDER BY R.Posizione ASC;");
    }

    public static ResultSet stampaTorneiGiocatore(Connection conn, Object... params) throws SQLException {
        return (ResultSet) executeQuery(conn, "SELECT\n" +
                "    T.Nome\n" +
                "FROM\n" +
                "    Partecipazione P\n" +
                "JOIN\n" +
                "    Torneo T ON P.Torneo = T.ID\n" +
                "WHERE\n" +
                "    P.Giocatore = ?\n" +
                "ORDER BY\n" +
                "    T.Nome;", params);
    }
}