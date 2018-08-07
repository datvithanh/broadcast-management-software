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
	private final String songsPerBroadcast = "5";

	/**
	 * Connect to the PostgreSQL database
	 *
	 * @return a Connection object
	 * @throws SQLException
	 */
	public static Connection connect() {
		Connection conn = null;
		try {
			conn = DriverManager.getConnection("jdbc:postgresql://127.0.0.1:54321/default", "default", "secret");
			System.out.println("Connected to the PostgreSQL server successfully.");
		} catch (SQLException e) {
			System.out.println(e.getMessage());
		}

		return conn;
	}

	public Song song(String songId) {
		Connection conn = connect();
		Song song = null;
		try {
			String query = "SELECT * FROM songs WHERE id = " + songId;
			Statement st = conn.createStatement();
			ResultSet rs = st.executeQuery(query);
			rs.next();
			song = new Song(rs.getString("id"), rs.getString("name"), rs.getString("composer"), rs.getString("singer"),
					rs.getString("link"));
		} catch (SQLException e) {
			System.out.println(e.getMessage());
		}
		return song;
	}

	public void updateSong(Song song) {
		Connection conn = connect();
		try {
			String query = "UPDATE songs SET (name, composer, singer, link) = ROW('" + song.getName()
					+ "', '" + song.getComposer() + "', '" + song.getSinger() + "', '" + song.getLink()
					+ "') where id = " + song.getId();
			Statement st = conn.createStatement();
			st.executeQuery(query);
		} catch (SQLException e) {
			System.out.println(e.getMessage());
		}
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
			String query = "SELECT requests.id, requests.user_name, songs.name as song_name,  songs.singer as singer_name, songs.composer as composer_name, requests.resolved, date(requests.created_at) as created_at FROM (SELECT requests.*, users.name as user_name FROM requests LEFT JOIN users ON requests.user_id = users.id) as requests LEFT JOIN songs ON requests.song_id = songs.id::varchar";
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
	public ArrayList<Broadcast> broadcastList() {
		ArrayList<Broadcast> broadcastList = new ArrayList<>();
		Connection conn = connect();
		try {
			String query = "SELECT id, name, date(created_at) as created_at FROM broadcasts order by created_at desc";
			Statement st = conn.createStatement();
			ResultSet rs = st.executeQuery(query);
			Broadcast broadcast;
			while (rs.next()) {
				broadcast = new Broadcast(rs.getString("id"), rs.getString("name"), rs.getString("created_at"));
				broadcastList.add(broadcast);
			}
		} catch (SQLException e) {
			System.out.println(e.getMessage());
		}
		return broadcastList;
	}

	public void deleteRequest(String requestId) {
		Connection conn = connect();
		try {
			String query = "delete from requests where id = " + requestId;
			PreparedStatement ps = conn.prepareStatement(query);
			ps.execute();
		} catch (SQLException e) {
			System.out.println(e.getMessage());
		}
	}

	public void insertSong(Song song) {
		Connection conn = connect();
		try {
			String query = " insert into songs (name, composer, singer, link)" + " values (?, ?, ?, ?)";
			PreparedStatement preparedStmt = conn.prepareStatement(query);
			preparedStmt.setString(1, song.getName());
			preparedStmt.setString(2, song.getComposer());
			preparedStmt.setString(3, song.getSinger());
			preparedStmt.setString(4, song.getLink());

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
			PreparedStatement preparedStmt = conn.prepareStatement(query);
			preparedStmt.setInt(1, Integer.parseInt(request.getUserId()));
			preparedStmt.setString(2, request.getSongId());
			preparedStmt.setString(3, request.getMessage());
			preparedStmt.execute();
		} catch (SQLException e) {
			System.out.println(e.getMessage());
		}
	}

	public void broadcastSongs(String songId, String broadcastId, int order) {
		Connection conn = connect();
		try {
			String query = "SELECT * FROM requests Where song_id = '" + songId + "'";
			Statement st = conn.createStatement();
			ResultSet rs = st.executeQuery(query);
			while (rs.next()) {
				String requestId = rs.getString("id");
				query = "insert into broadcast_request(broadcast_id, request_id, order_number)" + " values(?, ?, ?)";
				PreparedStatement preparedStmt = conn.prepareStatement(query);
				preparedStmt.setInt(1, Integer.parseInt(broadcastId));
				preparedStmt.setInt(2, Integer.parseInt(requestId));
				preparedStmt.setInt(3, order);
				preparedStmt.execute();
			}

			query = "UPDATE requests SET (resolved) = ROW(true) where song_id = '" + songId + "'";
			st.execute(query);
		} catch (SQLException e) {
			System.out.println(e.getMessage());
		}
	}
	public ArrayList<Request> broadcastRequestList(String broadcastId) {
		ArrayList<Request> broadcastRequestList = new ArrayList<>();
		Connection conn = connect();
		try {
			String query = "SELECT r.user_name as user_name, r.song_name as song_name, r.singer_name as singer_name, r.composer_name as composer_name, broadcast_request.order_number as order_number FROM (SELECT requests.id, requests.user_name, songs.name as song_name,  songs.singer as singer_name, songs.composer as composer_name, requests.resolved, date(requests.created_at) as created_at FROM (SELECT requests.*, users.name as user_name FROM requests LEFT JOIN users ON requests.user_id = users.id) as requests LEFT JOIN songs ON requests.song_id = songs.id::varchar) r JOIN broadcast_request ON r.id = broadcast_request.request_id WHERE broadcast_request.broadcast_id = "
					+ broadcastId;
			Statement st = conn.createStatement();
			ResultSet rs = st.executeQuery(query);
			Request request;
			while (rs.next()) {
				request = new Request(rs.getString("user_name"), rs.getString("song_name"), rs.getString("singer_name"),
						rs.getString("order_number"));
				broadcastRequestList.add(request);
			}
		} catch (SQLException e) {
			System.out.println(e.getMessage());
		}

		return broadcastRequestList;
	}
	public String insertBroadcast() {
		Connection conn = connect();
		try {
			String query = "SELECT count(*) FROM broadcasts where date(created_at) = current_date";
			Statement st = conn.createStatement();
			ResultSet rs = st.executeQuery(query);

			rs.next();
			int count = rs.getInt("count") + 1;

			query = "SELECT * FROM current_date";
			rs = st.executeQuery(query);
			rs.next();
			String date = rs.getString("current_date");
			String name = "Phat song ngay " + date + " lan " + Integer.toString(count);

			query = " insert into broadcasts (name)" + " values ('" + name + "') returning id";
			st = conn.createStatement();
			rs = st.executeQuery(query);
			rs.next();
			String broadcastId = rs.getString("id");

			query = "SELECT songs.id as id, songs.name as song_name, count(r.id) as request_count FROM songs LEFT JOIN requests r ON songs.id::varchar = r.song_id WHERE r.resolved = FALSE GROUP BY songs.id ORDER BY count(r.id) DESC LIMIT "
					+ songsPerBroadcast;

			rs = st.executeQuery(query);
			int i = 0;
			while (rs.next()) {
				++i;
				broadcastSongs(rs.getString("id"), broadcastId, i);
			}

			return "Phat song ngay " + date + " lan " + Integer.toString(count);
		} catch (SQLException e) {
			System.out.println(e.getMessage());
		}

		return null;
	}

	public static void main(String[] args) throws SQLException {
	}
}