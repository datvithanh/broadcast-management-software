package DAL;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
 
public class DataProvider{
    private final String url = "jdbc:postgresql://127.0.0.1:54321/default";
    private final String user = "default";
    private final String password = "secret";
 
    /**
     * Connect to the PostgreSQL database
     *
     * @return a Connection object
     */
    public Connection connect() {
        Connection conn = null;
        try {
            conn = DriverManager.getConnection(url, user, password);
            System.out.println("Connected to the PostgreSQL server successfully.");
        } catch (SQLException e) {
            System.out.println(e.getMessage());
            System.out.println("Adlasldl");
        }
 
        return conn;
    }
 
    /**
     * @param args the command line arguments
     */
    public static void main(String[] args) {
    	DataProvider app = new DataProvider();
        app.connect();
    }
}