<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="/IncludeBegin.jsp"%>
<%@ page import="com.amarsoft.app.pidr.common.PIDRConstants"%>
<%--  
	Author:  hcliu 
	CreationDate:2023-02-22
    Description:企业资产信贷信息当期表基础段全信息Tab页面
--%>
<%
 	String dueCode = CurPage.getParameter("DueCode");//list页面传递的借据号
	if(dueCode == null) dueCode = "";
 	String flag = PIDRConstants.ALLMSG_FLAG;//全信息页面控制显示标志
 	//定义strip数组：
 	//参数：0.是否显示, 1.标题，2.高度，3.组件ID，4.URL，5，参数串，6.事件
	String sTabStrip[][] = {
			{"true","基础段" ,"/PIDR/IntegatedQueryManage/CurrentDataManage/CreassManage/PidrCreassBs/PidrCreassBsList.jsp","DueCode="+dueCode+"&Flag="+flag,"","","false" },
			{"true","基本信息段" ,"/PIDR/IntegatedQueryManage/CurrentDataManage/CreassManage/PidrCreassFsinf/PidrCreassFsinfList.jsp","DueCode="+dueCode+"&Flag="+flag,"","","false" },
			};
 	
 	String sButtons[][] = {
 			{"false","","Button","返回","返回","returnList()","",""},
 	};
%>
<%@ include file="/Resources/CodeParts/Tab01.jsp"%>
<%@ include file="/IncludeEnd.jsp"%>
