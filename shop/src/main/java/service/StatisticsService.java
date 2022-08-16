package service;

import java.sql.Connection;
import java.util.Map;

import repository.DBUtil;
import repository.StatisticsDao;

public class StatisticsService {
	private DBUtil dbUtil;
	private StatisticsDao statisticsDao;
	
	// 누적구매수 누적조회수
	public Map<String,Object> getCount() {
		Map<String, Object> m = null;
		
		// 초기화
		this.dbUtil = new DBUtil();
		this.statisticsDao = new StatisticsDao();
		Connection conn = null;
		
		try {
			conn = this.dbUtil.getConnection();
			conn.setAutoCommit(false);
			
			m = this.statisticsDao.selectCount(conn);
			
			if(m == null) {
				System.out.println("StatisticsService selectCount 실패");
				throw new Exception();
			}
			
			conn.commit();
		} catch(Exception e) {
			e.printStackTrace();
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
		
		return m;
	}
}
