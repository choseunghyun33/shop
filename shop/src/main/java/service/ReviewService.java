package service;

import java.sql.Connection;
import java.util.List;
import java.util.Map;

import repository.DBUtil;
import repository.ReviewDao;

public class ReviewService {
	// 멤버변수
	private DBUtil dbUtil;
	private ReviewDao reviewDao;
	
	// getReviewByGoodsOne
	// 기능 : 리뷰리스트 보기
	// 리턴값 : List<Map<String, Object>>
	public List<Map<String, Object>> getReviewByGoodsOne(int goodsNo) {
		// 리턴값 초기화
		List<Map<String,Object>> list = null;
		
		// 멤버변수 초기화
		this.dbUtil = new DBUtil();
		this.reviewDao = new ReviewDao();
		
		// conn 초기화
		Connection conn = null;
		
		try {
			conn = this.dbUtil.getConnection();
			// 디버깅
			System.out.println("ReviewService.java getReviewByGoodsOne conn : " + conn);
			
			// 자동커밋해제
			conn.setAutoCommit(false);
			
			list = this.reviewDao.selectReviewByGoodsOne(conn, goodsNo);
			// 디버깅
			System.out.println("ReviewService.java getReviewByGoodsOne list : " + list.toString());
		
			// 실패했을 경우 exception 발생시키기
			if(list.size() < 1) {
				System.out.println("ReviewService.java getReviewByGoodsOne selectReviewListByPage() 실패");
				throw new Exception();
			}
			
			// 그후 커밋
			conn.commit();
		} catch(Exception e) {
			e.printStackTrace();
			// 문제있을경우 롤백
			try {
				conn.rollback();
			} catch (Exception e1) {
				e1.printStackTrace();
			}
		} finally {
			// 자원해제
			try {
				conn.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		
		return list;
	}
	
	// lastPage
	// 기능 : 페이징을 위한 lastPage 구하기
	// 리턴값 : int (lastPage)
	public int lastPage(final int rowPerPage) {
		// 리턴값 초기화
		int lastPage = 0;
		
		// 멤버변수 초기화
		this.dbUtil = new DBUtil();
		this.reviewDao = new ReviewDao();
		
		// conn 초기화
		Connection conn = null;
		
		try {
			conn = this.dbUtil.getConnection();
			// 디버깅
			System.out.println("ReviewService.java lastPage conn : " + conn);
			
			// 자동커밋 해제
			conn.setAutoCommit(false);
						
			int allCount = this.reviewDao.allCount(conn);
			// 디버깅
			System.out.println("ReviewService.java lastPage allCount : " + allCount);
			
			// 마지막페이지 구하기
			lastPage = (int) Math.ceil (allCount / (double)rowPerPage);
			
			// 문제있다면 익셉션 발생
			if(lastPage == 0) {
				// 디버깅
				System.out.println("ReviewService.java lastPage allCount() 실패");
				throw new Exception();
			}
			
			// 완료되면 커밋
			conn.commit();
		} catch(Exception e) {
			e.printStackTrace();
			// 문제있으면 롤백
			try {
				conn.rollback();
			} catch (Exception e1) {
				e1.printStackTrace();
			}
		} finally {
			// DB 자원해제
			if(conn != null) {
				try {
					conn.close();
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		}
		
		return lastPage;
	}
	
	// getReviewListByPage
	// 기능 : 리뷰리스트 보기
	// 리턴값 : List<Map<String, Object>>
	public List<Map<String, Object>> getReviewListByPage(final int rowPerPage, final int currentPage) {
		// 리턴값 초기화
		List<Map<String,Object>> list = null;
		
		// 멤버변수 초기화
		this.dbUtil = new DBUtil();
		this.reviewDao = new ReviewDao();
		
		// conn 초기화
		Connection conn = null;
		
		try {
			conn = this.dbUtil.getConnection();
			// 디버깅
			System.out.println("ReviewService.java getReviewListByPage conn : " + conn);
			
			// 자동커밋해제
			conn.setAutoCommit(false);
			
			// beginRow 구하는 식
			int beginRow = (currentPage - 1) * rowPerPage;
			
			list = this.reviewDao.selectReviewListByPage(conn, rowPerPage, beginRow);
			// 디버깅
			System.out.println("ReviewService.java getReviewListByPage list : " + list.toString());
		
			// 실패했을 경우 exception 발생시키기
			if(list.size() < 1) {
				System.out.println("ReviewService.java getReviewListByPage selectReviewListByPage() 실패");
				throw new Exception();
			}
			
			// 그후 커밋
			conn.commit();
		} catch(Exception e) {
			e.printStackTrace();
			// 문제있을경우 롤백
			try {
				conn.rollback();
			} catch (Exception e1) {
				e1.printStackTrace();
			}
		} finally {
			// 자원해제
			try {
				conn.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		
		return list;
	}
}
