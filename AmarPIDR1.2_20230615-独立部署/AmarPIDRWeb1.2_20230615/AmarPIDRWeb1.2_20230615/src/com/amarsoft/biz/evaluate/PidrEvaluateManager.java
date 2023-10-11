package com.amarsoft.biz.evaluate;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import com.amarsoft.are.ARE;
import com.amarsoft.are.jbo.BizObject;
import com.amarsoft.are.jbo.BizObjectManager;
import com.amarsoft.are.jbo.JBOFactory;
import com.amarsoft.are.jbo.JBOTransaction;
import com.amarsoft.are.jbo.QueryResult;
import com.amarsoft.are.lang.DateX;
import com.amarsoft.are.lang.StringX;
import com.amarsoft.are.lang.json.Json;
import com.amarsoft.are.lang.json.JsonDecoder;
import com.amarsoft.are.util.StringFunction;
import com.amarsoft.awe.control.model.Page;
import com.amarsoft.awe.ui.widget.HTMLControls;//独立版本使用
//import com.amarsoft.web.ui.HTMLControls;//合并版（ECR/UCR）放开始用

public class PidrEvaluateManager {
	private Evaluate evaluate;
	private String action;
	private String objectType;
	private String objectNo;
	private String modelNo;
	private String modelType;
	private String modelTypeName;
	private String modelTypeAttributes;
	private String accountMonthSelectSQL;
	private String defaultModelNoSQL;
	private String accountMonthInputType;
	private String accountMonthExplanation;
	private String displayFinalResult;
	private String displayItemScore;
	private String buttonSaveFace;
	private String buttonCalcFace;
	private String buttonDelFace;
	private String buttonCloseFace;
	private String itemValueDisplayWidth;
	private BizObjectManager evalRecordManager;
	private BizObjectManager evalDataManager;
	private BizObject evalCatalog;
	private Page CurPage;
	private List<List<String>> monthSelectList;
	private List<String> month24;
	private String monthSelections;
	private String modelSelections;
	/**  */
	public PidrEvaluateManager(String objectType, String objectNo, String modelType, JBOTransaction tx)
			throws Exception {
		this(objectType, objectNo, modelType);
	}
	/** 查看评级数据 */
	public PidrEvaluateManager(String objectType, String objectNo, String modelType) throws Exception {
		this.month24 = new ArrayList();
		this.objectNo = objectNo;
		this.objectType = objectType;
		this.modelType = modelType;
		queryModelType();
		String curMonth = DateX.format(new Date(), "yyyy/MM");
		for (int iMonth = 0; iMonth < 24; iMonth++) {
			this.month24.add(curMonth);
			curMonth = StringFunction.getRelativeAccountMonth(curMonth, "Month", -1);
		}
		BizObjectManager catalogManager = JBOFactory.getBizObjectManager("jbo.pidr.EVALUATE_CATALOG");
		String jql = "select ModelNo,ModelName from O where ModelType=:ModelType";
		if ("010".equals(modelType) || "012".equals(modelType)) {
			jql = String.valueOf(jql) + " and ModelNo = :ModelNo";
		}
		jql = String.valueOf(jql) + " order by ModelNo ";
		QueryResult queryResult = catalogManager.createQuery(jql).setParameter("ModelType", modelType).setParameter("ModelNo", this.modelNo).getResultList(false);
		this.modelSelections = HTMLControls.generateDropDownSelect(queryResult, "ModelNo", "ModelName", this.modelNo);
	}
	/**  */
	public PidrEvaluateManager(String action, String objectType, String objectNo, String serialNo, String modelNo,Page CurPage, JBOTransaction tx) throws Exception {
		this.month24 = new ArrayList();
		this.objectNo = objectNo;
		this.objectType = objectType;
		this.CurPage = CurPage;
		this.action = action;
		this.modelNo = modelNo;
		this.evalCatalog = JBOFactory.createBizObjectQuery("jbo.pidr.EVALUATE_CATALOG", "select O.* from O where ModelNo=:ModelNo").setParameter("ModelNo", modelNo).getSingleResult(false);
		if (this.evalCatalog != null) {
			this.modelType = this.evalCatalog.getAttribute("modelType").getString();
			queryModelType();
		}
		if (!StringX.isEmpty(objectType) && !StringX.isEmpty(objectNo) && !StringX.isEmpty(serialNo)) {
			this.evaluate = new Evaluate(objectType, objectNo, serialNo, tx);
			this.evalRecordManager = JBOFactory.getBizObjectManager(tx, "jbo.pidr.EVALUATE_RECORD");
			this.evalDataManager = JBOFactory.getBizObjectManager(tx, "jbo.pidr.EVALUATE_DATA");
		}
	}
	/** 为页面提供模型参数数据 */
	private void queryModelType() throws Exception {
		BizObject modelTypeBo = JBOFactory
				.createBizObjectQuery("jbo.pidr.CODE_LIBRARY","select ItemName,RelativeCode,Attribute1,Attribute2 from O where CodeNo='EvaluateModelType' and ItemNo=:ItemNo")
				.setParameter("ItemNo", this.modelType)
				.getSingleResult(false);
		if (modelTypeBo != null) {
			this.modelTypeName = modelTypeBo.getAttribute("ItemName").getString();
			this.accountMonthSelectSQL = modelTypeBo.getAttribute("Attribute1").getString();
			this.defaultModelNoSQL = modelTypeBo.getAttribute("Attribute2").getString();
			this.modelTypeAttributes = modelTypeBo.getAttribute("RelativeCode").getString();
			if (this.modelTypeAttributes == null)throw new Exception("模型类型 [" + this.modelType + "] 的属性集 没有定义，请查看CODE_LIBRARY:EvaluateModelType的RelativeCode属性");
			this.accountMonthInputType = StringFunction.getProfileString(this.modelTypeAttributes,"AccountMonthInputType");
			this.accountMonthExplanation = StringFunction.getProfileString(this.modelTypeAttributes,"AccountMonthExplanation");
			this.displayFinalResult = StringFunction.getProfileString(this.modelTypeAttributes, "DisplayFinalResult");
			this.displayItemScore = StringFunction.getProfileString(this.modelTypeAttributes, "DisplayItemScore");
			this.buttonSaveFace = StringFunction.getProfileString(this.modelTypeAttributes, "ButtonSaveFace");
			this.buttonCalcFace = StringFunction.getProfileString(this.modelTypeAttributes, "ButtonCalcFace");
			this.buttonDelFace = StringFunction.getProfileString(this.modelTypeAttributes, "ButtonDelFace");
			this.buttonCloseFace = StringFunction.getProfileString(this.modelTypeAttributes, "ButtonCloseFace");
			this.itemValueDisplayWidth = StringFunction.getProfileString(this.modelTypeAttributes,"ItemValueDisplayWidth");
			if (StringX.isEmpty(this.accountMonthInputType)) this.accountMonthInputType = "";
			if (StringX.isEmpty(this.accountMonthExplanation)) this.accountMonthExplanation = "无";
			if (StringX.isEmpty(this.displayFinalResult)) this.displayFinalResult = "Y";
			if (StringX.isEmpty(this.displayItemScore))	 this.displayItemScore = "Y";
			if (StringX.isEmpty(this.buttonSaveFace)) this.buttonSaveFace = "保存";
			if (StringX.isEmpty(this.buttonCalcFace)) this.buttonCalcFace = "测算";
			if (StringX.isEmpty(this.buttonDelFace)) this.buttonDelFace = "删除";
			if (StringX.isEmpty(this.buttonCloseFace)) this.buttonCloseFace = "返回";
			if (StringX.isEmpty(this.itemValueDisplayWidth)) this.itemValueDisplayWidth = "100";
			try {
				if (!StringX.isEmpty(this.accountMonthSelectSQL)) {
					this.monthSelectList = getResult(this.accountMonthSelectSQL);
					this.monthSelections = HTMLControls.generateDropDownSelect(getMonthSelectValue(),getMonthSelectName(), "");
				}
				if (!StringX.isEmpty(this.defaultModelNoSQL))
					this.modelNo = (String) ((List) getResult(this.defaultModelNoSQL).get(0)).get(0);
			} catch (Exception e) {
				ARE.getLog(getClass()).error(e.toString());
			}
		}
	}
	private List<List<String>> getResult(String jsonStr) throws Exception {
		Json accountMonthJson = JsonDecoder.decode(jsonStr);
		String mainClass = accountMonthJson.getString("MainClass");
		String returnAttributes = accountMonthJson.getString("ReturnAttributes");
		String jql = accountMonthJson.getString("Query");
		List<List<String>> list = new ArrayList<List<String>>();
		if (!StringX.isEmpty(jql)) {
			jql = jql.replace("#ObjectType", this.objectType).replace("#ObjectNo", this.objectNo).replace("#ModelType",
					this.modelType);
			String[] attrs = returnAttributes.split(",");
			for (int i = 0; i < attrs.length; i++) {
				list.add(new ArrayList());
			}
			QueryResult queryResult = JBOFactory.getBizObjectManager(mainClass).createQuery(jql).getResultList(false);
			for (BizObject bo : queryResult) {
				for (int i = 0; i < attrs.length; i++) {
					((List) list.get(i)).add(bo.getAttribute(attrs[i]).getString());
				}
			}
		}
		return list;
	}

	public String[] getMonthSelectValue() {
		return (String[]) ((List) this.monthSelectList.get(0)).toArray(new String[0]);
	}

	public String[] getMonthSelectName() {
		return (String[]) ((List) this.monthSelectList.get(1)).toArray(new String[0]);
	}

	public String getModelNo() {
		return this.modelNo;
	}

	public String getModelType() {
		return this.modelType;
	}

	public String getModelTypeAttributes() {
		return this.modelTypeAttributes;
	}

	public String getModelTypeName() {
		return this.modelTypeName;
	}

	public String getAccountMonthInputType() {
		return this.accountMonthInputType;
	}

	public String getAccountMonthExplanation() {
		return this.accountMonthExplanation;
	}

	public String getDisplayFinalResult() {
		return this.displayFinalResult;
	}

	public String getDisplayItemScore() {
		return this.displayItemScore;
	}

	public String getButtonSaveFace() {
		return this.buttonSaveFace;
	}

	public String getButtonCalcFace() {
		return this.buttonCalcFace;
	}

	public String getButtonDelFace() {
		return this.buttonDelFace;
	}

	public String getButtonCloseFace() {
		return this.buttonCloseFace;
	}

	public String getItemValueDisplayWidth() {
		return this.itemValueDisplayWidth;
	}

	public List<String> getMonth24() {
		return this.month24;
	}

	public String getMonthSelections() {
		return this.monthSelections;
	}

	public String getModelSelections() {
		return this.modelSelections;
	}

	public Evaluate getEvaluate() {
		return this.evaluate;
	}

	public BizObject getEvalCatalog() {
		return this.evalCatalog;
	}

	public BizObjectManager getEvalRecordManager() {
		return this.evalRecordManager;
	}

	public BizObjectManager getEvalDataManager() {
		return this.evalDataManager;
	}

}
