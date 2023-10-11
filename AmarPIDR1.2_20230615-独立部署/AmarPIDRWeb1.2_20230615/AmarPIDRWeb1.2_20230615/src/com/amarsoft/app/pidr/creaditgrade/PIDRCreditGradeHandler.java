package com.amarsoft.app.pidr.creaditgrade;

import com.amarsoft.app.pidr.common.PIDRConstants;
import com.amarsoft.are.ARE;
import com.amarsoft.are.jbo.BizObject;
import com.amarsoft.are.jbo.BizObjectManager;
import com.amarsoft.are.jbo.JBOException;
import com.amarsoft.are.jbo.JBOFactory;
import com.amarsoft.are.jbo.JBOTransaction;

/**
 * 预评级管理处理类
 * @author kwwu
 *
 */
public class PIDRCreditGradeHandler {
	private String customerIds;//预评级管理-多选的客户编号，以@分隔
	private String finStaYears;//预评级管理-多选的报表年份，以@分隔
	private String customerId;//拦截名单-删除暂缓上报的拦截记录时的传参
	/**
	 * 预评级管理-暂缓上报
	 * @return
	 */
	public String suspendReport(JBOTransaction tx) {
		String[] customerId = customerIds.split("@",-1);
		String[] finStaYear = finStaYears.split("@",-1);
		int updateNum = 0;
		try {
			for(int i = 0; i < customerId.length; i++) {
				BizObjectManager bom = JBOFactory.getBizObjectManager(tx, "jbo.pidr.PIDR_EVALUATE_RECORD");
				updateNum = updateNum + bom.createQuery("update O set ReportStatus = :ReportStatus where CustomerId = :CustomerId and FinStaYear = :FinStaYear and ObjectType = :ObjectType")
					.setParameter("ReportStatus",PIDRConstants.REPORT_STATUS_0)
					.setParameter("CustomerId",customerId[i]).setParameter("FinStaYear",finStaYear[i])
					.setParameter("ObjectType",PIDRConstants.EVALUATE_OBJECT_TYPE).executeUpdate();
			}
			ARE.getLog().info("暂缓上报处理" + updateNum + "条");
			tx.commit();
		} catch (JBOException e) {
			ARE.getLog().error("暂缓上报操作失败",e);
			try {
				tx.rollback();
			} catch (JBOException e1) {
				ARE.getLog().error("事物回滚异常",e1);
			}
			return "暂缓上报操作失败";
		}
		return "暂缓上报操作成功";
	}
	
	/**
	 * 预评级管理-恢复上报
	 * @return
	 */
	public String recoverReport(JBOTransaction tx) {
		String[] customerId = customerIds.split("@",-1);
		String[] finStaYear = finStaYears.split("@",-1);
		int updateNum = 0;
		try {
			for(int i = 0; i < customerId.length; i++) {
				BizObjectManager bom = JBOFactory.getBizObjectManager(tx, "jbo.pidr.PIDR_EVALUATE_RECORD");
				updateNum = updateNum + bom.createQuery("update O set ReportStatus = :ReportStatus where CustomerId = :CustomerId and FinStaYear = :FinStaYear and ObjectType = :ObjectType")
					.setParameter("ReportStatus",PIDRConstants.REPORT_STATUS_1)
					.setParameter("CustomerId",customerId[i]).setParameter("FinStaYear",finStaYear[i])
					.setParameter("ObjectType",PIDRConstants.EVALUATE_OBJECT_TYPE).executeUpdate();
			}
			ARE.getLog().info("恢复上报处理" + updateNum + "条");
			tx.commit();
		} catch (JBOException e) {
			ARE.getLog().error("恢复上报操作失败",e);
			try {
				tx.rollback();
			} catch (JBOException e1) {
				ARE.getLog().error("事物回滚异常",e1);
			}
			return "恢复上报操作失败";
		}
		return "恢复上报操作成功";
	}
	
	/**
	 * 拦截名单删除时，人为web端操作干涉的暂缓上报记录的报送状态需要恢复成正常上报
	 * @return
	 */
	public String regainReport(JBOTransaction tx) {
		try {
			BizObjectManager bom = JBOFactory.getBizObjectManager(tx, "jbo.pidr.PIDR_EVALUATE_RECORD");
			BizObject bo = bom.createQuery("select * from O where O.CustomerId = :CustomerId " 
					+ " and O.FinStaYear = (select max(per.FinStaYear) from jbo.pidr.PIDR_EVALUATE_RECORD per where per.objectType = O.objectType and per.customerId = O.customerId)")
				.setParameter("CustomerId",customerId).getSingleResult(true);
			bo.setAttributeValue("ReportStatus","");
			bom.saveObject(bo);
			tx.commit();
		} catch (JBOException e) {
			ARE.getLog().error("恢复上报操作失败",e);
			try {
				tx.rollback();
			} catch (JBOException e1) {
				ARE.getLog().error("事物回滚异常",e1);
			}
			return "fail";
		}
		return "success";
	}
	
	public String getCustomerIds() {
		return customerIds;
	}
	public void setCustomerIds(String customerIds) {
		this.customerIds = customerIds;
	}
	public String getFinStaYears() {
		return finStaYears;
	}
	public void setFinStaYears(String finStaYears) {
		this.finStaYears = finStaYears;
	}
	public String getCustomerId() {
		return customerId;
	}
	public void setCustomerId(String customerId) {
		this.customerId = customerId;
	}
}
