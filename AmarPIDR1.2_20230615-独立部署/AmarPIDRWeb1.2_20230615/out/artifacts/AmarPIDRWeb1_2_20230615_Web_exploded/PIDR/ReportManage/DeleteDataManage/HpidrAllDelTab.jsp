<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="/IncludeBegin.jsp"%>
<%--
	    Author:yyzang
       CreationDate:2023-02-22
       Description:整笔删除tab页
 --%>
<%
	//定义tab数组：
	//参数：0.是否显示, 1.标题，2.URL，3，参数串
	String sTabStrip[][] = {
		{"true", "企业评级信息整笔删除", "/PIDR/ReportManage/DeleteDataManage/HpidrRateAlldelList.jsp", "","","","false"},
		{"true", "企业信贷资产信息整笔删除", "/PIDR/ReportManage/DeleteDataManage/HpidrCreAssAlldelList.jsp", "","","","false"},

	};
%><%@ include file="/Resources/CodeParts/Tab01.jsp"%>
<%@ include file="/IncludeEnd.jsp"%>