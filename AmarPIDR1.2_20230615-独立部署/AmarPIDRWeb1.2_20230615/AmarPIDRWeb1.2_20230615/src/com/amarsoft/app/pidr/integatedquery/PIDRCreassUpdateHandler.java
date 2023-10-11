package com.amarsoft.app.pidr.integatedquery;

import java.util.Date;

import com.amarsoft.app.pidr.common.PIDRConstants;
import com.amarsoft.are.ARE;
import com.amarsoft.are.jbo.BizObjectManager;
import com.amarsoft.are.jbo.JBOException;
import com.amarsoft.are.jbo.JBOFactory;
import com.amarsoft.are.jbo.JBOTransaction;
import com.amarsoft.are.lang.DateX;

public class PIDRCreassUpdateHandler {
	private String dueCode;// 借据号
	private String tableName;//表名
	
	/**
	 * 企业信贷资产基本信息段变化更新，而基础段未更新，则反向更新基础段信息，记录标志RecordFlag为U-更新 
	 * 企业信贷资产基础段变化更新，而基本信息段未更新，则反向更新基本信息段信息，记录标志RecordFlag为U-更新 
	 * @param tx
	 * @return
	 */
	public String reverseUpdate(JBOTransaction tx) {
		try {
			String occurDate = DateX.format(new Date(), PIDRConstants.DATEFORMAT_1);
			BizObjectManager bom = JBOFactory.getBizObjectManager(tx, "jbo.pidr."+tableName);
			int updateNum = bom.createQuery("update O set RecordFlag = :RecordFlag , OccurDate = :OccurDate where DueCode = :DueCode and RecordFlag = :OldRecordFlag")
			.setParameter("RecordFlag", PIDRConstants.RECORDFLAG_U).setParameter("OccurDate", occurDate)
			.setParameter("DueCode", dueCode).setParameter("OldRecordFlag", PIDRConstants.RECORDFLAG_R).executeUpdate();
			ARE.getLog().info("更新" + tableName + "表记录" + updateNum + "条");
			tx.commit();
			return "success";		
		}catch(JBOException e) {
			ARE.getLog().error("反向更新记录标志失败",e);
			try {
				tx.rollback();
			} catch (JBOException e1) {
				ARE.getLog().error("事物回滚异常",e1);
			}
			return "fail";
		}
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
