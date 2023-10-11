package com.amarsoft.app.pidr.mdfc;

import com.amarsoft.app.pidr.common.PIDRConstants;
import com.amarsoft.are.ARE;
import com.amarsoft.are.jbo.BizObjectManager;
import com.amarsoft.are.jbo.JBOException;
import com.amarsoft.are.jbo.JBOFactory;
import com.amarsoft.are.jbo.JBOTransaction;
/**
 * 企业评级信息按段更正-删除按钮处理类
 * @author kwwu
 *
 */
public class DeleteRateMdfcInfo {
	private String customerId;//待更正客户编号
	private String mdfcSgmtCode;//待更正段段标
	private String finstaYear;//报表年份
	
	/**
	 * 根据段标进行删除
	 * @param tx
	 * @return
	 * @throws JBOException
	 */
	public String delMdfcInfo(JBOTransaction tx){
		String htable = PIDRConstants.PIDRRATE_SGMTCODE_TABLE_HIS.get(mdfcSgmtCode);//根据段标获取对应历史表
		try {
			if(PIDRConstants.PIDR_RATE_D.equals(mdfcSgmtCode)) {//注册资本及主要出资人段涉及两张表
				delHis(tx,"HPIDR_RATE_REGCAP");
				delHis(tx,"HPIDR_RATE_MNSHAHODINF");
			}else {
				delHis(tx,htable);		
			}
			tx.commit();
			return "删除成功";
		}catch(JBOException e) {
			ARE.getLog().error("评级信息按段更正，删除待更正历史段记录失败",e);
			try {
				tx.rollback();
			} catch (JBOException e1) {
				ARE.getLog().error("事物回滚异常",e1);
			}
			return "删除失败";
		}
	}
	
	/**
	 * 删除待更正段历史记录
	 * @param tx
	 * @param htable
	 * @throws JBOException
	 */
	public void delHis(JBOTransaction tx,String htable) throws JBOException {
		BizObjectManager manager = null;
		manager = JBOFactory.getBizObjectManager(tx, "jbo.pidr." + htable);
		if(manager !=null){
			if(PIDRConstants.PIDR_RATE_G.equals(mdfcSgmtCode) || PIDRConstants.PIDR_RATE_H.equals(mdfcSgmtCode) 
					|| PIDRConstants.PIDR_RATE_I.equals(mdfcSgmtCode)) {//资产负债表、利润表、现金流量表
				manager.createQuery("delete from O where CustomerId =:CustomerId and FinstaYear = :FinstaYear "
						+ " and SessionId =:SessionId " )
				.setParameter("CustomerId",customerId).setParameter("FinstaYear",finstaYear)
				.setParameter("SessionId",PIDRConstants.SESSIONID_14).executeUpdate();
			}else {
				manager.createQuery("delete from O where CustomerId = :CustomerId and SessionID = :SessionID")
					.setParameter("CustomerId", customerId).setParameter("SessionID", PIDRConstants.SESSIONID_14).executeUpdate();
			}
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

	public String getFinstaYear() {
		return finstaYear;
	}

	public void setFinstaYear(String finstaYear) {
		this.finstaYear = finstaYear;
	}
}