package repository;

import java.sql.*;

public class SignDao {
	// 아이디확인
	public String idCheck(Connection conn, String id) throws Exception {
		String ckId = null;
		String sql = "SELECT t.id FROM (SELECT customer_id id FROM customer UNION SELECT employee_id id FROM employee UNION SELECT out_id id FROM outid) t WHERE t.id = ?";
		/*
			SELECT t.id
			FROM (SELECT customer_id id FROM customer
				  UNION
				  SELECT employee_id id FROM employee
				  UNION
				  SELECT out_id id FROM outid) t
			WHERE t.id = ?
			
			--> null일때 사용가능한 아이디
		 */
		
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		try {
			stmt = conn.prepareStatement(sql);
			// stmt setter
			stmt.setString(1, id);
			// 디버깅
			System.out.println("SignDao.java idCheck stmt : " + stmt);
			rs = stmt.executeQuery();
			if(rs.next()) {
				ckId = rs.getString("t.id");
			}
		} finally {
			if(rs != null) {rs.close();}
			if(stmt != null) {stmt.close();}
		}
		
		return ckId;
	}
}
