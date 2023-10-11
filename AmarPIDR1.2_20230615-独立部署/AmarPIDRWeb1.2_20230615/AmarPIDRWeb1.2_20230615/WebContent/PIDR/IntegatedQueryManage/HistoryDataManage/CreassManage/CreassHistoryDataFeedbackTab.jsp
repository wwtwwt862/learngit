<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="/IncludeBegin.jsp"%>
<%@ page import="com.amarsoft.app.pidr.util.FeedbackErrors" %>
<%@ page import="com.amarsoft.app.pidr.util.CheckDataExist"%>
<%--  
	Author:  swpeng 
	CreationDate:2023-02-22
    Description:企业资产信贷信息历史表反馈信息展示Tab页面
--%>
<%
 	String dueCode = CurPage.getParameter("DueCode");
    if(dueCode==null) dueCode="";
	String flag=CurPage.getParameter("Flag");
    if(flag == null) flag = "";
	String sessionId=CurPage.getParameter("SessionId");
    if(sessionId == null) sessionId = "";
    String bsBusiIdSerialNo = CurPage.getParameter("BsBusiIdSerialNo");
  	if(bsBusiIdSerialNo == null) bsBusiIdSerialNo = ""; 
	String messageType = CurPage.getParameter("MessageType");
	if(messageType == null) messageType = "";
	String fNo = CurPage.getParameter("FNo");
	if(fNo == null) fNo = "";
	String rightType="";//反馈错误修改的历史页面可编辑
    String errMsg = "";
   	HashMap<String, String> map=null;
  	if(fNo != null) {
	     map = FeedbackErrors.getfeedbackErrInfo(bsBusiIdSerialNo,messageType, Sqlca);
	     for(String key : map.keySet()) {
		    errMsg += map.get(key)+"<br/>";
	    }
    }
 	CurPage.setAttribute("BeforeTabStripHtml", "<div style='font-weight:bold'>"+errMsg+"</div>");
	String flag1 = CheckDataExist.checkData("HPIDR_CREASS_BS","DueCode@SessionId",dueCode+'@'+sessionId, Sqlca);
 	String flag2 = CheckDataExist.checkData("HPIDR_CREASS_FSINF","DueCode@SessionId",dueCode+'@'+sessionId, Sqlca);
 	//定义strip数组：
 	//参数：0.是否显示, 1.标题，2.高度，3.组件ID，4.URL，5，参数串，6.事件
	String sTabStrip[][] = {
			{flag1,"基础段" ,"/PIDR/IntegatedQueryManage/HistoryDataManage/CreassManage/PidrCreassBs/HPidrCreassBsList.jsp","DueCode="+dueCode+"&FNo="+fNo+"&MessageType="+messageType+"&Flag="+flag+"&SessionId="+sessionId+"&RightType="+rightType,"","","false" },
			{flag2,"基本信息段" ,"/PIDR/IntegatedQueryManage/HistoryDataManage/CreassManage/PidrCreassFsinf/HPidrCreassFsinfList.jsp","DueCode="+dueCode+"&FNo="+fNo+"&MessageType="+messageType+"&Flag="+flag+"&SessionId="+sessionId+"&RightType="+rightType,"","","false" },
			};
%>
<%@ include file="/Resources/CodeParts/Tab01.jsp"%>
<script type="text/javascript">
</script>
<%@ include file="/IncludeEnd.jsp"%>