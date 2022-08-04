package repository;

import java.sql.Connection;
import java.sql.PreparedStatement;

public class OutIdDao {
	///////////////////////////////////////////////////////////////////////// 탈퇴회원의 아이디를 입력
	// CustomerService.removeCustomer(Customer paramCustomer)가 호출
	public int insertOutId(Connection conn, String customerId) throws Exception {
		// 동일한 conn 사용해야함
		// conn.close() X
		int row = 0;
		String sql = "INSERT INTO outid (out_id, out_date) VALUES (?, NOW())";
		
		PreparedStatement stmt = conn.prepareStatement(sql);
		// stmt setter
		stmt.setString(1, customerId);
		// 디버깅
		System.out.println("OutIdDao.java stmt : " + stmt);
		// 쿼리실행
		row = stmt.executeUpdate();
		
		return row;
	}
}
