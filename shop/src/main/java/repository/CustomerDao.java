package repository;

import java.sql.*;
import vo.Customer;

public class CustomerDao {
	///////////////////////////////////////////////////////////////////////// insertCustomer
	// CustomerService.addCustomer(Customer paramCustomer)가 호출
	public int insertCustomer(Connection conn, Customer paramCustomer) throws Exception {
		// 리턴할 변수 초기화
		int row = 0;
		String sql = "INSERT INTO customer (customer_id, customer_pass, customer_name, customer_address, customer_telephone, update_date, create_date) VALUES (?,PASSWORD(?),?,?,?,NOW(),NOW())";
		
		PreparedStatement stmt = null;
		try {
			stmt = conn.prepareStatement(sql);
			// stmt setter
			stmt.setString(1, paramCustomer.getCustomerId());
			stmt.setString(2, paramCustomer.getCustomerPass());
			stmt.setString(3, paramCustomer.getCustomerName());
			stmt.setString(4, paramCustomer.getCustomerAddress());
			stmt.setString(5, paramCustomer.getCustomerTelephone());
			// 디버깅
			System.out.println("CustomerDao.java insertCustomer stmt : " + stmt);
			
			// 쿼리실행
			row = stmt.executeUpdate();
		} finally {
			if(stmt != null) { stmt.close(); }
		}
		
		return row;
	}
	
	
	///////////////////////////////////////////////////////////////////////// delectCustomer
	// CustomerService.removeCustomer(Customer paramCustomer)가 호출
	public int delectCustomer(Connection conn, Customer paramCustomer) throws Exception {
		// 동일한 conn 사용해야함
		// conn.close() X
		int row = 0;
		String sql = "DELETE FROM customer WHERE customer_id = ? and customer_pass = PASSWORD(?)";
		
		
		PreparedStatement stmt = null;
		try {
			stmt = conn.prepareStatement(sql);
			// stmt setter
			stmt.setString(1, paramCustomer.getCustomerId());
			stmt.setString(2, paramCustomer.getCustomerPass());
			// 디버깅
			System.out.println("CustomerDao.java delectCustomer stmt : " + stmt);
			// 쿼리실행
			row = stmt.executeUpdate();
		} finally {
			if(stmt != null) { stmt.close(); }
		}
		
		return row;
	}
	
	
	///////////////////////////////////////////////////////////////////////// selectCustomerByIdAndPw
	// CustomerService가 호출
	public Customer selectCustomerByIdAndPw(Connection conn, Customer customer) throws Exception {
		// 리턴할 객체 초기화
		Customer loginCustomer = null;
		
		PreparedStatement stmt = null;
		ResultSet rs = null;
		String sql = "SELECT customer_id customerId, customer_name customerName FROM customer WHERE customer_id = ? and customer_pass = PASSWORD(?)";
		
		try {
			stmt = conn.prepareStatement(sql);
			// stmt setter
			stmt.setString(1, customer.getCustomerId());
			stmt.setString(2, customer.getCustomerPass());
			// 디버깅
			System.out.println("CustomerDao.java selectCustomerByIdAndPw stmt : " + stmt);
			rs = stmt.executeQuery();
			
			if(rs.next()) {
				// 쿼리가 실행됐다면 객체생성
				loginCustomer = new Customer();
				loginCustomer.setCustomerId(rs.getString("customerId"));
				loginCustomer.setCustomerName(rs.getString("customerName"));
				// 디버깅
				System.out.println("CustomerDao.java selectCustomerByIdAndPw customerId : " + loginCustomer.getCustomerId());
				System.out.println("CustomerDao.java selectCustomerByIdAndPw customerName : " + loginCustomer.getCustomerName());
			}
		} finally {
			if(rs != null) { rs.close(); }
			if(stmt != null) { stmt.close(); }
		}
		
		return loginCustomer;
	}
}
