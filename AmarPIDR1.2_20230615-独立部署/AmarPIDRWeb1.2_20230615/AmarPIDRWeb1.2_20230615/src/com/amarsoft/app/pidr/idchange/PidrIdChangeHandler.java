package com.amarsoft.app.pidr.idchange;

import com.amarsoft.app.pidr.common.PIDRConstants;
import com.amarsoft.are.ARE;
import com.amarsoft.are.jbo.BizObject;
import com.amarsoft.are.jbo.BizObjectManager;
import com.amarsoft.are.jbo.JBOException;
import com.amarsoft.are.jbo.JBOFactory;
import com.amarsoft.are.jbo.JBOTransaction;

/**
 * 标识变更处理类
 * @author kwwu
 *
 */
public class PidrIdChangeHandler {
	private String operationType;//区分报送管理-标识变更的新增、综合查询当期基础段的标识变更
	//评级信息标识变更
	private String oldEntCertType;
	private String oldEntCertNum;
	
	//信贷资产信息标识变更
	private String oldDueCode;//原借据号
	private String oldContractCode;//原合同号
	/**
	 * 新增评级标识变更
	 * @return
	 */
	public String addRateIdChange(JBOTransaction tx) {
		BizObjectManager bom;//查询标识变更记录
		BizObjectManager bom2;//查询基础段记录
		String mngmtorgCode = "";//业务管理金融机构代码
        String managerOrgId = "";//管户机构
        String finStaYear = "";//报表年份
		try {
			if(PIDRConstants.IDCHANGE_OPERATE_ADD.equalsIgnoreCase(operationType)) {//标识变更新增
				//查询新增标识是否实际存在
				bom2 = JBOFactory.getBizObjectManager(tx, "jbo.pidr.PIDR_RATE_BS");
				BizObject bo2 = bom2.createQuery("select * from O where EntCertType = :EntCertType and EntCertNum = :EntCertNum ")
						.setParameter("EntCertType", oldEntCertType).setParameter("EntCertNum", oldEntCertNum)
						.getSingleResult(false);
				if(bo2 == null) {//不存在该记录
					return "notExist";
				}else {
					mngmtorgCode = bo2.getAttribute("MngmtOrgCode").toString();
		            managerOrgId = bo2.getAttribute("ManagerOrgId").toString();
		            finStaYear = bo2.getAttribute("FinStaYear").toString();
				}
			}
			//查询是否已有标识变更记录
			bom = JBOFactory.getBizObjectManager(tx, "jbo.pidr.HPIDR_RATE_IDCHANGE");
			BizObject bo = bom.createQuery("select * from O where OldEntCertType = :OldEntCertType and OldEntCertNum = :OldEntCertNum ")
					.setParameter("OldEntCertType", oldEntCertType)
					.setParameter("OldEntCertNum", oldEntCertNum)
					.getSingleResult(true);
			if(bo!=null) {
				return "idChanged";
			}
			tx.commit();
		} catch (JBOException e) {
			ARE.getLog().error("标识变更操作出错",e);
			try {
				tx.rollback();
			} catch (JBOException e1) {
				ARE.getLog().error("事物回滚异常",e1);
			}
			return "标识变更操作出错";
		}
		return mngmtorgCode + "@" + managerOrgId + "@" + finStaYear;//返回业务管理金融机构代码、管户机构编号、报表年份，以用于前端新增时赋值保存
	}
	
	/**
	 * 新增信贷资产标识变更
	 * @return
	 */
	public String addCreAssIdChange(JBOTransaction tx) {
		BizObjectManager bom;//查询标识变更记录
		BizObjectManager bom2;//查询基础段记录
		String mngmtorgCode = "";//业务管理金融机构代码
        String managerOrgId = "";//管户机构
		try {
			if(PIDRConstants.IDCHANGE_OPERATE_ADD.equalsIgnoreCase(operationType)) {//标识变更新增
				//查询新增标识是否实际存在
				bom2 = JBOFactory.getBizObjectManager(tx, "jbo.pidr.PIDR_CREASS_BS");
				BizObject bo2 = bom2.createQuery("select * from O where DueCode = :DueCode and ContractCode = :ContractCode ")
						.setParameter("DueCode", oldDueCode)
						.setParameter("ContractCode", oldContractCode)
						.getSingleResult(false);
				if(bo2 == null) {//不存在该记录
					return "notExist";
				}else {
					mngmtorgCode = bo2.getAttribute("MngmtOrgCode").toString();
		            managerOrgId = bo2.getAttribute("ManagerOrgId").toString();
				}
			}
			//查询是否已有标识变更记录
			bom = JBOFactory.getBizObjectManager(tx, "jbo.pidr.HPIDR_CREASS_IDCHANGE");
			BizObject bo = bom.createQuery("select * from O where OldDueCode = :OldDueCode and OldContractCode = :OldContractCode ")
					.setParameter("OldDueCode", oldDueCode)
					.setParameter("OldContractCode", oldContractCode)
					.getSingleResult(true);
			if(bo!=null) {
				return "idChanged";
			}
			tx.commit();
		} catch (JBOException e) {
			ARE.getLog().error("标识变更操作出错",e);
			try {
				tx.rollback();
			} catch (JBOException e1) {
				ARE.getLog().error("事物回滚异常",e1);
			}
			return "标识变更操作出错";
		}
		return mngmtorgCode + "@" + managerOrgId ;//返回业务管理金融机构代码、管户机构编号，以用于前端新增时赋值保存
	}

	public String getOperationType() {
		return operationType;
	}

	public void setOperationType(String operationType) {
		this.operationType = operationType;
	}

	public String getOldEntCertType() {
		return oldEntCertType;
	}
	public void setOldEntCertType(String oldEntCertType) {
		this.oldEntCertType = oldEntCertType;
	}
	public String getOldEntCertNum() {
		return oldEntCertNum;
	}
	public void setOldEntCertNum(String oldEntCertNum) {
		this.oldEntCertNum = oldEntCertNum;
	}
	public String getOldDueCode() {
		return oldDueCode;
	}
	public void setOldDueCode(String oldDueCode) {
		this.oldDueCode = oldDueCode;
	}
	public String getOldContractCode() {
		return oldContractCode;
	}
	public void setOldContractCode(String oldContractCode) {
		this.oldContractCode = oldContractCode;
	}
}
