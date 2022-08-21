package repository;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import vo.Cart;

public class BuyDao {
	// selectBuyList
	// 기능 : 주문리스트 보기
	// 리턴값 : List 
	public List<Map<String, Object>> selectBuyListByCart(Connection conn, List<Cart> cartList) throws Exception {
		
		
		// 리턴값 초기화
		List<Map<String, Object>> list = new ArrayList<>();
		
		// 쿼리
		String sql = "SELECT goods_name goodsName, goods_price goodsPrice, goods_no goodsNo, cart_quantity cartQuantity, customer_address customerAddr FROM goods INNER JOIN cart USING(goods_no) INNER JOIN customer USING(customer_id) WHERE customer_id = ? AND goods_no = ?";
		
		// stmt, rs 초기화
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		// 파라미터 해부
		for(Cart cart : cartList) {
			try {
				// 쿼리 담기
				stmt = conn.prepareStatement(sql);
				
				
				// stmt setter
				stmt.setString(1, cart.getCustomerId());
				stmt.setInt(2, cart.getGoodsNo());
			
				// 디버깅
				System.out.println("CartDao.java selectCartById stmt : " + stmt);
				
				// 쿼리 실행
				rs = stmt.executeQuery();
				
				// map에 담기
				if(rs.next()) {
					Map<String, Object> m = new HashMap<>();
					
					m.put("goodsName", rs.getString("goodsName"));
					m.put("goodsPrice", rs.getString("goodsPrice"));
					m.put("goodsNo", rs.getInt("goodsNo"));
					m.put("cartQuantity", rs.getInt("cartQuantity"));
					m.put("customerAddr", rs.getString("customerAddr"));
					
					list.add(m);
					// 디버깅
					System.out.println("CartDao.java selectCartById list : " + list.toString());
				}
			} finally {
				// rs stmt close
				if(rs != null) { rs.close(); }
				if(stmt != null) { stmt.close(); }
			}
		}
		
		
		return list;
	}
}
	
