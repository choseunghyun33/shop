package repository;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import vo.Review;


public class ReviewDao {
	// deleteReviewByOrderNo
	// 기능 : 리뷰 삭제 
	// 리턴값 : int
	public int deleteReviewByOrderNo(Connection conn, int orderNo) throws Exception {
		// 리턴값 초기화
		int row = 0;
		
		// 쿼리
		String sql = "DELETE FROM review WHERE order_no = ?";
		
		// 초기화
		PreparedStatement stmt = null;
		
		try {
			stmt = conn.prepareStatement(sql);
			// stmt setter
			stmt.setInt(1, orderNo);
			// 디버깅
			System.out.println("ReviewDao.java insertReview stmt : " + stmt);
			
			// 쿼리실행
			row = stmt.executeUpdate();
		} finally {
			// stmt 닫기
			if(stmt != null) { stmt.close(); }
		}
		return row;
	}
	
	// updateReviewByOrderNo
	// 기능 : 리뷰 수정 
	// 리턴값 : int
	public int updateReviewByOrderNo(Connection conn, Review review) throws Exception {
		// 리턴값 초기화
		int row = 0;
		
		// 쿼리
		String sql = "UPDATE review SET review_content = ?, update_date = NOW(), star = ? WHERE order_no = ?";
		
		// 초기화
		PreparedStatement stmt = null;
		
		try {
			stmt = conn.prepareStatement(sql);
			// stmt setter
			stmt.setString(1, review.getReviewContent());
			stmt.setInt(2, review.getStar());
			stmt.setInt(3, review.getOrderNo());
			// 디버깅
			System.out.println("ReviewDao.java insertReview stmt : " + stmt);
			
			// 쿼리실행
			row = stmt.executeUpdate();
		} finally {
			// stmt 닫기
			if(stmt != null) { stmt.close(); }
		}
		return row;
	}
	
	// selectReviewByOrderNo
	// 기능 : 리뷰 하나 보여주기
	// 리턴값 : Review
	public Review selectReviewByOrderNo(Connection conn, int orderNo) throws Exception {
		// 리턴값 초기화
		Review review = null;
		// 쿼리
		String sql = "SELECT order_no orderNo, review_content reviewContent, create_date createDate, update_date updateDate, star FROM review WHERE order_no = ?";
		
		// 초기화
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		try {
			stmt = conn.prepareStatement(sql);
			// stmt setter
			stmt.setInt(1, orderNo);
			// 디버깅
			System.out.println("ReviewDao.java selectReviewByOrderNo stmt : " + stmt);
			
			// 쿼리실행
			rs = stmt.executeQuery();
			
			if(rs.next()) {
				review = new Review();
				
				// review setter
				review.setOrderNo(rs.getInt("orderNo"));
				review.setReviewContent(rs.getString("reviewContent"));
				review.setCreateDate(rs.getString("createDate"));
				review.setUpdateDate(rs.getString("updateDate"));
				review.setStar(rs.getInt("star"));
				
				// 디버깅
				System.out.println("ReviewDao.java selectReviewByOrderNo review : " + review.toString());
			}
		} finally {
			if(rs != null) { rs.close(); }
			if(stmt != null) { stmt.close(); }
		}
		
		return review;
	}
	
	
	// insertReview
	// 기능 : 리뷰쓰기
	// 리턴값 : int
	public int insertReview(Connection conn, Review review) throws Exception {
		// 리턴값 초기화
		int row = 0;
		
		// 쿼리
		String sql = "INSERT INTO review (order_no, review_content, update_date, create_date, star) VALUES (?, ?, NOW(), NOW(), ?)";
		
		// 초기화
		PreparedStatement stmt = null;
		
		try {
			stmt = conn.prepareStatement(sql);
			// stmt setter
			stmt.setInt(1, review.getOrderNo());
			stmt.setString(2, review.getReviewContent());
			stmt.setInt(3, review.getStar());
			// 디버깅
			System.out.println("ReviewDao.java insertReview stmt : " + stmt);
			
			// 쿼리실행
			row = stmt.executeUpdate();
		} finally {
			// stmt 닫기
			if(stmt != null) { stmt.close(); }
		}
		return row;
	}
	
	// selectAvailableRewiew
	// 기능 : 해당 주문번호에 관한 리뷰가 있는가 없는가
	// 리턴값 : String
	public String selectAvailableReview(Connection conn, int orderNo) throws Exception {
		// 리턴값 초기화
		String result = null;
		// 쿼리
		String sql = "SELECT order_no orderNo FROM review WHERE order_no = ?";
		// 만약 쿼리의 값이 있다면 리뷰가 이미 있기 때문에 또 쓸 수 없다.
		
		// 초기화
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		try {
			stmt = conn.prepareStatement(sql);
			// stmt setter
			stmt.setInt(1, orderNo);
			// 디버깅
			System.out.println("ReviewDao.java selectAvailableRewiew stmt : " + stmt);
			
			// 쿼리실행
			rs = stmt.executeQuery();
			
			if(rs.next()) {
				result = rs.getString("orderNo");
				// null 이라면 리뷰 없음
			}
		} finally {
			if(rs != null) { rs.close(); }
			if(stmt != null) { stmt.close(); }
		}
		
		
		return result;
	}
	
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
		String sql = "SELECT order_no orderNo, goods_no goodsNo, goods_name goodsName, customer_id customerId, review_content reviewContent, r.update_date updateDate, star, filename FROM orders INNER JOIN review r USING(order_no) INNER JOIN goods USING(goods_no) INNER JOIN goods_img USING(goods_no) ORDER BY goods_no LIMIT ?, ?";
		
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
				m.put("orderNo", rs.getInt("orderNo"));
				m.put("goodsNo", rs.getInt("goodsNo"));
				m.put("goodsName", rs.getString("goodsName"));
				m.put("customerId", rs.getString("customerId"));
				m.put("reviewContent", rs.getString("reviewContent"));
				m.put("updateDate", rs.getString("updateDate"));
				m.put("star", rs.getInt("star"));
				m.put("filename", rs.getString("filename"));
				
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
