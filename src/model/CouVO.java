package model;

public class CouVO extends ProVO{
	private String lcode;
	private String lname;
	private String room;
	private int hours;
	private int persons;
	private String instructor;
	private int capacity;
	public String getLcode() {
		return lcode;
	}
	public void setLcode(String lcode) {
		this.lcode = lcode;
	}
	public String getLname() {
		return lname;
	}
	public void setLname(String lname) {
		this.lname = lname;
	}
	public String getRoom() {
		return room;
	}
	public void setRoom(String room) {
		this.room = room;
	}
	public int getHours() {
		return hours;
	}
	public void setHours(int hours) {
		this.hours = hours;
	}
	public int getPersons() {
		return persons;
	}
	public void setPersons(int persons) {
		this.persons = persons;
	}
	public String getInstructor() {
		return instructor;
	}
	public void setInstructor(String instructor) {
		this.instructor = instructor;
	}
	public int getCapacity() {
		return capacity;
	}
	public void setCapacity(int capacity) {
		this.capacity = capacity;
	}
	@Override
	public String toString() {
		return "CouVO [lcode=" + lcode + ", lname=" + lname + ", room=" + room + ", hours=" + hours + ", persons="
				+ persons + ", instructor=" + instructor + ", capacity=" + capacity + "]";
	}
	
}
