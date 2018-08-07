package DTO;

public class Request {

	private String id;
	private String userId;
	private String songId;
	private boolean resolved;
	private String createdAt;
	private String userName;
	private String songName;
	private String composerName;
	private String singerName;
	private String message;
	private String exception;
	private String orderNumber;
	
	public Request(String userId, String songId, String message) {
		this.userId = userId;
		this.songId = userId;
		this.message = message;
	}
	
	public Request(String userName, String songName, String singerName, String orderNumber) {
		this.userName = userName;
		this.songName = songName;
		this.singerName = singerName;
		this.orderNumber = orderNumber;
	}
	
	public Request(String userName, String songId, String exception, int i) {
		this.userName = userName;
		this.songId = songId;
		this.exception = exception;
	}

	public Request(String id, String userName, String songName, String composerName, String singerName,
			String createdAt, boolean resolved) {
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

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public String getSongId() {
		return songId;
	}

	public void setSongId(String songId) {
		this.songId = songId;
	}

	public boolean getResolved() {
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

	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
	}

	public String getException() {
		return exception;
	}

	public void setException(String exception) {
		this.exception = exception;
	}

	public String getOrderNumber() {
		return orderNumber;
	}

	public void setOrderNumber(String orderNumber) {
		this.orderNumber = orderNumber;
	}

}
