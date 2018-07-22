
public class Broadcast {

		private int id;
		private String name;
		private String broadcastAt;
		private String createdAt;
	
	
	
	public Broadcast(int id, String name, String broadcastAt, String createdAt ) {	
		this.id = id;
		this.name = name;
		this.broadcastAt = broadcastAt;
		this.createdAt = createdAt;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getBroadcastAt() {
		return broadcastAt;
	}

	public void setBroadcastAt(String broadcastAt) {
		this.broadcastAt = broadcastAt;
	}

	public String getCreatedAt() {
		return createdAt;
	}

	public void setCreatedAt(String createdAt) {
		this.createdAt = createdAt;
	}
	
}
