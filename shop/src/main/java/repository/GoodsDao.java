package repository;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.naming.spi.DirStateFactory.Result;

import vo.Goods;

public class GoodsDao {
	///////////////////////////////////////////////////////////////////////////////////////////////////// updateGoods
	// goods수정
	public int updateGoods(Connection conn, Goods goods) throws Exception {
		// 리턴값 초기
		int row = 0;
		// 쿼리
		String sql = "UPDATE goods SET goods_name = ?, goods_price = ?, sold_out = ?, update_date = NOW() WHERE goods_no = ?";
		
		// 초기화
		PreparedStatement stmt = null;
		
		try {
			stmt = conn.prepareStatement(sql);
			// stmt setter
			stmt.setString(1, goods.getGoodsName());
			stmt.setInt(2, goods.getGoodsPrice());
			stmt.setString(3, goods.getSoldOut());
			stmt.setInt(4, goods.getGoodsNo());
			// 디버깅
			System.out.println("GoodsDao.java updateGoods stmt : " + stmt);
			
			// 쿼리실행
			row = stmt.executeUpdate();
			
		} finally {
			if(stmt != null) { stmt.close(); }
		}
		
		return row;
	}
	
	///////////////////////////////////////////////////////////////////////////////////////////////////// selectCustomerGoodsListByPage 
	// 고객 상품리스트 페이지로 반환
	public List<Map<String, Object>> selectCustomerGoodsListByPage(Connection conn, final int rowPerPage, final int beginRow, final String listVer) throws Exception {
		List<Map<String, Object>> list = new ArrayList<>();
		String viewCountSql = "";
		
		String orderSql = "SELECT g.goods_no goodsNo, g.goods_name goodsName, g.goods_price goodsPrice, g.sold_out soldOut, gi.filename fileName FROM goods g LEFT JOIN (SELECT goods_no, SUM(order_quantity) sumNum FROM orders GROUP BY goods_no) t ON g.goods_no = t.goods_no INNER JOIN goods_img gi ON g.goods_no = gi.goods_no ORDER BY IFNULL(t.sumNum, 0) DESC limit ?, ?";
		
		String lowPriceSql = "SELECT g.goods_no goodsNo, g.goods_name goodsName, g.goods_price goodsPrice, g.sold_out soldOut, gi.filename fileName FROM goods g INNER JOIN goods_img gi ON g.goods_no = gi.goods_no ORDER BY g.goods_price LIMIT ?, ?";
		
		String highPriceSql = "SELECT g.goods_no goodsNo, g.goods_name goodsName, g.goods_price goodsPrice, g.sold_out soldOut, gi.filename fileName FROM goods g INNER JOIN goods_img gi ON g.goods_no = gi.goods_no ORDER BY g.goods_price DESC LIMIT ?, ?";
		
		String createDateSql = "SELECT g.goods_no goodsNo, g.goods_name goodsName, g.goods_price goodsPrice, g.sold_out soldOut, gi.filename fileName FROM goods g INNER JOIN goods_img gi ON g.goods_no = gi.goods_no ORDER BY g.create_date DESC LIMIT ?, ?";
		
		String sql = "";
	
		/*
			인기순
			아직 클릭수가 구현되지 않았음
			고객이 주문수의 desc 
			SELECT g.goods_no, g.goods_name goodsName, g.goods_price goodsPrice, gi.filename FROM goods g LEFT JOIN (SELECT goods_no, SUM(order_quantity) sumNum FROM orders GROUP BY goods_no) t ON g.goods_no = t.goods_no INNER JOIN goods_img gi ON g.goods_no = gi.goods_no ORDER BY IFNULL(t.sumNum, 0) DESC LIMIT 0,10
		
		
			낮은가격순
			높은가격순
			최신순
	
		 */
		
		// 분기로 sql문을 다르게
		switch(listVer) {
			case "viewCountVer" : sql = viewCountSql; break; 
			case "orderVer" : sql = orderSql; break;
			case "lowPriceVer" : sql = lowPriceSql; break;
			case "highPriceVer" : sql = highPriceSql; break;
			case "createDateVer" : sql = createDateSql; break;
		}
		
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		try {
			stmt = conn.prepareStatement(sql);
			// stmt setter
			stmt.setInt(1, beginRow);
			stmt.setInt(2, rowPerPage);
			rs = stmt.executeQuery();
			
			while(rs.next()) {
				Map<String, Object> map = new HashMap<String, Object>();
				// map에 담기
				map.put("goodsNo", rs.getInt("goodsNo"));
				map.put("goodsName", rs.getString("goodsName"));
				map.put("goodsPrice", rs.getInt("goodsPrice"));
				map.put("soldOut", rs.getString("soldOut"));
				map.put("fileName", rs.getString("fileName"));
				
				// list에 담기
				list.add(map);
			}
		} finally {
			if(rs != null) { rs.close(); }
			if(stmt != null) { stmt.close(); }
		}
		
		return list;
	}
	
	///////////////////////////////////////////////////////////////////////////////////////////////////// updateSoldOutByKey
	public int updateSoldOutByKey(Connection conn, int goodsNo, String soldOut) throws Exception {
		int row = 0;
		String sql = "UPDATE goods SET sold_out = ?, update_date = now() where goods_no = ?";
		// stmt 초기화
		PreparedStatement stmt = null;
		
		try {
			stmt = conn.prepareStatement(sql);
			// stmt setter
			stmt.setString(1, soldOut);
			stmt.setInt(2, goodsNo);
			
			System.out.println("GoodsDao.java updateSoldOutByKey stmt : " + stmt);
			
			// 쿼리실행
			row = stmt.executeUpdate();
			
		} finally {
			if(stmt != null) { stmt.close(); }
		}
		
		return row;
	}
	
	
	///////////////////////////////////////////////////////////////////////////////////////////////////// insertGoods
	// 리턴값 : key값(goods_no) - jdbc 메서드를 사용하면 된다
	public int insertGoods(Connection conn, Goods goods) throws Exception {
		int goodsNo = 0; // keyId
		String sql = "INSERT INTO goods (goods_name, goods_price, update_date, create_date, sold_out) VALUES (?, ?, NOW(), NOW(), ?)";
		PreparedStatement stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS); // 키값을 반환하게 변경
		// stmt setter
		stmt.setString(1, goods.getGoodsName());
		stmt.setInt(2, goods.getGoodsPrice());
		stmt.setString(3, goods.getSoldOut());
		// 디버깅
		System.out.println("GoodsDao.java insertGoods stmt : " + stmt);
		
		// 1) insert 
		stmt.executeUpdate(); // 성공한 row의 수 
		// 2) select last_ai_key from  
		ResultSet rs = stmt.getGeneratedKeys(); // 컬럼명을 알 수 없다! select 문 순서가 첫번째 컬럼이기때문에 받을 수 있다.
		
		if(rs.next()) {
			goodsNo = rs.getInt(1);
		}
		
		if(rs != null) { rs.close(); }
		if(stmt != null) { stmt.close(); }
		
		return goodsNo;
	}
	
	
	///////////////////////////////////////////////////////////////////////////////////////////////////// selectGoodsAndImgOne
	public Map<String, Object> selectGoodsAndImgOne(Connection conn, int goodsNo) throws Exception{
		Map<String, Object> map = null;
		
		String sql = "SELECT g.goods_no goodsNo, g.goods_name goodsName, g.goods_price goodsPrice, g.update_date updateDate, g.create_date createDate, g.sold_out soldOut, gi.filename filename, gi.origin_filename originFilename, gi.content_type contentType "
				+ "FROM goods g INNER JOIN goods_img gi ON g.goods_no = gi.goods_no WHERE g.goods_no = ?";
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
		
		String sql = "SELECT goods_no goodsNo, goods_name goodsName, goods_price goodsPrice, update_date updateDate, create_date createDate, sold_out soldOut "
				+ "FROM goods ORDER BY goods_no DESC LIMIT ?, ?";
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
