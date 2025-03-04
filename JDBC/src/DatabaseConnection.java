import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

//Classe per la connessione al database
public class DatabaseConnection {
    private static final String URL = "jdbc:mysql://localhost:3306/NAME OF YOUR DATABASE";
    private static final String USER = "YOUR USERNAME";
    private static final String PASSWORD = "YOUR PASSWORD";

    public static Connection getConnection() throws SQLException {
        return DriverManager.getConnection(URL, USER, PASSWORD);
    }
}
