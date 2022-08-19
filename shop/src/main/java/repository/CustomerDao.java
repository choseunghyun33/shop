package repository;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import vo.Customer;

public class CustomerDao {
	//////////////////////////////////////////////////////////////////////// deleteCustomerByAdmin
	public int deleteCustomerByAdmin(Connection conn, String customerId) throws Exception {
		int row = 0;
		String sql = "DELETE FROM customer WHERE customer_id = ?";
		
		// 초기화
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		try {
			// 쿼리담기
			stmt = conn.prepareStatement(sql);
			// stmt setter
			stmt.setString(1, customerId);
			// 디버깅
			System.out.println("CustomerDao.java deleteCustomerByAdmin stmt : " + stmt);
			// 쿼리실행
			row = stmt.executeUpdate();
			
		} finally {
			if(rs != null) { rs.close(); }
			if(stmt != null) { stmt.close(); }
		}
		
		return row;
	}
	
	
	//////////////////////////////////////////////////////////////////////// lastPage
	// CustomerService.lastPage()가 호출
	public int allCount(Connection conn) throws Exception {
		int allCount = 0;
		String sql = "SELECT COUNT(*) count FROM customer";
		
		// 초기화
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		try {
			// 쿼리담기
			stmt = conn.prepareStatement(sql);
			// 디버깅
			System.out.println("CustomerDao.java allCount stmt : " + stmt);
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
	
	
	//////////////////////////////////////////////////////////////////////// selectCustomerList
	// CustomerService.getCustomerList(int rowPerPage, int currentPage)가 호출
	public List<Customer> selectCustomerList(Connection conn, final int rowPerPage, final int beginRow) throws Exception {
		List<Customer> list = new ArrayList<Customer>();
		String sql = "SELECT customer_id customerId, customer_name customerName, customer_address customerAddress, customer_telephone customerTelephone, create_date createDate, update_date updateDate FROM customer limit ?,?";
		
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		try {
			// 쿼리담기
			stmt = conn.prepareStatement(sql);
			// stmt setter
			stmt.setInt(1, beginRow);
			stmt.setInt(2, rowPerPage);
			// 디버깅
			System.out.println("CustomerDao.java selectCustomerList stmt : " + stmt);
			
			// 쿼리실행
			rs = stmt.executeQuery();
			while(rs.next()) {
				Customer customer = new Customer();
				customer.setCustomerId(rs.getString("customerId"));
				customer.setCustomerName(rs.getString("customerName"));
				customer.setCustomerAddress(rs.getString("customerAddress"));
				customer.setCustomerTelephone(rs.getString("customerTelephone"));
				customer.setCreateDate(rs.getString("createDate"));
				customer.setUpdateDate(rs.getString("updateDate"));
				// 디버깅
				System.out.println("CustomerDao.java selectCustomerList customer : " + customer.toString());
				
				// list에 담기
				list.add(customer);
			}
		} finally {
			if(rs != null) { rs.close(); }
			if(stmt != null) { stmt.close(); }
		}
		
		return list;
	}


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
	
	///////////////////////////////////////////////////////////////////////// selectCustomerAddrById
	// CustomerService가 호출
	public String selectCustomerAddrById(Connection conn, String id) throws Exception {
		// 리턴값 초기화
		String customerAddr = null;
		
		PreparedStatement stmt = null;
		ResultSet rs = null;
		String sql = "SELECT customer_address customerAddr FROM customer WHERE customer_id = ?";
		
		try {
			stmt = conn.prepareStatement(sql);
			// stmt setter
			stmt.setString(1, id);
			// 디버깅
			System.out.println("CustomerDao.java selectCustomerAddrById stmt : " + stmt);
			rs = stmt.executeQuery();
			
			if(rs.next()) {
				// 쿼리가 실행됐다면 객체생성
				customerAddr = rs.getString("customerAddr");
				// 디버깅
				System.out.println("CustomerDao.java selectCustomerAddrById customerAddr : " + customerAddr);
			}
		} finally {
			if(rs != null) { rs.close(); }
			if(stmt != null) { stmt.close(); }
		}
		
		return customerAddr;
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
