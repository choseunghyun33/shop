package service;

import java.sql.Connection;
import java.util.List;

import repository.DBUtil;
import repository.NoticeDao;
import vo.Notice;

public class NoticeService {
	// 멤버변수
	private DBUtil dbUtil;
	private NoticeDao noticeDao;
	
	// removeNoticeByNoticeNo
	// 기능 : notice 삭제
	// 리턴값 : boolean
	public boolean removeNoticeByNoticeNo(Notice notice) {
		// 리턴값 초기화
		boolean result = false;
		
		// 멤버변수 초기화
		this.dbUtil = new DBUtil();
		this.noticeDao = new NoticeDao();
		
		// conn 초기화
		Connection conn = null;
		
		try {
			conn = this.dbUtil.getConnection();
			// 디버깅
			System.out.println("NoticeService.java modifyNoticeByNoticeNo conn : " + conn);
			
			// 자동커밋 해제
			conn.setAutoCommit(false);
			
			// 메서드실행 (1 - 성공)
			int row = this.noticeDao.deleteNoticeByNoticeNo(conn, notice);
			
			// 0 - 실패일 경우 exception 발생
			if(row == 0) {
				// 디버깅
				System.out.println("NoticeService.java modifyNoticeByNoticeNo updateNoticeByNoticeNo() 실패");
				throw new Exception();
			}
			
			// 문제없다면 result = true
			result = true;
			
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
			
		
		return result;
	}
	
	// modifyNoticeByNoticeNo
	// 기능 : notice 수정
	// 리턴값 : boolean
	public boolean modifyNoticeByNoticeNo(Notice notice) {
		// 리턴값 초기화
		boolean result = false;
		
		// 멤버변수 초기화
		this.dbUtil = new DBUtil();
		this.noticeDao = new NoticeDao();
		
		// conn 초기화
		Connection conn = null;
		
		try {
			conn = this.dbUtil.getConnection();
			// 디버깅
			System.out.println("NoticeService.java modifyNoticeByNoticeNo conn : " + conn);
			
			// 자동커밋 해제
			conn.setAutoCommit(false);
			
			// 메서드실행 (1 - 성공)
			int row = this.noticeDao.updateNoticeByNoticeNo(conn, notice);
			
			// 0 - 실패일 경우 exception 발생
			if(row == 0) {
				// 디버깅
				System.out.println("NoticeService.java modifyNoticeByNoticeNo updateNoticeByNoticeNo() 실패");
				throw new Exception();
			}
			
			// 문제없다면 result = true
			result = true;
			
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
			
		
		return result;
	}
	
	// getNoticeOneByNoticeNo
	// 기능 : noticeOne 보기
	// 리턴값 : Notice
	public Notice getNoticeOneByNoticeNo(Notice paramNotice) {
		// 리턴값 초기화
		Notice notice = null;
		
		// 멤버변수 초기화
		this.dbUtil = new DBUtil();
		this.noticeDao = new NoticeDao();
		
		// conn 초기화
		Connection conn = null;
		
		try {
			conn = this.dbUtil.getConnection();
			// 디버깅
			System.out.println("NoticeService.java getNoticeOneByNoticeNo conn : " + conn);
			
			// 자동커밋 해제
			conn.setAutoCommit(false);
			
			// 메서드실행
			notice = this.noticeDao.selectNoticeOneByNoticeNo(conn, paramNotice);
			
			// null - 실패일 경우 exception 발생
			if(notice == null) {
				// 디버깅
				System.out.println("NoticeService.java getNoticeOneByNoticeNo selectNoticeOneByNoticeNo() 실패");
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
			
		return notice;
	}
	
	// addNotice
	// 기능 : notice 추가
	// 리턴값 : boolean (true - 성공)
	public boolean addNotice(Notice notice) {
		// 리턴값 초기화
		boolean result = false;
		
		// 멤버변수 초기화
		this.dbUtil = new DBUtil();
		this.noticeDao = new NoticeDao();
		
		// conn 초기화
		Connection conn = null;
		
		try {
			conn = this.dbUtil.getConnection();
			// 디버깅
			System.out.println("NoticeService.java addNotice conn : " + conn);
			
			// 자동커밋 해제
			conn.setAutoCommit(false);
			
			// 메서드실행 (1 - 성공)
			int row = this.noticeDao.insertNotice(conn, notice);
			
			// 0 - 실패일 경우 exception 발생
			if(row == 0) {
				// 디버깅
				System.out.println("NoticeService.java addNotice insertNotice() 실패");
				throw new Exception();
			}
			
			// 문제없다면 result = true
			result = true;
			
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
			
		
		return result;
	}
	
	// getNoticeListByPage
	// 기능 : noticeList 보기
	// 리턴값 : List<Notice>
	public List<Notice> getNoticeListByPage(final int rowPerPage, final int currentPage){
		// 리턴값 초기화
		List<Notice> list = null;
		
		// 멤버변수 초기화
		this.dbUtil = new DBUtil();
		this.noticeDao = new NoticeDao();
		
		// conn 초기화
		Connection conn = null;
		
		try {
			conn = this.dbUtil.getConnection();
			// 디버깅
			System.out.println("NoticeService.java getNoticeListByPage conn : " + conn);
			
			// 자동커밋해제
			conn.setAutoCommit(false);
			
			// beginRow 구하는 식
			int beginRow = (currentPage - 1) * rowPerPage;
			
			list = this.noticeDao.selectNoticeListByPage(conn, rowPerPage, beginRow);
			// 디버깅
			System.out.println("NoticeService.java getNoticeListByPage list : " + list.toString());
		
			// 실패했을 경우 exception 발생시키기
			if(list.size() < 1) {
				System.out.println("NoticeService.java getNoticeListByPage 실패");
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
		this.noticeDao = new NoticeDao();
		
		// conn 초기화
		Connection conn = null;
		
		try {
			conn = this.dbUtil.getConnection();
			// 디버깅
			System.out.println("NoticeService.java lastPage conn : " + conn);
			
			// 자동커밋 해제
			conn.setAutoCommit(false);
						
			int allCount = this.noticeDao.allCount(conn);
			// 디버깅
			System.out.println("NoticeService.java lastPage allCount : " + allCount);
			
			// 마지막페이지 구하기
			lastPage = (int) Math.ceil (allCount / (double)rowPerPage);
			
			// 문제있다면 익셉션 발생
			if(lastPage == 0) {
				// 디버깅
				System.out.println("NoticeService.java lastPage allCount() 실패");
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
}
