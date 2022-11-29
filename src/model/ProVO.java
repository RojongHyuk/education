package model;

public class ProVO {
	private String pcode;
	private String pname;
	private String dept;
	private String title;
	private int salary;
	private String hiredate;
	
	public String getPcode() {
		return pcode;
	}
	public void setPcode(String pcode) {
		this.pcode = pcode;
	}
	public String getPname() {
		return pname;
	}
	public void setPname(String pname) {
		this.pname = pname;
	}
	public String getDept() {
		return dept;
	}
	public void setDept(String dept) {
		this.dept = dept;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public int getSalary() {
		return salary;
	}
	public void setSalary(int salary) {
		this.salary = salary;
	}
	public String getHiredate() {
		return hiredate;
	}
	public void setHiredate(String hiredate) {
		this.hiredate = hiredate;
	}
	@Override
	public String toString() {
		return "ProVO [pcode=" + pcode + ", pname=" + pname + ", dept=" + dept + ", title=" + title + ", salary="
				+ salary + ", hiredate=" + hiredate + "]";
	}
	
}
