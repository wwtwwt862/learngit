package com.amarsoft.app.pidr.index;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.Date;

import com.amarsoft.app.pidr.common.CheckDBKind;
import com.amarsoft.app.pidr.common.DBManager;
import com.amarsoft.app.pidr.common.PIDRConstants;
import com.amarsoft.are.ARE;

/**
 * 首页统计数量处理类
 * @author yyzang
 *
 */
public class StatisCountHandler {

	/**
	 * 获取校验和反馈错误数量
	 * @return
	 */
	public int[] getErrorCount() {
		
		int[] result = new int[2];
		Connection conn = null;
		PreparedStatement ps1 = null;
		PreparedStatement ps2 = null;
		ResultSet rs1 = null;
		ResultSet rs2 = null;
		try {
			conn = DBManager.getConnection();
			//获取校验错误数量
			String validateSql = "select count(1) as count from PIDR_VALIDATEERRORS";
			ps1 = conn.prepareStatement(validateSql);
			rs1 = ps1.executeQuery();
			if(rs1.next()) {
				result[0] = rs1.getInt("count");
			}
			String feedbackSql = "select count(1) as count from PIDR_FEEDBACK";
			ps2 = conn.prepareStatement(feedbackSql);
			rs2 = ps2.executeQuery();
			if(rs2.next()) {
				result[1] = rs2.getInt("count");
			}			
		} catch (SQLException e) {
			ARE.getLog().error("首页获取校验和反馈错误数量时出错",e);
		}finally {
			DBManager.close(rs1);
			DBManager.close(rs2);
			DBManager.close(ps1);
			DBManager.close(ps2);
			DBManager.close(conn);
		}
		return result;
	}
	
	/**
	 * 统计昨日报文报送数量
	 * @return
	 */
	public int[] getReportCount() {
		new CheckDBKind().initDBKind();//判断数据库类型
		String dbKind = ARE.getProperty("DBKind");
		int[] result = new int[7];
		Connection conn = null;
		PreparedStatement ps= null;
		PreparedStatement ps1 = null;
		PreparedStatement ps2 = null;
		PreparedStatement ps3 = null;
		PreparedStatement ps4 = null;
		PreparedStatement ps5 = null;
		PreparedStatement ps6 = null;
		PreparedStatement ps7 = null;
		ResultSet rs = null;
		ResultSet rs1 = null;
		ResultSet rs2 = null;
		ResultSet rs3 = null;
		ResultSet rs4 = null;
		ResultSet rs5 = null;
		ResultSet rs6 = null;
		ResultSet rs7 = null;
		try {
			 conn = DBManager.getConnection();
			 //最新一次执行批量的日期
			 String batchDate = "";
			 String sql="";
			 if(PIDRConstants.DBKIND_MYSQL.equals(dbKind)) {//mysql
				 sql = "select max(left(InputDate,10) ) as batchDate from TASK_RUN_HISTORY where StatusType  ='task'";
			 }else {
				 sql = "select max(substr(TO_char(INPUTDATE,'yyyy-mm-dd'),1,10) ) as batchDate from TASK_RUN_HISTORY where StatusType  ='task'";
			 }
			 ps = conn.prepareStatement(sql);
			 rs = ps.executeQuery();
			 if(rs.next()) {
				 batchDate = rs.getString("batchDate");
			 }else {
				 batchDate = new SimpleDateFormat(PIDRConstants.DATEFORMAT_1).format(new Date());
			 }
			 //统计评级信息数量
			 String getRateCountSql = "select count(1) as count from  HPIDR_RATE_BS where OccurDate = ? and length(SessionId) = 16  ";
			 ps1 = conn.prepareStatement(getRateCountSql);
			 ps1.setString(1, batchDate);
			 rs1 = ps1.executeQuery();
			 if(rs1.next()) {
				 result[0] = rs1.getInt("count");
			 }
			 //统计评级标识变更数量
			 String getRateIdChangeCountSql = "select count(1) as count from  HPIDR_RATE_IDCHANGE where OccurDate = ? and length(SessionId) = 14  ";
			 ps2 = conn.prepareStatement(getRateIdChangeCountSql);
			 ps2.setString(1, batchDate);
			 rs2 = ps2.executeQuery();
			 if(rs2.next()) {
				 result[1] = rs2.getInt("count");
			 }
			 //统计评级按段更正数量
			 String getRateMdfCountSql = "select count(1) as count from  HPIDR_RATE_MDFCINFO where OccurDate = ? and length(SessionId) = 14  ";
			 ps3 = conn.prepareStatement(getRateMdfCountSql);
			 ps3.setString(1, batchDate);
			 rs3 = ps3.executeQuery();
			 if(rs3.next()) {
				 result[2] = rs3.getInt("count");
			 }
			 //统计评级整笔删除数量
			 String getRateAllDltCountSql = "select count(1) as count from  HPIDR_RATE_ALLDLT where OccurDate = ? and length(SessionId) = 14  ";
			 ps4 = conn.prepareStatement(getRateAllDltCountSql);
			 ps4.setString(1, batchDate);
			 rs4 = ps4.executeQuery();
			 if(rs4.next()) {
				 result[3] = rs4.getInt("count");
			 }
			 //统计信贷资产信息数量
			 String getCreAssCountSql = "select count(1) as count from  HPIDR_CREASS_BS where OccurDate = ? and length(SessionId) = 16  ";
			 ps5 = conn.prepareStatement(getCreAssCountSql);
			 ps5.setString(1, batchDate);
			 rs5 = ps5.executeQuery();
			 if(rs5.next()) {
				 result[4] = rs5.getInt("count");
			 }
			 //统计信贷资产标识变更数量
			 String getCreAssIdChangeCountSql = "select count(1) as count from  HPIDR_CREASS_IDCHANGE where OccurDate = ? and length(SessionId) = 14  ";
			 ps6 = conn.prepareStatement(getCreAssIdChangeCountSql);
			 ps6.setString(1, batchDate);
			 rs6 = ps6.executeQuery();
			 if(rs6.next()) {
				 result[5] = rs6.getInt("count");
			 }
			 //统计信贷资产整笔删除数量
			 String getCreAssAllDltCountSql = "select count(1) as count from  HPIDR_CREASS_ALLDLT where OccurDate = ? and length(SessionId) = 14  ";
			 ps7 = conn.prepareStatement(getCreAssAllDltCountSql);
			 ps7.setString(1, batchDate);
			 rs7 = ps7.executeQuery();
			 if(rs7.next()) {
				 result[6] = rs7.getInt("count");
			 }
		} catch (SQLException e) {
			ARE.getLog().error("首页数据统计出错",e);
		}finally {
			DBManager.close(rs);
			DBManager.close(ps);
			DBManager.close(rs1);
			DBManager.close(rs2);
			DBManager.close(rs3);
			DBManager.close(rs4);
			DBManager.close(rs5);
			DBManager.close(rs6);
			DBManager.close(rs7);
			DBManager.close(ps1);
			DBManager.close(ps2);
			DBManager.close(ps3);
			DBManager.close(ps4);
			DBManager.close(ps5);
			DBManager.close(ps6);
			DBManager.close(ps7);
			DBManager.close(conn);
		}
		return result;
	}
	
}
