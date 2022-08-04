package service;

import java.sql.Connection;

import repository.DBUtil;
import repository.EmployeeDao;
import repository.OutIdDao;
import vo.Employee;

public class EmployeeService {
	///////////////////////////////////////////////////////////////////////// delectEmployee
	// 컨트롤러와 레파지토리에서 하지 않아야 할 일을 가공하는 일을 한다. (예. 트랜젝션/비긴로우)
	// 트랜젝션 : 테이블이 변화되는것에서 필요 (select 제외)
	public boolean removeEmployee(Employee paramEmployee) {
		Connection conn = null;
		
		
		try {
			conn = new DBUtil().getConnection();
			conn.setAutoCommit(false); // executeUpdate()실행시 자동 커밋을 막음
			
			EmployeeDao employeeDao = new EmployeeDao();
			int deleteLow = employeeDao.delectEmployee(conn, paramEmployee);
			
			// 디버깅 및 예외발생시키기
			if(deleteLow != 1) {
				System.out.println("delete 실패");
				throw new Exception();
			} else {
				System.out.println("delete 실패");
			}
			
			OutIdDao outIdDao = new OutIdDao();
			int insertLow = outIdDao.insertOutId(conn, paramEmployee.getEmployeeId());
			
			// 디버깅 및 예외발생시키기
			if(insertLow != 1) {
				System.out.println("insert 실패");
				throw new Exception();
			} else {
				System.out.println("insert 성공");
			}
			
			conn.commit();
		} catch(Exception e) {
			e.printStackTrace(); // catch절에 무조건! console에 예외메세지 출력
			try{
				conn.rollback();
			} catch(Exception e1) {
				e1.printStackTrace();
			}
			return false;
			
		} finally {
			try {
				conn.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return true;
	}
	
	///////////////////////////////////////////////////////////////////////// employee로그인 - 성공시 id + name
	// employeeLoginAction.jsp 호출
	public Employee getEmployeeByIdAndPw(Employee paramEmployee) {
		// 객체 초기화
		Connection conn = null;
		Employee employee = null;
		
		try {
			// conn 메서드실행할 객체생성
			DBUtil dbUtil = new DBUtil();
			conn = dbUtil.getConnection();
			
			EmployeeDao employeeDao = new EmployeeDao();
			employee = employeeDao.selectEmployeeByIdAndPw(conn, paramEmployee);
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			// DB자원해제
			try {
				conn.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		
		return employee;
	}
}
