package DTO;

public class Song {
	private int id;
	private String name;
	private String composer;
	private String singer;

	public Song() {}

	public Song(int id, String name, String composer, String singer) {
		this.id = id;
		this.name = name;
		this.composer = composer;
		this.singer = singer;

	}

	public void setId(int id) {
		this.id = id;
	}
	public int getId() {
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
}
