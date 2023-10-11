package com.amarsoft.app.pidr.util;

import com.amarsoft.are.jbo.BizObject;
import com.amarsoft.are.jbo.BizObjectManager;
import com.amarsoft.are.jbo.JBOException;
import com.amarsoft.are.jbo.JBOFactory;

public class NameManager {
	
	public static String getComboNameByCode(String pbCode) throws JBOException {
		if ((pbCode == null) || (pbCode.equals(""))) {
			pbCode = "undefined";
		}
		BizObjectManager bom = JBOFactory.getBizObjectManager("jbo.pidr.PIDR_CODE_LIBRARY");
		String sql = "select PbItemName from O where PbCode =:PbCode";
		BizObject bo = bom.createQuery(sql).setParameter("PbCode",pbCode).getSingleResult(false);
		if(bo != null){
			return bo.getAttribute("PbItemName").getString();
		}
		return "";
	}
	
	public static String getComboNameByCode(String codeNo, String subCodeNo, String pbCode) throws JBOException {
		if ((codeNo == null) || (codeNo.equals(""))) {
			codeNo = "undefined";
		}
		if ((subCodeNo == null) || (subCodeNo.equals(""))) {
			subCodeNo = "undefined";
		}
		if ((pbCode == null) || (pbCode.equals(""))) {
			pbCode = "undefined";
		}
		BizObjectManager bom = JBOFactory.getBizObjectManager("jbo.pidr.PIDR_CODE_LIBRARY");
		String sql = "select PBITEMNAME from O where CodeNo = :CodeNo and SubCodeNo = :SubCodeNo and PbCode = :PbCode";
		BizObject bo = bom.createQuery(sql)
				.setParameter("CodeNo", codeNo)
				.setParameter("SubCodeNo", subCodeNo)
				.setParameter("PbCode", pbCode).getSingleResult(false);
		if(bo != null){
			return bo.getAttribute("PbItemName").getString();
		}
		return "";
	}
	
	public static String getComboNameByCode2(String codeno, String pbcode) throws JBOException {
		if ((pbcode == null) || (pbcode.equals(""))) {
			pbcode = "undefined";
		}
		BizObjectManager bom = JBOFactory.getBizObjectManager("jbo.pidr.PIDR_CODE_LIBRARY");
		String sql = "select PBITEMNAME from O where CodeNo = :codeno and PbCode = :pbcode";
		BizObject result = bom.createQuery(sql)
				.setParameter("codeno", codeno)
				.setParameter("pbcode", pbcode).getSingleResult(false);
		if(result != null){
			return result.getAttribute("PBITEMNAME").toString();
		}
		return "";
	}
}
