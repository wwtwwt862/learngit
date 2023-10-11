<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="/IncludeBegin.jsp"%>
<%--  
	Author: nxxiong
	CreationDate: 2023-02-22
	Description: 通过数组定义生成strip框架页面--企业评级信息当期表展示Tab页面
--%>
<%
 	//定义strip数组：
 	//参数：0.是否显示, 1.标题，2.高度，3.组件ID，4.URL，5，参数串，6.事件
	String sTabStrip[][] = {
		{"true","基础段" ,"/PIDR/IntegatedQueryManage/HistoryDataManage/RateManage/HPidrRateBs/HPidrRateBsList.jsp","","","","false" },
		{"true","基本概况段" ,"/PIDR/IntegatedQueryManage/HistoryDataManage/RateManage/HPidrRateFsinf/HPidrRateFsinfList.jsp","","","","false" },
		{"true","主要负责人段" ,"/PIDR/IntegatedQueryManage/HistoryDataManage/RateManage/HPidrRateLegrepinf/HPidrRateLegrepinfList.jsp","","","","false" },
		{"true","注册资本信息" ,"/PIDR/IntegatedQueryManage/HistoryDataManage/RateManage/HPidrRateRegcap/HPidrRateRegcapList.jsp","","","","false" },
		{"true","主要出资人信息" ,"/PIDR/IntegatedQueryManage/HistoryDataManage/RateManage/HPidrRateMnshahodinf/HPidrRateMnshahodinfList.jsp","","","","false" },
		{"true","对外投资段" ,"/PIDR/IntegatedQueryManage/HistoryDataManage/RateManage/HPidrRateInvabroinf/HPidrRateInvabroinfList.jsp","","","","false" },
		{"true","负面信息段" ,"/PIDR/IntegatedQueryManage/HistoryDataManage/RateManage/HPidrRateNeginf/HPidrRateNeginfList.jsp","","","","false" },
		{"true","资产负债表" ,"/PIDR/IntegatedQueryManage/HistoryDataManage/RateManage/HPidrRateBalancessheet/HPidrRateBalancessheetList.jsp","","","","false" },
		{"true","利润表段" ,"/PIDR/IntegatedQueryManage/HistoryDataManage/RateManage/HPidrRateIncome/HPidrRateIncomeList.jsp","","","","false" },
		{"true","现金流量表段" ,"/PIDR/IntegatedQueryManage/HistoryDataManage/RateManage/HPidrRateCashflow/HPidrRateCashflowList.jsp","","","","false" },
	};
%>
<%@ include file="/Resources/CodeParts/Tab01.jsp"%>
<%@ include file="/IncludeEnd.jsp"%>