package com.amarsoft.app.awe.pidr.dwhandler;

import com.amarsoft.are.jbo.BizObject;
import com.amarsoft.are.jbo.JBOFactory;
import com.amarsoft.are.jbo.JBOTransaction;
import com.amarsoft.are.lang.StringX;
import com.amarsoft.awe.dw.handler.impl.CommonHandler;
/**
 * classCatalig的handler类
 * @author jyshen
 *
 */
public class PidrClassCatalogHandler extends CommonHandler{
	@Override
	public void beforeDelete(JBOTransaction tx, BizObject bo) throws Exception {
		String className = bo.getAttribute("ClassName").getString();
		if(StringX.isEmpty(className)) { return;}
		JBOFactory.getBizObjectManager(tx, "jbo.sys.CLASS_METHOD").createQuery("DELETE FROM O where ClassName=:ClassName")
		 .setParameter("ClassName", className).executeUpdate();
	}
}
