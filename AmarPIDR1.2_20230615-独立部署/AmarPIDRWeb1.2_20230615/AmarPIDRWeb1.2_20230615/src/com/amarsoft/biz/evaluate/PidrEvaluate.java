package com.amarsoft.biz.evaluate;

import java.math.BigDecimal;
import java.text.NumberFormat;
import java.util.List;

import com.amarsoft.amarscript.Any;
import com.amarsoft.amarscript.ELContext;
import com.amarsoft.amarscript.Expression;
import com.amarsoft.are.ARE;
import com.amarsoft.are.jbo.BizObject;
import com.amarsoft.are.jbo.BizObjectManager;
import com.amarsoft.are.jbo.BizObjectQuery;
import com.amarsoft.are.jbo.JBOException;
import com.amarsoft.are.jbo.JBOFactory;
import com.amarsoft.are.jbo.JBOTransaction;
import com.amarsoft.are.lang.StringX;
import com.amarsoft.are.lang.json.Json;
import com.amarsoft.are.lang.json.JsonElement;
import com.amarsoft.are.util.StringFunction;
import com.amarsoft.awe.AWEException;

public class PidrEvaluate {
	public JBOTransaction tx;
	public String ObjectType;
	public String CustomerId;
	public String SerialNo;
	public String FinStaYear;
	public String ModelNo;
	public String EvaluateDate;
	public String EcoIndusCate;//行业分类,为了处理计算值处理
	public String ObjectName;
	public String EvaluateResult;
	public String OrgID;
	public String UserID;
	public boolean isInitFlag=false;

	public List<BizObject> getEvalDataList() {
		return this.evalDataList;
	}

	public String Remark;
	public String ReportScope;
	public String ModelName;
	public String ModelType;
	public String TransformMethod;
	public String EvaluateContext;
	public double EvaluateScore;
	private BizObjectManager recordManager;
	private BizObjectManager dataManager;
	private List<BizObject> evalDataList;
	private String[][] ConstantList;

	public PidrEvaluate(String customerId,String sObjectType, JBOTransaction tx) throws Exception {
		if(customerId.contains("@")) isInitFlag=true;customerId=customerId.replace("@","");
		this.EvaluateScore = 0.0D;
		this.ConstantList = new String[][] { { "#ObjectType", "" }, { "#CustomerId", "" }, { "#SerialNo", "" }, { "#FinStaYear", "" }, { "#ModelNo", "" }, { "#ItemValue", "" }, { "#TotalScore", "" }, { "#ReportScope", "" }, { "#ItemNo", "" } };
		this.tx = tx;
		this.recordManager = JBOFactory.getBizObjectManager(tx, "jbo.pidr.PIDR_EVALUATE_RECORD");
		this.dataManager = JBOFactory.getBizObjectManager(tx, "jbo.pidr.PIDR_EVALUATE_DATA");
		init(sObjectType, customerId);
	}

	private void init(String sObjectType, String customerId ) throws Exception {
		this.ObjectType = sObjectType;
		this.CustomerId = customerId;
		this.ConstantList[0][1] = this.ObjectType;
		this.ConstantList[1][1] = this.CustomerId;
		this.ConstantList[2][1] = this.SerialNo;
		
		if (getRecord()) {
			getData();
			getModel();
		} else {
			throw new Exception("PIDR_EVALUATE_RECORD中未找到数据:sObjectType, sCustomerId ---" + sObjectType + ","
					+ CustomerId );
		}
	}
	/** 获取评级记录的数据相关内容 */
	public boolean getRecord() throws Exception {
		String jql = "select FinStaYear,ModelNo,EvaluateDate,EcoIndusCate,EvaluateScore,EvaluateResult,OrgID,UserID,Remark from O where ObjectType=:ObjectType and CustomerId=:CustomerId ";

		BizObject evalRecord = this.recordManager.createQuery(jql).setParameter("ObjectType", this.ObjectType)
				.setParameter("CustomerId", this.CustomerId).getSingleResult(false);
		if (evalRecord != null) {
			this.FinStaYear = evalRecord.getAttribute("FinStaYear").getString();
			this.ModelNo = evalRecord.getAttribute("ModelNo").getString();
			this.EvaluateDate = evalRecord.getAttribute("EvaluateDate").getString();
			this.EcoIndusCate = evalRecord.getAttribute("EcoIndusCate").getString();
			this.EvaluateScore = evalRecord.getAttribute("EvaluateScore").getDouble();
			this.EvaluateResult = evalRecord.getAttribute("EvaluateResult").getString();
			this.OrgID = evalRecord.getAttribute("OrgID").getString();
			this.UserID = evalRecord.getAttribute("UserID").getString();
			this.Remark = evalRecord.getAttribute("Remark").getString();
			//报表口径
			//this.ReportScope = getEvaluateScope(this.CustomerId, this.FinStaYear);
			this.ConstantList[3][1] = this.FinStaYear;
			this.ConstantList[4][1] = this.ModelNo;
			this.ConstantList[7][1] = this.ReportScope;
			return true;
		}
		return false;
	}
	/** 获取页面打开时，反馈页面的评级数据信息 */
	public List<BizObject> getData() throws JBOException {
		this.evalDataList = JBOFactory.getBizObjectManager("jbo.pidr.PIDR_EVALUATE_DATA").createQuery(
				" select O.ObjectType,O.CustomerId,O.ItemNo,"
				+ "O.ITEMVALUE,O.ITEMVALUE2,O.EVALUATESCORE,O.EVALUATESCORE2,M.MODELNO,"
				+ "M.DISPLAYNO,M.ITEMNAME,M.ITEMATTRIBUTE,M.VALUEMETHOD,"
				+ "M.VALUECODE,M.VALUETYPE,M.EVALUATEMETHOD,M.COEFFICIENT,M.REMARK , P.WEIGHTEDVALUE01,P.EXCELLENTVALUE01,P.LOWERVALUE01,P.WEIGHTEDVALUE02,"
				+ "P.EXCELLENTVALUE02,P.LOWERVALUE02,P.WEIGHTEDVALUE03,P.EXCELLENTVALUE03,P.LOWERVALUE03,P.WEIGHTEDVALUE04,P.EXCELLENTVALUE04,P.LOWERVALUE04,"
				+ "P.WEIGHTEDVALUE05,P.EXCELLENTVALUE05,P.LOWERVALUE05,P.WEIGHTEDVALUE06,P.EXCELLENTVALUE06,P.LOWERVALUE06,P.WEIGHTEDVALUE07,P.EXCELLENTVALUE07,"
				+ "P.LOWERVALUE07,P.WEIGHTEDVALUE08,P.EXCELLENTVALUE08,P.LOWERVALUE08,P.WEIGHTEDVALUE09,P.EXCELLENTVALUE09,P.LOWERVALUE09,P.WEIGHTEDVALUE10,"
				+ "P.EXCELLENTVALUE10,P.LOWERVALUE10,P.WEIGHTEDVALUE11,P.EXCELLENTVALUE11,P.LOWERVALUE11,P.WEIGHTEDVALUE12,P.EXCELLENTVALUE12,P.LOWERVALUE12,P.WEIGHTEDVALUE13,P.EXCELLENTVALUE13,P.LOWERVALUE13,P.WEIGHTEDVALUE14,P.EXCELLENTVALUE14,P.LOWERVALUE14,P.WEIGHTEDVALUE15,P.EXCELLENTVALUE15,P.LOWERVALUE15,P.WEIGHTEDVALUE16,P.EXCELLENTVALUE16,P.LOWERVALUE16,P.WEIGHTEDVALUE17,P.EXCELLENTVALUE17,P.LOWERVALUE17"
				+ " from O,"
				+ " jbo.pidr.EVALUATE_MODEL M,  "
				+" jbo.pidr.PIDR_ECOINDUSCATE_LIBRARY P "
				+ " where O.ObjectType=:ObjectType and O.CustomerId=:CustomerId  "
				+" and P.ecoinduscate =(select substr(PRF.EcoIndusCate,1,1)  from jbo.pidr.PIDR_RATE_FSINF PRF where PRF.CustomerId=:ObjectName) "
				+ " and  M.ModelNo=:ModelNo and O.ItemNo = M.ItemNo order by M.DisplayNo ")
				.setParameter("ObjectType", this.ObjectType).setParameter("CustomerId", this.CustomerId)
				.setParameter("ModelNo", this.ModelNo).setParameter("ObjectName", this.CustomerId)
				.getResultList(true);
		return this.evalDataList;
	}

	/** 评估模型的结果，针对等级 */
	public void getModel() throws Exception {
		BizObject evalCatalog = JBOFactory.createBizObjectQuery("jbo.pidr.EVALUATE_CATALOG", "ModelNo=:ModelNo")
				.setParameter("ModelNo", this.ModelNo).getSingleResult(false);
		if (evalCatalog != null) {
			this.ModelName = evalCatalog.getAttribute("modelName").getString();
			this.ModelType = evalCatalog.getAttribute("modelType").getString();
			this.TransformMethod = evalCatalog.getAttribute("TRANSFORMMETHOD").getString();
			this.EvaluateContext = evalCatalog.getAttribute("EVALUATECONTEXT").getString();
		}
	}

	public void updateRecord() throws Exception {
		JBOFactory.getBizObjectManager("jbo.pidr.PIDR_EVALUATE_RECORD").createQuery(
				"update O  set EvaluateScore=:EvaluateScore, EvaluateResult=:EvaluateResult ,CognDate=EvaluateDate,CognScore=EvaluateScore,CognResult=EvaluateResult,CognOrgID=ORGID,CognUserID=USERID where ObjectType=:ObjectType and CustomerId=:CustomerId ")

				.setParameter("EvaluateScore", floatConvert(String.valueOf(this.EvaluateScore)))
				.setParameter("EvaluateResult", this.EvaluateResult).setParameter("ObjectType", this.ObjectType)
				.setParameter("CustomerId", this.CustomerId).executeUpdate();
		
		//完成页面预评级，更新白名单信息中评分
		JBOFactory.getBizObjectManager("jbo.pidr.PIDR_WHITELIST").createQuery(
				"update O set O.PIDREvalScore = :EvaluateScore ,RunStatus = :RunStatus where O.CustomerId = :CustomerId")
				.setParameter("EvaluateScore", floatConvert(String.valueOf(this.EvaluateScore)))
				.setParameter("RunStatus", "20")
				.setParameter("CustomerId", this.CustomerId).executeUpdate();
	}

	public String floatConvert(String sValue) {
		if (sValue != null) {
			NumberFormat nf = NumberFormat.getInstance();
			nf.setMinimumFractionDigits(6);
			nf.setMaximumFractionDigits(6);
			return StringFunction.replace(nf.format(Double.valueOf(sValue).doubleValue()), ",", "");
		}
		return null;
	}

	/**
	 * 更新人工调整值“ItemValue”
	 * @param objectType
	 * @param CustomerId
	 * @param evaluatedatajo
	 * @param tx
	 * @throws JBOException
	 */
	public static void updateEvaluateData(String objectType, String CustomerId, Json evaluatedatajo,
			JBOTransaction tx) throws JBOException {
		BizObjectManager bm = JBOFactory.getBizObjectManager(tx, "jbo.pidr.PIDR_EVALUATE_DATA");
		String jql = "update O set ItemValue =:ItemValue  where ObjectType =:ObjectType and CustomerId=:CustomerId  and ItemNo=:ItemNo ";
		BizObjectQuery bq = bm.createQuery(jql);
		bq.setParameter("ObjectType", objectType).setParameter("CustomerId", CustomerId);
		for (JsonElement je : evaluatedatajo.elementList()) {
			String itemNo = je.getName();
			String itemValue = (String) je.getValue();
			bq.setParameter("ItemValue", itemValue).setParameter("ItemNo", itemNo).executeUpdate();
		}
	}

	/**
	 * 测算更新（人工调整得分-ItemValue）
	 * @param evaluatedatajo
	 * @throws JBOException
	 */
	public void updateEvalDataList(Json evaluatedatajo) throws JBOException {
		for (BizObject bo : this.evalDataList) {
			String itemNo = bo.getString("ItemNo");
			if (evaluatedatajo.get(itemNo) == null)
				continue;
			bo.setAttributeValue("ItemValue", (String) evaluatedatajo.get(itemNo));
		}
	}
	
	/**
	 * 初始化测算（人工调整得分-ItemValue = 计算得分-ItemValue）
	 * @param evaluatedatajo
	 * @throws JBOException
	 */
	public void initEvalDataList(Json evaluatedatajo) throws JBOException {
		for (BizObject bo : this.evalDataList) {
			String itemNo = bo.getString("ItemNo");
			if (evaluatedatajo.get(itemNo) == null)
				continue;
			bo.setAttributeValue("ItemValue", (String) evaluatedatajo.get(itemNo));
			bo.setAttributeValue("ItemValue2", (String) evaluatedatajo.get(itemNo));
		}
	}

	public void evaluate() throws Exception {
		double dbTotalScore = 0.0D;
		if (this.evalDataList != null && this.evalDataList.size() > 0) {
			ELContext context = new ELContext();
			context.setJBOTransaction(this.tx);

			for (int i = 0; i < this.ConstantList.length; i++) {
				context.defineVarible(this.ConstantList[i][0], this.ConstantList[i][1]);
			}
			String contextStr = this.EvaluateContext;

			context.defineBeans(contextStr);
			
			for (BizObject bo : this.evalDataList) {
				Any anyItemValue = null,anyItemValue2 = null;
				String sItemNo = bo.getAttribute("ItemNo").getString();
				String sItemValue = bo.getAttribute("ItemValue").getString();//存放人工调整值
				String itemValue2 = bo.getAttribute("ItemValue2").getString();//计算值
				String sValueMethod = bo.getAttribute("ValueMethod").getString();//获取对应指标值
				String sValueType = bo.getAttribute("ValueType").getString();
				String sEvaluateMethod = bo.getAttribute("EvaluateMethod").getString();//计算最后的得分处理
				double dbCoefficient = bo.getAttribute("Coefficient").getDouble();
				this.ConstantList[8][1] = sItemNo;
				ARE.getLog().info(" 自库内查询数据情况,节点=" + sItemNo + " ,sItemValue=" + sItemValue + ",itemValue2=" + itemValue2);
				if (sValueType != null && sValueType.trim().length() != 0) {
					if (sItemValue != null && sItemValue.trim().length() > 0) {
						anyItemValue = new Any(sValueType, sItemValue);
					}
					//如下为evaluate_model的VALUEMETHOD不为空的处理模式
					if (sValueMethod != null && sValueMethod.trim().length() > 0) {
						sValueMethod = sValueMethod.trim();
						try {
							//人工调整入库
							anyItemValue = Expression.getExpressionValue(pretreatExpression(sValueMethod), context);
							itemValue2 =String.valueOf(anyItemValue.doubleValue());
							//当前为初始化时才会将计算值赋给人工值，默认false
							if(isInitFlag) {
								sItemValue=itemValue2;
							}
							ARE.getLog().info(" 函数方法计算,节点=" + sItemNo + " ,sItemValue=" + sItemValue + ",itemValue2=" + itemValue2);
							if(!"Null".equals(sItemValue))sItemValue=	floatConvert(String.valueOf(sItemValue));
							if(!"Null".equals(itemValue2))itemValue2=	floatConvert(String.valueOf(itemValue2));
							if(isInitFlag && sItemNo.length()==5 && sItemNo.startsWith("2.")) {
								sItemValue=evaScore(bo, sItemNo, sItemValue);
							}
							bo.setAttributeValue("ItemValue", sItemValue);//人工调整值
							if(isInitFlag)bo.setAttributeValue("EVALUATESCORE2", sItemValue);//人工调整值
							bo.setAttributeValue("ItemValue2", itemValue2);//机器测算计算值
							Object obj = context.getBean("this");
							if (obj != null) {
								ARE.getLog().info("当上下文this不为空,保存评级数据");
								EvaluateObject evalObj = (EvaluateObject) obj;
								evalObj.setAttribute(sItemNo, sItemValue);
								this.dataManager.saveObject(bo);
							}
						} catch (AWEException e) {
							if (e.getErrorLevel() == 1)
								throw e;
						}
					}
					//当前为人工值不为空，将此值作为得分计算
					if (!StringX.isEmpty(sItemValue)) {
						double dbEvaluateScore;
						this.ConstantList[5][1] = sItemValue;
						if (sEvaluateMethod != null && sEvaluateMethod.trim().length() > 0) {
							sEvaluateMethod = sEvaluateMethod.trim();
							try {
								//计算得分值的
								dbEvaluateScore = Expression.getExpressionValue(pretreatExpression(sEvaluateMethod), context).doubleValue();
								bo.setAttributeValue("EvaluateScore", dbEvaluateScore);
								ARE.getLog().info("保存评级数据值");
								this.dataManager.saveObject(bo);
							} catch (AWEException e) {
								if (e.getErrorLevel() == 1)
									throw e;
								dbEvaluateScore = 0.0D;
							}
						} else {
							dbEvaluateScore = 0.0D;
						}
						dbTotalScore += dbEvaluateScore * dbCoefficient;
					}
				}
			}
			this.ConstantList[6][1] = String.valueOf(dbTotalScore);

			String sTotalResult = transformScoreToResult(dbTotalScore, context);
			this.EvaluateScore = dbTotalScore;
			this.EvaluateResult = sTotalResult;
			updateRecord();
		}
	}
	/**
	 *  根据指标值处理测算的分数
	 * @param bo
	 * @param num
	 * @param dataV
	 * @return
	 */
	public static String evaScore(BizObject bo ,String ItemNo,String dataV) {
		String num=getNum(ItemNo);
		BigDecimal weightStr=new BigDecimal(bo.getString("WEIGHTEDVALUE"+num).replace(" ",""));//7
		BigDecimal excellentStr=new BigDecimal(bo.getString("EXCELLENTVALUE"+num).replace(" ",""));
		BigDecimal avgStr=new BigDecimal(bo.getString("LOWERVALUE"+num).replace(" ",""));
		BigDecimal dataBig=new BigDecimal(dataV);
		BigDecimal endData=new BigDecimal("0");//评估得分
		BigDecimal oneHundred=new BigDecimal("100");
		if(dataBig.compareTo(avgStr)==-1) {
			if(dataBig.compareTo(excellentStr)>=0 && dataBig.compareTo(avgStr)<=0) {
				endData=(dataBig.subtract(avgStr)).multiply(oneHundred).divide(excellentStr.subtract(avgStr),2,BigDecimal.ROUND_HALF_UP);
			}else {
				if(dataBig.compareTo(excellentStr)<=0) {
					endData=oneHundred;
				}
			}
		}
		String oldScore=endData.toString();
		return oldScore;
	}
	/**
	 * 根据传入的节点名字，给出对应取权重、优秀值、平均值处理数据
	 * @param itemNo
	 * @return
	 */
	private static String getNum(String itemNo) {
		if("2.1.1".equals(itemNo)) {
			return "01";
		}else if("2.1.2".equals(itemNo)){
			return "02";
		}else if("2.1.3".equals(itemNo)){
			return "03";
		}else if("2.2.1".equals(itemNo)){
			return "04";
		}else if("2.2.2".equals(itemNo)){
			return "05";
		}else if("2.2.3".equals(itemNo)){
			return "06";
		}else if("2.2.4".equals(itemNo)){
			return "07";
		}else if("2.2.5".equals(itemNo)){
			return "08";
		}else if("2.2.6".equals(itemNo)){
			return "09";
		}else if("2.2.7".equals(itemNo)){
			return "10";
		}else if("2.3.1".equals(itemNo)){
			return "11";
		}else if("2.3.2".equals(itemNo)){
			return "12";
		}else if("2.3.3".equals(itemNo)){
			return "13";
		}else if("2.3.4".equals(itemNo)){
			return "14";
		}else if("2.4.1".equals(itemNo)){
			return "15";
		}else if("2.4.2".equals(itemNo)){
			return "16";
		}else if("2.4.3".equals(itemNo)){
			return "17";
		}
		return null;
	}
/*
	public static Object[] evaluate(BizObject _evalRecord, List<BizObject> _evalDataList) throws Exception {
		String sTotalResult = null;
		double dbTotalScore = 0.0D;
		if (_evalRecord != null && _evalDataList != null && _evalDataList.size() > 0) {

			ELContext context = new ELContext();

			String modelNo = _evalRecord.getAttribute("modelNo").getString();
			context.defineVarible("#ObjectType", _evalRecord.getAttribute("ObjectType").getString());
			String _CustomerId = _evalRecord.getAttribute("CustomerId").getString();
			context.defineVarible("#CustomerId", _CustomerId);
			context.defineVarible("#SerialNo", _evalRecord.getAttribute("SerialNo").getString());
			String _FinStaYear = _evalRecord.getAttribute("FinStaYear").getString();
			context.defineVarible("#FinStaYear", _FinStaYear);
			context.defineVarible("#ModelNo", modelNo);
			String _scope = getEvaluateScope(_CustomerId, _FinStaYear);
			context.defineVarible("#ReportScope", _scope);
			BizObject _catalog = JBOFactory.getBizObjectManager("jbo.sys.EVALUATE_CATALOG")
					.createQuery("select * from O where modelNo=:modelNo ").setParameter("modelNo", modelNo)
					.getSingleResult(false);
			QueryResult queryResult = JBOFactory.getBizObjectManager("jbo.sys.EVALUATE_MODEL")
					.createQuery("select * from O where modelNo=:modelNo ").setParameter("modelNo", modelNo)
					.getResultList(false);

			context.defineBeans(_catalog.getAttribute("EVALUATECONTEXT").getString());

			Map<String, BizObject> modelMap = new HashMap<String, BizObject>();
			for (BizObject model : queryResult) {
				modelMap.put(model.getAttribute("itemNo").getString(), model);
			}
			for (BizObject bo : _evalDataList) {
				Any anyItemValue = null;
				String sItemNo = bo.getAttribute("ItemNo").getString();
				String sItemValue = bo.getAttribute("ItemValue").getString();
				BizObject _model = (BizObject) modelMap.get(sItemNo);
				String sValueMethod = _model.getAttribute("ValueMethod").getString();
				String sValueType = _model.getAttribute("ValueType").getString();
				String sEvaluateMethod = _model.getAttribute("EvaluateMethod").getString();
				double dbCoefficient = _model.getAttribute("Coefficient").getDouble();

				context.defineVarible("#ItemNo", sItemNo);

				if (sValueType != null && sValueType.trim().length() != 0) {
					if (sItemValue != null && sItemValue.trim().length() > 0) {
						anyItemValue = new Any(sValueType, sItemValue);
					}
					if (sValueMethod != null && sValueMethod.trim().length() > 0) {
						sValueMethod = sValueMethod.trim();
						try {
							anyItemValue = Expression.getExpressionValue(sValueMethod, context);
							sItemValue = anyItemValue.toStringValue();
							bo.setAttributeValue("ItemValue", sItemValue);

							Object obj = context.getBean("this");
							if (obj != null) {
								PidrEvaluateObject evalObj = (PidrEvaluateObject) obj;
								evalObj.setAttribute(sItemNo, sItemValue);
							}
						} catch (AWEException e) {
							if (e.getErrorLevel() == 1)
								throw e;
						}
					}
					context.defineVarible("#ItemValue", bo.getAttribute("ItemValue").getString());
					if (anyItemValue != null) {
						double dbEvaluateScore;
						if (sEvaluateMethod != null && sEvaluateMethod.trim().length() > 0) {
							sEvaluateMethod = sEvaluateMethod.trim();
							try {
								dbEvaluateScore = Expression.getExpressionValue(sEvaluateMethod, context).doubleValue();
								bo.setAttributeValue("EvaluateScore", dbEvaluateScore);
							} catch (AWEException e) {
								if (e.getErrorLevel() == 1)
									throw e;
								dbEvaluateScore = 0.0D;
							}
						} else {
							dbEvaluateScore = 0.0D;
						}
						dbTotalScore += dbEvaluateScore * dbCoefficient;
					}
				}
			}
			context.defineVarible("#TotalScore", dbTotalScore);
			String sTransformMethod = _catalog.getAttribute("TRANSFORMMETHOD").getString();

			sTotalResult = Expression.getExpressionValue(sTransformMethod.trim(), context).stringValue();
		}

		return new Object[] { Double.valueOf(dbTotalScore), sTotalResult };
	}
*/
	public String pretreatExpression(String sCondition) throws Exception {
		return Expression.pretreatConstant(sCondition, this.ConstantList);
	}

	private String transformScoreToResult(double dbScore, ELContext context) throws Exception {
		String sResult = "";
		String sTransformMethod = this.TransformMethod;
		if (sTransformMethod != null && sTransformMethod.trim().length() > 0) {
			sResult = Expression.getExpressionValue(pretreatExpression(sTransformMethod.trim()), context).stringValue();
		}
		return sResult;
	}


	public static void deleteEvaluate(String sObjectType, String CustomerId, JBOTransaction tx)
			throws Exception {
		BizObjectManager evalRecordManager = JBOFactory.getBizObjectManager(tx, "jbo.pidr.PIDR_EVALUATE_RECORD");
		BizObjectManager evalDataManager = JBOFactory.getBizObjectManager(tx, "jbo.pidr.PIDR_EVALUATE_DATA");
		evalRecordManager
				.createQuery("delete from O where ObjectType=:ObjectType and CustomerId=:CustomerId ")
				.setParameter("ObjectType", sObjectType)
				.setParameter("CustomerId", CustomerId).executeUpdate();
		evalDataManager
				.createQuery("delete from O where ObjectType=:ObjectType and CustomerId=:CustomerId ")
				.setParameter("ObjectType", sObjectType)
				.setParameter("CustomerId", CustomerId).executeUpdate();
	}

}
