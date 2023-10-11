package com.amarsoft.app.pidr.whitelist;

import java.text.SimpleDateFormat;
import java.util.Date;

import com.amarsoft.are.ARE;
import com.amarsoft.are.jbo.BizObject;
import com.amarsoft.are.jbo.BizObjectManager;
import com.amarsoft.are.jbo.JBOException;
import com.amarsoft.are.jbo.JBOFactory;
import com.amarsoft.are.jbo.JBOTransaction;

/**
 * 央评系统白名单处理类
 * @author hcliu
 *
 */
public class PidrWhiteListHandler {
	private String customerID;
	private String entName;
	private String entCertType;
	private String entCertNum;
	private String PBCEvalScore;
	private SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	private String date = "";//日期
	
	/**
	 * 新增数据保存
	 * @param tx
	 * @return 提示信息
	 */
	public String saveRecord(JBOTransaction tx) {
		date = dateFormat.format(new Date(System.currentTimeMillis()));
		BizObjectManager bom;//白名单表
		try {
			//向白名单中添加列表数据
			bom = JBOFactory.getBizObjectManager(tx, "jbo.pidr.PIDR_WHITELIST");
			BizObject bo = bom.newObject();
			bo.setAttributeValue("CustomerID", customerID);
			bo.setAttributeValue("EntName", entName);
			bo.setAttributeValue("EntCertType", entCertType);
			bo.setAttributeValue("EntCertNum", entCertNum);
			bo.setAttributeValue("PBCEvalScore", PBCEvalScore);
			bo.setAttributeValue("RunStatus", "00");//状态-新增
			bo.setAttributeValue("RunTime", date);
			bom.saveObject(bo);
			tx.commit();
		} catch (JBOException e) {
			ARE.getLog().error("向白名单添加数据异常！！！" , e);
			try {
				tx.rollback();
			} catch (JBOException e1) {
				ARE.getLog().error("事务回滚异常！！！" , e1);
			}
			return "保存白名单数据时出错";
		}
		return "SUCCESS";
	}
	
	/**
	 * 全表清空记录方法
	 * @return 提示信息
	 */
	public String clearRecord(JBOTransaction tx) {
		try {
			BizObjectManager clearBom = JBOFactory.getBizObjectManager(tx, "jbo.pidr.PIDR_WHITELIST");
			clearBom.createQuery("delete from O").executeUpdate();
			tx.commit();
		} catch (JBOException e) {
			ARE.getLog().error("清空白名单异常！！！" , e);
			try {
				tx.rollback();
			} catch (JBOException e1) {
				ARE.getLog().error("事务回滚异常！！！" , e1);
			}
			return "清空白名单数据时出错";
		}
		
		return "SUCESS";
	}
	
	/**
	 * 从接口表插入数据到白名单表中
	 * @return
	 */
	public String insertWhiteList(JBOTransaction tx) {
		date = dateFormat.format(new Date(System.currentTimeMillis()));
		try {
			BizObjectManager bom = JBOFactory.getBizObjectManager(tx, "jbo.pidr.PIDR_WHITELIST");
			// 重复客户校验
			BizObject selectBo = bom.createQuery("select 1 from O where CustomerID = :CustomerID")
										.setParameter("CustomerID", customerID)
										.getSingleResult(true);
			if (selectBo != null) {
				ARE.getLog("白名单中已存在该客户，客户号：" + customerID);
				return "EXISTS";
			}
			//新白名单数据插入
			BizObject insertBo = bom.newObject();
			insertBo.setAttributeValue("CustomerID", customerID);
			insertBo.setAttributeValue("EntName", entName);
			insertBo.setAttributeValue("EntCertType", entCertType);
			insertBo.setAttributeValue("EntCertNum", entCertNum);
			insertBo.setAttributeValue("RunStatus", "00");//状态-新增
			insertBo.setAttributeValue("RunTime", date);
			bom.saveObject(insertBo);
			tx.commit();
		} catch (JBOException e) {
			ARE.getLog().error("插入白名单数据异常！！！",e);
			try {
				tx.rollback();
			} catch (JBOException e1) {
				ARE.getLog().error("事务回滚异常！！！",e1);
			}
			return "向白名单表中插入数据时出错";
		}
		return "SUCCESS";
	}
	public String getCustomerID() {
		return customerID;
	}
	public void setCustomerID(String customerID) {
		this.customerID = customerID;
	}
	public String getEntName() {
		return entName;
	}
	public void setEntName(String entName) {
		this.entName = entName;
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
	public String getPBCEvalScore() {
		return PBCEvalScore;
	}
	public void setPBCEvalScore(String pBCEvalScore) {
		PBCEvalScore = pBCEvalScore;
	}
}
