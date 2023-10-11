<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="/IncludeBegin.jsp"%>
<%--
	Author:kwwu
	CreationDate:2023-02-21
	Description:标识变更管理Tab
 --%>
<%
	//定义tab数组：
	//参数：0.是否显示, 1.标题，2.URL，3，参数串
	String sTabStrip[][] = {
		{"true", "企业评级信息标识变更", "/PIDR/ReportManage/ModifyDataManage/IDChangeManage/HpidrRateIdChangeList.jsp", "","","","false"},
		{"true", "企业信贷资产信息标识变更", "/PIDR/ReportManage/ModifyDataManage/IDChangeManage/HpidrCreAssIdChangeList.jsp", "","","","false"},

	};
%><%@ include file="/Resources/CodeParts/Tab01.jsp"%>
<%@ include file="/IncludeEnd.jsp"%>