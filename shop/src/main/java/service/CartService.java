package service;

import java.sql.Connection;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import repository.CartDao;
import repository.DBUtil;
import vo.Cart;

public class CartService {
	// 멤버변수
	private DBUtil dbUtil;
	private CartDao cartDao;
	
	// removeCartById
	// 기능 : 카트품목 삭제
	// 리턴값 : boolean 
	public boolean removeCartById(List<Cart> cartList) {
		// 리턴값 초기화
		boolean result = false;
		
		// DB연결 위한 conn 초기화
		Connection conn = null;
		
		// 멤버변수 new
		this.dbUtil = new DBUtil();
		this.cartDao = new CartDao();
		
		try {
			// conn 메서드
			conn = this.dbUtil.getConnection();
			
			// 디버깅
			System.out.println("CartService.java removeCartById conn : " + conn);
			
			// conn 자동커밋 해제
			conn.setAutoCommit(false);
			
			// 메서드 실행
			// row 리턴값이 1일 경우 성공 0일 경우 실패
			List<Integer> list = this.cartDao.deleteCartById(conn, cartList);
			
			for(Integer i : list) {
				// 리턴값이 0일 경우 실패 - 익셉션 발생시켜 rollback하기
				if(i == 0) {
					// 디버깅
					System.out.println("CartService.java removeCartById deleteCartById() 실패");
					
					// 익셉션 만들기
					throw new Exception();
				}	
			}
			
			// 문제없다면 result = true
			result = true;
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
		
		return result;			
	}
	
	// getCartById
	// 기능 : 카트리스트 보기
	// 리턴값 : List 
	public List<Map<String, Object>> getCartById(Cart cart) {
		// 리턴값 초기화
		List<Map<String, Object>> list = new ArrayList<>();
		
		// DB연결 위한 conn 초기화
		Connection conn = null;
		
		// 멤버변수 new
		this.dbUtil = new DBUtil();
		this.cartDao = new CartDao();
		
		try {
			// conn 메서드
			conn = this.dbUtil.getConnection();
			
			// 디버깅
			System.out.println("CartService.java getCartById conn : " + conn);
			
			// conn 자동커밋 해제
			conn.setAutoCommit(false);
			
			// 메서드 실행
			list = this.cartDao.selectCartById(conn, cart);
			
			// 실패할 경우 list == null
			// 그럴경우 exception 발생
			if(list == null) {
				// 디버깅
				System.out.println("CartService.java getCartById selectCartById() 실패");
				
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
	
	// addCart
	// 기능 : 카트에 담기
	// 리턴값 : boolean (true - 성공, false - 실패)
	public boolean addCart(Cart cart) {
		// 리턴값 초기화
		boolean result = false;
		
		// DB연결 위한 conn 초기화
		Connection conn = null;
		
		// 멤버변수 new
		this.dbUtil = new DBUtil();
		this.cartDao = new CartDao();
		
		try {
			// conn 메서드
			conn = this.dbUtil.getConnection();
			
			// 디버깅
			System.out.println("CartService.java addCart conn : " + conn);
			
			// conn 자동커밋 해제
			conn.setAutoCommit(false);
			
			// 메서드 실행
			// row 리턴값이 1일 경우 성공 0일 경우 실패
			int row = this.cartDao.insertCart(conn, cart);

			// 리턴값이 0일 경우 실패 - 익셉션 발생시켜 rollback하기
			if(row == 0) {
				// 디버깅
				System.out.println("CartService.java addCart insertCart() 실패");
				
				// 익셉션 만들기
				throw new Exception();
			}
			
			// 문제없다면 result = true
			result = true;
			
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
		
		return result;
	}
}
