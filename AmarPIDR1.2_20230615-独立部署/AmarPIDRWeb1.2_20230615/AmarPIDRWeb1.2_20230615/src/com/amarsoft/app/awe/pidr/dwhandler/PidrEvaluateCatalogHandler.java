package com.amarsoft.app.awe.pidr.dwhandler;

import com.amarsoft.are.jbo.BizObject;
import com.amarsoft.are.jbo.JBOFactory;
import com.amarsoft.are.jbo.JBOTransaction;
import com.amarsoft.are.lang.StringX;
import com.amarsoft.awe.dw.handler.impl.CommonHandler;
/**
 * evaluate_model的handler类
 * @author jyshen
 *
 */
public class PidrEvaluateCatalogHandler extends CommonHandler{
	@Override
	public void beforeDelete(JBOTransaction tx, BizObject bo) throws Exception {
		String modelNo = bo.getAttribute("ModelNo").getString();
		if(StringX.isEmpty(modelNo)) { return;}
		JBOFactory.getBizObjectManager(tx, "jbo.pidr.EVALUATE_MODEL").createQuery("DELETE FROM O where ModelNo=:ModelNo")
		.setParameter("ModelNo", modelNo).executeUpdate();
	}
}
