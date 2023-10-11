<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="/IncludeBegin.jsp"%>
<%@ page import="com.amarsoft.app.pidr.common.PIDRConstants"%>
<%@ page import="com.amarsoft.app.pidr.util.CheckDataExist"%>
<%--  
	Author: nxxiong
	CreationDate: 2023-02-22
	Description: 通过数组定义生成strip框架页面——企业评级信息当期表展示全信息Tab页面
--%>
<%
 	String customerId = CurPage.getParameter("CustomerId");// 客户编号
	if(customerId == null) customerId = "";
 	String flag = PIDRConstants.ALLMSG_FLAG;// 全信息页面控制显示标志
 	
 	String flag1 = CheckDataExist.checkData("PIDR_RATE_BS","CustomerId",customerId, Sqlca);
	String flag2 = CheckDataExist.checkData("PIDR_RATE_FSINF","CustomerId",customerId, Sqlca);
	String flag3 = CheckDataExist.checkData("PIDR_RATE_LEGREPINF","CustomerId",customerId, Sqlca);
	String flag4 = CheckDataExist.checkData("PIDR_RATE_REGCAP","CustomerId",customerId, Sqlca);
	String flag5 = CheckDataExist.checkData("PIDR_RATE_MNSHAHODINF","CustomerId",customerId, Sqlca);
	String flag6 = CheckDataExist.checkData("PIDR_RATE_INVABROINF","CustomerId",customerId, Sqlca);
	String flag7 = CheckDataExist.checkData("PIDR_RATE_NEGINF","CustomerId",customerId, Sqlca);
	String flag8 = CheckDataExist.checkData("PIDR_RATE_BALANCESSHEET","CustomerId",customerId, Sqlca);
	String flag9 = CheckDataExist.checkData("PIDR_RATE_INCOME","CustomerId",customerId, Sqlca);
	String flag10 = CheckDataExist.checkData("PIDR_RATE_CASHFLOW","CustomerId",customerId, Sqlca);
	
 	//定义strip数组：
 	//参数：0.是否显示, 1.标题，2.高度，3.组件ID，4.URL，5，参数串，6.事件
	String sTabStrip[][] = {
		{flag1,"基础段" ,"/PIDR/IntegatedQueryManage/CurrentDataManage/RateManage/PidrRateBs/PidrRateBsList.jsp","CustomerId="+customerId+"&Flag="+flag,"","","false" },
		{flag2,"基本概况段" ,"/PIDR/IntegatedQueryManage/CurrentDataManage/RateManage/PidrRateFsinf/PidrRateFsinfList.jsp","CustomerId="+customerId+"&Flag="+flag,"","","false" },
		{flag3,"主要负责人段" ,"/PIDR/IntegatedQueryManage/CurrentDataManage/RateManage/PidrRateLegrepinf/PidrRateLegrepinfList.jsp","CustomerId="+customerId+"&Flag="+flag,"","","false" },
		{flag4,"注册资本信息" ,"/PIDR/IntegatedQueryManage/CurrentDataManage/RateManage/PidrRateRegcap/PidrRateRegcapList.jsp","CustomerId="+customerId+"&Flag="+flag,"","","false" },
		{flag5,"主要出资人信息" ,"/PIDR/IntegatedQueryManage/CurrentDataManage/RateManage/PidrRateMnshahodinf/PidrRateMnshahodinfList.jsp","CustomerId="+customerId+"&Flag="+flag,"","","false" },
		{flag6,"对外投资段" ,"/PIDR/IntegatedQueryManage/CurrentDataManage/RateManage/PidrRateInvabroinf/PidrRateInvabroinfList.jsp","CustomerId="+customerId+"&Flag="+flag,"","","false" },
		{flag7,"负面信息段" ,"/PIDR/IntegatedQueryManage/CurrentDataManage/RateManage/PidrRateNeginf/PidrRateNeginfList.jsp","CustomerId="+customerId+"&Flag="+flag,"","","false" },
		{flag8,"资产负债表段" ,"/PIDR/IntegatedQueryManage/CurrentDataManage/RateManage/PidrRateBalancessheet/PidrRateBalancessheetList.jsp","CustomerId="+customerId+"&Flag="+flag,"","","false" },
		{flag9,"利润表" ,"/PIDR/IntegatedQueryManage/CurrentDataManage/RateManage/PidrRateIncome/PidrRateIncomeList.jsp","CustomerId="+customerId+"&Flag="+flag,"","","false" },
		{flag10,"现金流量表段" ,"/PIDR/IntegatedQueryManage/CurrentDataManage/RateManage/PidrRateCashflow/PidrRateCashflowList.jsp","CustomerId="+customerId+"&Flag="+flag,"","","false" },
	};
 	
%>
<%@ include file="/Resources/CodeParts/Tab01.jsp"%>
<%@ include file="/IncludeEnd.jsp"%>