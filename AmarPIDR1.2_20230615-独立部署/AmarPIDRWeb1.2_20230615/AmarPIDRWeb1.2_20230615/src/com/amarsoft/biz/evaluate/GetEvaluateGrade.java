package com.amarsoft.biz.evaluate;

import java.math.BigDecimal;

import com.amarsoft.are.jbo.BizObject;
import com.amarsoft.are.jbo.BizObjectManager;
import com.amarsoft.are.jbo.JBOException;
import com.amarsoft.are.jbo.JBOFactory;
import com.amarsoft.awe.util.SqlObject;
import com.amarsoft.awe.util.Transaction;
import com.amarsoft.biz.bizlet.Bizlet;
import com.amarsoft.dict.als.manage.ObjectTypeManager;

public class GetEvaluateGrade extends Bizlet{
	
	public Object run(Transaction Sqlca) throws Exception {
		String objectNo = (String)getAttribute("ObjectNo");
		if (objectNo == null) objectNo = "";
		String orderNum = (String)getAttribute("OrderNum");
		if (orderNum == null) orderNum = "";
		BigDecimal evaluateGrade = new BigDecimal((String)getAttribute("EvaluateGrade"));
		
		String ecoIndusCate = getEcoIndusCate(objectNo).substring(1);// 获取行业分类代码大类（首字母）
		BigDecimal weightedValue = new BigDecimal(getWeightedValue(ecoIndusCate,orderNum));// 获取行业权重
		BigDecimal excellentValue = new BigDecimal(getExcellentValue(ecoIndusCate,orderNum));// 获取行业优秀值
		BigDecimal lowerValue = new BigDecimal(getLowerValue(ecoIndusCate,orderNum));// 获取行业平均值
		
		BigDecimal score = new BigDecimal(0);
		if(evaluateGrade.compareTo(lowerValue) > 0) {
			if(evaluateGrade.compareTo(excellentValue) <= 0) {
				score = (evaluateGrade.subtract(lowerValue)).divide((excellentValue.subtract(lowerValue)),2,BigDecimal.ROUND_HALF_UP);
			}else {
				score = new BigDecimal(100);
			}
		}
		
		return score.setScale(2,BigDecimal.ROUND_HALF_UP);
	}
	
	/**
	 * 获取行业分类代码
	 * @param ObjectNo
	 * @return
	 * @throws JBOException 
	 */
	public String getEcoIndusCate(String objectNo) throws JBOException {
		String sql = "select EcoIndusCate from PIDR_RATE_FSINF where CustomerId=:CustomerId";
		BizObject bo = JBOFactory.createBizObjectQuery("PIDR_RATE_FSINF", sql).setParameter("CustomerId", objectNo).getSingleResult(false);
		String ecoIndusCate = "";
		if(bo != null) {
			ecoIndusCate = bo.getAttribute("EcoIndusCate").getString();
		}
		return ecoIndusCate;
	}
	
	/**
	 * 获取行业权重
	 * @param ObjectNo
	 * @return
	 * @throws JBOException 
	 */
	public String getWeightedValue(String ecoIndusCate,String num) throws JBOException {
		String weight = "weightedValue" + num;
		String sql = "select " + weight + " from PIDR_ECOINDUSCATE_LIBRARY where ModelNo=:ModelNo and EcoIndusCate=:EcoIndusCate";
		BizObject bo = JBOFactory.createBizObjectQuery("PIDR_RATE_FSINF", sql)
				.setParameter("ModelNo", "ECRCreditGrade")
				.setParameter("EcoIndusCate", ecoIndusCate).getSingleResult(false);
		String weightedValue = "";
		if(bo != null) {
			weightedValue = bo.getAttribute(weight).getString();
		}
		return weightedValue;
	}

	/**
	 * 获取行业优秀值
	 * @param ObjectNo
	 * @return
	 * @throws JBOException 
	 */
	public String getExcellentValue(String ecoIndusCate,String num) throws JBOException {
		String excellent = "excellentValue" + num;
		String sql = "select " + excellent + " from PIDR_ECOINDUSCATE_LIBRARY where ModelNo=:ModelNo and EcoIndusCate=:EcoIndusCate";
		BizObject bo = JBOFactory.createBizObjectQuery("PIDR_RATE_FSINF", sql)
				.setParameter("ModelNo", "ECRCreditGrade")
				.setParameter("EcoIndusCate", ecoIndusCate).getSingleResult(false);
		String excellentValue = "";
		if(bo != null) {
			excellentValue = bo.getAttribute(excellent).getString();
		}
		return excellentValue;
	}

	/**
	 * 获取行业平均值
	 * @param ObjectNo
	 * @return
	 * @throws JBOException 
	 */
	public String getLowerValue(String ecoIndusCate,String num) throws JBOException {
		String lower = "lowerValue" + num;
		String sql = "select " + lower + " from PIDR_ECOINDUSCATE_LIBRARY where ModelNo=:ModelNo and EcoIndusCate=:EcoIndusCate";
		BizObject bo = JBOFactory.createBizObjectQuery("PIDR_RATE_FSINF", sql)
				.setParameter("ModelNo", "ECRCreditGrade")
				.setParameter("EcoIndusCate", ecoIndusCate).getSingleResult(false);
		String lowerValue = "";
		if(bo != null) {
			lowerValue = bo.getAttribute(lower).getString();
		}
		return lowerValue;
	}
}
