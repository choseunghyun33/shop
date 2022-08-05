package service;

import java.sql.Connection;

import repository.DBUtil;
import repository.SignDao;

public class SignService {
	// 생각해볼것 : 멤버변수 지역변수 어떤것이 더 효율적일 것인가
	private DBUtil dbUtil;
	private SignDao signDao;
	
	// return
	// true : 사용가능한 아이디 (SignDao.idCheck 리턴값이 null인 경우)
	// false : 사용불가한 아이디
	public boolean idCheck(String id) {
		boolean result = false;
		Connection conn = null;
		
		this.signDao = new SignDao();
		this.dbUtil = new DBUtil();
		
		try {
			conn = dbUtil.getConnection();
			// 디버깅
			System.out.println("SignService.java idCheck conn : " + conn);
			conn.setAutoCommit(false); // executeUpdate()실행시 자동 커밋을 막음
			
			// signDao.idCheck 메서드실행 시 null이라면 아이디 사용가능
			if(signDao.idCheck(conn, id) == null) {
				result = true;
			}
			
			// 그 후 커밋하기
			conn.commit();
		} catch (Exception e) {
			e.printStackTrace();
			try {
				// 예외발생으로 실행이 되지 않았다면 rollback하기
				conn.rollback();
			} catch (Exception e1) {
				e1.printStackTrace();
			}
		} finally {
			// conn이 null이 아니라면 닫기
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
}
