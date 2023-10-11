package com.amarsoft.app.pidr.feedback;

import com.amarsoft.are.ARE;
import com.amarsoft.are.jbo.BizObject;
import com.amarsoft.are.jbo.BizObjectManager;
import com.amarsoft.are.jbo.JBOException;
import com.amarsoft.are.jbo.JBOFactory;
import com.amarsoft.are.jbo.JBOTransaction;
/**
 * 更新session表的反馈信息 
 * @author kwwu
 * @date 2023-02-24
 */
public class UpdateSession {
	private String reportName;//报文名称
	private String feedbackName; //反馈报文名
	
	/*
	 * 通过报文名称查找是否有相应的记录，如果有则更新对应的反馈信息
	 */
	public String updateFeedbackSession(JBOTransaction tx){
		BizObjectManager manager = null;
		try {
			manager = JBOFactory.getBizObjectManager(tx,"jbo.pidr.PIDR_SESSION");
			BizObject result = manager.createQuery("select * from O where ReportFileName=:ReportFileName").setParameter("ReportFileName", reportName).getSingleResult(true);
			if (result == null) {
				return "false";
			}
			result.setAttributeValue("FeedBackFileName", feedbackName);
			result.setAttributeValue("FeedBackStatus", feedbackName.substring(29, 30));
			manager.saveObject(result);
			tx.commit();
			return "true";
		}catch(JBOException e) {
			ARE.getLog().error("查询报文记录表失败",e);
			try {
				tx.rollback();
			} catch (JBOException e1) {
				ARE.getLog().error("事物回滚异常",e1);
			}
			return "false";
		}
	}

	public String getReportName() {
		return reportName;
	}

	public void setReportName(String reportName) {
		this.reportName = reportName;
	}

	public String getFeedbackName() {
		return feedbackName;
	}

	public void setFeedbackName(String feedbackName) {
		this.feedbackName = feedbackName;
	}
}