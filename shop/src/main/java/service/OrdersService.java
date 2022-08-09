package service;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import repository.DBUtil;
import repository.OrdersDao;
import vo.Orders;

public class OrdersService {
	// 멤버변수
	DBUtil dbUtil;
	OrdersDao ordersDao;
	
	///////////////////////////////////////////////////////////////////////////////////////////////////// modifyOrdersByOrders	
	public boolean modifyOrdersByOrders(Orders orders){
		// conn 초기화
		Connection conn = null;
		
		// dbUtil, ordersDao 초기화
		this.dbUtil = new DBUtil();
		this.ordersDao = new OrdersDao();
		
		try {
			conn = this.dbUtil.getConnection();
			// 디버깅
			System.out.println("OrdersService.java modifyOrdersByOrders conn : " + conn);
			
			// 메서드 실행 - row 0이면 update 안됨
			int row = this.ordersDao.updateOrdersByOrders(conn, orders);
			// 디버깅
			System.out.println("OrdersService.java modifyOrdersByOrders row : " + row);
			
			// 분기
			if(row == 1) {
				System.out.println("OrdersService.java modifyOrdersByOrders update 성공");
			} else {
				System.out.println("OrdersService.java modifyOrdersByOrders update 실패");
				throw new Exception();
			}
		} catch(Exception e) {
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
	
	
	///////////////////////////////////////////////////////////////////////////////////////////////////// updateOrderStateByOrderNo	
	public boolean modifyOrderStateByOrderNo(String orderState, int orderNo) {
		// conn 초기화
		Connection conn = null;
		
		// dbUtil, ordersDao 초기화
		this.dbUtil = new DBUtil();
		this.ordersDao = new OrdersDao();
		
		try {
			conn = this.dbUtil.getConnection();
			// 디버깅
			System.out.println("OrdersService.java modifyOrderStateByOrderNo conn : " + conn);
			
			// 메서드 실행 - row 0이면 update 안됨
			int row = this.ordersDao.updateOrderStateByOrderNo(conn, orderState, orderNo);
			// 디버깅
			System.out.println("OrdersService.java modifyOrderStateByOrderNo row : " + row);
			
			// 분기
			if(row == 1) {
				System.out.println("OrdersService.java modifyOrderStateByOrderNo update 성공");
			} else {
				System.out.println("OrdersService.java modifyOrderStateByOrderNo update 실패");
				throw new Exception();
			}
		} catch(Exception e) {
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
			
			// 마지막페이지 구하기 식
			lastPage = (int) Math.ceil(allCount / (double) rowPerPage);
			
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			// DB 자원해제
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
			
			if(this.ordersDao.selectOrdersOne(conn, orderNo) == null) {
				System.out.println("OrdersService.java selectOrdersOne 실패");
			} else {
				System.out.println("OrdersService.java selectOrdersOne 성공");
			}
		} catch(Exception e){
			e.printStackTrace();
		} finally {
			// DB 연동해제
			if(conn != null) {
				try {
					conn.close();
				} catch (Exception e) {
					e.printStackTrace();
				}
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
			
			// beginRow 구하는 식
			int beginRow = (currentPage - 1) * rowPerPage;
			
			list = this.ordersDao.selectOrdersList(conn, rowPerPage, beginRow);
			// 디버깅
			System.out.println("OrdersService.java getOrdersListByCustomer conn : " + conn);
			System.out.println("OrdersService.java getOrdersListByCustomer list : " + list.toString());
			
			// 분기
			if(list.size() < 1) {
				System.out.println("OrdersService.java selectOrdersList 실패");
			} else {
				System.out.println("OrdersService.java selectOrdersList 성공");
			}
		} catch(Exception e){
			e.printStackTrace();
		} finally {
			// DB 연동해제
			if(conn != null) {
				try {
					conn.close();
				} catch (Exception e) {
					e.printStackTrace();
				}
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

			// beginRow 구하는 식
			int beginRow = (currentPage - 1) * rowPerPage;
			
			list = this.ordersDao.selectOrdersListByCustomer(conn, customerId, rowPerPage, beginRow);
			// 디버깅
			System.out.println("OrdersService.java getOrdersListByCustomer conn : " + conn);
			System.out.println("OrdersService.java getOrdersListByCustomer list : " + list.toString());
			
			// 분기
			if(list.size() < 1) {
				System.out.println("OrdersService.java selectOrdersListByCustomer 실패");
			} else {
				System.out.println("OrdersService.java selectOrdersListByCustomer 성공");
			}
		} catch(Exception e){
			e.printStackTrace();
		} finally {
			// DB 연동해제
			if(conn != null) {
				try {
					conn.close();
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		}
		
		return list;
	}
}
