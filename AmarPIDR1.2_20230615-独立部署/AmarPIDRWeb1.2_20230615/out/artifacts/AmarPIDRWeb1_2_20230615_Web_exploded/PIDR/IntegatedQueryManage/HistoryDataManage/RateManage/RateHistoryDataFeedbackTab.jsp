<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="com.amarsoft.app.pidr.util.FeedbackErrors" %>
<%@ page import="com.amarsoft.app.pidr.util.CheckDataExist"%>
<%@ include file="/IncludeBegin.jsp"%>
<%--  
	Author: swpeng
	CreationDate: 2023-02-22
	Description: 通过数组定义生成strip框架页面--企业评级信息反馈展示Tab页面
--%>
<%
 	String customerId = CurPage.getParameter("CustomerId");
    if(customerId==null) customerId="";
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
 	String flag1 = CheckDataExist.checkData("HPIDR_RATE_BS","CustomerId@SessionId",customerId+'@'+sessionId, Sqlca);
 	String flag2 = CheckDataExist.checkData("HPIDR_RATE_FSINF","CustomerId@SessionId",customerId+'@'+sessionId, Sqlca);
 	String flag3 = CheckDataExist.checkData("HPIDR_RATE_LEGREPINF","CustomerId@SessionId",customerId+'@'+sessionId, Sqlca);
 	String flag4 = CheckDataExist.checkData("HPIDR_RATE_REGCAP","CustomerId@SessionId",customerId+'@'+sessionId, Sqlca);
 	String flag5 = CheckDataExist.checkData("HPIDR_RATE_MNSHAHODINF","CustomerId@SessionId",customerId+'@'+sessionId, Sqlca);
 	String flag6 = CheckDataExist.checkData("HPIDR_RATE_INVABROINF","CustomerId@SessionId",customerId+'@'+sessionId, Sqlca);
 	String flag7 = CheckDataExist.checkData("HPIDR_RATE_NEGINF","CustomerId@SessionId",customerId+'@'+sessionId, Sqlca);
 	String flag8 = CheckDataExist.checkData("HPIDR_RATE_BALANCESSHEET","CustomerId@SessionId",customerId+'@'+sessionId, Sqlca);
 	String flag9 = CheckDataExist.checkData("HPIDR_RATE_INCOME","CustomerId@SessionId",customerId+'@'+sessionId, Sqlca);
 	String flag10 = CheckDataExist.checkData("HPIDR_RATE_CASHFLOW","CustomerId@SessionId",customerId+'@'+sessionId, Sqlca);
 	//定义strip数组：
 	//参数：0.是否显示, 1.标题，2.高度，3.组件ID，4.URL，5，参数串，6.事件
	String sTabStrip[][] = {
		{flag1,"基础段" ,"/PIDR/IntegatedQueryManage/HistoryDataManage/RateManage/HPidrRateBs/HPidrRateBsList.jsp","CustomerId="+customerId+"&FNo="+fNo+"&MessageType="+messageType+"&Flag="+flag+"&SessionId="+sessionId+"&RightType="+rightType,"","","false" },
		{flag2,"基本概况段" ,"/PIDR/IntegatedQueryManage/HistoryDataManage/RateManage/HPidrRateFsinf/HPidrRateFsinfList.jsp","CustomerId="+customerId+"&FNo="+fNo+"&MessageType="+messageType+"&Flag="+flag+"&SessionId="+sessionId+"&RightType="+rightType,"","","false" },
		{flag3,"主要负责人段" ,"/PIDR/IntegatedQueryManage/HistoryDataManage/RateManage/HPidrRateLegrepinf/HPidrRateLegrepinfList.jsp","CustomerId="+customerId+"&FNo="+fNo+"&MessageType="+messageType+"&Flag="+flag+"&SessionId="+sessionId+"&RightType="+rightType,"","","false" },
		{flag4,"注册资本信息" ,"/PIDR/IntegatedQueryManage/HistoryDataManage/RateManage/HPidrRateRegcap/HPidrRateRegcapList.jsp","CustomerId="+customerId+"&FNo="+fNo+"&MessageType="+messageType+"&Flag="+flag+"&SessionId="+sessionId+"&RightType="+rightType,"","","false" },
		{flag5,"主要出资人信息" ,"/PIDR/IntegatedQueryManage/HistoryDataManage/RateManage/HPidrRateMnshahodinf/HPidrRateMnshahodinfList.jsp","CustomerId="+customerId+"&FNo="+fNo+"&MessageType="+messageType+"&Flag="+flag+"&SessionId="+sessionId+"&RightType="+rightType,"","","false" },
		{flag6,"对外投资段" ,"/PIDR/IntegatedQueryManage/HistoryDataManage/RateManage/HPidrRateInvabroinf/HPidrRateInvabroinfList.jsp","CustomerId="+customerId+"&FNo="+fNo+"&MessageType="+messageType+"&Flag="+flag+"&SessionId="+sessionId+"&RightType="+rightType,"","","false" },
		{flag7,"负面信息段" ,"/PIDR/IntegatedQueryManage/HistoryDataManage/RateManage/HPidrRateNeginf/HPidrRateNeginfList.jsp","CustomerId="+customerId+"&FNo="+fNo+"&MessageType="+messageType+"&Flag="+flag+"&SessionId="+sessionId+"&RightType="+rightType,"","","false" },
		{flag8,"资产负债表段" ,"/PIDR/IntegatedQueryManage/HistoryDataManage/RateManage/HPidrRateBalancessheet/HPidrRateBalancessheetList.jsp","CustomerId="+customerId+"&FNo="+fNo+"&MessageType="+messageType+"&Flag="+flag+"&SessionId="+sessionId+"&RightType="+rightType,"","","false" },
		{flag8,"利润表" ,"/PIDR/IntegatedQueryManage/HistoryDataManage/RateManage/HPidrRateIncome/HPidrRateIncomeList.jsp","CustomerId="+customerId+"&FNo="+fNo+"&MessageType="+messageType+"&Flag="+flag+"&SessionId="+sessionId+"&RightType="+rightType,"","","false" },
		{flag10,"现金流量表段" ,"/PIDR/IntegatedQueryManage/HistoryDataManage/RateManage/HPidrRateCashflow/HPidrRateCashflowList.jsp","CustomerId="+customerId+"&FNo="+fNo+"&MessageType="+messageType+"&Flag="+flag+"&SessionId="+sessionId+"&RightType="+rightType,"","","false" },
	};
%>
<%@ include file="/Resources/CodeParts/Tab01.jsp"%>
<script type="text/javascript">
</script>
<%@ include file="/IncludeEnd.jsp"%>