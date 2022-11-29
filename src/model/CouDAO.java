package model;

import java.sql.CallableStatement;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

public class CouDAO {
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
	DecimalFormat df = new DecimalFormat("#,###¿ø");
	
	//°­ÁÂµî·Ï
			public void insert(CouVO vo) {
				try {
					String sql="insert into courses(lcode, lname, hours, capacity, instructor, room) values(?,?,?,?,?,?)";
					PreparedStatement ps =Database.CON.prepareStatement(sql);
					ps.setString(1,  vo.getLcode());
					ps.setString(2, vo.getLname());
					ps.setInt(3, vo.getHours());
					ps.setInt(4, vo.getCapacity());
					ps.setString(5, vo.getInstructor());
					ps.setString(6, vo.getRoom());
					ps.execute();
				}catch(Exception e){
					System.out.println("°­ÁÂµî·Ï" +e.toString());
				}
				
			}
		
	//»õ°­ÁÂÄÚµå
			public String getCode() {
				String code="";
				try {
					String sql="select max(lcode) code from courses";
					PreparedStatement ps =Database.CON.prepareStatement(sql);
					ResultSet rs=ps.executeQuery();
					if(rs.next()) {
						String scode=rs.getString("code");
						scode=scode.substring(1);
						int icode=Integer.parseInt(scode) +1;
						code="N" +icode;
					}
				}catch(Exception e){
					System.out.println("»õ °­ÁÂ ÄÚµå" +e.toString());
				}
				return code;
			}
	
	//°­ÁÂÁ¤º¸
	public CouVO read(String lcode) {
		CouVO vo = new CouVO();
		try {
			String sql="select * from cou where lcode=?";
			PreparedStatement ps = Database.CON.prepareStatement(sql);
			ps.setString(1, lcode);
			ResultSet rs=ps.executeQuery();
			if(rs.next()) {
				vo.setLcode(rs.getString("lcode"));
				vo.setLname(rs.getString("lname"));
				vo.setRoom(rs.getString("room"));
				vo.setCapacity(rs.getInt("Capacity"));
				vo.setPersons(rs.getInt("persons"));
				vo.setHours(rs.getInt("hours"));
				vo.setInstructor(rs.getString("instructor"));
				vo.setPname(rs.getString("pname"));
				vo.setDept(rs.getString("dept"));
			}
		}catch(Exception e){
			System.out.println("°­ÁÂÁ¤º¸" +e.toString());
		}
		return vo;
	}
	
	//°­ÁÂ¸ñ·Ï
		public JSONObject list(SqlVO vo) {
			JSONObject object = new JSONObject();
			try {
				String sql="call list('cou',?,?,?,?,?,?)";
				CallableStatement cs=Database.CON.prepareCall(sql);
				cs.setString(1,  vo.getKey());
				cs.setString(2,  vo.getWord());
				cs.setString(3,  vo.getOrder());
				cs.setString(4,  vo.getDesc());
				cs.setInt(5,  vo.getPage());
				cs.setInt(6,  vo.getPer());
				cs.execute();
				ResultSet rs=cs.getResultSet();
				JSONArray jArray = new JSONArray();
				while(rs.next()) {
					JSONObject obj=new JSONObject();
					obj.put("lcode", rs.getString("lcode"));
					obj.put("lname", rs.getString("lname"));
					obj.put("hours", rs.getString("hours"));
					obj.put("room", rs.getString("room"));
					obj.put("instructor", rs.getString("instructor"));
					obj.put("capacity", rs.getString("capacity"));
					obj.put("persons", rs.getString("persons"));
					obj.put("pname", rs.getString("pname"));
					obj.put("dept", rs.getString("dept"));
					jArray.add(obj);
				}
				object.put("array", jArray);
				
				cs.getMoreResults();
				rs=cs.getResultSet();
				int total =0;
				if(rs.next()) total=rs.getInt("total");
				object.put("total", total);
				
				int last=total%vo.getPer()==0 ? total/vo.getPer():
				total/vo.getPer()+1;
				object.put("last", last);
			}catch(Exception e){
				System.out.println("ÇÐ»ý¸ñ·Ï234" +e.toString());
			}
			return object;
		}
}
