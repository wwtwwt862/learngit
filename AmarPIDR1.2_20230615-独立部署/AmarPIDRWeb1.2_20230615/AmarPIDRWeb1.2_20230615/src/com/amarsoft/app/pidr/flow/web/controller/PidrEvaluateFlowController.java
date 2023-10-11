package com.amarsoft.app.pidr.flow.web.controller;

import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.amarsoft.awe.annotation.MappingInterface;
import com.amarsoft.awe.control.model.Page;
//import com.amarsoft.awe.manager.A3WebManager;
import com.amarsoft.awe.ui.model.ItemHelp;
import com.amarsoft.awe.web.controller.ControllerBase;
import com.amarsoft.awe.web.controller.ControllerHelp;
import com.amarsoft.osf.client.OSFClient;
import com.amarsoft.are.ARE;
import com.amarsoft.are.bm.ServiceMessage;
import com.amarsoft.are.lang.json.JsonEncoder;

@Controller
@RequestMapping({"/Pidr/FinancialReportFlow"})
public class PidrEvaluateFlowController extends ControllerBase {
    public PidrEvaluateFlowController() {
    }
	  @RequestMapping({"/EvaluateDetail.view"})
	  @MappingInterface("评级详情")
	  public ModelAndView getEvaluateDetail(HttpServletRequest request, ServletResponse response) throws Exception {
	    Page curPage = new Page(request);
	    String modelNo = curPage.getParameter("ModelNo");
	    String sObjectType = curPage.getParameter("ObjectType");
	    String customerID = curPage.getParameter("CustomerID");
	    String ecoIndusCate = curPage.getParameter("EcoIndusCate");
	    String sEditable = curPage.getParameter("Editable");
	    String entName = curPage.getParameter("EntName");
	    
	    String[][] sButtons = {
	        { "false".equals(sEditable) ? "false" : "true", "", "Button", "保存", "保存", "updateData()", "", "", "", ""
	        }, { "false".equals(sEditable) ? "false" : "true", "", "Button", "测算", "测算", "evaluateData()", "", "", "", ""
	        }, { "false".equals(sEditable) ? "false" : "true", "", "Button", "删除", "删除", "deleteData()", "", "", "", "" }
	      };
	    
	    ModelAndView mv = ControllerHelp.createModelAndView("/PIDR/Grade/EvaluateDetail", curPage, request);
	    mv.addObject("objectType", sObjectType)
	    .addObject("customerID", customerID)
	    .addObject("ecoIndusCate", ecoIndusCate)
	    .addObject("modelNo", modelNo)
	    .addObject("entName", entName);
	    ControllerHelp.getRootModel(mv).put("buttonItems", ItemHelp.getButtonItemArray(sButtons, curPage));
	    return mv;
	  }
	  
	  @RequestMapping(value = {"/GetEvaluateData.serv"},method = {RequestMethod.POST})
	  @ResponseBody
	  @MappingInterface("获取评级数据")
	  public ServiceMessage getEvaluateData(HttpServletRequest request, @RequestBody ServiceMessage smIn) throws Exception {
	    ARE.getLog(this.getClass()).debug("request_message_in:" + JsonEncoder.encode(smIn));
	    smIn.getSysHead().setServiceCode("pidr.level.getevaluatedata");
	    //return  (new A3WebManager()).getALSClient().callService(smIn);//  合并版本（ECR/UCR）使用
	    return  OSFClient.getDefaultClient().callService(smIn);//独立版本使用
	  }
	  
	  
	  @RequestMapping(value = {"/EvaluateSave.serv"},method = {RequestMethod.POST})
	  @ResponseBody
	  @MappingInterface("评级数据保存")
	  public ServiceMessage saveEvaluateData(HttpServletRequest request, @RequestBody ServiceMessage sm) throws Exception {
	    ARE.getLog(this.getClass()).debug("request_message_in:" + JsonEncoder.encode(sm));
	    sm.getSysHead().setServiceCode("pidr.level.saveevaluatedata");
	    //return  (new A3WebManager()).getALSClient().callService(sm);//  合并版本（ECR/UCR）使用
	    return OSFClient.getDefaultClient().callService(sm);
	  }
	  
	  @RequestMapping(value = {"/EvaluateCalc.serv"},method = {RequestMethod.POST})
	  @ResponseBody
	  @MappingInterface("评级数据测算")
	  public ServiceMessage calcEvaluateData(HttpServletRequest request, @RequestBody ServiceMessage sm) throws Exception {
		  sm.getSysHead().setServiceCode("pidr.level.calcevaluate");
		    //return  (new A3WebManager()).getALSClient().callService(sm);//  合并版本（ECR/UCR）使用
		  return OSFClient.getDefaultClient().callService(sm);
	  }

	    @RequestMapping(value = {"/EvaluateDelete.serv"},method = {RequestMethod.POST})
	    @ResponseBody
	    @MappingInterface("评级数据删除")
	    public ServiceMessage deleteEvaluate(HttpServletRequest request, @RequestBody ServiceMessage sm) throws Exception {
	        sm.getSysHead().setServiceCode("pidr.level.deleteevaluate");
		    //return  (new A3WebManager()).getALSClient().callService(sm);//  合并版本（ECR/UCR）使用
	        return OSFClient.getDefaultClient().callService(sm);
	    }
	  
}
