<%@ page pageEncoding="UTF-8" %><%@
 page import="java.util.*" %><%@
 page import="java.net.URLDecoder"%><%@
 page import="com.amarsoft.are.*" %><%@
 page import="com.amarsoft.are.jbo.*" %><%@
 page import="com.amarsoft.awe.util.*" %><%@
 page import="com.amarsoft.awe.dw.*" %><%@
 page import="com.amarsoft.awe.dw.handler.BusinessProcessData" %><%@
 page import="com.amarsoft.awe.dw.ui.actions.IDataAction" %><%@
 page import="com.amarsoft.awe.dw.ui.list.*" %><%@
 page import="com.amarsoft.awe.util.*,com.amarsoft.awe.ui.util.*" %><%@
 page import="com.amarsoft.awe.dw.ui.util.ConvertXmlAndJava" %><%@
 page import="com.amarsoft.awe.dw.ui.htmlfactory.*" %><%@
 page import="com.amarsoft.awe.dw.ui.htmlfactory.imp.*" %><%@
 page import="com.amarsoft.awe.ui.util.RequestUtils"%><%
String sJbo = RequestUtils.GBKSingleRequest("SERIALIZED_JBO",request);
String sASD = RequestUtils.GBKSingleRequest("SERIALIZED_ASD",request);
sASD = sASD.replace("%7C", "|");
//String sPostEvents = RequestUtils.GBKSingleRequest("POST_EVENTS",request);//前台执行脚本
String sCurPage = RequestUtils.GBKSingleRequest("curpage",request);
int iCurPage = 0;
if(sCurPage.matches("[0-9]+"))
	iCurPage = Integer.parseInt(sCurPage);
//String sTableIndex = RequestUtils.GBKSingleRequest("index",request);
String sAction = RequestUtils.GBKSingleRequest("SYS_ACTION",request);//获得动作名称
String sSelectedRows = RequestUtils.GBKSingleRequest("SelectedRows",request);
//request.setCharacterEncoding("UTF-8");
String sUpdatedFields = request.getParameter("UPDATED_FIELD");//获得保存过的字段
if(sUpdatedFields==null)sUpdatedFields = "";
sUpdatedFields= URLDecoder.decode(sUpdatedFields,"UTF-8");
//sUpdatedFields = new String(sUpdatedFields.getBytes("GBK"),"UTF-8");
BusinessProcessData bpData = new BusinessProcessData();
bpData.SelectedRows = PublicFuns.getIntArrays(sSelectedRows);
try{
	IDataAction action = null;
	if(sJbo.trim().length()>0 && AWEObjectConverts.getObject(sJbo) instanceof String[][]){
		action = new ListActionForArrayData(request);
	}else{
		action = new ListAction(request,sUpdatedFields);
	}
	ASDataObject asObj = ASDataObject.getDataObject(com.amarsoft.awe.control.model.Page.getComponent(request));
	boolean result = action.run(sJbo,asObj,sAction,bpData);
	if(result){
		out.println("{status:'success',resultInfo:'"+ WordConvertor.convertJava2Js(action.getResultInfo()) +"'}");
	}else{
		out.println("{status:'fail',errors:'"+ WordConvertor.convertJava2Js(action.getErrors()) +"'}");
	}
}catch(Exception e){
	//e.printStackTrace();
	out.println("{status:'fail',errors:'ListExtendAction错误'}");
	ARE.getLog(this.getClass()).error("ListExtendAction错误" + e.toString());
}
%>