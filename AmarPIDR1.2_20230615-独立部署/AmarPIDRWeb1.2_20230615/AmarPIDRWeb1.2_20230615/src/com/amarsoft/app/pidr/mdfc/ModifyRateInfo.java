package com.amarsoft.app.pidr.mdfc;

import java.util.Date;
import java.util.List;

import com.amarsoft.app.pidr.common.PIDRConstants;
import com.amarsoft.are.ARE;
import com.amarsoft.are.jbo.BizObject;
import com.amarsoft.are.jbo.BizObjectKey;
import com.amarsoft.are.jbo.BizObjectManager;
import com.amarsoft.are.jbo.JBOException;
import com.amarsoft.are.jbo.JBOFactory;
import com.amarsoft.are.jbo.JBOTransaction;
import com.amarsoft.are.lang.DateX;


/**
 * 企业评级信息按段更正
 * @author kwwu
 *
 */
public class ModifyRateInfo {
	private String customerId;//待更正客户编号
	private String mdfcSgmtCode;
	private String sessionId=PIDRConstants.SESSIONID_14;
	private String managerOrgId;
	private String curUserId;
	private String curOrgId;
	public String modifyRateInfo(JBOTransaction tx){
		String htable = PIDRConstants.PIDRRATE_SGMTCODE_TABLE_HIS.get(mdfcSgmtCode);
		//判断该段是否已经上报更正（历史表是否有该客户14个0的记录）
		BizObjectManager bom = null;
		List<BizObject> listbo = null;
		try {
			if(PIDRConstants.PIDR_RATE_D.equals(mdfcSgmtCode)) {//注册资本及主要出资人段涉及两张表
				bom = JBOFactory.getBizObjectManager(tx,"jbo.pidr.HPIDR_RATE_REGCAP");//主要出资人是通过注册资本关联查询得来，注册资本无记录，则也不会有对应的主要出资人按段更正记录
				listbo = bom.createQuery("select * from O where CustomerId = :CustomerId and SessionId = :SessionId" )
						.setParameter("CustomerId",customerId).setParameter("SessionId",sessionId).getResultList(true);
			}else {
				bom = JBOFactory.getBizObjectManager(tx,"jbo.pidr." + htable);
				listbo = bom.createQuery("select * from O where CustomerId = :CustomerId and SessionId = :SessionId" )
						.setParameter("CustomerId",customerId).setParameter("SessionId",sessionId).getResultList(true);
			}
			if(listbo.size()>0){
				return "该段已经进行了按段更正操作，如有异议，\n请到{报送管理-数据变更管理-按段更正管理}处处理！";
			}
			//查一下基础段（按段更正在当期信息段中，需要保证有对应的当期基础段记录）
	        BizObjectManager bomBS = JBOFactory.getBizObjectManager(tx,"jbo.pidr.PIDR_RATE_BS");
	        BizObject bobs = bomBS.getObject(customerId);
	        if(bobs==null) {
				return "数据错误，没有相应的基础段";
			}
	        //查询基础段中一些字段，以用于存入按段更正表
	        String rptDate = bobs.getAttribute("RptDate").getString();//信息报告日期
	        String mngmtOrgCode = bobs.getAttribute("MngmtOrgCode").getString();//业务管理机构代码
	        String entCertType = bobs.getAttribute("EntCertType").getString();//身份标识类型
	        String entCertNum = bobs.getAttribute("EntCertNum").getString();//身份标识号码
	        String finStaYear = bobs.getAttribute("FinStaYear").getString();//报表年份
	        
	        //插入一条信息更正请求类记录
	  		BizObjectManager bomHM = JBOFactory.getBizObjectManager(tx,"jbo.pidr.HPIDR_RATE_MDFCINFO");
	  		BizObjectKey keyhm = bomHM.getKey();
	  		keyhm.setAttributeValue("SessionID", sessionId);
	  		keyhm.setAttributeValue("CustomerId", customerId);
	  		keyhm.setAttributeValue("MdfcSgmtCode", mdfcSgmtCode);
	  		BizObject bohm = bomHM.getObject(keyhm);
	  		if(bohm==null) {			
	  			bohm = bomHM.newObject();
	  			bohm.setAttributeValue("SessionID", sessionId);
	  			bohm.setAttributeValue("InfRecType", PIDRConstants.MDFCINFO_RATE);
	  			bohm.setAttributeValue("CustomerId", customerId);
	  			bohm.setAttributeValue("EntCertType", entCertType);
	  			bohm.setAttributeValue("EntCertNum", entCertNum);
	  			bohm.setAttributeValue("RptDate", rptDate);
	  			bohm.setAttributeValue("FinStaYear", finStaYear);
	  			bohm.setAttributeValue("MdfcSgmtCode", mdfcSgmtCode);
	  			bohm.setAttributeValue("MngmtOrgCode", mngmtOrgCode);
	  			bohm.setAttributeValue("InputUserID", curUserId);
	  			bohm.setAttributeValue("ManagerOrgID", managerOrgId);
	  			bohm.setAttributeValue("InputOrgID", curOrgId);
	  			bohm.setAttributeValue("InputTime", DateX.format(new Date(), "yyyy-MM-dd hh:mm:ss"));
	  			bohm.setAttributeValue("OccurDate", DateX.format(new Date(), "yyyy-MM-dd"));
	  			bomHM.saveObject(bohm);
	  		}
	  		
	  		//查询需要被复制到历史表的信息，即当期表记录，并往历史表中插入记录
	        if(PIDRConstants.PIDR_RATE_D.equals(mdfcSgmtCode)) {//注册资本及主要出资人段涉及两张表
	        	insertHisRate(tx,"HPIDR_RATE_REGCAP");
	        	insertHisRate(tx,"HPIDR_RATE_MNSHAHODINF");
	        }else {
	        	insertHisRate(tx, htable);
	        }
	        tx.commit();
			return "操作成功";
		}catch(JBOException e) {
			ARE.getLog().error("评级信息按段更正操作失败",e);
			try {
				tx.rollback();
			} catch (JBOException e1) {
				ARE.getLog().error("事物回滚异常",e1);
			}
			return "操作失败";
		}
	}
	
	/**
	 * 查询需要被复制到历史表的信息，即当期表记录，并往历史表中插入记录
	 * 其中对外投资信息段、负面信息段、主要出资人信息表只存入有效的记录
	 * @param tx
	 * @param htable
	 * @throws JBOException
	 */
	public void insertHisRate(JBOTransaction tx,String htable) throws JBOException{
		String ctable = htable.replaceFirst("H", "");//被复制的当期表
		BizObjectManager bom = JBOFactory.getBizObjectManager(tx,"jbo.pidr." + ctable);
		List<BizObject> listbo = null;
		if(PIDRConstants.PIDR_RATE_E.equals(mdfcSgmtCode) || PIDRConstants.PIDR_RATE_F.equals(mdfcSgmtCode) || "HPIDR_RATE_MNSHAHODINF".equals(htable)){//对外投资信息段、负面信息段、主要出资人信息表
            listbo = bom.createQuery("select * from O where CustomerId =:CustomerId and EffStatus =:EffStatus " )
                    .setParameter("CustomerId",customerId).setParameter("EffStatus",PIDRConstants.EFFSTATUS_1).getResultList(true);
        }else {
        	listbo = bom.createQuery("select * from O where CustomerId =:CustomerId " )
                    .setParameter("CustomerId",customerId).getResultList(true);
        }
  		//往对应的历史表里插入一条新的记录
		bom = JBOFactory.getBizObjectManager(tx,"jbo.pidr." + htable);
		for(BizObject bo : listbo){
			BizObject boNew = bom.newObject();
			boNew.setAttributesValue(bo);
			boNew.setAttributeValue("SessionID", sessionId);//十四个0
			bom.saveObject(boNew);
		}
	}

	public String getCustomerId() {
		return customerId;
	}

	public void setCustomerId(String customerId) {
		this.customerId = customerId;
	}

	public String getMdfcSgmtCode() {
		return mdfcSgmtCode;
	}

	public void setMdfcSgmtCode(String mdfcSgmtCode) {
		this.mdfcSgmtCode = mdfcSgmtCode;
	}

	public String getSessionId() {
		return sessionId;
	}

	public void setSessionId(String sessionId) {
		this.sessionId = sessionId;
	}

	public String getManagerOrgId() {
		return managerOrgId;
	}

	public void setManagerOrgId(String managerOrgId) {
		this.managerOrgId = managerOrgId;
	}

	public String getCurUserId() {
		return curUserId;
	}

	public void setCurUserId(String curUserId) {
		this.curUserId = curUserId;
	}

	public String getCurOrgId() {
		return curOrgId;
	}

	public void setCurOrgId(String curOrgId) {
		this.curOrgId = curOrgId;
	}
	
}