package DTO;

public class Song {
	private String id;
	private String name;
	private String composer;
	private String singer;
	private int requestCount;
	
	public Song() {}

	public Song(String id, String name, String composer, String singer) {
		this.id = id;
		this.name = name;
		this.composer = composer;
		this.singer = singer;
	}
	
	public Song(String name, String composer, String singer) {
		this.name = name;
		this.composer = composer;
		this.singer = singer;
	}
	
	public Song(String id, String name, int requestCount) {
		this.id = id;
		this.name = name;
		this.setRequestCount(requestCount);
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

	public int getRequestCount() {
		return requestCount;
	}

	public void setRequestCount(int requestCount) {
		this.requestCount = requestCount;
	}
}
