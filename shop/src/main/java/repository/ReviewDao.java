package repository;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;


public class ReviewDao {
	// selectReviewByGoodsOne
	// 기능 : 그 상품에 관한 리뷰 보여주기
	// 리턴값 : List<Map<String, Object>>
	public List<Map<String, Object>> selectReviewByGoodsOne(Connection conn, int goodsNo) throws Exception {
		// 리턴값 초기화
		List<Map<String, Object>> list = new ArrayList<>();
		// 쿼리
		String sql = "SELECT goods_no goodsNo, goods_name goodsName, customer_id customerId, review_content reviewContent, r.update_date updateDate, star FROM orders INNER JOIN review r USING(order_no) INNER JOIN goods USING(goods_no) WHERE goods_no = ? ORDER BY r.create_date DESC";
		
		// 초기화
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		try {
			stmt = conn.prepareStatement(sql);
			// stmt setter
			stmt.setInt(1, goodsNo);
			// 디버깅
			System.out.println("ReviewDao.java selectReviewByGoodsOne stmt : " + stmt);
			
			// 쿼리실행
			rs = stmt.executeQuery();
			
			while(rs.next()) {
				Map<String, Object> m = new HashMap<String, Object>();
				
				// m setter
				m.put("goodsNo", rs.getInt("goodsNo"));
				m.put("goodsName", rs.getString("goodsName"));
				m.put("customerId", rs.getString("customerId"));
				m.put("reviewContent", rs.getString("reviewContent"));
				m.put("updateDate", rs.getString("updateDate"));
				m.put("star", rs.getInt("star"));
				
				
				// list에 담기
				list.add(m);
			}
		} finally {
			if(rs != null) { rs.close(); }
			if(stmt != null) { stmt.close(); }
		}
		
		return list;
	}
	
	// allCount
	// 기능 : lastPage 구하기 위한 notice 개수파악
	// 리턴값 : int (allCount)
	public int allCount(Connection conn) throws Exception {
		// 리턴값 초기화
		int allCount = 0;
		
		// 쿼리
		String sql = "SELECT COUNT(*) count FROM review";
		
		// 초기화
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		try {
			// 쿼리담기
			stmt = conn.prepareStatement(sql);
			// 디버깅
			System.out.println("ReviewDao.java allCount stmt : " + stmt);
			
			// 쿼리실행
			rs = stmt.executeQuery();
			if(rs.next()) {
				allCount = rs.getInt("count");
				
				// 디버깅
				System.out.println("ReviewDao.java allCount allCount : " + allCount);
			}
		} finally {
			if(rs != null) { rs.close(); }
			if(stmt != null) { stmt.close(); }
		}
			
		return allCount;
	}
	
	// selectReviewListByPage
	// 기능 : 리뷰리스트 보기
	// 리턴값 : List<Map<String, Object>>
	public List<Map<String, Object>> selectReviewListByPage(Connection conn, final int rowPerPage, final int beginRow) throws Exception {
		// 리턴값 초기화
		List<Map<String,Object>> list = new ArrayList<>();
		
		// 쿼리
		String sql = "SELECT goods_no goodsNo, goods_name goodsName, customer_id customerId, review_content reviewContent, r.update_date updateDate, star FROM orders INNER JOIN review r USING(order_no) INNER JOIN goods USING(goods_no) ORDER BY goods_no LIMIT ?, ?";
		
		// 초기화
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		try {
			// 쿼리담기
			stmt = conn.prepareStatement(sql);
			// stmt setter
			stmt.setInt(1, beginRow);
			stmt.setInt(2, rowPerPage);
			// 디버깅
			System.out.println("ReviewDao.java selectReviewListByPage stmt : " + stmt);
			
			// 쿼리실행
			rs = stmt.executeQuery();
			
			while(rs.next()) {
				Map<String, Object> m = new HashMap<>();
				
				// m setter
				m.put("goodsNo", rs.getInt("goodsNo"));
				m.put("goodsName", rs.getString("goodsName"));
				m.put("customerId", rs.getString("customerId"));
				m.put("reviewContent", rs.getString("reviewContent"));
				m.put("updateDate", rs.getString("updateDate"));
				m.put("star", rs.getInt("star"));
				
				// list에 담기
				list.add(m);
				
				// 디버깅
				System.out.println("NoticeDao.java selectNoticeListByPage list<Notice> : " + list.toString());
			}
		} finally {
			if(rs != null) { rs.close(); }
			if(stmt != null) { stmt.close(); }
		}
		
		return list;
	}
}
