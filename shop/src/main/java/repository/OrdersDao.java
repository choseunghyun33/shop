package repository;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import vo.Orders;


public class OrdersDao {
	
	///////////////////////////////////////////////////////////////////////////////////////////////////// insertOrders
	// 기능 : 주문 넣기
	// 리턴값 : int (1 - 성공 / 0 - 실패)
	public int insertOrders(Connection conn, Orders orders) throws Exception {
		// 리턴값 초기화
		int row = 0;
		
		// 쿼리
		String sql = "INSERT INTO orders (goods_no, customer_id, order_quantity, order_price, order_addr, update_date, create_date) VALUES (?,?,?,?,?,NOW(),NOW())";
		
		// stmt 초기화
		PreparedStatement stmt = null;
		
		try {
			stmt = conn.prepareStatement(sql);
			// stmt setter
			stmt.setInt(1, orders.getGoodsNo());
			stmt.setString(2, orders.getCustomerId());
			stmt.setInt(3, orders.getOrderQuantity());
			stmt.setInt(4, orders.getOrderPrice());
			stmt.setString(5, orders.getOrderAddr());
			// 디버깅
			System.out.println("OrdersDao.java insertOrders stmt : " + stmt);
			
			// 쿼리 실행
			row = stmt.executeUpdate();
		} finally {
			// stmt close
			if(stmt != null) { stmt.close(); }
		}
			
		return row;
	}
	
	
	///////////////////////////////////////////////////////////////////////////////////////////////////// updateOrdersByOrders	
	public int updateOrdersByOrders(Connection conn, Orders orders) throws Exception {
		int row = 0;
		String sql = "UPDATE orders SET order_state = ?, order_price = ?, order_quantity = ?, order_addr = ?, update_date = NOW() WHERE order_no = ?";
		
		// stmt 초기화
		PreparedStatement stmt = null;
		
		try {
			stmt = conn.prepareStatement(sql);
			// stmt setter
			stmt.setString(1, orders.getOrderState());
			stmt.setInt(2, orders.getOrderPrice());
			stmt.setInt(3, orders.getOrderQuantity());
			stmt.setString(4, orders.getOrderAddr());
			stmt.setInt(5, orders.getOrderNo());
			// 디버깅
			System.out.println("OrdersDao.java updateOrdersByOrders stmt : " + stmt);
			
			// 쿼리 실행
			row = stmt.executeUpdate();
		} finally {
			if(stmt != null) { stmt.close(); }
		}
		
		return row;
	}

	///////////////////////////////////////////////////////////////////////////////////////////////////// updateOrderStateByOrderNo	
	public int updateOrderStateByOrderNo(Connection conn, String orderState, int orderNo) throws Exception {
		int row = 0;
		String sql = "UPDATE orders SET order_state = ?, update_date = NOW() WHERE order_no = ?";
		
		// stmt 초기화
		PreparedStatement stmt = null;
		
		try {
			stmt = conn.prepareStatement(sql);
			// stmt setter
			stmt.setString(1, orderState);
			stmt.setInt(2, orderNo);
			// 디버깅
			System.out.println("OrdersDao.java updateOrderStateByOrderNo stmt : " + stmt);
			
			// 쿼리 실행
			row = stmt.executeUpdate();
		} finally {
			if(stmt != null) { stmt.close(); }
		}
		
		return row;
	}
	
	///////////////////////////////////////////////////////////////////////////////////////////////////// allCount	
	// 개인 마지막페이지 구할 총 count
	public int allCountById(Connection conn, String customerId) throws Exception {
		int allCount = 0;
		String sql = "SELECT COUNT(*) allCount FROM orders WHERE customer_id = ?";
		
		// stmt, rs 초기화
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		try {
			stmt = conn.prepareStatement(sql);
			// stmt setter
			stmt.setString(1, customerId);
			
			// 디버깅
			System.out.println("OrdersDao.java allCount stmt : " + stmt);
			rs = stmt.executeQuery();
			if(rs.next()) {
				allCount = rs.getInt("allCount");
			}
		} finally {
			if(rs != null) { rs.close(); }
			if(stmt != null) { stmt.close(); }
		}
		
		return allCount;
	}
	
	///////////////////////////////////////////////////////////////////////////////////////////////////// allCount	
	// 마지막페이지 구할 총 count
	public int allCount(Connection conn) throws Exception {
		int allCount = 0;
		String sql = "SELECT COUNT(*) allCount FROM orders";
		
		// stmt, rs 초기화
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		try {
			stmt = conn.prepareStatement(sql);
			// 디버깅
			System.out.println("OrdersDao.java allCount stmt : " + stmt);
			rs = stmt.executeQuery();
			if(rs.next()) {
				allCount = rs.getInt("allCount");
			}
		} finally {
			if(rs != null) { rs.close(); }
			if(stmt != null) { stmt.close(); }
		}
		
		return allCount;
	}

	///////////////////////////////////////////////////////////////////////////////////////////////////// selectOrdersOne	
	// 5-2 주문 상세 보기
	public Map<String, Object> selectOrdersOne(Connection conn, int orderNo) throws Exception{
		Map<String, Object> map = null;
		/*
			SELECT FROM orders o INNER JOIN goods g ON o.goods_no = g.goods_no INNER JOIN customer c ON o.customer_id = c.customer_id WHERE o.order_no = ?  
		 */
		
		String sql = "SELECT o.order_no orderNo, o.goods_no goodsNo, o.customer_id customerId, o.order_quantity orderQuantity, o.order_price orderPrice, o.order_addr orderAddr, o.order_state orderState, o.update_date updateDate, o.create_date createDate, g.goods_name goodsName, c.customer_name customerName, c.customer_telephone customerTelephone FROM orders o INNER JOIN goods g ON o.goods_no = g.goods_no LEFT JOIN customer c ON o.customer_id = c.customer_id WHERE o.order_no = ?";
		
		// stmt, rs 초기화
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		try {
			stmt = conn.prepareStatement(sql);
			// stmt setter
			stmt.setInt(1, orderNo);
			// 디버깅
			System.out.println("OrdersDao.java selectOrdersListByCustomer stmt : " + stmt);
			
			// 쿼리 실행
			rs = stmt.executeQuery();
			if(rs.next()) {
				map = new HashMap<>();
				map.put("orderNo", rs.getInt("orderNo"));
				map.put("goodsNo", rs.getInt("goodsNo"));
				map.put("customerId", rs.getString("customerId"));
				map.put("orderQuantity", rs.getInt("orderQuantity"));
				map.put("orderPrice", rs.getInt("orderPrice"));
				map.put("orderAddr", rs.getString("orderAddr"));
				map.put("orderState", rs.getString("orderState"));
				map.put("updateDate", rs.getString("updateDate"));
				map.put("createDate", rs.getString("createDate"));
				map.put("goodsName", rs.getString("goodsName"));
				map.put("customerName", rs.getString("customerName"));
				map.put("customerTelephone", rs.getString("customerTelephone"));
				// 디버깅
				System.out.println("OrdersDao.java selectOrdersListByCustomer map : " + map.toString());
			}
		} finally {
			if(rs != null) { rs.close(); }
			if(stmt != null) { stmt.close(); }
		}
		
		
		return map;
	}
	
	///////////////////////////////////////////////////////////////////////////////////////////////////// selectOrdersList	
	// 5-1 전체 주문 목록
	public List<Map<String, Object>> selectOrdersList(Connection conn, final int rowPerPage, final int beginRow) throws Exception{
		List<Map<String, Object>> list = new ArrayList<>(); // 다형성
		/*
		 	SELECT  FROM orders o INNER JOIN goods g ON o.goods_no = g.goods_no ORDER BY create_date DESC LIMIT ?,?
		 */
		
		String sql = "SELECT o.order_no orderNo, o.goods_no goodsNo, o.customer_id customerId, o.order_quantity orderQuantity, o.order_price orderPrice, o.order_addr orderAddr, o.order_state orderState, o.update_date updateDate, o.create_date createDate, g.goods_name goodsName FROM orders o INNER JOIN goods g ON o.goods_no = g.goods_no ORDER BY o.create_date DESC LIMIT ?,?";
		
		// stmt, rs 초기화
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		try {
			stmt = conn.prepareStatement(sql);
			// stmt setter
			stmt.setInt(1, beginRow);
			stmt.setInt(2, rowPerPage);
			// 디버깅
			System.out.println("OrdersDao.java selectOrdersList stmt : " + stmt);
			
			// 쿼리 실행
			rs = stmt.executeQuery();
			while(rs.next()) {
				Map<String,Object> map = new HashMap<>();
				map.put("orderNo", rs.getInt("orderNo"));
				map.put("goodsNo", rs.getInt("goodsNo"));
				map.put("customerId", rs.getString("customerId"));
				map.put("orderQuantity", rs.getInt("orderQuantity"));
				map.put("orderPrice", rs.getInt("orderPrice"));
				map.put("orderAddr", rs.getString("orderAddr"));
				map.put("orderState", rs.getString("orderState"));
				map.put("updateDate", rs.getString("updateDate"));
				map.put("createDate", rs.getString("createDate"));
				map.put("goodsName", rs.getString("goodsName"));
				// 리스트에 담기
				list.add(map);
			}
			// 디버깅
			System.out.println("OrdersDao.java selectOrdersList list : " + list.toString());
		} finally {
			if(rs != null) { rs.close(); }
			if(stmt != null) { stmt.close(); }
		}
		
		return list;
	}
	
	
	///////////////////////////////////////////////////////////////////////////////////////////////////// selectOrdersListByCustomer		
	// 2-1 고객 한명의 주문 목록 - 관리자/고객 페이지
	public List<Map<String, Object>> selectOrdersListByCustomer(Connection conn, String customerId, final int rowPerPage, final int beginRow) throws Exception {
		List<Map<String, Object>> list = new ArrayList<>(); // 다형성
		/*
		 	SELECT  FROM orders o INNER JOIN goods g ON o.goods_no = g.goods_no WHERE customer_id = ? ORDER BY create_date DESC LIMIT ?,?
		 */
		
		String sql = "SELECT o.order_no orderNo, o.goods_no goodsNo, o.customer_id customerId, o.order_quantity orderQuantity, o.order_price orderPrice, o.order_addr orderAddr, o.order_state orderState, o.update_date updateDate, o.create_date createDate, g.goods_name goodsName FROM orders o INNER JOIN goods g ON o.goods_no = g.goods_no WHERE customer_id = ? ORDER BY o.create_date DESC LIMIT ?,?";
		
		// stmt, rs 초기화
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		try {
			stmt = conn.prepareStatement(sql);
			// stmt setter
			stmt.setString(1, customerId);
			stmt.setInt(2, beginRow);
			stmt.setInt(3, rowPerPage);
			// 디버깅
			System.out.println("OrdersDao.java selectOrdersListByCustomer stmt : " + stmt);
			
			// 쿼리 실행
			rs = stmt.executeQuery();
			while(rs.next()) {
				Map<String,Object> map = new HashMap<>();
				map.put("orderNo", rs.getInt("orderNo"));
				map.put("goodsNo", rs.getInt("goodsNo"));
				map.put("orderQuantity", rs.getInt("orderQuantity"));
				map.put("orderPrice", rs.getInt("orderPrice"));
				map.put("orderAddr", rs.getString("orderAddr"));
				map.put("orderState", rs.getString("orderState"));
				map.put("updateDate", rs.getString("updateDate"));
				map.put("createDate", rs.getString("createDate"));
				map.put("goodsName", rs.getString("goodsName"));
				// 리스트에 담기
				list.add(map);
			}
			// 디버깅
			System.out.println("OrdersDao.java selectOrdersListByCustomer list : " + list.toString());
		} finally {
			if(rs != null) { rs.close(); }
			if(stmt != null) { stmt.close(); }
		}
		
		return list;
	}
}
