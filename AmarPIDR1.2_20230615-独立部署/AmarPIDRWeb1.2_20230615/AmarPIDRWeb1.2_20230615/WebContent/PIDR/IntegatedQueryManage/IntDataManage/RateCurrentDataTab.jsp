<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="/IncludeBegin.jsp"%>
<%--  
	Author: swpeng
	CreationDate: 2023-04-20
	Description: 通过数组定义生成strip框架页面——企业评级信息接口表展示Tab页面
--%>
<%
 	//定义strip数组：
 	//参数：0.是否显示, 1.标题，2.高度，3.组件ID，4.URL，5，参数串，6.事件
	String sTabStrip[][] = {
		{"true","企业基本信息" ,"/PIDR/IntegatedQueryManage/IntDataManage/PidrIntEnt/PidrIntEntList.jsp","","","","false" },
		{"true","企业主要出资人信息" ,"/PIDR/IntegatedQueryManage/IntDataManage/PidrIntMnshahodinf/PidrIntMnshahodinfList.jsp","","","","false" },
		{"true","企业对外投资信息" ,"/PIDR/IntegatedQueryManage/IntDataManage/PidrIntInvabroinf/PidrIntInvabroinfList.jsp","","","","false" },
		{"true","企业负面信息" ,"/PIDR/IntegatedQueryManage/IntDataManage/PidrIntNeginf/PidrIntNeginfList.jsp","","","","false" },
		{"true","企业资产负债信息" ,"/PIDR/IntegatedQueryManage/IntDataManage/PidrIntBalancessheet/PidrIntBalancessheetList.jsp","","","","false" },
		{"true","企业利润信息" ,"/PIDR/IntegatedQueryManage/IntDataManage/PidrIntIncome/PidrIntIncomeList.jsp","","","","false" },
		{"true","企业现金流量信息" ,"/PIDR/IntegatedQueryManage/IntDataManage/PidrIntCashflow/PidrIntCashflowList.jsp","","","","false" },
		{"true","企业补充报表信息" ,"/PIDR/IntegatedQueryManage/IntDataManage/PidrIntFinanceStatement/PidrIntFinanceStatementList.jsp","","","","false" },
		{"true","企业信贷资产信息" ,"/PIDR/IntegatedQueryManage/IntDataManage/PidrIntBusiinf/PidrIntBusiinfList.jsp","","","","false" },
};
%>
<%@ include file="/Resources/CodeParts/Tab01.jsp"%>
<%@ include file="/IncludeEnd.jsp"%>