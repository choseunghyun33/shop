package repository;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import vo.Goods;

public class GoodsDao {
	///////////////////////////////////////////////////////////////////////////////////////////////////// lastPage
	public int lastPage(Connection conn) throws Exception{
		int lastPage = 0;
		/*
			SELECT count(*) count FROM goods
		*/
		
		String sql = "SELECT count(*) count FROM goods";
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		try {
			stmt = conn.prepareStatement(sql);
			// 디버깅
			System.out.println("GoodsDao.java lastPage stmt : " + stmt);
			rs = stmt.executeQuery();
			
			if(rs.next()) {
				lastPage = rs.getInt("count");
			}
			
		} finally {
			if(rs != null) { rs.close(); }
			if(stmt != null) { stmt.close(); }
		}
		
		return lastPage;
	}
	
	///////////////////////////////////////////////////////////////////////////////////////////////////// selectGoodsListByPage
	public List<Goods> selectGoodsListByPage(Connection conn, final int rowPerPage, final int beginRow) throws Exception{
		List<Goods> list = new ArrayList<Goods>();
		/*
			SELECT goods_no goodsNo, goods_name goodsName, goods_price goodsPrice, update_date updateDate, create_date createDate, sold_out soldOut FROM goods ORDER BY goods_no DESC LIMIT ?, ?
		 */
		
		String sql = "SELECT goods_no goodsNo, goods_name goodsName, goods_price goodsPrice, update_date updateDate, create_date createDate, sold_out soldOut FROM goods ORDER BY goods_no DESC LIMIT ?, ?";
		// 초기화
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		try {
			stmt = conn.prepareStatement(sql);
			// stmt setter
			stmt.setInt(1, beginRow);
			stmt.setInt(2, rowPerPage);
			// 디버깅
			System.out.println("GoodsDao.java selectGoodsListByPage stmt : " + stmt);
			
			// 쿼리실행
			rs = stmt.executeQuery();
			
			while(rs.next()) {
				// goods 생성 후 setter
				Goods goods = new Goods();
				goods.setGoodsNo(rs.getInt("goodsNo"));
				goods.setGoodsName(rs.getString("goodsName"));
				goods.setGoodsPrice(rs.getInt("goodsPrice"));
				goods.setUpdateDate(rs.getString("updateDate"));
				goods.setCreateDate(rs.getString("createDate"));
				goods.setSoldOut(rs.getString("soldOut"));
				// 디버깅
				System.out.println("GoodsDao.java selectGoodsListByPage goods : " + goods.toString());
				
				// list에 담기
				list.add(goods);
			}
			
		} finally {
			if(rs != null) { rs.close(); }
			if(stmt != null) { stmt.close(); }
		}
		
		return list;
	}
}
