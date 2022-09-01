package service;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import repository.DBUtil;
import repository.GoodsDao;
import repository.GoodsImgDao;
import vo.Goods;
import vo.GoodsImg;

public class GoodsService {
	// 서비스 : 트랜잭션 + action이나 dao가 해서는 안되는 일
	// 멤버변수
	private GoodsDao goodsDao;
	private GoodsImgDao goodsImgDao;
	private DBUtil dbUtil;
	
	
	
	//////////////////////////////////////////////////////////////////////////////////////////////////// modifyGoods
	public boolean modifyGoods(Goods goods) {
		boolean result = false;
		
		// conn 초기화
		Connection conn = null;
		// 멤버변수 초기화
		this.dbUtil = new DBUtil();
		this.goodsDao = new GoodsDao();
		
		try {
			conn = this.dbUtil.getConnection();
			// 디버깅
			System.out.println("GoodsService.java modifyGoods conn : " + conn);
			
			// 자동 커밋 수정
			conn.setAutoCommit(false);
			
			// 리턴값 1 성공 0 실패
			int row = this.goodsDao.updateGoods(conn, goods);
			// 디버깅
			System.out.println("GoodsService.java modifyGoods row : " + row);
			
			if(row == 0) {
				System.out.println("GoodsService.java modifyGoods update 실패");
				throw new Exception();
			}
			
			result = true;
			// 완료되면 커밋
			conn.commit();
		} catch (Exception e) {
			e.printStackTrace();
			// 문제 있으면 롤백
			try {
				conn.rollback();
			} catch (Exception e1) {
				e1.printStackTrace();
			}
		} finally {
			if(conn != null) {
				try {
					conn.close();
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		}
		
		return result;
	}
	
	///////////////////////////////////////////////////////////////////////////////////////////////////// getCustomerGoodsListByPage 
	public List<Map<String, Object>> getCustomerGoodsListByPage(final int rowPerPage, final int currentPage, final String listVer) {
		List<Map<String, Object>> list = null;
		
		// conn 초기화
		Connection conn = null;
		// 멤버변수 초기화
		this.dbUtil = new DBUtil();
		this.goodsDao = new GoodsDao();
		
		// beginRow 구하기
		int beginRow = (currentPage - 1) * rowPerPage;
		
		try {
			conn = this.dbUtil.getConnection();
			// 디버깅
			System.out.println("GoodsService.java getCustomerGoodsListByPage conn : " + conn);
			
			// 자동 커밋 해제
			conn.setAutoCommit(false);
			
			// 메서드 실행
			list = this.goodsDao.selectCustomerGoodsListByPage(conn, rowPerPage, beginRow, listVer);
			
			// 완료되지 않으면 익셉션 만들기
			if(list.size() < 1) {
				// 디버깅
				System.out.println("GoodsService.java getCustomerGoodsListByPage selectCustomerGoodsListByPage() 실패");
				throw new Exception();
			}
			// 완료되면 커밋
			conn.commit();
		} catch (Exception e) {
			e.printStackTrace();
			// 문제 있으면 롤백
			try {
				conn.rollback();
			} catch (Exception e1) {
				e1.printStackTrace();
			}
		} finally {
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
	
	
	///////////////////////////////////////////////////////////////////////////////////////////////////// updateSoldOutByKey
	public boolean modifySoldOutByKey(int goodsNo, String soldOut) {
		// 리턴값 초기화
		boolean result = false;
		
		// conn 초기화
		Connection conn = null;
		// 멤버변수 초기화
		this.dbUtil = new DBUtil();
		this.goodsDao = new GoodsDao();
		
		try {
			conn = this.dbUtil.getConnection();
			// 디버깅
			System.out.println("GoodsService.java modifySoldOutByKey conn" + conn);
			
			conn.setAutoCommit(false);
			
			// 메서드 실행 - 0 update 실패
			int row = this.goodsDao.updateSoldOutByKey(conn, goodsNo, soldOut);
			// 디버깅
			System.out.println("GoodsService.java modifySoldOutByKey row : " + row);
			
			// 분기
			if(row == 1) {
				System.out.println("GoodsService.java modifySoldOutByKey 성공");
			} else {
				System.out.println("GoodsService.java modifySoldOutByKey 실패");
				throw new Exception();
			}
			
			// 완료되면 커밋
			conn.commit();
		} catch (Exception e) {
			e.printStackTrace();
			// 문제있으면 롤백
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
		return true;
	}
	

	///////////////////////////////////////////////////////////////////////////////////////////////////// addGoods
	// 트랜젝션
	public void addGoods(Goods goods, GoodsImg goodsImg) {
		// 메서드 사용할 객체생성
		this.dbUtil = new DBUtil();
		this.goodsDao = new GoodsDao();

		Connection conn = null;
		
		try {
			conn = new DBUtil().getConnection();
			// 디버깅
			System.out.println("GoodsService.java addGoods conn : " + conn);
			
			// 자동 commit 끄기
			conn.setAutoCommit(false);
			
			goodsDao = new GoodsDao();
			goodsImgDao = new GoodsImgDao();
			
			int goodsNo = goodsDao.insertGoods(conn, goods); // goodsNo가 AI로 자동생성되어 DB입력
			
			if(goodsNo != 0) { // 0이 아니면 키가 있다는 뜻
				// 키값 setter
				goodsImg.setGoodsNo(goodsNo);
				
				if(goodsImgDao.insertGoodsImg(conn, goodsImg) == 0) {
					throw new Exception(); // 이미지 입력실패시 강제로 rollback(catch)절 이동
				}
			}
			
			conn.commit();
		} catch(Exception e) {
			e.printStackTrace();
			// Exception 발생시
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
	}
	
	
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
			
			// 자동커밋 해제
			conn.setAutoCommit(false);
			
			// 1. 상세보기 메서드
			map = this.goodsDao.selectGoodsAndImgOne(conn, goodsNo);
			// 디버깅
			System.out.println("GoodsService.java getGoodsAndImgOne map : " + map.toString());
		
			// 문제있다면 익셉션 발생
			if(map.size() < 1) {
				// 디버깅
				System.out.println("GoodsService.java getGoodsAndImgOne selectGoodsAndImgOne() 실패");
				throw new Exception();
			}
			
			// 2. 조회수증가 메서드
			int row = this.goodsDao.updateGoodsHit(conn, goodsNo);
			
			// 제대로 들어오지 못함 exception 발생시키기
			if(row == 0) {
				// 디버깅
				System.out.println("GoodsService.java getGoodsAndImgOne updateGoodsHit() : 실패");
				throw new Exception();
			}
			
			// 완료되면 커밋
			conn.commit();
		} catch (Exception e) {
			e.printStackTrace();
			// 문제있으면 롤백
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
			
			// 자동커밋 해제
			conn.setAutoCommit(false);
						
			int allCount = this.goodsDao.allCount(conn);
			// 디버깅
			System.out.println("GoodsService.java lastPage allCount : " + allCount);
			
			// 마지막페이지 구하기
			lastPage = (int) Math.ceil (allCount / (double)rowPerPage);
			
			// 문제있다면 익셉션 발생
			if(lastPage == 0) {
				// 디버깅
				System.out.println("GoodsService.java lastPage allCount() 실패");
				throw new Exception();
			}
			
			// 완료되면 커밋
			conn.commit();
		} catch(Exception e) {
			e.printStackTrace();
			// 문제있으면 롤백
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
			
			// 자동커밋 해제
			conn.setAutoCommit(false);
			
			// 메서드 리턴값 담기
			list = this.goodsDao.selectGoodsListByPage(conn, rowPerPage, beginRow);
			// 디버깅
			System.out.println("GoodsService.java getGoodsListByPage list : " + list.toString());
			
			// 문제 생기면 익셉션 만들기
			if(list.size() < 0) {
				// 디버깅
				System.out.println("GoodsService.java getGoodsListByPage selectGoodsListByPage() 실패");
				throw new Exception();
			}
			
			// 완료되면 커밋
			conn.commit();
		} catch(Exception e) {
			e.printStackTrace();
			// 문제있으면 롤백
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
		
		return list;
	}
}
