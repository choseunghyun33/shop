package service;

import java.sql.Connection;
import java.util.List;
import java.util.Map;

import repository.DBUtil;
import repository.GoodsDao;
import vo.Goods;

public class GoodsService {
	// 멤버변수
	private GoodsDao goodsDao;
	private DBUtil dbUtil;
	
	///////////////////////////////////////////////////////////////////////////////////////////////////// getGoodsAndImgOne
	public Map<String, Object> getGoodsAndImgOne(int goodsNo) {
		Map<String, Object> map = null;
		
		// 메서드 사용할 객체생성
		this.dbUtil = new DBUtil();
		this.goodsDao = new GoodsDao();
		Connection conn = null;
		
		try {
			conn = this.dbUtil.getConnection();
			// 디버깅
			System.out.println("GoodsService.java getGoodsAndImgOne conn : " + conn);
			
			map = this.goodsDao.selectGoodsAndImgOne(conn, goodsNo);
			// 디버깅
			System.out.println("GoodsService.java getGoodsAndImgOne map : " + map.toString());
		
		} catch (Exception e) {
			
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
		
		return map;
	}
	
	///////////////////////////////////////////////////////////////////////////////////////////////////// lastPage
	public int lastPage(final int rowPerPage){
		int lastPage = 0;
		
		// 메서드 사용할 객체 생성
		this.dbUtil = new DBUtil();
		this.goodsDao = new GoodsDao();
		Connection conn = null;
		
		
		try {
			conn = this.dbUtil.getConnection();
			// 디버깅
			System.out.println("GoodsService.java lastPage conn : " + conn);
			int allCount = this.goodsDao.allCount(conn);
			// 디버깅
			System.out.println("GoodsService.java lastPage allCount : " + allCount);
			
			// 마지막페이지 구하기
			lastPage = (int) Math.ceil (allCount / (double)rowPerPage);
			
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
