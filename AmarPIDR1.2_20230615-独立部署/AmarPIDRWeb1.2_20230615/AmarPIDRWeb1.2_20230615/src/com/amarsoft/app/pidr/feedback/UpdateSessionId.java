package com.amarsoft.app.pidr.feedback;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import com.amarsoft.app.pidr.common.DBManager;
import com.amarsoft.app.pidr.common.PIDRConstants;
import com.amarsoft.are.ARE;
import com.amarsoft.are.jbo.JBOException;
import com.amarsoft.are.jbo.JBOTransaction;

/**
 * 更新session表的反馈信息
 * 
 * @author swpeng
 * @date 2021-05-06
 */
public class UpdateSessionId {
	private String SessionId;// 期次号
	private String FNo;// 反馈标识号
	private String MessageType;// 报文类型
	private String BsbusiIdserialNo;// 基础信息标识号
	private String OldEntCertType;// 标识变更主键
	private String OldEntCertNum;// 标识变更主键
	private String sessionIDValue;// 反馈错误更新用期次号
	/*
	 * 通过期次号和标识号查找相应的记录，更新对应期次号
	 */

	public String updateFeedbackSession(JBOTransaction tx) throws JBOException {
		int upresult = 0;
		int deresult = 0;
		Connection connection = null;
		PreparedStatement ps = null;
		try {
			connection = ARE.getDBConnection(PIDRConstants.DATASOURCE_PIDR);
			String tableNames[] = null;
			if (PIDRConstants.NORMALREPORT_RATE.equals(MessageType)) {// 评级
				tableNames = new String[] { "HPIDR_RATE_BS", "HPIDR_RATE_FSINF", "HPIDR_RATE_LEGREPINF",
						"HPIDR_RATE_REGCAP", "HPIDR_RATE_MNSHAHODINF", "HPIDR_RATE_INVABROINF", "HPIDR_RATE_NEGINF",
						"HPIDR_RATE_BALANCESSHEET", "HPIDR_RATE_INCOME", "HPIDR_RATE_CASHFLOW" };
				for (int i = 0; i < tableNames.length; i++) {
					String updateSql = "update " + tableNames[i] + " set SessionId = '" + sessionIDValue
							+ "' WHERE SessionId=? AND CustomerId=?";
					ps = connection.prepareStatement(updateSql);
					ps.setString(1, PIDRConstants.SESSIONID_16_9);
					ps.setString(2, BsbusiIdserialNo);
					upresult = ps.executeUpdate()+upresult;
					DBManager.close(ps);
				}
			} else if (PIDRConstants.NORMALREPORT_CREASS.equals(MessageType)) {// 企业信贷资产
				tableNames = new String[] { "HPIDR_CREASS_BS", "HPIDR_CREASS_FSINF" };
				for (int i = 0; i < tableNames.length; i++) {
					String updateSql = "update " + tableNames[i] + " set SessionId ='" + sessionIDValue
							+ "' WHERE SessionId=? AND DueCode=?";
					ps = connection.prepareStatement(updateSql);
					ps.setString(1, PIDRConstants.SESSIONID_16_9);
					ps.setString(2, BsbusiIdserialNo);
					upresult = ps.executeUpdate()+upresult;
					DBManager.close(ps);
				}

			} else if (PIDRConstants.IDCHANGE_RATE.equals(MessageType)) {// 企业评级信息标识变更
				String array[] = BsbusiIdserialNo.split("@");
				String updateSql = "update HPIDR_RATE_IDCHANGE set SessionId ='" + sessionIDValue
						+ "' WHERE SessionId=? AND OldEntCertType=? AND OldEntCertNum =?";
				ps = connection.prepareStatement(updateSql);
				ps.setString(1, PIDRConstants.SESSIONID_14_9);
				ps.setString(2, array[0]);
				ps.setString(3, array[1]);
				upresult = ps.executeUpdate();
				DBManager.close(ps);
			} else if (PIDRConstants.IDCHANGE_CREASS.equals(MessageType)) {// 企业信贷资产信息标识变更
				String array[] = BsbusiIdserialNo.split("@");
				String updateSql = "update HPIDR_CREASS_IDCHANGE set SessionId ='" + sessionIDValue
						+ "' WHERE SessionId=? AND OldDueCode=? AND OldContractCode =?";
				ps = connection.prepareStatement(updateSql);
				ps.setString(1, PIDRConstants.SESSIONID_14_9);
				ps.setString(2, array[0]);
				ps.setString(3, array[1]);
				upresult = ps.executeUpdate();
				DBManager.close(ps);
			} else if (PIDRConstants.ALLDELETE_RATE.equals(MessageType)) {// 企业评级信息整笔删除
				String array[] = BsbusiIdserialNo.split("@");
				String updateSql = "update HPIDR_RATE_ALLDLT set SessionId ='" + sessionIDValue
						+ "' WHERE SessionId=? AND EntCertType=? AND EntCertNum=? ";
				ps = connection.prepareStatement(updateSql);
				ps.setString(1, PIDRConstants.SESSIONID_14_9);
				ps.setString(2, array[0]);
				ps.setString(3, array[1]);
				upresult = ps.executeUpdate();
				DBManager.close(ps);
			} else if (PIDRConstants.ALLDELETE_CREASS.equals(MessageType)) {// 企业信息资产信息整笔删除
				String array[] = BsbusiIdserialNo.split("@");
				String updateSql = "update HPIDR_CREASS_ALLDLT set SessionId ='" + sessionIDValue
						+ "' WHERE SessionId=? AND DelDueCode=? AND DelContractCode=? ";
				ps = connection.prepareStatement(updateSql);
				ps.setString(1, PIDRConstants.SESSIONID_14_9);
				ps.setString(2, array[0]);
				ps.setString(3, array[1]);
				upresult = ps.executeUpdate();
				DBManager.close(ps);
			} else if (PIDRConstants.MDFCINFO_RATE.equals(MessageType)) {// 评级按段更正
				String array[] = BsbusiIdserialNo.split("@");
				String hisTable = PIDRConstants.PIDRRATE_SGMTCODE_TABLE_HIS.get(array[2]);//待更正段对应历史表
				//更新按段更正表记录
				String updateSql = "update HPIDR_RATE_MDFCINFO set SessionId ='" + sessionIDValue
						+ "' WHERE SessionId=? AND CustomerID=? AND MdfcSgmtCode=? ";
				ps = connection.prepareStatement(updateSql);
				ps.setString(1, PIDRConstants.SESSIONID_14_9);
				ps.setString(2, array[0]);
				ps.setString(3, array[2]);
				upresult = ps.executeUpdate();
				DBManager.close(ps);
				//更新待更正段记录
				if(PIDRConstants.PIDR_RATE_D.equals(array[2])) {//注册资本及主要出资人段涉及两张表
					updateMdfcHis(connection,ps,"HPIDR_RATE_REGCAP",PIDRConstants.SESSIONID_14_9,array[0]);//注册资本信息表
					updateMdfcHis(connection,ps,"HPIDR_RATE_MNSHAHODINF",PIDRConstants.SESSIONID_14_9,array[0]);//主要出资人信息表
				}else {
					updateMdfcHis(connection,ps,hisTable,PIDRConstants.SESSIONID_14_9,array[0]);
				}
			}
			//删除反馈错误表记录
			String deleteSql = "delete from PIDR_FEEDBACK where BsBusiIdSerialNo = ?";
			ps = connection.prepareStatement(deleteSql);
			ps.setString(1, BsbusiIdserialNo);
			deresult = ps.executeUpdate();
			DBManager.close(ps);
			ARE.getLog().info("表更新记录数量为：" + upresult);
			ARE.getLog().info("反馈错误删除记录数量为：" + deresult);
		} catch (SQLException e1) {
			ARE.getLog().error("修改完成功能更新删除记录出错", e1);
		} finally {
			DBManager.close(ps);
			DBManager.close(connection);
		}
		if(upresult <= 0) {
			return "未找到反馈错误对应原表记录，更新失败";
		}
		if(deresult <= 0) {
			return "未找到反馈错误记录，删除失败";
		}
		return "true";
	}

	/*
	 * 按段更正记录修改完成，需要更新待更正段对应历史表记录
	 */
	public void updateMdfcHis(Connection connection,PreparedStatement ps,  String hisTable, String sessionId, String customerID) {
		String updateSql = "update " + hisTable + " set SessionId ='" + sessionIDValue
				+ "' WHERE SessionId=? AND CustomerID=? ";
		try {
			ps = connection.prepareStatement(updateSql);
			ps.setString(1, sessionId);
			ps.setString(2, customerID);
			int upresult = ps.executeUpdate();
			ARE.getLog().info("按段更正反馈错误更新的历史段数量为：" + upresult);
		} catch (SQLException e) {
			ARE.getLog().error("评级按段更正对应待更正历史表更新失败");
			e.printStackTrace();
		} finally{
			DBManager.close(ps);
		}
	}
	
	public String getSessionId() {
		return SessionId;
	}

	public void setSessionId(String sessionId) {
		SessionId = sessionId;
	}

	public String getFNo() {
		return FNo;
	}

	public void setFNo(String fNo) {
		FNo = fNo;
	}

	public String getMessageType() {
		return MessageType;
	}

	public void setMessageType(String messageType) {
		MessageType = messageType;
	}

	public String getBsbusiIdserialNo() {
		return BsbusiIdserialNo;
	}

	public void setBsbusiIdserialNo(String bsbusiIdserialNo) {
		BsbusiIdserialNo = bsbusiIdserialNo;
	}

	public String getOldEntCertType() {
		return OldEntCertType;
	}

	public void setOldEntCertType(String oldEntCertType) {
		OldEntCertType = oldEntCertType;
	}

	public String getOldEntCertNum() {
		return OldEntCertNum;
	}

	public void setOldEntCertNum(String oldEntCertNum) {
		OldEntCertNum = oldEntCertNum;
	}

	public String getSessionIDValue() {
		return sessionIDValue;
	}

	public void setSessionIDValue(String sessionIDValue) {
		this.sessionIDValue = sessionIDValue;
	}

	

}
