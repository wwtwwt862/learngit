<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="/IncludeBegin.jsp"%>
<%--  
	Author: nxxiong
	CreationDate: 2023-02-22
	Description: 通过数组定义生成strip框架页面——企业评级信息当期表展示Tab页面
--%>
<%
 	//定义strip数组：
 	//参数：0.是否显示, 1.标题，2.高度，3.组件ID，4.URL，5，参数串，6.事件
	String sTabStrip[][] = {
		{"true","基础段" ,"/PIDR/IntegatedQueryManage/CurrentDataManage/RateManage/PidrRateBs/PidrRateBsList.jsp","","","","false" },
		{"true","基本概况段" ,"/PIDR/IntegatedQueryManage/CurrentDataManage/RateManage/PidrRateFsinf/PidrRateFsinfList.jsp","","","","false" },
		{"true","主要负责人段" ,"/PIDR/IntegatedQueryManage/CurrentDataManage/RateManage/PidrRateLegrepinf/PidrRateLegrepinfList.jsp","","","","false" },
		{"true","注册资本信息" ,"/PIDR/IntegatedQueryManage/CurrentDataManage/RateManage/PidrRateRegcap/PidrRateRegcapList.jsp","","","","false" },
		{"true","主要出资人信息" ,"/PIDR/IntegatedQueryManage/CurrentDataManage/RateManage/PidrRateMnshahodinf/PidrRateMnshahodinfList.jsp","","","","false" },
		{"true","对外投资段" ,"/PIDR/IntegatedQueryManage/CurrentDataManage/RateManage/PidrRateInvabroinf/PidrRateInvabroinfList.jsp","","","","false" },
		{"true","负面信息段" ,"/PIDR/IntegatedQueryManage/CurrentDataManage/RateManage/PidrRateNeginf/PidrRateNeginfList.jsp","","","","false" },
		{"true","资产负债表段" ,"/PIDR/IntegatedQueryManage/CurrentDataManage/RateManage/PidrRateBalancessheet/PidrRateBalancessheetList.jsp","","","","false" },
		{"true","利润表段" ,"/PIDR/IntegatedQueryManage/CurrentDataManage/RateManage/PidrRateIncome/PidrRateIncomeList.jsp","","","","false" },
		{"true","现金流量表段" ,"/PIDR/IntegatedQueryManage/CurrentDataManage/RateManage/PidrRateCashflow/PidrRateCashflowList.jsp","","","","false" },
		{"true","补充报表数据" ,"/PIDR/IntegatedQueryManage/CurrentDataManage/RateManage/PidrFinanceStatement/PidrFinanceStatementList.jsp","","","","false" },
	};
%>
<%@ include file="/Resources/CodeParts/Tab01.jsp"%>
<%@ include file="/IncludeEnd.jsp"%>