package com.amarsoft.awe.dw.ui.list;

import java.io.ByteArrayInputStream;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import com.amarsoft.are.jbo.BizObject;
import com.amarsoft.are.jbo.BizObjectKey;
import com.amarsoft.are.jbo.BizObjectManager;
import com.amarsoft.are.jbo.JBOFactory;
import com.amarsoft.are.lang.OperationContext;
import com.amarsoft.are.util.xml.Document;
import com.amarsoft.are.util.xml.Element;
import com.amarsoft.awe.Configure;
import com.amarsoft.awe.RuntimeContext;
import com.amarsoft.awe.dw.ASDataObject;
import com.amarsoft.awe.dw.handler.BusinessProcess;
import com.amarsoft.awe.dw.ui.util.Const;
import com.amarsoft.context.ASUser;

public class DeleteAction
{
    private String jboClass;
    private String businessProcess;
	private BizObject[] bizObjects;
	private List<Element> rowList;
	private String errors;
	private String resultInfo;
	private HttpServletRequest request;
	private ASDataObject asObj;
	protected ASUser curUser;
  
	public String getResultInfo() { return this.resultInfo; }


	public String getErrors() { return this.errors; } public DeleteAction(String jboClass, ASDataObject asObj, HttpServletRequest request, String businessProcess) { this.jboClass = "";
    	this.businessProcess = "";
    	this.errors = "";
    	this.resultInfo = "";
    	this.jboClass = jboClass;
    	this.asObj = asObj;
    	this.businessProcess = businessProcess;
    	this.request = request;
    	this.curUser = ((RuntimeContext)request.getSession().getAttribute("CurARC")).getUser(); }

  
	protected BusinessProcess createBusinessProcess(String name) throws Exception {
		if (name == null || name.equals(""))
			name = Const.getDefaultBusinessProcess(); 
		return (BusinessProcess)Class.forName(name).newInstance();
	}
 
	public boolean deleteObjects(String beDeleteDatas) throws Exception {
		parseXml(beDeleteDatas);
		BizObjectManager manager = JBOFactory.getFactory().getManager(this.jboClass);
		this.bizObjects = new BizObject[this.rowList.size()];
		ArrayList bizObjectList = new ArrayList();
		for (int i = 0; i < this.rowList.size(); i++) {
			BizObjectKey key = manager.getKey();
			Element row = (Element)this.rowList.get(i);
			List cols = row.getChildren();
			for (int j = 0; j < cols.size(); j++) {
				Element col = (Element)cols.get(j);
				key.setAttributeValue(col.getAttributeValue("name"), col.getTextTrim());
			} 
			this.bizObjects[i] = manager.getObject(key);
			if (this.bizObjects[i] != null)
				bizObjectList.add(this.bizObjects[i]); 
		} 
		this.bizObjects = (BizObject[])bizObjectList.toArray(new BizObject[0]);
		BusinessProcess process = createBusinessProcess(this.businessProcess);
		process.setRequest(this.request);
		process.setManager(manager);
		process.setObjects(this.bizObjects);
		process.setASDataObject(this.asObj);
		process.setCurUser(this.curUser);
		OperationContext auditContext = OperationContext.currentContext();
		if (auditContext != null) {
			auditContext.setApplicationData(this.asObj.getDONO());
		}
		process.setConfigure(Configure.getInstance(this.request.getSession().getServletContext()));
		boolean result = process.delete(null);
		this.errors = process.getErrors();
		this.resultInfo = process.getResultInfo();
		return result;
	}
  
	private void parseXml(String xml) throws Exception {
		Document xDocument = new Document(new ByteArrayInputStream(xml.getBytes("UTF-8")));
		Element root = xDocument.getRootElement();
    
		this.rowList = root.getChildren();
	}
}


/* Location:              /home/amarsoft/work/workspace-test/AmarPIDRWeb1.0_20230316/WebContent/WEB-INF/lib/awe-ow-5.3.jar!/com/amarsoft/awe/dw/ui/list/DeleteAction.class
 * Java compiler version: 8 (52.0)
 * JD-Core Version:       1.0.7
 */