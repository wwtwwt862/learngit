package com.amarsoft.app.pidr.integatedquery;

import java.util.Date;

import com.amarsoft.app.pidr.common.PIDRConstants;
import com.amarsoft.are.ARE;
import com.amarsoft.are.jbo.BizObjectManager;
import com.amarsoft.are.jbo.JBOException;
import com.amarsoft.are.jbo.JBOFactory;
import com.amarsoft.are.jbo.JBOTransaction;
import com.amarsoft.are.lang.DateX;

public class PIDRRateUpdateHandler {
	private String customerId;// 客户编号
	private String tableName;// 表名
	private String finStaYear;//报表年份
	private String sheetType;//报表类型
	private String sheetTypeDivide;//报表类型细分
	
	
	/**
	 * 1.当基本概况段、法定代表人段、注册资本、主要出资人、对外投资段、负面信息段发生更新而基础段未更新，则更新基础段
	 * 2.当注册资本发生更新，则更新主要出资人表
	 * 3.1当主要出资人段发生更新,则更新其他未发生更新有效的出资人
	 * 3.2当主要出资人段发生，则更新注册资本表
	 * 4.当对外投资段发生更新,则更新其他未发生更新的有效的对外投资信息
	 * 5.当负面信息段发生更新,则更新其他未发生更新的有效的负面信息信息
	 * 6.负债表、利润表、现金流量表发生更新而基础段未更新，则反向更新基础段
	 * @param tx
	 * @return
	 */
	public String reverseUpdate(JBOTransaction tx) {
		try {
			if(PIDRConstants.TABLE_PIDR_RATE_FSINF.equalsIgnoreCase(tableName)) {
				// 当基本概况段发生更新时，更新基础段
				setRecordFlag(tx, PIDRConstants.TABLE_PIDR_RATE_BS);
			}else if(PIDRConstants.TABLE_PIDR_RATE_LEGREPINF.equalsIgnoreCase(tableName)) {
				// 当法定代表人段发生更新时，更新基础段
				setRecordFlag(tx, PIDRConstants.TABLE_PIDR_RATE_BS);
			}else if(PIDRConstants.TABLE_PIDR_RATE_REGCAP.equalsIgnoreCase(tableName)) {
				// 当注册资本发生更新，更新基础段和主要出资人表
				setRecordFlag(tx, PIDRConstants.TABLE_PIDR_RATE_BS);
				setRecordFlag(tx, PIDRConstants.TABLE_PIDR_RATE_MNSHAHODINF);
			}else if(PIDRConstants.TABLE_PIDR_RATE_MNSHAHODINF.equalsIgnoreCase(tableName)) {
				// 当主要出资人段发生更新,更新基础段、注册资本表和其他未发生更新有效的出资人
				setRecordFlag(tx, PIDRConstants.TABLE_PIDR_RATE_BS);
				setRecordFlag(tx, PIDRConstants.TABLE_PIDR_RATE_REGCAP);
				setEffStatusRecordFlag(tx, PIDRConstants.TABLE_PIDR_RATE_MNSHAHODINF);
			}else if(PIDRConstants.TABLE_PIDR_RATE_INVABROINF.equalsIgnoreCase(tableName)) {
				// 当主要对外投资段发生更新,更新基础段、其他未发生更新的有效的对外投资信息
				setRecordFlag(tx, PIDRConstants.TABLE_PIDR_RATE_BS);
				setEffStatusRecordFlag(tx, PIDRConstants.TABLE_PIDR_RATE_INVABROINF);
			}else if(PIDRConstants.TABLE_PIDR_RATE_NEGINF.equalsIgnoreCase(tableName)) {
				// 当负面信息段发生更新,更新基础段、其他未发生更新的有效的负面信息信息
				setRecordFlag(tx, PIDRConstants.TABLE_PIDR_RATE_BS);
				setEffStatusRecordFlag(tx, PIDRConstants.TABLE_PIDR_RATE_NEGINF);
			}else if(PIDRConstants.TABLE_PIDR_RATE_BALANCESSHEET.equalsIgnoreCase(tableName)) {
				// 当负债表发生更新,更新基础段、本期信息与上期信息也需要同步
				setRecordFlag(tx, PIDRConstants.TABLE_PIDR_RATE_BS);
				setFinanceRecordFlag(tx, PIDRConstants.TABLE_PIDR_RATE_BALANCESSHEET);
			}else if(PIDRConstants.TABLE_PIDR_RATE_INCOME.equalsIgnoreCase(tableName)) {
				// 当利润表发生更新,更新基础段、本期信息与上期信息也需要同步
				setRecordFlag(tx, PIDRConstants.TABLE_PIDR_RATE_BS);
				setFinanceRecordFlag(tx, PIDRConstants.TABLE_PIDR_RATE_INCOME);
			}else if(PIDRConstants.TABLE_PIDR_RATE_CASHFLOW.equalsIgnoreCase(tableName)) {
				// 当现金流量表发生更新,更新基础段、本期信息与上期信息也需要同步
				setRecordFlag(tx, PIDRConstants.TABLE_PIDR_RATE_BS);
				setFinanceRecordFlag(tx, PIDRConstants.TABLE_PIDR_RATE_CASHFLOW);
			}
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
	
	/**
	 * 根据客户编号更新当前期次表的记录标识
	 * @param tx
	 * @param tableName 表名
	 * @throws JBOException 
	 */
	public void setRecordFlag(JBOTransaction tx,String tableName) throws JBOException {
		String occurDate = DateX.format(new Date(), PIDRConstants.DATEFORMAT_1);
		BizObjectManager bom = JBOFactory.getBizObjectManager(tx, "jbo.pidr."+tableName);
		int updateNum = bom.createQuery("update O set RecordFlag = :RecordFlag , OccurDate = :OccurDate where CustomerId = :CustomerId and RecordFlag = :OldRecordFlag")
		.setParameter("RecordFlag", PIDRConstants.RECORDFLAG_U).setParameter("OccurDate", occurDate)
		.setParameter("CustomerId", customerId).setParameter("OldRecordFlag", PIDRConstants.RECORDFLAG_R).executeUpdate();
		ARE.getLog().info("更新" + tableName + "表记录" + updateNum + "条");
	}
	
	/**
	 * 针对存在有效标志字段的主要出资人、对外投资、负面信息段，需更新该客户所有有效记录
	 * @param tx
	 * @param tableName 表名
	 * @throws JBOException 
	 */
	public void setEffStatusRecordFlag(JBOTransaction tx, String tableName) throws JBOException {
		String occurDate = DateX.format(new Date(), PIDRConstants.DATEFORMAT_1);
		BizObjectManager bom = JBOFactory.getBizObjectManager(tx, "jbo.pidr."+tableName);
		int updateNum = bom.createQuery("update O set RecordFlag = :RecordFlag , OccurDate = :OccurDate where CustomerId = :CustomerId and RecordFlag = :OldRecordFlag and EffStatus = :EffStatus")
		.setParameter("RecordFlag", PIDRConstants.RECORDFLAG_U).setParameter("OccurDate", occurDate)
		.setParameter("CustomerId", customerId).setParameter("OldRecordFlag", PIDRConstants.RECORDFLAG_R)
		.setParameter("EffStatus", PIDRConstants.EFFSTATUS_1).executeUpdate();
		ARE.getLog().info("更新" + tableName + "表记录" + updateNum + "条");
	}
	/**
	 * 针对资产负债表、利润表、现金流量表，本期信息与上期信息需要同步更新
	 * @param tx
	 * @param tableName 表名
	 * @throws JBOException 
	 */
	public void setFinanceRecordFlag(JBOTransaction tx, String tableName) throws JBOException {
		String occurDate = DateX.format(new Date(), PIDRConstants.DATEFORMAT_1);
		BizObjectManager bom = JBOFactory.getBizObjectManager(tx, "jbo.pidr."+tableName);
		int updateNum = bom.createQuery("update O set RecordFlag = :RecordFlag , OccurDate = :OccurDate "
				+ "where CustomerId = :CustomerId "
				+ "and FinStaYear = :FinStaYear and SheetType = :SheetType and SheetTypeDivide = :SheetTypeDivide "
				+ "and RecordFlag = :OldRecordFlag ")
		.setParameter("RecordFlag", PIDRConstants.RECORDFLAG_U).setParameter("OccurDate", occurDate)
		.setParameter("CustomerId", customerId).setParameter("FinStaYear", finStaYear)
		.setParameter("SheetType", sheetType).setParameter("SheetTypeDivide", sheetTypeDivide)
		.setParameter("OldRecordFlag", PIDRConstants.RECORDFLAG_R).executeUpdate();
		ARE.getLog().info("更新" + tableName + "表记录" + updateNum + "条");
	}

	public String getCustomerId() {
		return customerId;
	}

	public void setCustomerId(String customerId) {
		this.customerId = customerId;
	}

	public String getTableName() {
		return tableName;
	}

	public void setTableName(String tableName) {
		this.tableName = tableName;
	}

	public String getFinStaYear() {
		return finStaYear;
	}

	public void setFinStaYear(String finStaYear) {
		this.finStaYear = finStaYear;
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
	
}
