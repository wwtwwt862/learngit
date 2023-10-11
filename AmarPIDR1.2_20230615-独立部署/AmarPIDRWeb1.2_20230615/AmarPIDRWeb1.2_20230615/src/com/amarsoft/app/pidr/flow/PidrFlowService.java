package com.amarsoft.app.pidr.flow;

import java.util.List;

import com.amarsoft.app.pidr.common.PIDRConstants;
import com.amarsoft.are.ARE;
import com.amarsoft.are.jbo.BizObject;
import com.amarsoft.are.jbo.JBOTransaction;
import com.amarsoft.are.lang.StringX;
import com.amarsoft.are.lang.json.Json;
import com.amarsoft.are.lang.json.JsonDecoder;
import com.amarsoft.are.util.DataConvert;
import com.amarsoft.are.util.json.JSONElement;
import com.amarsoft.awe.util.Transaction;
import com.amarsoft.biz.evaluate.PidrEvaluate;
import com.amarsoft.biz.evaluate.PidrEvaluateManager;
import com.amarsoft.osf.ExecuteResult;
import com.amarsoft.osf.message.ServiceMessage;
import com.amarsoft.osf.message.StrictJSONArray;
import com.amarsoft.osf.message.StrictJSONObject;
import com.amarsoft.awe.ui.widget.HTMLControls;
//import com.amarsoft.web.ui.HTMLControls;//合并版（ECR/UCR）放开始用

public class PidrFlowService
{
  /** 获取数据 */
  public ExecuteResult getEvaluateData(ServiceMessage request, ServiceMessage response, JBOTransaction tx) throws Exception {
    String objectType = request.getBody().getString("evaluateObjectType");
    String customerId = request.getBody().getString("evaluateCustomerId");
    String ecoIndusCate = request.getBody().getString("evaluateEcoIndusCate");
    PidrEvaluate evaluate = new PidrEvaluate(customerId, objectType, tx);
    List<BizObject> dataList = evaluate.getEvalDataList();    
   ((JSONElement)response.getBody().getElementByName("evaluateModelName", true)).setValue(evaluate.ModelName);
    ((JSONElement)response.getBody().getElementByName("evaluateModelType", true)).setValue(evaluate.ModelType);
    ((JSONElement)response.getBody().getElementByName("evaluateScore", true)).setValue(Double.valueOf(evaluate.EvaluateScore));
    ((JSONElement)response.getBody().getElementByName("evaluateResult", true)).setValue(evaluate.EvaluateResult);
    StrictJSONArray evaluatedatalist = (StrictJSONArray)response.getBody().getValue("evaluatedatalist");
    for (BizObject bo : dataList) {
    	StrictJSONObject data = (StrictJSONObject)evaluatedatalist.appendNewElement().getValue();       
    	data.setValue(bo);
    	((JSONElement)data.getElementByName("evaluateMethod", true)).setValue(bo.getAttribute("evaluateMethod").getString().trim());
    	String valueCode = bo.getAttribute("ValueCode").getString();
    	String itemValue = bo.getAttribute("ItemValue").getString();
	    String displayNo = bo.getAttribute("DisplayNo").getString();
        String valueType = bo.getAttribute("ValueType").getString();
        if (itemValue != null && !itemValue.equalsIgnoreCase("null") && !itemValue.equals("")){ 
        	if (valueType != null && valueType.equals("Number") && StringX.isEmpty(valueCode)) {
        		itemValue = DataConvert.toMoney(itemValue);
        		if (itemValue.equals("")) itemValue = "0.00"; 
        	}  
        }else { itemValue = ""; }
        if (displayNo.length() == 1) itemValue = ""; 
        ((JSONElement)data.getElementByName("itemValue", true)).setValue(itemValue);
        String valueCodeOptions = HTMLControls.generateDropDownSelect(valueCode, DataConvert.toString(itemValue));
        ((JSONElement)data.getElementByName("valueCodeOptions", true)).setValue(valueCodeOptions);
    } 
    PidrEvaluateManager evalManager = new PidrEvaluateManager(objectType, customerId, evaluate.ModelType);
    ((JSONElement)response.getBody().getElementByName("modelTypeName" ,true)).setValue(evalManager.getModelTypeName());
    ((JSONElement)response.getBody().getElementByName("displayFinalResult", true)).setValue(evalManager.getDisplayFinalResult());
    ((JSONElement)response.getBody().getElementByName("displayItemScore", true)).setValue(evalManager.getDisplayItemScore());
    ((JSONElement)response.getBody().getElementByName("itemValueDisplayWidth", true)).setValue(evalManager.getItemValueDisplayWidth());
    tx.commit();
    return ExecuteResult.createResult(ExecuteResult.OK_CODE, "获取评级数据成功");
  }

  /** 保存 */
  public ExecuteResult saveEvaluateData(ServiceMessage request, ServiceMessage response, JBOTransaction tx) throws Exception {
    String objectType = request.getBody().getString("evaluateObjectType");
    String customerId = request.getBody().getString("evaluateCustomerID");
    String evaluatedatas = request.getBody().getString("evaluatedatas");
    Json evaluatedatajo = JsonDecoder.decode(evaluatedatas);
    
    PidrEvaluate.updateEvaluateData(objectType, customerId, evaluatedatajo, tx);
    return ExecuteResult.createResult(ExecuteResult.OK_CODE, "该期评级数据保存完成！");
  }
  /** 测算   */
  public ExecuteResult calcEvaluate(ServiceMessage request, ServiceMessage response,JBOTransaction tx) throws Exception {
	tx = Transaction.createTransaction(PIDRConstants.DATASOURCE_PIDR);
    ExecuteResult er = null;
    String initFormData="{\"1.1.1\":\"100.00\",\"1.1.2\":\"100.00\",\"1.2.1\":\"100.00\",\"1.2.2\":\"100.00\",\"1.3.1\":\"100.00\",\"1.3.2\":\"100.00\",\"1.4.1\":\"100.00\",\"1.4.2\":\"100.00\",\"1.4.3\":\"100.00\",\"1.5.1\":\"100.00\",\"1.5.2\":\"100.00\",\"1.5.3\":\"100.00\",\"1.6.1\":\"100.00\",\"1.6.2\":\"100.00\",\"2.1.1\":\"\",\"2.1.2\":\"\",\"2.1.3\":\"\",\"2.2.1\":\"\",\"2.2.2\":\"\",\"2.2.3\":\"\",\"2.2.4\":\"\",\"2.2.5\":\"\",\"2.2.6\":\"\",\"2.2.7\":\"\",\"2.3.1\":\"\",\"2.3.2\":\"\",\"2.3.3\":\"\",\"2.3.4\":\"\",\"2.4.1\":\"\",\"2.4.2\":\"\",\"2.4.3\":\"\"}";
    String objectType = request.getBody().getString("evaluateObjectType");
    String customerId = request.getBody().getString("evaluateCustomerId");
    String evaluatedatas = request.getBody().getString("evaluatedatas");
    if(customerId.contains("@")) evaluatedatas=initFormData;
    
    Json evaluatedatajo = JsonDecoder.decode(evaluatedatas);
    PidrEvaluate evaluate = new PidrEvaluate(customerId,objectType, tx);
    try {
      evaluate.updateEvalDataList(evaluatedatajo);//
      evaluate.evaluate();//
      er = ExecuteResult.createResult(ExecuteResult.OK_CODE, "该期评级测算完成！");
    } catch (Exception e) {
      ARE.getLog(PidrFlowService.class).error("calcEvaluate error!", e);
      er = ExecuteResult.createResult("999", "该期评级测算没有正常完成！");
    }
    double evaluateScore = evaluate.EvaluateScore;
    String evaluateResult = evaluate.EvaluateResult;
    
    ((JSONElement)response.getBody().getElementByName("evaluateScore", true)).setValue(Double.valueOf(evaluateScore));
    ((JSONElement)response.getBody().getElementByName("evaluateResult", true)).setValue(evaluateResult);
    tx.commit();
    return er;
  }
  /** 删除操作 */
	public ExecuteResult deleteEvaluate(ServiceMessage request, ServiceMessage response, JBOTransaction tx)
			throws Exception {
		ExecuteResult er = null;
		String objectType = request.getBody().getString("evaluateObjectType");
		String objectNo = request.getBody().getString("evaluateCustomerID");
		try {
			PidrEvaluate.deleteEvaluate(objectType, objectNo, tx);
			er = ExecuteResult.createResult(ExecuteResult.OK_CODE, "该期评级删除完成！");
		} catch (Exception e) {
			er = ExecuteResult.createResult("999", "该期评级测算没有正常删除！");
		}
		tx.commit();
		return er;
	}

  
}
