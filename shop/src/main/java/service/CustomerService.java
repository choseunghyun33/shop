package service;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import repository.CustomerDao;
import repository.DBUtil;
import repository.OutIdDao;
import vo.Customer;

public class CustomerService {
	// 멤버변수
	private DBUtil dbUtil;
	private CustomerDao customerDao;
	
	//////////////////////////////////////////////////////////////////////// modifyCustomerByAdmin
	public boolean modifyCustomerByAdmin(Customer customer) {
		// conn 초기화
		Connection conn = null;
		this.dbUtil = new DBUtil();
		this.customerDao = new CustomerDao();
		
		try {
			conn = this.dbUtil.getConnection();
			// 디버깅
			System.out.println("CustomerService.java modifyCustomerByAdmin conn : " + conn);
			
			// 메서드 실행 row 1일 경우 성공
			int row = this.customerDao.updateCustomerByAdmin(conn, customer);
			// 디버깅
			System.out.println("CustomerService.java modifyCustomerByAdmin row : " + row);
			
			// 분기
			if(row == 1) {
				System.out.println("CustomerService.java modifyCustomerByAdmin update 성공");
			} else {
				System.out.println("CustomerService.java modifyCustomerByAdmin update 실패");
				throw new Exception();
			}
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		} finally {
			if(conn != null) {
				try {
					conn.close();
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		}
		return true;
	}
	
	//////////////////////////////////////////////////////////////////////// deleteCustomerByAdmin
	public boolean removeCustomerByAdmin(String customerId) {
		// conn 초기화
		Connection conn = null;
		this.dbUtil = new DBUtil();
		this.customerDao = new CustomerDao();
		
		try {
			conn = this.dbUtil.getConnection();
			// 디버깅
			System.out.println("CustomerService.java removeCustomerByAdmin conn : " + conn);
			
			// 메서드 실행 row 1일 경우 성공
			int row = this.customerDao.deleteCustomerByAdmin(conn, customerId);
			// 디버깅
			System.out.println("CustomerService.java removeCustomerByAdmin row : " + row);
			
			// 분기
			if(row == 1) {
				System.out.println("CustomerService.java removeCustomerByAdmin delete 성공");
			} else {
				System.out.println("CustomerService.java removeCustomerByAdmin delete 실패");
				throw new Exception();
			}
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		} finally {
			if(conn != null) {
				try {
					conn.close();
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		}
		return true;
	}
	
	///////////////////////////////////////////////////////////////////////// lastPage
	public int lastPage(final int rowPerPage) {
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
			int allCount = customerDao.allCount(conn);
			
			// 마지막페이지 구하기
			lastPage = (int) Math.ceil (allCount / (double)rowPerPage);
			
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
	
	///////////////////////////////////////////////////////////////////////// getCustomerAddrById
	// CustomerService가 호출
	public String getCustomerAddrById(String id) {
		// 리턴값 초기화
		String customerAddr = null;
		
		// 객체 초기화
		Connection conn = null;
		
		try {
			// conn 메서드실행할 객체생성
			this.dbUtil = new DBUtil();
			conn = this.dbUtil.getConnection();
			// 디버깅
			System.out.println("CustomerService.java getCustomerAddrById conn : " + conn);
			// autocommit 정지
			conn.setAutoCommit(false);
			
			this.customerDao = new CustomerDao();
			customerAddr = this.customerDao.selectCustomerAddrById(conn, id);
			
			// 실패했다면 익셉션 발생시키기
			if(customerAddr == null) {
				System.out.println("CustomerService.java getCustomerAddrById selectCustomerAddrById() 실패");
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
		} finally {
			try {
				conn.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}

		
		return customerAddr;
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