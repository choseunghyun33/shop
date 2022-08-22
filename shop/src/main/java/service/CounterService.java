package service;

import java.sql.Connection;

import repository.CounterDao;
import repository.DBUtil;

public class CounterService {
	// 멤버변수
	private DBUtil dbUtil;
	private CounterDao counterDao;
	
	// 오늘 날짜에 날짜가 있다면 그리고 없다면
	public void count() {
		// 멤버변수 초기화
		this.dbUtil = new DBUtil();
		this.counterDao = new CounterDao();
		
		// conn 초기화
		Connection conn = null;
		
		try {
			// conn 메서드실행
			conn = this.dbUtil.getConnection();
			
			// conn 자동커밋해제
			conn.setAutoCommit(false);
			
			// 분기 (오늘 날짜가 DB에 없다면 오늘 처음 들어온 것이기 때문에 insert를 해줘야 하고 있다면 update를 해줘야 한다)
			if(this.counterDao.selectCounterToday(conn) == null) { // 오늘 날짜에 날짜가 없다면 1 입력
				// insert
				this.counterDao.insertCounter(conn);
			} else { // 오늘 날짜에 날짜가 있다면 +1 update
				// update
				this.counterDao.updateCounter(conn);
			}
			
			// 문제 없을시 commit
			conn.commit();
		} catch(Exception e) {
			e.printStackTrace();
			// 문제 있을시 rollback
			try {
				conn.rollback();
			} catch (Exception e1) {
				e1.printStackTrace();
			}
		} finally {
			// 자원해제
			if(conn != null) {
				try {
					conn.close();
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
			
		}
		
	}
	
	// 전체접속자 수
	public int getTotalCount() {
		// 리턴값 초기화
		int totalCount = 0;
		
		// 멤버변수 초기화
		this.dbUtil = new DBUtil();
		this.counterDao = new CounterDao();
		
		// conn 초기화
		Connection conn = null;
		
		try {
			// conn 메서드실행
			conn = this.dbUtil.getConnection();
			
			// conn 자동커밋해제
			conn.setAutoCommit(false);
			
			// totalCount 메서드 실행
			totalCount = this.counterDao.selectTotalCount(conn);
			
			// totalCount가 계속 -9라면 문제발생
			if(totalCount == -9) {
				// 디버깅
				System.out.println("CounterService.java getTotalCount selectTotalCount() 실패");
				// 익셉션 발생시키기
				throw new Exception();
			}
			
			// 문제 없을시 commit
			conn.commit();
		} catch(Exception e) {
			e.printStackTrace();
			// 문제 있을시 rollback
			try {
				conn.rollback();
			} catch (Exception e1) {
				e1.printStackTrace();
			}
		} finally {
			// 자원해제
			if(conn != null) {
				try {
					conn.close();
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
			
		}
		return totalCount;
	}

	// 오늘접속자 수
	public int getTodayCount() {
		// 리턴값 초기화
		int todayCount = 0;
		
		// 멤버변수 초기화
		this.dbUtil = new DBUtil();
		this.counterDao = new CounterDao();
		
		// conn 초기화
		Connection conn = null;
		
		try {
			// conn 메서드실행
			conn = this.dbUtil.getConnection();
			
			// conn 자동커밋해제
			conn.setAutoCommit(false);
			
			// totalCount 메서드 실행
			todayCount = this.counterDao.selectTodayCount(conn);
			
			// totalCount가 계속 -9라면 문제발생
			if(todayCount == -9) {
				// 디버깅
				System.out.println("CounterService.java getTodayCount selectTodayCount() 실패");
				// 익셉션 발생시키기
				throw new Exception();
			}
			
			// 문제 없을시 commit
			conn.commit();
		} catch(Exception e) {
			e.printStackTrace();
			// 문제 있을시 rollback
			try {
				conn.rollback();
			} catch (Exception e1) {
				e1.printStackTrace();
			}
		} finally {
			// 자원해제
			if(conn != null) {
				try {
					conn.close();
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		}
		
		return todayCount;
	}
	
}
