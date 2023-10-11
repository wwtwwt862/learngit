<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="/IncludeBegin.jsp"%>
<%--
	Author:kwwu
	CreationDate:2023-02-17
	Description:按段更正管理Tab
--%>
<%
  	//定义strip数组：
   	//参数：0.是否显示, 1.标题，2.高度，3.组件ID，4.URL，5，参数串，6.事件
	String sTabStrip[][] = {
		{"true", "企业评级信息按段更正", "/PIDR/ReportManage/ModifyDataManage/MdfcInfoManage/HpidrRateMdfcList.jsp", "","","","false"},
	};
%><%@ include file="/Resources/CodeParts/Tab01.jsp"%>
<%@ include file="/IncludeEnd.jsp"%>