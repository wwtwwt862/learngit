package com.amarsoft.app.pidr.alldlt;

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
 * 整笔删除类
 * @author yyzang
 *
 */
public class PidrAllDelHandler {

	private String entCertType;
	private String entCertNum;
	private String sessionId;
	private String inputTime;
	private String inputOrgId;
	private String inputUserId;
	private String occurDate;
	
	private String delDueCode;//借据号
	private String delContractCode;//合同号
	/**
	 * 新增评级信息整笔删除
	 * @param tx
	 * @return
	 */
	public String addRateAllDel(JBOTransaction tx) {
		
		BizObjectManager bom;
		BizObjectManager bom2;
		try {
			bom = JBOFactory.getBizObjectManager(tx, "jbo.pidr.HPIDR_RATE_ALLDLT");
			bom2 = JBOFactory.getBizObjectManager(tx, "jbo.pidr.PIDR_RATE_BS");
			BizObject bo2 = bom2.createQuery("select * from O where EntCertType = :EntCertType and EntCertNum = :EntCertNum")
					.setParameter("EntCertType", entCertType)
					.setParameter("EntCertNum", entCertNum)
					.getSingleResult(true);
			if(bo2 == null) {//不存在该记录
				return "不存在该记录，不可操作";
			}
			BizObject bo = bom.createQuery("select * from O where EntCertType = :EntCertType and EntCertNum = :EntCertNum  and SessionId =:SessionId")
					.setParameter("EntCertType", entCertType)
					.setParameter("EntCertNum", entCertNum)
					.setParameter("SessionId", PIDRConstants.SESSIONID_14)//未报送的
					.getSingleResult(false);
				if(bo!=null) {
					return "该记录已经发起过整笔删除且为待报送状态，不可再操作";
				}
				sessionId = PIDRConstants.SESSIONID_14;
				inputTime = DateX.format(new Date(), PIDRConstants.DATEFORMAT_3);
				occurDate = DateX.format(new Date(), PIDRConstants.DATEFORMAT_1);
				bo = bom.newObject();
				bo.setAttributeValue("SessionId", sessionId);
				bo.setAttributeValue("InfRecType",PIDRConstants.ALLDELETE_RATE );
				bo.setAttributeValue("EntCertType", entCertType);
				bo.setAttributeValue("EntCertNum", entCertNum);
				bo.setAttributeValue("FinStaYear", bo2.getAttribute("FinStaYear").getString());
				bo.setAttributeValue("InputUserId", inputUserId);
				bo.setAttributeValue("InputOrgId", inputOrgId);
				bo.setAttributeValue("InputTime", inputTime);
				bo.setAttributeValue("RptDate", occurDate);
				bo.setAttributeValue("ManagerOrgId", bo2.getAttribute("ManagerOrgId").getString());
				bo.setAttributeValue("MngmtOrgCode", bo2.getAttribute("MngmtOrgCode").getString());
				bo.setAttributeValue("OccurDate", occurDate);
				bom.saveObject(bo);
				tx.commit();
		} catch (JBOException e) {
			ARE.getLog().error("评级信息保存整笔删除时出错",e);
			try {
				tx.rollback();
			} catch (JBOException e1) {
				ARE.getLog().error("事物回滚异常",e1);
			}
			return "保存整笔删除时出错";
		}
		return "SUCCESS";
	}
	
	
	
	/**
	 * 新增信贷资产信息整笔删除
	 * @param tx
	 * @return
	 */
	public String addCreAssAllDel(JBOTransaction tx) {
		
		BizObjectManager bom;
		BizObjectManager bom2;
		try {
			bom = JBOFactory.getBizObjectManager(tx, "jbo.pidr.HPIDR_CREASS_ALLDLT");
			bom2 = JBOFactory.getBizObjectManager(tx, "jbo.pidr.PIDR_CREASS_BS");
			BizObject bo2 = bom2.createQuery("select * from O where DueCode = :DueCode and ContractCode = :ContractCode ")
					.setParameter("DueCode", delDueCode)
					.setParameter("ContractCode", delContractCode)
					.getSingleResult(false);
			if(bo2 == null) {//不存在该记录
				return "不存在该记录，不可操作";
			}
			BizObject bo = bom.createQuery("select * from O where DelDueCode = :DelDueCode and DelContractCode = :DelContractCode and SessionId =:SessionId")
					.setParameter("DelDueCode", delDueCode)
					.setParameter("DelContractCode", delContractCode)
					.setParameter("SessionId", PIDRConstants.SESSIONID_14)//未报送的
					.getSingleResult(true);
				if(bo!=null) {
					return "该记录已经发起过整笔删除且为待报送状态，不可再操作";
				}
				sessionId = PIDRConstants.SESSIONID_14;
				inputTime = DateX.format(new Date(), PIDRConstants.DATEFORMAT_3);
				occurDate = DateX.format(new Date(), PIDRConstants.DATEFORMAT_1);
				bo = bom.newObject();
				bo.setAttributeValue("SessionId", sessionId);
				bo.setAttributeValue("InfRecType",PIDRConstants.ALLDELETE_CREASS );
				bo.setAttributeValue("DelDueCode", delDueCode);
				bo.setAttributeValue("DelContractCode", delContractCode);
				bo.setAttributeValue("InputUserId", inputUserId);
				bo.setAttributeValue("InputOrgId", inputOrgId);
				bo.setAttributeValue("InputTime", inputTime);
				bo.setAttributeValue("ManagerOrgId", bo2.getAttribute("ManagerOrgId").getString());
				bo.setAttributeValue("DelMngmtOrgCode", bo2.getAttribute("MngmtOrgCode").getString());
				bo.setAttributeValue("OccurDate", occurDate);
				bom.saveObject(bo);
				tx.commit();
		} catch (JBOException e) {
			ARE.getLog().error("信贷资产信息保存整笔删除时出错",e);
			try {
				tx.rollback();
			} catch (JBOException e1) {
				ARE.getLog().error("事物回滚异常",e1);
			}
			return "保存整笔删除时出错";
		}
		return "SUCCESS";
	}
	
	
	public String getEntCertType() {
		return entCertType;
	}
	public void setEntCertType(String entCertType) {
		this.entCertType = entCertType;
	}
	public String getEntCertNum() {
		return entCertNum;
	}
	public void setEntCertNum(String entCertNum) {
		this.entCertNum = entCertNum;
	}
	public String getSessionId() {
		return sessionId;
	}
	public void setSessionId(String sessionId) {
		this.sessionId = sessionId;
	}
	public String getInputTime() {
		return inputTime;
	}
	public void setInputTime(String inputTime) {
		this.inputTime = inputTime;
	}
	public String getInputOrgId() {
		return inputOrgId;
	}
	public void setInputOrgId(String inputOrgId) {
		this.inputOrgId = inputOrgId;
	}
	public String getInputUserId() {
		return inputUserId;
	}
	public void setInputUserId(String inputUserId) {
		this.inputUserId = inputUserId;
	}
	public String getOccurDate() {
		return occurDate;
	}
	public void setOccurDate(String occurDate) {
		this.occurDate = occurDate;
	}
	public String getDelDueCode() {
		return delDueCode;
	}
	public void setDelDueCode(String delDueCode) {
		this.delDueCode = delDueCode;
	}
	public String getDelContractCode() {
		return delContractCode;
	}
	public void setDelContractCode(String delContractCode) {
		this.delContractCode = delContractCode;
	}
	
	
	
	
}
