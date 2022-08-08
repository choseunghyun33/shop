package repository;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import vo.Goods;

public class GoodsDao {
	
	///////////////////////////////////////////////////////////////////////////////////////////////////// selectGoodsAndImgOne
	public Map<String, Object> selectGoodsAndImgOne(Connection conn, int goodsNo) throws Exception{
		Map<String, Object> map = null;
		
		String sql = "SELECT g.goods_no goodsNo, g.goods_name goodsName, g.goods_price goodsPrice, g.update_date updateDate, g.create_date createDate, g.sold_out soldOut, gi.filename filename, gi.origin_filename originFilename, gi.content_type contentType FROM goods g INNER JOIN goods_img gi ON g.goods_no = gi.goods_no WHERE g.goods_no = ?";
		PreparedStatement stmt = null;
		ResultSet rs = null;
		/*
			SELECT FROM goods g INNER JOIN goods_img gi ON g.goods_no = gi.goods_no WHERE g.goods_no = ?
		 
			
			while(rs.next()) {
				Map<String, Object> m = new HashMap<String, Object>();
				m.put("goodsNo", rs.getInt("goodsNo"));
			}
			
			쿼리에서 where 조건이 없다면?
			
			반환 타입 List<Map<String, Object>> list
			
		 */
		try {
			stmt = conn.prepareStatement(sql);
			// stmt setter
			stmt.setInt(1, goodsNo);
			// 디버깅
			System.out.println("GoodsDao.java selectGoodsAndImgOne stmt : " + stmt);
			
			// 쿼리담기
			rs = stmt.executeQuery();
			if(rs.next()) {
				map = new HashMap<String, Object>();
				// map에 담기
				map.put("goodsNo", rs.getInt("goodsNo"));
				map.put("goodsName", rs.getString("goodsName"));
				map.put("goodsPrice", rs.getInt("goodsPrice"));
				map.put("updateDate", rs.getString("updateDate"));
				map.put("createDate", rs.getString("createDate"));
				map.put("soldOut", rs.getString("soldOut"));
				map.put("filename", rs.getString("filename"));
				map.put("originFilename", rs.getString("originFilename"));
				map.put("contentType", rs.getString("contentType"));
			}
			
		} finally {
			if(rs != null) { rs.close(); }
			if(stmt != null) { stmt.close(); }
		}
		
		return map;
	}
	
	///////////////////////////////////////////////////////////////////////////////////////////////////// allCount
	public int allCount(Connection conn) throws Exception{
		int allCount = 0;
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
				allCount = rs.getInt("count");
			}
			
		} finally {
			if(rs != null) { rs.close(); }
			if(stmt != null) { stmt.close(); }
		}
		
		return allCount;
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
