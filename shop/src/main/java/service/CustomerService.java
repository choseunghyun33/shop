package service;

import java.sql.Connection;
import java.util.ArrayList;
import java.util.List;

import repository.CustomerDao;
import repository.DBUtil;
import repository.OutIdDao;
import vo.Customer;

public class CustomerService {
	// 멤버변수
	private DBUtil dbUtil;
	private CustomerDao customerDao;
	
	///////////////////////////////////////////////////////////////////////// lastPage
	public int lastPage() {
		int lastPage = 0;
		
		// conn 초기화
		Connection conn = null;
		
		try {// Connection 부를 객체생성
			this.dbUtil = new DBUtil();
			// getConnection메서드 실행
			conn = this.dbUtil.getConnection();
			// 디버깅
			System.out.println("CustomerService.java getCustomerList conn : " + conn);
			// 자동 commit 해제
			conn.setAutoCommit(false);
			
			// CustomerDao 객체 생성
			this.customerDao = new CustomerDao();
			// selectCustomerList메서드 실행 값 변수에 받기
			lastPage = customerDao.lastPage(conn);
			
			if(lastPage == 0) {
				// lastPage가 없다면
				throw new Exception();
			}
			
			// 완료되었으면 commit
			conn.commit();
		} catch(Exception e) {
			e.printStackTrace();
			// 실패라면 rollback
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
	
	///////////////////////////////////////////////////////////////////////// getCustomerList
	public List<Customer> getCustomerList(final int rowPerPage, final int currentPage) {
		List<Customer> list = new ArrayList<Customer>();
		// Connection 받을 변수 초기화
		Connection conn = null;
		
		int beginRow = (currentPage - 1) * rowPerPage;
		
		try {
			// Connection 부를 객체생성
			this.dbUtil = new DBUtil();
			// getConnection메서드 실행
			conn = this.dbUtil.getConnection();
			// 디버깅
			System.out.println("CustomerService.java getCustomerList conn : " + conn);
			// 자동 commit 해제
			conn.setAutoCommit(false);
			
			// CustomerDao 객체 생성
			this.customerDao = new CustomerDao();
			// selectCustomerList메서드 실행 값 변수에 받기
			list = customerDao.selectCustomerList(conn, rowPerPage, beginRow);
			
			// 완료되었다면 commit
			conn.commit();
		} catch(Exception e) {
			e.printStackTrace();
			try {
				conn.rollback();
			} catch (Exception e1) {
				e1.printStackTrace();
			}
		} finally {
			// DB 자원해제
			try {
				conn.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		
		return list;
	}
	
	
	///////////////////////////////////////////////////////////////////////// addCustomer
	public boolean addCustomer(Customer paramCustomer) {
		// Connection 받을 변수 초기화
		Connection conn = null;
		
		try {
			// Connection 부를 객체생성
			this.dbUtil = new DBUtil();
			// getConnection메서드 실행
			conn = this.dbUtil.getConnection();
			// 디버깅
			System.out.println("CustomerService.java addCustomer conn : " + conn);
			// 자동 commit 해제
			conn.setAutoCommit(false);
			
			// CustomerDao 객체 생성
			this.customerDao = new CustomerDao();
			// insertCustomer메서드 실행 값 변수에 받기
			int row = this.customerDao.insertCustomer(conn, paramCustomer);
			
			// 디버깅
			if(row == 1) {
				System.out.println("CustomerService addCustomer : insert 성공");
			} else {
				System.out.println("CustomerService addCustomer : insert 실패");
				throw new Exception();
			}
			
			// 되었다면 commit
			conn.commit();
		} catch(Exception e) {
			// 안되었다면 rollback
			e.printStackTrace();
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
	
	
	///////////////////////////////////////////////////////////////////////// delectCustomer
	// 컨트롤러와 레파지토리에서 하지 않아야 할 일을 가공하는 일을 한다. (예. 트랜젝션/비긴로우)
	// 트랜젝션 : 테이블이 변화되는것에서 필요 (select 제외)
	public boolean removeCustomer(Customer paramCustomer) {
		Connection conn = null;
		
		
		try {
			conn = new DBUtil().getConnection();
			// 디버깅
			System.out.println("CustomerService.java removeCustomer conn : " + conn);
			conn.setAutoCommit(false); // executeUpdate()실행시 자동 커밋을 막음
			
			this.customerDao = new CustomerDao();
			int deleteLow = this.customerDao.delectCustomer(conn, paramCustomer);
			
			// 디버깅
			if(deleteLow != 1) {
				System.out.println("CustomerService removeCustomer : delete 실패");
				throw new Exception();
			} else {
				System.out.println("CustomerService removeCustomer : delete 성공");
			}
			
			OutIdDao outIdDao = new OutIdDao();
			int insertLow = outIdDao.insertOutId(conn, paramCustomer.getCustomerId());
			
			// 디버깅
			if(insertLow != 1) {
				System.out.println("CustomerService removeCustomer : insert 실패");
				throw new Exception();
			} else {
				System.out.println("CustomerService removeCustomer : insert 성공");
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
	
	///////////////////////////////////////////////////////////////////////// customer로그인 - 성공시 id + name
	// loginAction.jsp 호출
	public Customer getCustomerByIdAndPw(Customer paramCustomer) {
		// 객체 초기화
		Connection conn = null;
		Customer customer = null;
		
		try {
			// conn 메서드실행할 객체생성
			this.dbUtil = new DBUtil();
			conn = this.dbUtil.getConnection();
			// 디버깅
			System.out.println("CustomerService.java getCustomerByIdAndPw conn : " + conn);
			// autocommit 정지
			conn.setAutoCommit(false);
			
			this.customerDao = new CustomerDao();
			customer = this.customerDao.selectCustomerByIdAndPw(conn, paramCustomer);
			
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
			try {
				conn.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		
		return customer;
	}
}