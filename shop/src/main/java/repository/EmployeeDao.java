package repository;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import vo.Employee;

public class EmployeeDao {	
	//////////////////////////////////////////////////////////////////////// updateActiveById
	// EmployeeService.modifyActiveById(String id, String Active)가 호출
	public int updateActiveById(Connection conn, String employeeId, String active) throws Exception {
		// 리턴할 변수 초기화
		int row = 0;
		String sql = "UPDATE employee SET active = ? WHERE employee_id = ?";
		
		// 초기화
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		try {
			// 쿼리담기
			stmt = conn.prepareStatement(sql);
			// stmt setter
			stmt.setString(1, active);
			stmt.setString(2, employeeId);
			// 디버깅
			System.out.println("EmployeeDao updateActiveById stmt : " + stmt);
			// 쿼리실행
			row = stmt.executeUpdate();
		} finally {
			if(stmt != null) { stmt.close(); }
		}
		
		return row;
	}
		
	//////////////////////////////////////////////////////////////////////// lastPage
	// EmployeeService.lastPage()가 호출
	public int lastPage(Connection conn) throws Exception {
		int lastPage = 0;
		String sql = "SELECT COUNT(*) count FROM employee";
		
		// 초기화
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		try {
			// 쿼리담기
			stmt = conn.prepareStatement(sql);
			// 디버깅
			System.out.println("EmployeeDao lastPage stmt : " + stmt);
			// 쿼리실행
			rs = stmt.executeQuery();
			if(rs.next()) {
				lastPage = rs.getInt("count");
			}
		} finally {
			if(rs != null) { rs.close(); }
			if(stmt != null) { stmt.close(); }
		}
				
		return lastPage;
	}
	
	
	//////////////////////////////////////////////////////////////////////// selectEmployeeList
	// EmployeeService.getEmployeeList(int rowPerPage, int currentPage)가 호출
	public List<Employee> selectEmployeeList(Connection conn, final int rowPerPage, final int beginRow) throws Exception {
		List<Employee> list = new ArrayList<Employee>();
		String sql = "SELECT employee_id employeeId, employee_name employeeName, create_date createDate, update_date updateDate, active FROM employee limit ?,?";
		
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		try {
			// 쿼리담기
			stmt = conn.prepareStatement(sql);
			// stmt setter
			stmt.setInt(1, beginRow);
			stmt.setInt(2, rowPerPage);
			// 디버깅
			System.out.println("EmployeeDao selectEmployeeList stmt : " + stmt);
	
			// 쿼리실행
			rs = stmt.executeQuery();
			while(rs.next()) {
				Employee employee = new Employee();
				employee.setEmployeeId(rs.getString("employeeId"));
				employee.setEmployeeName(rs.getString("employeeName"));
				employee.setCreateDate(rs.getString("createDate"));
				employee.setUpdateDate(rs.getString("updateDate"));
				employee.setActive(rs.getString("active"));
				// list에 담기
				list.add(employee);
			}
		} finally {
			if(rs != null) { rs.close(); }
			if(stmt != null) { stmt.close(); }
		}
		
		return list;
	}
	
	
	///////////////////////////////////////////////////////////////////////// insertEmployee
	// EmployeeService.addEmployee(Employee paramEmployee)가 호출
	public int insertEmployee(Connection conn, Employee paramEmployee) throws Exception {
		// 리턴할 변수 초기화
		int row = 0;
		String sql = "INSERT INTO employee (employee_id, employee_pass, employee_name, update_date, create_date) VALUES (?,PASSWORD(?),?,NOW(),NOW())";
		
		PreparedStatement stmt = null;
		try {
			stmt = conn.prepareStatement(sql);
			// stmt setter
			stmt.setString(1, paramEmployee.getEmployeeId());
			stmt.setString(2, paramEmployee.getEmployeePass());
			stmt.setString(3, paramEmployee.getEmployeeName());
			// 디버깅
			System.out.println("EmployeeDao.java insertEmployee stmt : " + stmt);
			
			// 쿼리실행
			row = stmt.executeUpdate();
		} finally {
			if(stmt != null) { stmt.close(); }
		}
		
		
		return row;
	}
	
	///////////////////////////////////////////////////////////////////////// delectEmployee
	// EmployeeService.removeEmployee(Employee paramEmployee)가 호출
	public int delectEmployee(Connection conn, Employee paramEmployee) throws Exception {
		// 동일한 conn 사용해야함
		// conn.close() X
		int row = 0;
		String sql = "DELETE FROM employee WHERE employee_id = ? and employee_pass = PASSWORD(?)";
		
		
		PreparedStatement stmt = null;
		try {
			stmt = conn.prepareStatement(sql);
			// stmt setter
			stmt.setString(1, paramEmployee.getEmployeeId());
			stmt.setString(2, paramEmployee.getEmployeePass());
			// 디버깅
			System.out.println("EmployeeDao.java stmt : " + stmt);
			// 쿼리실행
			row = stmt.executeUpdate();
		} finally {
			if(stmt != null) { stmt.close(); }
		}
		
		return row;
	}
	
	
	///////////////////////////////////////////////////////////////////////// selectEmployeeByIdAndPw
	// EmployeeService가 호출
	public Employee selectEmployeeByIdAndPw(Connection conn, Employee employee) throws Exception {
		// 리턴할 객체 초기화
		Employee loginEmployee = null;
		
		// 객체 초기화
		PreparedStatement stmt = null;
		ResultSet rs = null;
		String sql = "SELECT employee_id employeeId, employee_name employeeName FROM employee WHERE employee_id = ? and employee_pass = PASSWORD(?) and active = 'Y'";
		
		try {
			stmt = conn.prepareStatement(sql);
			// stmt setter
			stmt.setString(1, employee.getEmployeeId());
			stmt.setString(2, employee.getEmployeePass());
			// 디버깅
			System.out.println("loginEmployee method stmt : " + stmt);
			rs = stmt.executeQuery();
			
			if(rs.next()) {
				// 쿼리가 실행됐다면 객체생성
				loginEmployee = new Employee();
				loginEmployee.setEmployeeId(rs.getString("employeeId"));
				loginEmployee.setEmployeeName(rs.getString("employeeName"));
				// 디버깅
				System.out.println("loginEmployee method employeeId : " + loginEmployee.getEmployeeId());
				System.out.println("loginEmployee method employeeName : " + loginEmployee.getEmployeeId());
			}
		} finally {
			if(rs != null) { rs.close(); }
			if(stmt != null) { stmt.close(); }
		}
		
		
		return loginEmployee;
	}
}
