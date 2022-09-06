package service;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import repository.BuyDao;
import repository.DBUtil;
import vo.Cart;

public class BuyService {
	// 멤버변수	
	private DBUtil dbUtil;
	private BuyDao buyDao;
	
	// getBuyListByCart
	// 기능 : 카트리스트 보기
	// 리턴값 : List 
	public List<Map<String, Object>> getBuyListByDirect(Cart cart){
		// 리턴값 초기화
		List<Map<String, Object>> list = null;
		
		// DB연결 위한 conn 초기화
		Connection conn = null;
		
		// 멤버변수 new
		this.dbUtil = new DBUtil();
		this.buyDao = new BuyDao();
		
		try {
			// conn 메서드
			conn = this.dbUtil.getConnection();
			
			// 디버깅
			System.out.println("BuyService.java getBuyListByDirect conn : " + conn);
			
			// conn 자동커밋 해제
			conn.setAutoCommit(false);
			
			// 메서드 실행
			list = this.buyDao.selectBuyListByDirect(conn, cart);
			
			// 실패할 경우 m == null
			// 그럴경우 exception 발생
			if(list == null) {
				// 디버깅
				System.out.println("BuyService.java getBuyListByDirect selectBuyListByDirect() 실패");
				
				// exception 만들기
				throw new Exception();
			}
			
			// 완료될 경우 commit
			conn.commit();
		} catch(Exception e) {
			e.printStackTrace();
			// 익셉션이 있을경우 rollback
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
	
	// getBuyListByCart
	// 기능 : 카트리스트 보기
	// 리턴값 : List 
	public List<Map<String, Object>> getBuyListByCart(List<Cart> cartList){
		// 리턴값 초기화
		List<Map<String, Object>> list = null;
		
		// DB연결 위한 conn 초기화
		Connection conn = null;
		
		// 멤버변수 new
		this.dbUtil = new DBUtil();
		this.buyDao = new BuyDao();
		
		try {
			// conn 메서드
			conn = this.dbUtil.getConnection();
			
			// 디버깅
			System.out.println("BuyService.java getBuyListByCart conn : " + conn);
			
			// conn 자동커밋 해제
			conn.setAutoCommit(false);
			
			// 메서드 실행
			list = this.buyDao.selectBuyListByCart(conn, cartList);
			
			// 실패할 경우 m == null
			// 그럴경우 exception 발생
			if(list == null) {
				// 디버깅
				System.out.println("BuyService.java getBuyListByCart selectBuyListByCart() 실패");
				
				// exception 만들기
				throw new Exception();
			}
			
			// 완료될 경우 commit
			conn.commit();
		} catch(Exception e) {
			e.printStackTrace();
			// 익셉션이 있을경우 rollback
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

