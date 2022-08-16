package repository;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.HashMap;
import java.util.Map;

public class StatisticsDao {
	// 누적구매수 누적조회수
	public Map<String,Object> selectCount(Connection conn) throws Exception {
		Map<String, Object> m = null;
		
		// 쿼리
		String sql = "SELECT SUM(order_quantity) sum, SUM(hit) hit FROM orders INNER JOIN goods USING(goods_no)";
		
		// 초기화
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		try {
			stmt = conn.prepareStatement(sql);
			rs = stmt.executeQuery();
			if(rs.next()) {
				m = new HashMap<String, Object>();
				m.put("sum", rs.getString("sum"));
				m.put("hit", rs.getInt("hit"));
			}
		} finally {
			if(rs != null) { rs.close(); }
			if(stmt != null) { stmt.close(); }
		}
		
		return m;
	}
}
