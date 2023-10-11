<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="/IncludeBegin.jsp"%>
<%@ page import="com.amarsoft.app.pidr.common.PIDRConstants"%>
<%--  
	Author:  hcliu 
	CreationDate:2023-02-22
    Description:企业资产信贷信息历史表基础段全信息Tab页面
--%>
<%
 	String dueCode = CurPage.getParameter("DueCode");//list页面传递的借据号
	if(dueCode == null) dueCode = "";
 	String flag = PIDRConstants.ALLMSG_FLAG;//全信息页面控制显示标志
 	//定义strip数组：
 	//参数：0.是否显示, 1.标题，2.高度，3.组件ID，4.URL，5，参数串，6.事件
	String sTabStrip[][] = {
			{"true","基础段" ,"/PIDR/IntegatedQueryManage/HistoryDataManage/CreassManage/PidrCreassBs/HPidrCreassBsList.jsp","DueCode="+dueCode+"&Flag="+flag,"","","false" },
			{"true","基本信息段" ,"/PIDR/IntegatedQueryManage/HistoryDataManage/CreassManage/PidrCreassFsinf/HPidrCreassFsinfList.jsp","DueCode="+dueCode+"&Flag="+flag,"","","false" },
			};
%>
<%@ include file="/Resources/CodeParts/Tab01.jsp"%>
<%@ include file="/IncludeEnd.jsp"%>