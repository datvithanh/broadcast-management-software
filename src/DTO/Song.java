package DTO;

public class Song {
	private String id;
	private String name;
	private String composer;
	private String singer;
	
	public Song() {}

	public Song(String id, String name, String composer, String singer) {
		this.id = id;
		this.name = name;
		this.composer = composer;
		this.singer = singer;
	}

	public void setId(String string) {
		this.id = string;
	}
	public String getId() {
		return id;
	}

	public void setName(String name) {
		this.name = name;
	}
	public String getName() {
		return name;
	}
 
 	public void setComposer(String composer) {
 		this.composer = composer;
 	}
 	public String getComposer() {
 		return composer;
 	}

 	public void setSinger(String singer) {
 		this.singer = singer;
 	}

 	public String getSinger() {
 		return singer;
 	}
 	
// 	public ArrayList<Song> getSongArray() throws SQLException {
// 		DataProvider dp = new DataProvider();
// 		ResultSet rs = dp.getSongs();
//
// 		ArrayList<Song> songArray = new ArrayList<Song>();
// 		
// 		ResultSetMetaData rsmd = rs.getMetaData();
//        while (rs.next()) {
//        	Song song = new Song(rs.getString("id"), rs.getString("name"), rs.getString("composer"), rs.getString("singer"));
//        	songArray.add(song);   
//            System.out.println(song.getName());
//
//        }
//      
//        
//		return songArray;
// 	}
}
