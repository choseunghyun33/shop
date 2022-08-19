package service;

import java.sql.Connection;

import repository.DBUtil;
import repository.GoodsImgDao;
import vo.GoodsImg;

public class GoodsImgService {
	private DBUtil dbUtil;
	private GoodsImgDao goodsImgDao;
	
	// 이미지 수정할때 - 삭제하고 다시 삽입
	public boolean modifyGoodsImg(GoodsImg goodsImg) {
		// 리턴값 초기화
		boolean result = false;
		
		// 초기화
		this.dbUtil = new DBUtil();
		this.goodsImgDao = new GoodsImgDao();
		Connection conn = null;
		
		try {
			conn = this.dbUtil.getConnection();
			// 디버깅
			System.out.println("GoodsImgService.java modifyGoodsImg conn : " + conn);
			// 커넥션 자동 커밋 해제
			conn.setAutoCommit(false);
			
			// 메서드 실행 (리턴값 1 성공)
			int row = this.goodsImgDao.insertGoodsImg(conn, goodsImg);
			
			// 분기 (리턴값 0 실패시 익셉션 발생)
			if(row == 0) {
				// 디버깅
				System.out.println("GoodsImgService.java modifyGoodsImg insertGoodsImg() 실패");
				throw new Exception();
			}
			
			// 문제 없음 - true
			result = true;
			// 완료될 경우 커밋
			conn.commit();
		} catch(Exception e) {
			e.printStackTrace();
			// 문제있을시 conn 롤백
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
}
