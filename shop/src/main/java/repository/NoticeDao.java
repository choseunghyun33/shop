package repository;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import vo.Notice;

public class NoticeDao {
	// deleteNoticeByNoticeNo
	// 기능 : notice 삭제
	// 리턴값 : int
	public int deleteNoticeByNoticeNo(Connection conn, Notice notice) throws Exception {
		// 리턴값 초기화
		int row = 0;
		
		// 쿼리
		String sql = "DELETE FROM notice WHERE notice_no = ?";
		
		// 초기화
		PreparedStatement stmt = null;
		
		try {
			// 쿼리담기
			stmt = conn.prepareStatement(sql);
			// stmt setter
			stmt.setInt(1, notice.getNoticeNo());
			
			// 디버깅
			System.out.println("NoticeDao.java deleteNoticeByNoticeNo stmt : " + stmt);
			
			// 쿼리실행
			row = stmt.executeUpdate();
		} finally {
			// stmt 닫기
			if(stmt != null) { stmt.close(); }
		}
		
		return row;
	}
	
	// updateNoticeByNoticeNo
	// 기능 : notice 수정
	// 리턴값 : int
	public int updateNoticeByNoticeNo(Connection conn, Notice notice) throws Exception {
		// 리턴값 초기화
		int row = 0;
		
		// 쿼리
		String sql = "UPDATE notice SET notice_title = ?, notice_content = ?, update_date = NOW() WHERE notice_no = ?";
		
		// 초기화
		PreparedStatement stmt = null;
		
		try {
			// 쿼리담기
			stmt = conn.prepareStatement(sql);
			// stmt setter
			stmt.setString(1, notice.getNoticeTitle());
			stmt.setString(2, notice.getNoticeContent());
			stmt.setInt(3, notice.getNoticeNo());
			
			// 디버깅
			System.out.println("NoticeDao.java insertNotice stmt : " + stmt);
			
			// 쿼리실행
			row = stmt.executeUpdate();
		} finally {
			// stmt 닫기
			if(stmt != null) { stmt.close(); }
		}
		
		return row;
	}
	
	// selectNoticeOneByNoticeNo
	// 기능 : noticeOne 보기
	// 리턴값 : Notice
	public Notice selectNoticeOneByNoticeNo(Connection conn, Notice paramNotice) throws Exception {
		// 리턴값 초기화
		Notice notice = null;
		
		// 쿼리
		String sql = "SELECT notice_no noticeNo, notice_title noticeTitle, notice_content noticeContent, update_date updateDate, create_date createDate FROM notice WHERE notice_no = ?";
		
		// 초기화
		PreparedStatement stmt = null;
		ResultSet rs = null;

		try {
			// 쿼리담기
			stmt = conn.prepareStatement(sql);
			// stmt setter
			stmt.setInt(1, paramNotice.getNoticeNo());
			
			// 디버깅
			System.out.println("NoticeDao.java selectNoticeOneByNoticeNo stmt : " + stmt);
			
			// 쿼리실행
			rs = stmt.executeQuery();
			
			if(rs.next()) {
				notice = new Notice();
				
				notice.setNoticeNo(rs.getInt("noticeNo"));
				notice.setNoticeTitle(rs.getString("noticeTitle"));
				notice.setNoticeContent(rs.getString("noticeContent"));
				notice.setUpdateDate(rs.getString("updateDate"));
				notice.setCreateDate(rs.getString("createDate"));
				
				// 디버깅
				System.out.println("NoticeDao.java selectNoticeOneByNoticeNo notice : " + notice.toString());
			}
		} finally {
			if(rs != null) { rs.close(); }
			if(stmt != null) { stmt.close(); }
		}
		
		
		return notice;
	}
	
	// insertNotice
	// 기능 : notice 추가
	// 리턴값 : int (1 - 성공)
	public int insertNotice(Connection conn, Notice notice) throws Exception {
		// 리턴값 초기화
		int row = 0;
		
		// 쿼리
		String sql = "INSERT INTO notice (notice_title, notice_content, update_date, create_date) VALUES (?, ?, NOW(), NOW())";
		
		// 초기화
		PreparedStatement stmt = null;
		
		try {
			// 쿼리담기
			stmt = conn.prepareStatement(sql);
			// stmt setter
			stmt.setString(1, notice.getNoticeTitle());
			stmt.setString(2, notice.getNoticeContent());
			
			// 디버깅
			System.out.println("NoticeDao.java insertNotice stmt : " + stmt);
			
			// 쿼리실행
			row = stmt.executeUpdate();
		} finally {
			// stmt 닫기
			if(stmt != null) { stmt.close(); }
		}
		
		return row;
	}
	
	// selectNoticeListByPage
	// 기능 : noticeList 보기
	// 리턴값 : List<Notice>
	public List<Notice> selectNoticeListByPage(Connection conn, final int rowPerPage, final int beginRow) throws Exception {
		// 리턴값 초기화
		List<Notice> list = new ArrayList<>();
		
		// 쿼리
		String sql = "SELECT notice_no noticeNo, notice_title noticeTitle, notice_content noticeContent, update_date updateDate, create_date createDate FROM notice ORDER BY create_date DESC, notice_no DESC LIMIT ?, ?";
		
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
			System.out.println("NoticeDao.java selectNoticeListByPage stmt : " + stmt);
			
			// 쿼리실행
			rs = stmt.executeQuery();
			
			while(rs.next()) {
				Notice notice = new Notice();
				
				notice.setNoticeNo(rs.getInt("noticeNo"));
				notice.setNoticeTitle(rs.getString("noticeTitle"));
				notice.setNoticeContent(rs.getString("noticeContent"));
				notice.setUpdateDate(rs.getString("updateDate"));
				notice.setCreateDate(rs.getString("createDate"));
				
				// list에 담기
				list.add(notice);
				
				// 디버깅
				System.out.println("NoticeDao.java selectNoticeListByPage list<Notice> : " + list.toString());
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
		String sql = "SELECT COUNT(*) count FROM notice";
		
		// 초기화
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		try {
			// 쿼리담기
			stmt = conn.prepareStatement(sql);
			// 디버깅
			System.out.println("NoticeDao.java allCount stmt : " + stmt);
			
			// 쿼리실행
			rs = stmt.executeQuery();
			if(rs.next()) {
				allCount = rs.getInt("count");
			}
		} finally {
			if(rs != null) { rs.close(); }
			if(stmt != null) { stmt.close(); }
		}
			
		return allCount;
	}
}
