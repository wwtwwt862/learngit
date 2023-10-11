<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="/IncludeBegin.jsp"%>
<%@ page import="com.amarsoft.app.pidr.common.PIDRConstants"%>
<%@ page import="com.amarsoft.app.pidr.util.CheckDataExist"%>
<%--  
	Author: nxxiong
	CreationDate: 2023-02-22
	Description: 通过数组定义生成strip框架页面——企业评级信息历史表展示全信息Tab页面
--%>
<%
	String sessionId = CurPage.getParameter("SessionId");// 期次号
	if(sessionId == null) sessionId = "";
 	String customerId = CurPage.getParameter("CustomerId");// 客户编号
	if(customerId == null) customerId = "";
 	String flag = PIDRConstants.ALLMSG_FLAG;// 全信息页面控制显示标志
 	
 	String flag1 = CheckDataExist.checkData("HPIDR_RATE_BS","SessionId" + "@CustomerId", sessionId + "@" + customerId, Sqlca);
	String flag2 = CheckDataExist.checkData("HPIDR_RATE_FSINF","SessionId" + "@CustomerId", sessionId + "@" + customerId, Sqlca);
	String flag3 = CheckDataExist.checkData("HPIDR_RATE_LEGREPINF","SessionId" + "@CustomerId", sessionId + "@" + customerId, Sqlca);
	String flag4 = CheckDataExist.checkData("HPIDR_RATE_REGCAP","SessionId" + "@CustomerId", sessionId + "@" + customerId, Sqlca);
	String flag5 = CheckDataExist.checkData("HPIDR_RATE_MNSHAHODINF","SessionId" + "@CustomerId", sessionId + "@" + customerId, Sqlca);
	String flag6 = CheckDataExist.checkData("HPIDR_RATE_INVABROINF","SessionId" + "@CustomerId", sessionId + "@" + customerId, Sqlca);
	String flag7 = CheckDataExist.checkData("HPIDR_RATE_NEGINF","SessionId" + "@CustomerId", sessionId + "@" + customerId, Sqlca);
	String flag8 = CheckDataExist.checkData("HPIDR_RATE_BALANCESSHEET","SessionId" + "@CustomerId", sessionId + "@" + customerId, Sqlca);
	String flag9 = CheckDataExist.checkData("HPIDR_RATE_INCOME","SessionId" + "@CustomerId", sessionId + "@" + customerId, Sqlca);
	String flag10 = CheckDataExist.checkData("HPIDR_RATE_CASHFLOW","SessionId" + "@CustomerId", sessionId + "@" + customerId, Sqlca);
 	
 	//定义strip数组：
 	//参数：0.是否显示, 1.标题，2.高度，3.组件ID，4.URL，5，参数串，6.事件
	String sTabStrip[][] = {
		{flag1,"基础段" ,"/PIDR/IntegatedQueryManage/HistoryDataManage/RateManage/HPidrRateBs/HPidrRateBsList.jsp","SessionId="+sessionId+"&CustomerId="+customerId+"&Flag="+flag,"","","false" },
		{flag2,"基本概况段" ,"/PIDR/IntegatedQueryManage/HistoryDataManage/RateManage/HPidrRateFsinf/HPidrRateFsinfList.jsp","SessionId="+sessionId+"&CustomerId="+customerId+"&Flag="+flag,"","","false" },
		{flag3,"主要负责人段" ,"/PIDR/IntegatedQueryManage/HistoryDataManage/RateManage/HPidrRateLegrepinf/HPidrRateLegrepinfList.jsp","SessionId="+sessionId+"&CustomerId="+customerId+"&Flag="+flag,"","","false" },
		{flag4,"注册资本信息" ,"/PIDR/IntegatedQueryManage/HistoryDataManage/RateManage/HPidrRateRegcap/HPidrRateRegcapList.jsp","SessionId="+sessionId+"&CustomerId="+customerId+"&Flag="+flag,"","","false" },
		{flag5,"主要出资人信息" ,"/PIDR/IntegatedQueryManage/HistoryDataManage/RateManage/HPidrRateMnshahodinf/HPidrRateMnshahodinfList.jsp","SessionId="+sessionId+"&CustomerId="+customerId+"&Flag="+flag,"","","false" },
		{flag6,"对外投资段" ,"/PIDR/IntegatedQueryManage/HistoryDataManage/RateManage/HPidrRateInvabroinf/HPidrRateInvabroinfList.jsp","SessionId="+sessionId+"&CustomerId="+customerId+"&Flag="+flag,"","","false" },
		{flag7,"负面信息段" ,"/PIDR/IntegatedQueryManage/HistoryDataManage/RateManage/HPidrRateNeginf/HPidrRateNeginfList.jsp","SessionId="+sessionId+"&CustomerId="+customerId+"&Flag="+flag,"","","false" },
		{flag8,"资产负债表段" ,"/PIDR/IntegatedQueryManage/HistoryDataManage/RateManage/HPidrRateBalancessheet/HPidrRateBalancessheetList.jsp","SessionId="+sessionId+"&CustomerId="+customerId+"&Flag="+flag,"","","false" },
		{flag9,"利润表" ,"/PIDR/IntegatedQueryManage/HistoryDataManage/RateManage/HPidrRateIncome/HPidrRateIncomeList.jsp","SessionId="+sessionId+"&CustomerId="+customerId+"&Flag="+flag,"","","false" },
		{flag10,"现金流量表段" ,"/PIDR/IntegatedQueryManage/HistoryDataManage/RateManage/HPidrRateCashflow/HPidrRateCashflowList.jsp","SessionId="+sessionId+"&CustomerId="+customerId+"&Flag="+flag,"","","false" },
	};
 	
%>
<%@ include file="/Resources/CodeParts/Tab01.jsp"%>
<%@ include file="/IncludeEnd.jsp"%>