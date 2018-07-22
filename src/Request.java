
public class Request {
		
	private int id;
	private int userId;
	private int songId;
	private boolean resolved;
	private String createAt;

	public Request(int id, int userId, int songId, boolean resolved, String createAt) {
		
		this.id = id;
		this.userId = userId;
		this.songId = songId;
		this.resolved = resolved;
		this.createAt = createAt;
		
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
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

	public String getCreateAt() {
		return createAt;
	}

	public void setCreateAt(String createAt) {
		this.createAt = createAt;
	}
	
	
	
}


