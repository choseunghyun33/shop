package repository;

import java.sql.Connection;
import java.sql.PreparedStatement;

import vo.Cart;

public class CartDao {
	// insertCart
	// 기능 : 카트에 담기
	// 리턴값 : int (1 - 성공, 0 - 실패)
	public int insertCart(Connection conn, Cart cart) throws Exception {
		// 리턴값 초기화
		int row = 0;
		
		// 쿼리
		String sql = "INSERT INTO CART (goods_no, customer_id, cart_quantity, update_date, create_date) VALUES (?, ?, ?, NOW(), NOW())";
		
		// stmt 초기화
		PreparedStatement stmt = null;
		
		try {
			// 쿼리 담기
			stmt = conn.prepareStatement(sql);
			// stmt setter
			stmt.setInt(1, cart.getGoodsNo());
			stmt.setString(2, cart.getCustomerId());
			stmt.setInt(3, cart.getCartQuantity());
			
			// 디버깅
			System.out.println("CartDao.java insertCart stmt : " + stmt);
			
			// 쿼리 실행
			row = stmt.executeUpdate();
		} finally {
			// stmt close
			if(stmt != null) { stmt.close(); }
		}
		
		
		return row;
	}
}
