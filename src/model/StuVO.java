package model;

public class StuVO extends ProVO {
	private String sname;
	private String scode;
	private String year;
	private String birthday; 
	private String dept;
	private String advisor;
	public String getSname() {
		return sname;
	}
	public void setSname(String sname) {
		this.sname = sname;
	}
	public String getScode() {
		return scode;
	}
	public void setScode(String scode) {
		this.scode = scode;
	}
	public String getYear() {
		return year;
	}
	public void setYear(String year) {
		this.year = year;
	}
	public String getBirthday() {
		return birthday;
	}
	public void setBirthday(String birthday) {
		this.birthday = birthday;
	}
	public String getDept() {
		return dept;
	}
	public void setDept(String dept) {
		this.dept = dept;
	}
	public String getAdvisor() {
		return advisor;
	}
	public void setAdvisor(String advisor) {
		this.advisor = advisor;
	}
	@Override
	public String toString() {
		return "StuVO [sname=" + sname + ", scode=" + scode + ", year=" + year + ", birthday=" + birthday + ", dept="
				+ dept + ", advisor=" + advisor + "]";
	}
	
}
