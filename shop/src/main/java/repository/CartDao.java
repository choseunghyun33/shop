package repository;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import vo.Cart;

public class CartDao {
	// updateCartQuantity
	// 기능 : 카트 상품개수 변경
	// 리턴값 : void 
	public List<Integer> updateCartQuantity(Connection conn, List<Cart> cartList) throws Exception {
		// 리턴값 초기화
		List<Integer> list = new ArrayList<>();
		
		// 쿼리
		String sql = "UPDATE cart SET cart_quantity = ? WHERE goods_no = ? AND customer_id = ?";
		
		// stmt 초기화
		PreparedStatement stmt = null;
		
		for(Cart c : cartList) {
			try {
				// 쿼리 담기
				stmt = conn.prepareStatement(sql);
				// stmt setter
				stmt.setInt(1, c.getCartQuantity());
				stmt.setInt(2, c.getGoodsNo());
				stmt.setString(3, c.getCustomerId());
				
				// 디버깅
				System.out.println("CartDao.java deleteCartById stmt : " + stmt);
				
				// 쿼리 실행
				int row = stmt.executeUpdate();

				list.add(row);
			} finally {
				// stmt close
				if(stmt != null) { stmt.close(); }
			}	
		}
		
		return list;
	}
		
	// updateCartQuantityPlus
	// 기능 : 카트에 존재하는데 또 카트에 담을 경우 개수 증가시키기
	// 리턴값 : int 
	public int updateCartQuantityPlus(Connection conn, Cart cart) throws Exception {
		// 리턴값 초기화
		int row = 0;
		
		// 쿼리
		String sql = "UPDATE cart SET cart_quantity = cart_quantity + 1 WHERE goods_no = ? AND customer_id = ?";
		
		// stmt
		PreparedStatement stmt = null;
		
		try {
			// 쿼리 담기
			stmt = conn.prepareStatement(sql);
			// stmt setter
			stmt.setInt(1, cart.getGoodsNo());
			stmt.setString(2, cart.getCustomerId());
			
			// 디버깅
			System.out.println("CartDao.java updateCartQuantityPlus stmt : " + stmt);
			
			// 쿼리 실행
			row = stmt.executeUpdate();
			
		} finally {
			// stmt close
			if(stmt != null) { stmt.close(); }
		}	
		
		return row;
	}
	
	// selectIsCart
	// 기능 : 카트품목 조회
	// 리턴값 : int 
	public int selectIsCart(Connection conn, Cart cart) throws Exception {
		// 리턴값 초기화
		int goodsNo = 0;
		
		// 쿼리
		String sql = "SELECT goods_no goodsNo FROM cart WHERE goods_no = ? AND customer_id = ?";
		
		// stmt, rs 초기화
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		try {
			// 쿼리담기
			stmt = conn.prepareStatement(sql);
			// stmt setter
			stmt.setInt(1, cart.getGoodsNo());
			stmt.setString(2, cart.getCustomerId());
	
			// 쿼리실행
			rs = stmt.executeQuery();
			// 조건문(쿼리가 실행될 것이 있으면 진행하기)
			if(rs.next()) {
				goodsNo = rs.getInt("goodsNo");
			}
		} finally {
			// rs, stmt 닫기
			if(rs != null) { rs.close(); }
			if(stmt != null) { stmt.close(); }
		}
		
		return goodsNo;
	}
	
	
	// deleteCartById
	// 기능 : 카트품목 삭제
	// 리턴값 : int 
	public List<Integer> deleteCartById(Connection conn, List<Cart> cartList) throws Exception {
		// 리턴값 초기화
		List<Integer> list = new ArrayList<>();
		
		// 쿼리
		String sql = "DELETE FROM cart WHERE customer_id = ? AND goods_no = ?";
		
		// stmt 초기화
		PreparedStatement stmt = null;
		
		for(Cart c : cartList) {
			try {
				// 쿼리 담기
				stmt = conn.prepareStatement(sql);
				// stmt setter
				stmt.setString(1, c.getCustomerId());
				stmt.setInt(2, c.getGoodsNo());
				
				// 디버깅
				System.out.println("CartDao.java deleteCartById stmt : " + stmt);
				
				// 쿼리 실행
				int row = stmt.executeUpdate();
				
				list.add(row);
				
			} finally {
				// stmt close
				if(stmt != null) { stmt.close(); }
			}	
		}
		
			
		
		return list;
	}
	
	// selectCartById
	// 기능 : 카트리스트 보기
	// 리턴값 : List 
	public List<Map<String, Object>> selectCartById(Connection conn, Cart cart) throws Exception {
		// 리턴값 초기화
		List<Map<String, Object>> list = new ArrayList<>();
		
		// 쿼리
		String sql = "SELECT goods_no goodsNo, cart_quantity cartQuantity, goods_name goodsName, goods_price goodsPrice, filename FROM cart INNER JOIN goods USING(goods_no) INNER JOIN goods_img USING(goods_no) WHERE customer_id = ?";
		
		// stmt, rs 초기화
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		try {
			// 쿼리 담기
			stmt = conn.prepareStatement(sql);
			// stmt setter
			stmt.setString(1, cart.getCustomerId());
			
			// 디버깅
			System.out.println("CartDao.java selectCartById stmt : " + stmt);
			
			// 쿼리 실행
			rs = stmt.executeQuery();
			
			// map에 담기
			while(rs.next()) {
				Map<String, Object> m = new HashMap<>();

				m.put("goodsNo", rs.getInt("goodsNo"));
				m.put("cartQuantity", rs.getInt("cartQuantity"));
				m.put("goodsName", rs.getString("goodsName"));
				m.put("goodsPrice", rs.getString("goodsPrice"));
				m.put("filename", rs.getString("filename"));
				
				list.add(m);
			}
		} finally {
			// rs stmt close
			if(rs != null) { rs.close(); }
			if(stmt != null) { stmt.close(); }
		}
		
		return list;
	}
	
	// insertCart
	// 기능 : 카트에 담기
	// 리턴값 : int (1 - 성공, 0 - 실패)
	public int insertCart(Connection conn, Cart cart) throws Exception {
		// 리턴값 초기화
		int row = 0;
		
		// 쿼리
		String sql = "INSERT INTO cart (goods_no, customer_id, cart_quantity, update_date, create_date) VALUES (?, ?, ?, NOW(), NOW())";
		
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
