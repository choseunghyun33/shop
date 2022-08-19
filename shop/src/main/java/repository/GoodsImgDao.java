package repository;

import java.sql.Connection;
import java.sql.PreparedStatement;

import vo.GoodsImg;

public class GoodsImgDao {
	public int insertGoodsImg(Connection conn, GoodsImg goodsImg) throws Exception {
		int row = 0;
		String sql = "INSERT INTO goods_img (goods_no, filename, origin_filename, content_type, create_date) VALUES (?, ?, ?, ?, NOW())";
		
		// stmt 초기화
		PreparedStatement stmt = null;
		
		
		stmt = conn.prepareStatement(sql);
		// stmt setter
		stmt.setInt(1, goodsImg.getGoodsNo());
		stmt.setString(2, goodsImg.getFilename());
		stmt.setString(3, goodsImg.getOriginFilename());
		stmt.setString(4, goodsImg.getContentType());
		// 디버깅
		System.out.println("GoodsImgDao insertGoodsImg stmt : " + stmt);
		
		
		// 쿼리실행
		row = stmt.executeUpdate();
		
		if(stmt != null) {
			stmt.close();
		}
		
		return row;
	}
	
	
	// 이미지 수정
	public int updateGoodsImg(Connection conn, GoodsImg goodsImg) throws Exception {
		int row = 0;
		String sql = "UPDATE goods_img SET filename = ?, origin_filename = ?, content_type = ? WHERE goods_no = ?";
		
		// stmt 초기화
		PreparedStatement stmt = null;
		
		try {
			stmt = conn.prepareStatement(sql);
			// stmt setter
			stmt.setString(1, goodsImg.getFilename());
			stmt.setString(2, goodsImg.getOriginFilename());
			stmt.setString(3, goodsImg.getContentType());
			stmt.setInt(4, goodsImg.getGoodsNo());
			// 디버깅
			System.out.println("GoodsImgDao updateGoodsImg stmt : " + stmt);
			
			
			// 쿼리실행
			row = stmt.executeUpdate();
		} finally {
			if(stmt != null) { stmt.close(); }
		}
		return row;
	}
}
