package com.amarsoft.app.pidr.integatedquery;

import java.util.Date;

import com.amarsoft.app.pidr.common.PIDRConstants;
import com.amarsoft.are.ARE;
import com.amarsoft.are.jbo.BizObject;
import com.amarsoft.are.jbo.BizObjectManager;
import com.amarsoft.are.jbo.JBOException;
import com.amarsoft.are.jbo.JBOFactory;
import com.amarsoft.are.jbo.JBOTransaction;
import com.amarsoft.are.lang.DateX;
/**
 * 	kwwu		2023-03-20
 *  资产负债表、利润表、现金流量表基本信息插入保存（本期信息、上期信息）
 */
public class PIDRRateFinanceInsertBs {
	private String tableName;// 表名
	private String customerId;//客户编号
	private String finstaYear;//报表年份
	private String sheetType;//报表类型
	private String sheetTypeDivide;//报表类型细分
	private String managerOrgId;
	private String managerUserId;
	public String insetFinanceBs(JBOTransaction tx) {
		try {
			BizObjectManager bom = JBOFactory.getBizObjectManager(tx, "jbo.pidr."+tableName);
			BizObject bohm = null;
			for(int i = 1; i < 3; i++) {
				bohm = bom.newObject();
				bohm.setAttributeValue("SessionID", PIDRConstants.SESSIONID_16);
				bohm.setAttributeValue("CustomerId", customerId);
				bohm.setAttributeValue("FinstaYear", finstaYear);
				bohm.setAttributeValue("SheetType", sheetType);
				bohm.setAttributeValue("SheetTypeDivide", sheetTypeDivide);
				bohm.setAttributeValue("Stage", i);//1-本期信息，2-上期信息
				bohm.setAttributeValue("ManagerOrgId", managerOrgId);
				bohm.setAttributeValue("ManagerUserId", managerUserId);
				bohm.setAttributeValue("RecordFlag", PIDRConstants.RECORDFLAG_A);//新增
				bohm.setAttributeValue("OccurDate", DateX.format(new Date(), "yyyy-MM-dd"));
				bom.saveObject(bohm);
			}
			tx.commit();
			return "操作成功";
		} catch (JBOException e) {
			ARE.getLog().error("新增记录失败",e);
			try {
				tx.rollback();
			} catch (JBOException e1) {
				ARE.getLog().error("事物回滚异常",e1);
			}
			return "新增记录失败";
		}
	}
	public String deleteFinance(JBOTransaction tx) {
		try {
			BizObjectManager bom = JBOFactory.getBizObjectManager(tx, "jbo.pidr."+tableName);
			bom.createQuery("delete from O where CustomerId=:CustomerId ").setParameter("CustomerId", customerId).executeUpdate();
			tx.commit();
			return "删除成功";
		} catch (JBOException e) {
			ARE.getLog().error("删除记录失败",e);
			try {
				tx.rollback();
			} catch (JBOException e1) {
				ARE.getLog().error("删除事物回滚异常",e1);
			}
			return "删除记录失败";
		}
	}
	public String getTableName() {
		return tableName;
	}
	public void setTableName(String tableName) {
		this.tableName = tableName;
	}
	public String getCustomerId() {
		return customerId;
	}
	public void setCustomerId(String customerId) {
		this.customerId = customerId;
	}
	public String getFinstaYear() {
		return finstaYear;
	}
	public void setFinstaYear(String finstaYear) {
		this.finstaYear = finstaYear;
	}
	public String getSheetType() {
		return sheetType;
	}
	public void setSheetType(String sheetType) {
		this.sheetType = sheetType;
	}
	public String getSheetTypeDivide() {
		return sheetTypeDivide;
	}
	public void setSheetTypeDivide(String sheetTypeDivide) {
		this.sheetTypeDivide = sheetTypeDivide;
	}
	public String getManagerOrgId() {
		return managerOrgId;
	}
	public void setManagerOrgId(String managerOrgId) {
		this.managerOrgId = managerOrgId;
	}
	public String getManagerUserId() {
		return managerUserId;
	}
	public void setManagerUserId(String managerUserId) {
		this.managerUserId = managerUserId;
	}
	
}
