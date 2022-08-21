package service;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import repository.CartDao;
import repository.DBUtil;
import repository.OrdersDao;
import vo.Cart;
import vo.Orders;

public class OrdersService {
	// 멤버변수
	private	DBUtil dbUtil;
	private OrdersDao ordersDao;
	
	///////////////////////////////////////////////////////////////////////////////////////////////////// addOrders	
	// 기능 : 주문 넣기
	// 리턴값 : boolean (true - 성공 / false - 실패)
	public boolean addOrders(Orders orders) {
		// 리턴값 초기화
		boolean result = false;
		
		// conn 초기화
		Connection conn = null;
		
		// dbUtil, ordersDao 초기화
		this.dbUtil = new DBUtil();
		this.ordersDao = new OrdersDao();
		
		try {
			conn = this.dbUtil.getConnection();
			// 디버깅
			System.out.println("OrdersService.java addOrders conn : " + conn);
			
			// 자동커밋해제
			conn.setAutoCommit(false);
			
			// dao에서 메서드 불러오기
			int row = this.ordersDao.insertOrders(conn, orders);
			// 디버깅
			System.out.println("OrdersService.java addOrders insertOrders() row : " + row);
			
			// row == 0 실패 -> 익셉션발생
			if(row == 0) {
				// 디버깅
				System.out.println("OrdersService.java addOrders insert 실패");
				throw new Exception();
			}
			
			// addOrders 가 잘되었다면 cart에서는 remove
			// cartDao에서 메서드 실행
			// 이때 파라미터가 List<Cart>이니 형식에 맞춘다.
			List<Cart> list = new ArrayList<>();
			
			Cart cart = new Cart();
			cart.setCustomerId(orders.getCustomerId());
			cart.setGoodsNo(orders.getGoodsNo());
			
			list.add(cart);
			
			// 리턴값을 맞추기
			List<Integer> removeRow = new CartDao().deleteCartById(conn, list);
			
			if(removeRow.size() < 1) {
				// 디버깅
				System.out.println("OrdersService.java addOrders deleteCartById 실패");
				throw new Exception();
			}
			
			// 성공할 경우 result = true
			result = true;
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
			
		
		return result;
	}
	
	
	///////////////////////////////////////////////////////////////////////////////////////////////////// modifyOrdersByOrders	
	public boolean modifyOrdersByOrders(Orders orders){
		// 리턴값 초기화
		boolean result = false;
		
		// conn 초기화
		Connection conn = null;
		
		// dbUtil, ordersDao 초기화
		this.dbUtil = new DBUtil();
		this.ordersDao = new OrdersDao();
		
		try {
			conn = this.dbUtil.getConnection();
			// 디버깅
			System.out.println("OrdersService.java modifyOrdersByOrders conn : " + conn);

			// 자동커밋해제
			conn.setAutoCommit(false);
			
			// 메서드 실행 - row 0이면 update 안됨
			int row = this.ordersDao.updateOrdersByOrders(conn, orders);
			// 디버깅
			System.out.println("OrdersService.java modifyOrdersByOrders row : " + row);
			
			// row == 0 실패 -> 익셉션발생
			if(row == 0) {
				System.out.println("OrdersService.java modifyOrdersByOrders update 실패");
				throw new Exception();
			}
			
			// 성공할 경우 result = true
			result = true;
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
		
		return result;
	}	
	
	
	///////////////////////////////////////////////////////////////////////////////////////////////////// updateOrderStateByOrderNo	
	public boolean modifyOrderStateByOrderNo(String orderState, int orderNo) {
		// 리턴값 초기화
		boolean result = false;
				
		// conn 초기화
		Connection conn = null;
		
		// dbUtil, ordersDao 초기화
		this.dbUtil = new DBUtil();
		this.ordersDao = new OrdersDao();
		
		try {
			conn = this.dbUtil.getConnection();
			// 디버깅
			System.out.println("OrdersService.java modifyOrderStateByOrderNo conn : " + conn);
			
			// 자동커밋해제
			conn.setAutoCommit(false);
						
			// 메서드 실행 - row 0이면 update 안됨
			int row = this.ordersDao.updateOrderStateByOrderNo(conn, orderState, orderNo);
			// 디버깅
			System.out.println("OrdersService.java modifyOrderStateByOrderNo row : " + row);
			
			// row == 0 실패 -> 익셉션발생
			if(row == 0) {
				System.out.println("OrdersService.java modifyOrderStateByOrderNo update 실패");
				throw new Exception();
			}
			
			// 성공할 경우 result = true
			result = true;
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
		return result;
	}
	
	
	///////////////////////////////////////////////////////////////////////////////////////////////////// lastPage	
	// 마지막페이지 구할 총 count
	public int lastPage(final int rowPerPage) {
		int lastPage = 0;
		
		// conn, dbUtil, ordersDao 초기화
		Connection conn = null;
		this.dbUtil = new DBUtil();
		this.ordersDao = new OrdersDao();
		
		try {
			conn = this.dbUtil.getConnection();
			int allCount = this.ordersDao.allCount(conn);
			// 디버깅
			System.out.println("OrdersService.java modifyOrderStateByOrderNo conn : " + conn);
			System.out.println("OrdersService.java modifyOrderStateByOrderNo allCount : " + allCount);
			
			// 자동커밋해제
			conn.setAutoCommit(false);
			
			// 마지막페이지 구하기 식
			lastPage = (int) Math.ceil(allCount / (double) rowPerPage);
			
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
		
		return lastPage;
	}
	
	///////////////////////////////////////////////////////////////////////////////////////////////////// getOrdersOne	
	// 5-2 주문 상세 보기
	public Map<String, Object> getOrdersOne(int orderNo) {
		Map<String, Object> map = null;
		
		// conn 초기화
		Connection conn = null;
		// 객체 new
		this.dbUtil = new DBUtil();
		this.ordersDao = new OrdersDao();
		
		try {
			// 메서드 실행 후 담기
			conn = this.dbUtil.getConnection();
			map = this.ordersDao.selectOrdersOne(conn, orderNo);
			// 디버깅
			System.out.println("OrdersService.java getOrdersListByCustomer conn : " + conn);
			System.out.println("OrdersService.java getOrdersListByCustomer map : " + map.toString());
			
			// 자동커밋해제
			conn.setAutoCommit(false);
			
			if(this.ordersDao.selectOrdersOne(conn, orderNo) == null) {
				System.out.println("OrdersService.java selectOrdersOne 실패");
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
		
		return map;
	}
	
	///////////////////////////////////////////////////////////////////////////////////////////////////// getOrdersList	
	// 5-1 전체 주문 목록
	public List<Map<String, Object>> getOrdersList(final int rowPerPage, final int currentPage) {
		List<Map<String, Object>> list = null;
		// conn 초기화
		Connection conn = null;
		// 객체 new
		this.dbUtil = new DBUtil();
		this.ordersDao = new OrdersDao();
		
		try {
			// 메서드 실행 후 담기
			conn = this.dbUtil.getConnection();
			
			// 자동커밋해제
			conn.setAutoCommit(false);
			
			// beginRow 구하는 식
			int beginRow = (currentPage - 1) * rowPerPage;
			
			list = this.ordersDao.selectOrdersList(conn, rowPerPage, beginRow);
			// 디버깅
			System.out.println("OrdersService.java getOrdersListByCustomer conn : " + conn);
			System.out.println("OrdersService.java getOrdersListByCustomer list : " + list.toString());
			
			// 분기
			if(list.size() < 1) {
				System.out.println("OrdersService.java selectOrdersList 실패");
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
	
	///////////////////////////////////////////////////////////////////////////////////////////////////// getOrdersListByCustomer
	// 2-1 고객 한명의 주문 목록 - 관리자/고객 페이지
	public List<Map<String, Object>> getOrdersListByCustomer(String customerId, final int rowPerPage, final int currentPage){
		List<Map<String, Object>> list = null;
		// conn 초기화
		Connection conn = null;
		// 객체 new
		this.dbUtil = new DBUtil();
		this.ordersDao = new OrdersDao();
		
		try {
			// 메서드 실행 후 담기
			conn = this.dbUtil.getConnection();

			// 자동커밋해제
			conn.setAutoCommit(false);
			
			// beginRow 구하는 식
			int beginRow = (currentPage - 1) * rowPerPage;
			
			list = this.ordersDao.selectOrdersListByCustomer(conn, customerId, rowPerPage, beginRow);
			// 디버깅
			System.out.println("OrdersService.java getOrdersListByCustomer conn : " + conn);
			System.out.println("OrdersService.java getOrdersListByCustomer list : " + list.toString());
			
			// 분기
			if(list.size() < 1) {
				System.out.println("OrdersService.java selectOrdersListByCustomer 실패");
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
}
