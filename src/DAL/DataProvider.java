package DAL;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import DTO.Broadcast;
import DTO.Request;
import DTO.Song;
import DTO.User;

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
			String query = "SELECT * FROM songs ORDER BY created_at DESC";
			Statement st = conn.createStatement();
			ResultSet rs = st.executeQuery(query);
			Song song;
			while (rs.next()) {
				song = new Song(rs.getString("id"), rs.getString("name"), rs.getString("composer"),
						rs.getString("singer"));
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
			String query = "SELECT requests.id, requests.user_name, songs.name as song_name,  songs.singer as singer_name, songs.composer as composer_name, requests.resolved, requests.created_at FROM (SELECT requests.*, users.name as user_name FROM requests LEFT JOIN users ON requests.user_id = users.id) as requests LEFT JOIN songs ON requests.song_id = songs.id::varchar";
			Statement st = conn.createStatement();
			ResultSet rs = st.executeQuery(query);
			Request request;
			while (rs.next()) {
				request = new Request(rs.getString("id"), rs.getString("user_name"), rs.getString("song_name"),
						rs.getString("singer_name"), rs.getString("composer_name"), rs.getString("created_at"),
						rs.getBoolean("resolved"));
				requestList.add(request);
			}
		} catch (SQLException e) {
			System.out.println(e.getMessage());
		}
		return requestList;
	}

	public ArrayList<Song> favoriteSongList() {
		ArrayList<Song> songList = new ArrayList<>();
		Connection conn = connect();
		try {
			String query = "SELECT songs.id as id, songs.name as song_name, count(r.id) as request_count FROM songs LEFT JOIN requests r ON songs.id::varchar = r.song_id WHERE r.resolved = TRUE GROUP BY songs.id ORDER BY count(r.id) DESC";
			Statement st = conn.createStatement();
			ResultSet rs = st.executeQuery(query);
			Song song;
			while (rs.next()) {
				// if (rs.getInt("request_count") != 0) {
				song = new Song(rs.getString("id"), rs.getString("song_name"), rs.getInt("request_count"));
				songList.add(song);
				// }
			}
		} catch (SQLException e) {
			System.out.println(e.getMessage());
		}
		return songList;
	}

	public ArrayList<Song> unresolvedSongList() {
		ArrayList<Song> songList = new ArrayList<>();
		Connection conn = connect();
		try {
			String query = "SELECT songs.id as id, songs.name as song_name, count(r.id) as request_count FROM songs LEFT JOIN requests r ON songs.id::varchar = r.song_id WHERE r.resolved = FALSE GROUP BY songs.id ORDER BY count(r.id) DESC";
			Statement st = conn.createStatement();
			ResultSet rs = st.executeQuery(query);
			Song song;
			while (rs.next()) {
				// if (rs.getInt("request_count") != 0) {
				song = new Song(rs.getString("id"), rs.getString("song_name"), rs.getInt("request_count"));
				songList.add(song);
				// }
			}
		} catch (SQLException e) {
			System.out.println(e.getMessage());
		}
		return songList;
	}
	
	public ArrayList<Broadcast> broadcastList(){
		ArrayList<Broadcast> broadcastList = new ArrayList<>();
		Connection conn = connect();
		return broadcastList;
	}
	
	public ArrayList<Request> requestExceptionList() {
		ArrayList<Request> requestList = new ArrayList<>();
		Connection conn = connect();
		try {
			String query = "SELECT users.name, requests.song_id, 'Khong ton tai ma bai hat' as exception FROM (SELECT * FROM requests WHERE song_id NOT IN (SELECT id::VARCHAR FROM songs)) requests LEFT JOIN users ON requests.user_id = users.id;";
			Statement st = conn.createStatement();
			ResultSet rs = st.executeQuery(query);
			Request request;
			while (rs.next()) {
				request = new Request(rs.getString("name"), rs.getString("song_id"), rs.getString("exception"), 1);
				requestList.add(request);
			}
		} catch (SQLException e) {
			System.out.println(e.getMessage());
		}
		return requestList;
	}

	public void insertSong(Song song) {
		Connection conn = connect();
		try {
			String query = " insert into songs (name, composer, singer)" + " values (?, ?, ?)";
			PreparedStatement preparedStmt = conn.prepareStatement(query);
			preparedStmt.setString(1, song.getName());
			preparedStmt.setString(2, song.getComposer());
			preparedStmt.setString(3, song.getSinger());
			preparedStmt.execute();
		} catch (SQLException e) {
			System.out.println(e.getMessage());
		}
	}

	public String insertUser(User user) {
		Connection conn = connect();
		try {
			String query = "select * from insert_users('" + user.getName() + "', '" + user.getPhone() + "', '"
					+ user.getAddress() + "')";
			Statement st = conn.createStatement();
			ResultSet rs = st.executeQuery(query);
			rs.next();
			return rs.getString("user_id");
		} catch (SQLException e) {
			System.out.println(e.getMessage());
		}
		String a = "";
		return a;
	}
	
	public void insertRequest(Request request) {
		Connection conn = connect();
		try {
			String query = " insert into requests (user_id, song_id, message)" + " values (?, ?, ?)";
			System.out.println(query);
			PreparedStatement preparedStmt = conn.prepareStatement(query);
			preparedStmt.setInt(1, Integer.parseInt(request.getUserId()));
			preparedStmt.setString(2, request.getSongId());
			preparedStmt.setString(3, request.getMessage());
			preparedStmt.execute();
		} catch (SQLException e) {
			System.out.println(e.getMessage());
		}
	}

	public static void main(String[] args) throws SQLException {

	}
}