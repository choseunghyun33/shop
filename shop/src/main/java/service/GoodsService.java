package service;

import java.sql.Connection;
import java.util.List;

import repository.DBUtil;
import repository.GoodsDao;
import vo.Goods;

public class GoodsService {
	// 멤버변수
	private GoodsDao goodsDao;
	private DBUtil dbUtil;
	
	///////////////////////////////////////////////////////////////////////////////////////////////////// lastPage
	public int lastPage(){
		int lastPage = 0;
		
		// 메서드 사용할 객체 생성
		this.dbUtil = new DBUtil();
		this.goodsDao = new GoodsDao();
		Connection conn = null;
		
		try {
			conn = this.dbUtil.getConnection();
			// 디버깅
			System.out.println("GoodsService.java lastPage conn : " + conn);
			lastPage = this.goodsDao.lastPage(conn);
			// 디버깅
			System.out.println("GoodsService.java lastPage lastPage : " + lastPage);
			
		} catch(Exception e) {
			e.printStackTrace();
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
	
	
	///////////////////////////////////////////////////////////////////////////////////////////////////// getGoodsListByPage
	public List<Goods> getGoodsListByPage(final int rowPerPage, final int currentPage){
		List<Goods> list = null;
		Connection conn = null;
		
		this.goodsDao = new GoodsDao();
		
		// 시작페이지 구하기
		int beginRow = (currentPage - 1) * rowPerPage;
		
		try {
			conn = this.dbUtil.getConnection();
			// 디버깅
			System.out.println("GoodsService.java getGoodsListByPage conn : " + conn);
			
			// 메서드 리턴값 담기
			list = this.goodsDao.selectGoodsListByPage(conn, rowPerPage, beginRow);
			// 디버깅
			System.out.println("GoodsService.java getGoodsListByPage list : " + list.toString());
			
		} catch(Exception e) {
			e.printStackTrace();
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
		
		return list;
	}
}
