package com.amarsoft.app.pidr.alldlt;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import com.amarsoft.app.pidr.common.DBManager;
import com.amarsoft.app.pidr.common.PIDRConstants;
import com.amarsoft.are.ARE;
import com.amarsoft.are.jbo.JBOTransaction;

/**
 * 当期表新增的记录做删除操作，关联删除所有段。
 * @author yyzang
 * @date 2023-03-29
 *
 */
public class PidrCascadeDelete {
	private String customerId;//客户编号
	private String tableName;//表明
	private String dueCode;//借据号
	
	/**
	 * 评级关联删除
	 * @param tx
	 * @return
	 */
	public  String deleteRateById(JBOTransaction tx) {
		Connection conn = null;
		PreparedStatement ps =null;
		try {
			conn = DBManager.getConnection();
			String sql = "delete from  "+tableName + " where customerId = ? ";
			ps = conn.prepareStatement(sql);
			ps.setString(1, customerId);
			ps.executeUpdate();
		} catch (SQLException e) {
			ARE.getLog().error("删除当前评级记录时出错,请查看",e);
			return "删除失败,请查看日志!";
		} finally {
			DBManager.close(ps);
			DBManager.close(conn);
		}
		return "删除成功!";
	}
	
	/**
	 * 评级删除
	 * @param tx
	 * @return
	 */
	public  String deleteRateAll(JBOTransaction tx) {
		Connection conn = null;
		PreparedStatement ps =null;
		String rateArray[] = {PIDRConstants.TABLE_PIDR_RATE_BS,
				                       PIDRConstants.TABLE_PIDR_RATE_FSINF,
				                       PIDRConstants.TABLE_PIDR_RATE_LEGREPINF,
				                       PIDRConstants.TABLE_PIDR_RATE_REGCAP,
				                       PIDRConstants.TABLE_PIDR_RATE_MNSHAHODINF,
				                       PIDRConstants.TABLE_PIDR_RATE_INVABROINF,
				                       PIDRConstants.TABLE_PIDR_RATE_NEGINF,
				                       PIDRConstants.TABLE_PIDR_RATE_BALANCESSHEET,
				                       PIDRConstants.TABLE_PIDR_RATE_INCOME,
				                       PIDRConstants.TABLE_PIDR_RATE_CASHFLOW,
				                       PIDRConstants.PIDR_FINANCE_STATEMENT};
		try {
			conn = DBManager.getConnection();
			//循环删除所有段
			for(int i=0;i<rateArray.length;i++) {
				String sql = "delete from  "+rateArray[i] + " where customerId = ? ";
				ps = conn.prepareStatement(sql);
				ps.setString(1, customerId);
				ps.executeUpdate();
			}
		} catch (SQLException e) {
			ARE.getLog().error("关联删除评级记录时出错,请查看",e);
			return "删除失败,请查看日志!";
		} finally {
			DBManager.close(ps);
			DBManager.close(conn);
		}
		return "删除成功!";
	}
	
	/**
	 * 评关信息关联删除
	 * @param tx
	 * @return
	 */
	public  String deleteCreassByDudCode(JBOTransaction tx) {
		Connection conn = null;
		PreparedStatement ps =null;
		try {
			conn = DBManager.getConnection();
			//循环删除所有段
			String sql = "delete from  "+tableName+ " where DueCode = ? ";
			ps = conn.prepareStatement(sql);
			ps.setString(1, dueCode);
			ps.executeUpdate();
		} catch (SQLException e) {
			ARE.getLog().error("删除当前信贷资产记录时出错,请查看",e);
			return "删除失败,请查看日志!";
		} finally {
			DBManager.close(ps);
			DBManager.close(conn);
		}
		return "删除成功!";
	}
	/**
	 * 评关信息关联删除
	 * @param tx
	 * @return
	 */
	public  String deleteCreassAll(JBOTransaction tx) {
		Connection conn = null;
		PreparedStatement ps =null;
		String rateArray[] = {PIDRConstants.TABLE_PIDR_CREASS_BS, PIDRConstants.TABLE_PIDR_CREASS_FSINF};
		try {
			conn = DBManager.getConnection();
			//循环删除所有段
			for(int i=0;i<rateArray.length;i++) {
				String sql = "delete from  "+rateArray[i] + " where DueCode = ? ";
				ps = conn.prepareStatement(sql);
				ps.setString(1, dueCode);
				ps.executeUpdate();
			}
		} catch (SQLException e) {
			ARE.getLog().error("关联删除信贷资产记录时出错,请查看",e);
			return "删除失败,请查看日志!";
		} finally {
			DBManager.close(ps);
			DBManager.close(conn);
		}
		return "删除成功!";
	}
	
	public String getCustomerId() {
		return customerId;
	}
	public void setCustomerId(String customerId) {
		this.customerId = customerId;
	}
	public String getDueCode() {
		return dueCode;
	}
	public void setDueCode(String dueCode) {
		this.dueCode = dueCode;
	}
	public String getTableName() {
		return tableName;
	}
	public void setTableName(String tableName) {
		this.tableName = tableName;
	}
	
}
