package DTO;

public class User {

	private int id;
	private String name;
	private String phone;
	private String address;

	public User() {}

	public User(int id, String name, String phone, String address) {
		this.id = id;
		this.name = name;
		this.phone = phone;
		this.address = address;
	}
	
	public User(String name, String phone, String address) {
		this.name = name;
		this.phone = phone;
		this.address = address;
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
 
 	public void setPhone(String phone) {
 		this.phone = phone;
 	}
 	public String getPhone() {
 		return phone;
 	}

 	public void setAddress(String address) {
 		this.address = address;
 	}

 	public String getAddress() {
 		return address;
 	}


}
