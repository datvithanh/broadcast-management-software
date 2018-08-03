package DTO;

public class Request {
		
	private String id;
	private int userId;
	private int songId;
	private boolean resolved;
	private String createdAt;
	private String userName;
	private String songName;
	private String composerName;
	private String singerName;


	public Request(String id, String userName, String songName, String composerName, String singerName, String createdAt, boolean resolved) {
		
		this.id = id;
		this.userName = userName;
		this.songName = songName;
		this.composerName = composerName;
		this.singerName = singerName;
		this.setCreatedAt(createdAt);
		this.resolved = resolved;
		
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public int getUserId() {
		return userId;
	}

	public void setUserId(int userId) {
		this.userId = userId;
	}

	public int getSongId() {
		return songId;
	}

	public void setSongId(int songId) {
		this.songId = songId;
	}

	public boolean isResolved() {
		return resolved;
	}

	public void setResolved(boolean resolved) {
		this.resolved = resolved;
	}

	public String getSingerName() {
		return singerName;
	}

	public void setSingerName(String singerName) {
		this.singerName = singerName;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public String getComposerName() {
		return composerName;
	}

	public void setComposerName(String composerName) {
		this.composerName = composerName;
	}

	public String getSongName() {
		return songName;
	}

	public void setSongName(String songName) {
		this.songName = songName;
	}

	public String getCreatedAt() {
		return createdAt;
	}

	public void setCreatedAt(String createdAt) {
		this.createdAt = createdAt;
	}
	
	
	
}


