package DTO;

import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import DAL.DataProvider;

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
 	
 	public Object[][] getSongArray() throws SQLException {
 		DataProvider dp = new DataProvider();
 		ResultSet rs = dp.getSongs();

 		ArrayList<Song> songArray = new ArrayList<Song>();
 		
 		ResultSetMetaData rsmd = rs.getMetaData();
        while (rs.next()) {
        	Song song = new Song(rs.getString("id"), rs.getString("name"), rs.getString("composer"), rs.getString("singer"));
        	songArray.add(song);
        	
//            for (int i = 1; i <= columnsNumber; i++) {
//                if (i > 1) System.out.print(",  ");
//                String columnValue = rs.getString(id);
//                System.out.print(columnValue + " " + rsmd.getColumnName(i));
//            }
//            System.out.println("");
        }
      
        
		return songArray.toArray();
 	}
}
