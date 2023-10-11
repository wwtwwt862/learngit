package com.amarsoft.app.awe.pidr.dwhandler;

import java.util.Date;
import java.util.List;

import com.amarsoft.app.pidr.common.PIDRConstants;
import com.amarsoft.app.pidr.flow.PidrFlowService;
import com.amarsoft.are.ARE;
import com.amarsoft.are.jbo.BizObject;
import com.amarsoft.are.jbo.BizObjectManager;
import com.amarsoft.are.jbo.JBOException;
import com.amarsoft.are.jbo.JBOFactory;
import com.amarsoft.are.jbo.JBOTransaction;
import com.amarsoft.are.jbo.QueryResult;
import com.amarsoft.are.lang.DateX;
import com.amarsoft.are.lang.StringX;
import com.amarsoft.are.lang.json.Json;
import com.amarsoft.are.lang.json.JsonDecoder;
import com.amarsoft.biz.evaluate.PidrEvaluate;

/**
 * 财报数据的评级信入库
 */
public class PidrRunEvaluate {
	private static String objectType;
	private static String CustomerId;// 客户号
	private static String modelNo;
	private static String FinStaYear;
	private static String EntName;
	private static String EntCertType;
	private static String EntCertNum;
	private static String userId;
	private static String orgId;
	private static String Flag;

	public String runEvaluate(JBOTransaction tx) throws Exception {
		String exitStr=exitRecords(CustomerId,FinStaYear,tx);
		if(!"Success".equals(exitStr)) return exitStr;
		String returnMessage = "";
		BizObjectManager evalRecordManager = JBOFactory.getBizObjectManager(tx, "jbo.pidr.PIDR_EVALUATE_RECORD");
		BizObjectManager evalDataManager = JBOFactory.getBizObjectManager(tx, "jbo.pidr.PIDR_EVALUATE_DATA");
		BizObjectManager evalModelManager = JBOFactory.getBizObjectManager(tx, "jbo.pidr.EVALUATE_MODEL");
		// 判断是否存在已有的，依据客户号，报表年份判断 EVALUATE_RECORD
		List<BizObject> listRecord = evalRecordManager
				.createQuery("select * from o where CustomerId=:CustomerId and FinStaYear=:FinStaYear")
				.setParameter("CustomerId", CustomerId).setParameter("FinStaYear", FinStaYear).getResultList();

		if (listRecord.size() > 0) {
			if ("1".equals(Flag)) {
				returnMessage = "该数据已有评级数据，是否覆盖更新原有评级";
				return returnMessage;
			}
		}
		if (PIDRConstants.EVALUATE_FLAG_ADD.equals(Flag)) {// 新增数据
			//判断是否数据段是否存在
			returnMessage = exitRecords(CustomerId,FinStaYear,tx);
			BizObject evalRecord = evalRecordManager.newObject();
			evalRecord.setAttributeValue("ObjectType", objectType)// 对象类型
					.setAttributeValue("CustomerId", CustomerId)// 客户号
					.setAttributeValue("FinStaYear", FinStaYear)// 年份
					.setAttributeValue("EntName", EntName)
					.setAttributeValue("EntCertType", EntCertType)
					.setAttributeValue("EntCertNum", EntCertNum)
					.setAttributeValue("ModelNo", modelNo)// 模型编号
					.setAttributeValue("EvaluateDate", DateX.format(new Date()))// 评级日期
					.setAttributeValue("OrgID", orgId)//
					.setAttributeValue("UserID", userId).setAttributeValue("ReportScope", Flag)// 报表口径
					.setAttributeValue("ReportStatus",PIDRConstants.REPORT_STATUS_1);//初始插入record表，默认正常上报
			evalRecordManager.saveObject(evalRecord);
			QueryResult queryResult = evalModelManager.createQuery("ModelNo=:ModelNo ").setParameter("ModelNo", modelNo)// 模型编号
					.getResultList(false);
			for (BizObject tempBo : queryResult) {
				BizObject evalData = evalDataManager.newObject();
				String jdNum=tempBo.getAttribute("ItemNo").getString();
				evalData.setAttributeValue("ObjectType", objectType);// 模型编号
				evalData.setAttributeValue("CustomerId", CustomerId);// 客户号
				evalData.setAttributeValue("ItemNo",jdNum);// 节点
				if(jdNum.length()==5&& jdNum.startsWith("1.")) {
					evalData.setAttributeValue("ItemValue","100" );// 人工计算值，新增默认给100
					evalData.setAttributeValue("ItemValue2","100" );// 机器计算值，新增默认给100
					evalData.setAttributeValue("EVALUATESCORE2","100" );// 评估分数，每加权重和折扣前的
				}
				evalDataManager.saveObject(evalData);
			}
			returnMessage = "新增成功";
		} else if(PIDRConstants.EVALUATE_FLAG_EDITE.equals(Flag)) {// 更新数据的
				// serino EVALUATE_RECORD
			int upRecord = evalRecordManager.createQuery(
					"update o set EvaluateDate=:EvaluateDate,FinStaYear=:FinStaYear,EntName=:EntName,EntCertType=:EntCertType"
					+ ",EntCertNum=:EntCertNum where  CustomerId=:CustomerId and FinStaYear=:FinStaYear")
					.setParameter("EvaluateDate", DateX.format(new Date()))
					.setParameter("FinStaYear", FinStaYear)// 年份
					.setParameter("EntName", EntName)
					.setParameter("EntCertType", EntCertType)
					.setParameter("EntCertNum", EntCertNum)
					.setParameter("CustomerId", CustomerId)
					.setParameter("FinStaYear", FinStaYear).executeUpdate();
			if(upRecord > 0) {
				returnMessage = "更新成功";
			}else {
				returnMessage = "更新失败";
			}
		}
		upEcoIndusCate(CustomerId,FinStaYear,tx);
		return returnMessage;
	}
	/** 评级前数据段存在性验证 */
	public static String exitRecords(String customerId, String finStaYear,JBOTransaction tx) throws JBOException {
		StringBuffer returnMessage = new StringBuffer();
		BizObjectManager fsInfBom = JBOFactory.getBizObjectManager(tx, "jbo.pidr.PIDR_RATE_BS");
		List<BizObject> fsInfoBoList = fsInfBom.createQuery("select prf.customerid as v.prf ," + 
				"concat(prb2.CustomerID,prb2.Stage) as v.prb2," + 
				"concat(prb22.CustomerID,prb22.Stage) as v.prb22," + 
				"concat(prc.CustomerID,prc.Stage) as  v.prc," + 
				"concat(prc2.CustomerID,prc2.Stage) as  v.prc2, " + 
					"concat(pri.CustomerID,pri.Stage) as  v.pri," + 
				"concat(pri2.CustomerID,pri2.Stage) as v.pri2," + 
				"concat(pfs.CustomerID,pfs.Stage) as  v.pfs, " + 
				"concat(pfs2.CustomerID,pfs2.Stage)  as  v.pfs2  " + 
				"from  O  " + 
				"LEFT JOIN jbo.pidr.PIDR_RATE_FSINF PRF ON O.CUSTOMERID=PRF.CUSTOMERID  " + 
					"LEFT JOIN jbo.pidr.PIDR_RATE_BALANCESSHEET PRB2 ON PRB2.CUSTOMERID =O.CUSTOMERID AND PRB2.STAGE ='1' " + 
				"LEFT JOIN jbo.pidr.PIDR_RATE_BALANCESSHEET PRB22 ON PRB22.CUSTOMERID =O.CUSTOMERID AND PRB22.STAGE ='2' " + 
				"LEFT JOIN jbo.pidr.PIDR_RATE_CASHFLOW PRC ON PRC.CUSTOMERID =O.CUSTOMERID AND PRC.STAGE ='1' " + 
				"LEFT JOIN jbo.pidr.PIDR_RATE_CASHFLOW PRC2 ON PRC2.CUSTOMERID =O.CUSTOMERID AND PRC2.STAGE ='2' " + 
				"LEFT JOIN jbo.pidr.PIDR_RATE_INCOME PRI  ON PRI.CUSTOMERID =O.CUSTOMERID AND PRI.STAGE ='1' " + 
				"LEFT JOIN jbo.pidr.PIDR_RATE_INCOME PRI2 ON PRI2.CUSTOMERID =O.CUSTOMERID AND PRI2.STAGE ='2' " + 
				"LEFT JOIN jbo.pidr.PIDR_FINANCE_STATEMENT PFS  ON PFS.CUSTOMERID =O.CUSTOMERID AND PFS.STAGE ='1' " + 
				"LEFT JOIN jbo.pidr.PIDR_FINANCE_STATEMENT PFS2 ON PFS2.CUSTOMERID =O.CUSTOMERID AND PFS2.STAGE ='2' " + 
				"where O.CustomerId=:CustomerId").setParameter("CustomerId", customerId).getResultList(false);
		for(BizObject bo:fsInfoBoList) {
			if(StringX.isEmpty(bo.getString("prf"))) returnMessage.append("基本概况段数据为空\n");
			if(StringX.isEmpty(bo.getString("prb2"))) returnMessage.append("资产负债段本期数据为空\n");
			if(StringX.isEmpty(bo.getString("prb22"))) returnMessage.append("资产负债段上期数据为空\n");
			if(StringX.isEmpty(bo.getString("prc"))) returnMessage.append("现金流量表段本期数据为空\n");
			if(StringX.isEmpty(bo.getString("prc2"))) returnMessage.append("现金流量表段上期数据为空\n");
			if(StringX.isEmpty(bo.getString("pri"))) returnMessage.append("利润表段本期数据为空\n");
			if(StringX.isEmpty(bo.getString("pri2"))) returnMessage.append("利润表段上期数据为空\n");
			if(StringX.isEmpty(bo.getString("pfs"))) returnMessage.append("补充报表本期数据为空\n");
			if(StringX.isEmpty(bo.getString("pfs2"))) returnMessage.append("补充报表上期数据为空\n");
		}
		String endStr=returnMessage.toString();
		return StringX.isEmpty(endStr)?"Success":endStr;
	}
	/** 新增评级数据，默认执行测算数据 */
	public static void upData(JBOTransaction tx) throws Exception {
		/** 如下更新数据的，自测算流程获取 
		  @throws JBOException */
		String jsonStr = "{\"1.1.1\":\"100.00\",\"1.1.2\":\"100.00\",\"1.2.1\":\"100.00\",\"1.2.2\":\"100.00\",\"1.3.1\":\"100.00\",\"1.3.2\":\"100.00\",\"1.4.1\":\"100.00\",\"1.4.2\":\"100.00\",\"1.4.3\":\"100.00\",\"1.5.1\":\"100.00\",\"1.5.2\":\"100.00\",\"1.5.3\":\"100.00\",\"1.6.1\":\"100.00\",\"1.6.2\":\"100.00\",\"2.1.1\":\"\",\"2.1.2\":\"\",\"2.1.3\":\"\",\"2.2.1\":\"\",\"2.2.2\":\"\",\"2.2.3\":\"\",\"2.2.4\":\"\",\"2.2.5\":\"\",\"2.2.6\":\"\",\"2.2.7\":\"\",\"2.3.1\":\"\",\"2.3.2\":\"\",\"2.3.3\":\"\",\"2.3.4\":\"\",\"2.4.1\":\"\",\"2.4.2\":\"\",\"2.4.3\":\"\"}";
	    Json evaluatedatajo = JsonDecoder.decode(jsonStr);
	    PidrEvaluate evaluate = new PidrEvaluate(CustomerId+"@",objectType, tx);
	    try {
	      evaluate.updateEvalDataList(evaluatedatajo);
	      evaluate.evaluate();
	    } catch (Exception e) {
	      ARE.getLog(PidrFlowService.class).error("calcEvaluate error!", e);
	    }
	}
	/** 更新行业分类 */
	public static void upEcoIndusCate(String customerId,String finStaYear,JBOTransaction tx) throws JBOException {
		BizObjectManager evalRecordManager = JBOFactory.getBizObjectManager(tx, "jbo.pidr.PIDR_EVALUATE_RECORD");
		evalRecordManager.createQuery(
				"update  o set o.EcoIndusCate=(select p.EcoIndusCate from jbo.pidr.PIDR_RATE_FSINF p where p.CUSTOMERID=o.CUSTOMERID)"
				+ " where o.CustomerId=:CustomerId and o.FinStaYear=:FinStaYear")
				.setParameter("FinStaYear", finStaYear)// 年份
				.setParameter("CustomerId", customerId).executeUpdate();
	}
	/** 自数据页面提供的查看评级按钮提供的字段数据 */
	public static String getViewInfo(JBOTransaction tx) throws Exception {
		String returnStr="";
		//查询ModelNo，ObjectType
		BizObjectManager evalRecordManager = JBOFactory.getBizObjectManager(tx, "jbo.pidr.PIDR_EVALUATE_RECORD");
		List<BizObject> listRecord = evalRecordManager
				.createQuery("select * from o where CustomerId=:CustomerId and FinStaYear=:FinStaYear")
				.setParameter("CustomerId", CustomerId).setParameter("FinStaYear", FinStaYear).getResultList();
		//行业分类的中文名
		BizObjectManager ecoIndusCateManager = JBOFactory.getBizObjectManager(tx, "jbo.pidr.PIDR_CODE_LIBRARY");
		List<BizObject> listecoIndusCate = ecoIndusCateManager
				.createQuery("select o.PBITEMNAME from  o where PBCODE =(select prf.EcoIndusCate  from jbo.pidr.PIDR_RATE_FSINF prf where prf.CustomerId=:CustomerId)")
				.setParameter("CustomerId", CustomerId).getResultList();
		String modelNo="";
		String objectType="";
		String ecoIndusCate="";
		for(BizObject bo:listRecord) {
			modelNo=bo.getAttribute("modelNo").getString();
			objectType=bo.getAttribute("objectType").getString();
		}
		for(BizObject bo:listecoIndusCate) {
			ecoIndusCate=bo.getAttribute("PBITEMNAME").getString();
		}
		if(StringX.isEmpty(objectType)) {
			returnStr="当前记录不存在评级信息，请先发起评级！";
		}else {
			returnStr="&EcoIndusCate="+ecoIndusCate+"&ModelNo="+modelNo+"&ObjectType="+objectType;
		}
		
		return returnStr;
	}

	public static String getObjectType() {
		return objectType;
	}

	public static void setObjectType(String objectType) {
		PidrRunEvaluate.objectType = objectType;
	}

	public static String getCustomerId() {
		return CustomerId;
	}

	public static void setCustomerId(String customerId) {
		CustomerId = customerId;
	}

	public static String getModelNo() {
		return modelNo;
	}

	public static void setModelNo(String modelNo) {
		PidrRunEvaluate.modelNo = modelNo;
	}

	public static String getFinStaYear() {
		return FinStaYear;
	}

	public static void setFinStaYear(String finStaYear) {
		FinStaYear = finStaYear;
	}

	public static String getEntName() {
		return EntName;
	}

	public static void setEntName(String entName) {
		EntName = entName;
	}

	public static String getEntCertType() {
		return EntCertType;
	}

	public static void setEntCertType(String entCertType) {
		EntCertType = entCertType;
	}

	public static String getEntCertNum() {
		return EntCertNum;
	}

	public static void setEntCertNum(String entCertNum) {
		EntCertNum = entCertNum;
	}

	public static String getUserId() {
		return userId;
	}

	public static void setUserId(String userId) {
		PidrRunEvaluate.userId = userId;
	}

	public static String getOrgId() {
		return orgId;
	}

	public static void setOrgId(String orgId) {
		PidrRunEvaluate.orgId = orgId;
	}

	public static String getFlag() {
		return Flag;
	}

	public static void setFlag(String flag) {
		Flag = flag;
	}

}