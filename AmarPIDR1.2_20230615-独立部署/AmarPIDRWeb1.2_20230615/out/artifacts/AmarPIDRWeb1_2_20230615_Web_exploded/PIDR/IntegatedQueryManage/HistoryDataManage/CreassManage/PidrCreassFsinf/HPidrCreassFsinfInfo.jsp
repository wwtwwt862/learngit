<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="/Frame/resources/include/include_begin_info.jspf"%>
<%@ page import="com.amarsoft.app.pidr.common.PIDRConstants"%>
<%@ page import="com.amarsoft.app.pidr.util.FeedbackErrors" %>
<%--  
	Author:  hcliu 
	CreationDate:2023-02-22
    Description:企业资产信贷信息历史表基本信息段详情页面
--%>
<%
    String bsBusiIdSerialNo = CurPage.getParameter("DueCode");//业务标示号
    if(bsBusiIdSerialNo==null) bsBusiIdSerialNo="";
    String fNo = CurPage.getParameter("fNo");//反馈处理编号
    if(fNo == null) fNo = "";
    String messageType = CurPage.getParameter("MessageType");//报文类型
    if(messageType == null) messageType = "";
    HashMap<String, String> errFieldMap= new HashMap<String, String>();
    if(fNo != null) {
        errFieldMap = FeedbackErrors.getfeedbackErrField(bsBusiIdSerialNo,messageType, Sqlca);
    }
  
%>
<%	
	String dueCode = CurPage.getParameter("DueCode");
	if(dueCode == null) dueCode = "";
	String rightType = CurPage.getParameter("RightType");// 页面只读控制
	if(rightType == null) rightType = "";
	ASObjectModel doTemp = new ASObjectModel("HPidrCreassFsinfInfo");
	String errMsg = "";
    for(String errField :errFieldMap.keySet()){
        doTemp.setHTMLStyle(errField,"style={border:1px solid red}");//把所有的错误字段红框标出
        if(doTemp.getColumn(errField)!=null){
            errMsg += errFieldMap.get(errField)+"<br/>";
        }
    }
    out.println("<div style='font-weight:bold'>"+errMsg+"</div>");
	doTemp.appendJboWhere("DueCode = :DueCode");
	ASObjectWindow dwTemp = new ASObjectWindow(CurPage,doTemp,request);
	dwTemp.Style="2";     //设置为Grid风格
	dwTemp.MultiSelect = false; //不允许多选
	dwTemp.setParameter("DueCode", dueCode);
	dwTemp.genHTMLObjectWindow("");
	
	String sButtons[][] = {
		{PIDRConstants.RIGHTTYPE_READONLY.equals(rightType)? "false":"true","","Button","保存","保存","if(confirm('确定保存吗？')) as_save(0)","","","","",""},
	};
%>
<%@ include file="/Frame/resources/include/ui/include_info.jspf"%>
<%@ include file="/Frame/resources/include/include_end.jspf"%>
