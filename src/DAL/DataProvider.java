package DAL;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import DTO.Request;
import DTO.Song;
import java.util.ArrayList;

public class DataProvider {
	private final String url = "jdbc:postgresql://127.0.0.1:54321/default";
	private final String user = "default";
	private final String password = "secret";

	/**
	 * Connect to the PostgreSQL database
	 *
	 * @return a Connection object
	 * @throws SQLException
	 */
	public Connection connect() {
		Connection conn = null;
		try {
			conn = DriverManager.getConnection(url, user, password);
			System.out.println("Connected to the PostgreSQL server successfully.");
		} catch (SQLException e) {
			System.out.println(e.getMessage());
		}

		return conn;
	}

	public ArrayList<Song> songList() {
		ArrayList<Song> songList = new ArrayList<>();
		Connection conn = connect();
		try {
			String query = "select * from get_songs()";
			Statement st = conn.createStatement();
			ResultSet rs = st.executeQuery(query);
			Song song;
			while (rs.next()) {
				song = new Song(rs.getString("id"), rs.getString("name"), rs.getString("composer"), rs.getString("singer"));
				songList.add(song);
			}
		} catch (SQLException e) {
			System.out.println(e.getMessage());
		}
		return songList;
	}
	
	public ArrayList<Request> requestList() {
		ArrayList<Request> requestList = new ArrayList<>();
		Connection conn = connect();
		try {
			String query = "select * from get_requests()";
			Statement st = conn.createStatement();
			ResultSet rs = st.executeQuery(query);
			Request request;
			while (rs.next()) {
				request = new Request(rs.getString("id"), rs.getString("user_name"), rs.getString("song_name"), rs.getString("singer_name"), rs.getString("composer_name"), rs.getString("created_at"), rs.getBoolean("resolved"));
				requestList.add(request);
			}
		} catch (SQLException e) {
			System.out.println(e.getMessage());
		}
		return requestList;
	}
	
	public static void main(String[] args) throws SQLException {

	}
}