package model;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

public class EnrollDAO {
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
	DecimalFormat df = new DecimalFormat("#,###원");
	
	//특정강좌의 특정학생의 점수수정
	public void update(String lcode, String scode, int grade) {
		try {
			String sql="update enrollments set grade=? where lcode=? and scode=?";
			PreparedStatement ps=Database.CON.prepareStatement(sql);
			ps.setInt(1,  grade);
			ps.setString(2,  lcode);
			ps.setString(3,  scode);
			ps.execute();
		}catch(Exception e){
			System.out.println("점수수정" +e.toString());
		}
	}
	
	//특정 강좌의 학생목록 
	public JSONArray slist(String lcode) {
		JSONArray array  = new JSONArray();
		try {
			String sql="select * from enroll_stu_info where lcode=?";
			PreparedStatement ps= Database.CON.prepareStatement(sql);
			ps.setString(1,  lcode);
			ResultSet rs=ps.executeQuery();
			while(rs.next()) {
				JSONObject obj=new JSONObject();
				obj.put("scode", rs.getString("scode"));
				obj.put("sname", rs.getString("sname"));
				obj.put("dept", rs.getString("dept"));
				obj.put("year", rs.getString("year"));
				String edate=sdf.format(rs.getDate("edate"));
				obj.put("edate", edate);
				obj.put("grade", rs.getString("grade"));
				array.add(obj);
			}
		}catch(Exception e){
			System.out.println("학생목록" +e.toString());
		}
		return array;
	}
	
	//수강취소
		public void delete(String lcode, String scode) {
			try {
				String sql="delete from enrollments where lcode=? and scode=?";
				PreparedStatement ps = Database.CON.prepareStatement(sql);
				ps.setString(1,  lcode);
				ps.setString(2,  scode);
				ps.execute();
				
				sql="update courses set persons=persons-1 where lcode=?";
				ps=Database.CON.prepareStatement(sql);
				ps.setString(1, lcode);
				ps.execute();
			}catch(Exception e){
				System.out.println("수강취소"+e.toString());
			}
		}
	
	//수강신청
	public void insert(String lcode, String scode) {
		try {
			String sql="insert into enrollments(lcode,scode) values(?,?)";
			PreparedStatement ps = Database.CON.prepareStatement(sql);
			ps.setString(1,  lcode);
			ps.setString(2,  scode);
			ps.execute();
			
			sql="update courses set persons=persons+1 where lcode=?";
			ps=Database.CON.prepareStatement(sql);
			ps.setString(1, lcode);
			ps.execute();
		}catch(Exception e){
			System.out.println("수강신청"+e.toString());
		}
	}
	
	//중복체크
	public int check(String lcode, String scode) {
		int count=0;
		try {
			String sql="select count(*) from enrollments where lcode=? and scode=?";
			PreparedStatement ps = Database.CON.prepareStatement(sql);
			ps.setString(1,  lcode);
			ps.setString(2,  scode);
			ResultSet rs=ps.executeQuery();
			if(rs.next()) count=rs.getInt("count(*)");
		}catch(Exception e){
			System.out.println("중복체크" +e.toString());
		}
		return count;
	}
	
	//강좌목록
	public JSONArray alist(){
		JSONArray array = new JSONArray();
		try {
			String sql="select * from cou";
			PreparedStatement ps=Database.CON.prepareStatement(sql);
			ResultSet rs=ps.executeQuery();
			while(rs.next()) {
				JSONObject obj = new JSONObject();
				obj.put("lcode", rs.getString("lcode"));
				obj.put("lname", rs.getString("lname"));
				obj.put("pname", rs.getString("pname"));
				obj.put("capacity", rs.getInt("capacity"));
				obj.put("persons", rs.getInt("persons"));
				array.add(obj);
			}
		}catch(Exception e){
			System.out.println("강좌목록" +e.toString());
		}
		return array;
	}
	
	//특정 학생의 수강신청 목록
	public JSONArray clist(String scode) {
		JSONArray array = new JSONArray();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		try {
			String sql="select * from enroll_cou_info where scode=?";
			PreparedStatement ps=Database.CON.prepareStatement(sql);
			ps.setString(1, scode);
			ResultSet rs=ps.executeQuery();
			while(rs.next()) {
				JSONObject obj=new JSONObject();
				obj.put("lcode", rs.getString("lcode"));
				obj.put("lname", rs.getString("lname"));
				obj.put("pname", rs.getString("pname"));
				obj.put("room", rs.getString("room"));
				obj.put("hours", rs.getString("hours"));
				obj.put("capacity", rs.getInt("capacity"));
				obj.put("persons", rs.getInt("persons"));
				String edate=sdf.format(rs.getDate("edate"));
				obj.put("edate", edate);
				array.add(obj);
			}
		}catch(Exception e){
			System.out.println("강좌목록" +e.toString());
		}
		return array;
	}
}
