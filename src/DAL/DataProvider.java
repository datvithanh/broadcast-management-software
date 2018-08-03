package DAL;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
 
public class DataProvider{
    private final String url = "jdbc:postgresql://127.0.0.1:54321/default";
    private final String user = "default";
    private final String password = "secret";
 
    /**
     * Connect to the PostgreSQL database
     *
     * @return a Connection object
     * @throws SQLException 
     */
    public Connection connect() throws SQLException {
        Connection conn = null;
        try {
            conn = DriverManager.getConnection(url, user, password);
            System.out.println("Connected to the PostgreSQL server successfully.");
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
        
        return conn;
    }
    
    public ResultSet getSongs() throws SQLException {
    	DataProvider app = new DataProvider();
        Connection conn = app.connect();
    	String query = "select * from get_songs()" ;
        Statement stmt = conn.createStatement() ;
        ResultSet rs = stmt.executeQuery(query) ;
        
        return rs;
    }
    /**
     * @param args the command line arguments
     * @throws SQLException 
     */
    public static void main(String[] args) throws SQLException {
    	DataProvider app = new DataProvider();
        app.getSongs();
    }
}