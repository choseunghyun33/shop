package service;

import java.sql.Connection;

import repository.CustomerDao;
import repository.DBUtil;
import repository.OutIdDao;
import vo.Customer;

public class CustomerService {
	
	///////////////////////////////////////////////////////////////////////// delectCustomer
	// 컨트롤러와 레파지토리에서 하지 않아야 할 일을 가공하는 일을 한다. (예. 트랜젝션/비긴로우)
	// 트랜젝션 : 테이블이 변화되는것에서 필요 (select 제외)
	public boolean removeCustomer(Customer paramCustomer) {
		Connection conn = null;
		
		
		try {
			conn = new DBUtil().getConnection();
			conn.setAutoCommit(false); // executeUpdate()실행시 자동 커밋을 막음
			
			CustomerDao customerDao = new CustomerDao();
			int deleteLow = customerDao.delectCustomer(conn, paramCustomer);
			
			// 디버깅
			if(deleteLow != 1) {
				System.out.println("delete 실패");
				throw new Exception();
			} else {
				System.out.println("delete 성공");
			}
			
			OutIdDao outIdDao = new OutIdDao();
			int insertLow = outIdDao.insertOutId(conn, paramCustomer.getCustomerId());
			
			// 디버깅
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
	
	///////////////////////////////////////////////////////////////////////// customer로그인 - 성공시 id + name
	// loginAction.jsp 호출
	public Customer getCustomerByIdAndPw(Customer paramCustomer) throws Exception {
		// 객체 초기화
		Connection conn = null;
		Customer customer = null;
		
		try {
			// conn 메서드실행할 객체생성
			DBUtil dbUtil = new DBUtil();
			conn = dbUtil.getConnection();
			
			CustomerDao customerDao = new CustomerDao();
			customer = customerDao.selectCustomerByIdAndPw(conn, paramCustomer);
		} catch(Exception e) {
			e.printStackTrace();
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