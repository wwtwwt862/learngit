<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="/IncludeBegin.jsp"%>
<%--
	    Author:yyzang
       CreationDate:2023-03-27
       Description:业务模型管理Tab
 --%>
 
<%
	String type = CurPage.getParameter("ModelType");
	if(type == null) type = "CreditLevel";
	//定义tab数组：ModelConfigMain
	//参数：0.是否显示, 1.标题，2.URL，3，参数串
	String sTabStrip[][] = {
		{"true", "评级模型", "/PIDR/ModelManage/EvaluateManage/EvaluateConfigFrame.jsp", "Type="+type,"","","false"},
		{"true", "基础配置", "/PIDR/ModelManage/ClassManage/ClassManageFrame.jsp", "","","","false"},

	};
%><%@ include file="/Resources/CodeParts/Tab01.jsp"%>
<%@ include file="/IncludeEnd.jsp"%>