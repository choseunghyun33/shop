package service;

import java.sql.Connection;

import repository.EmployeeDao;
import repository.DBUtil;
import repository.OutIdDao;
import vo.Employee;

public class EmployeeService {
	///////////////////////////////////////////////////////////////////////// addEmployee
	public boolean addEmployee(Employee paramEmployee) {
		// Connection 받을 변수 초기화
		Connection conn = null;
		
		try {
			// Connection 부를 객체생성
			DBUtil dbUtil = new DBUtil();
			// getConnection메서드 실행
			conn = dbUtil.getConnection();
			// 디버깅
			System.out.println("EmployeeService.java addEmployee conn : " + conn);
			// 자동 commit 해제
			conn.setAutoCommit(false);
			
			// EmployeeDao 객체 생성
			EmployeeDao employeeDao = new EmployeeDao();
			// insertEmployee메서드 실행 값 변수에 받기
			int row = employeeDao.insertEmployee(conn, paramEmployee);
			
			// 디버깅
			if(row == 1) {
				System.out.println("EmployeeService addEmployee : insert 성공");
			} else {
				System.out.println("EmployeeService addEmployee : insert 실패");
				throw new Exception();
			}
			
			// 되었다면 commit
			conn.commit();
		} catch(Exception e) {
			e.printStackTrace();
			// 안되었다면 rollback
			try {
				conn.rollback();
			} catch (Exception e1) {
				e1.printStackTrace();
			}
			return false;
		} finally {
			// DB 자원해제
			try {
				conn.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		
		return true;
	}
		
	///////////////////////////////////////////////////////////////////////// delectEmployee
	// 컨트롤러와 레파지토리에서 하지 않아야 할 일을 가공하는 일을 한다. (예. 트랜젝션/비긴로우)
	// 트랜젝션 : 테이블이 변화되는것에서 필요 (select 제외)
	public boolean removeEmployee(Employee paramEmployee) {
		Connection conn = null;
		
		
		try {
			conn = new DBUtil().getConnection();
			// 디버깅
			System.out.println("EmployeeService.java removeEmployee conn : " + conn);
			conn.setAutoCommit(false); // executeUpdate()실행시 자동 커밋을 막음
			
			EmployeeDao employeeDao = new EmployeeDao();
			int deleteLow = employeeDao.delectEmployee(conn, paramEmployee);
			
			// 디버깅 및 예외발생시키기
			if(deleteLow != 1) {
				System.out.println("EmployeeService removeEmployee : delete 실패");
				throw new Exception();
			} else {
				System.out.println("EmployeeService removeEmployee : delete 실패");
			}
			
			OutIdDao outIdDao = new OutIdDao();
			int insertLow = outIdDao.insertOutId(conn, paramEmployee.getEmployeeId());
			
			// 디버깅 및 예외발생시키기
			if(insertLow != 1) {
				System.out.println("EmployeeService removeEmployee : insert 실패");
				throw new Exception();
			} else {
				System.out.println("EmployeeService removeEmployee : insert 성공");
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
			// 디버깅
			System.out.println("EmployeeService.java getEmployeeByIdAndPw conn : " + conn);
			// 자동 commit 해제
			conn.setAutoCommit(false);
			
			EmployeeDao employeeDao = new EmployeeDao();
			employee = employeeDao.selectEmployeeByIdAndPw(conn, paramEmployee);
			
			// 되었다면 commit
			conn.commit();
		} catch(Exception e) {
			e.printStackTrace();
			// 안되었다면 rollback
			try {
				conn.rollback();
			} catch (Exception e1) {
				e1.printStackTrace();
			}
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
