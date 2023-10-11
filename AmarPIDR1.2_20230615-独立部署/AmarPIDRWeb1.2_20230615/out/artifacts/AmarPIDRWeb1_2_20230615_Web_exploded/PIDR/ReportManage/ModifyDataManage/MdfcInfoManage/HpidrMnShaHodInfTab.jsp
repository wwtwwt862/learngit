<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="/IncludeBegin.jsp"%>
<%@ page import="com.amarsoft.app.pidr.util.CheckDataExist"%>
<%

	/*
	Author:  kwwu
	Content: 按段更正详请-待更正段若是注册资本及主要出资人段，需要在详情中同时展示注册资本、主要出资人信息列表
	*/
	// 获取参数，设置条件筛选数据
	String rightType = CurPage.getParameter("RightType");// 页面只读控制
	if(rightType == null) rightType = "ReadOnly";
	String sessionId = CurPage.getParameter("SessionId");// 期次号
	if(sessionId == null) sessionId = "";
	String customerId = CurPage.getParameter("CustomerId");// 客户编号
	if(customerId == null) customerId = "";
	String flag = CurPage.getParameter("Flag");// 页面复用标志，用来控制list页面jboWhere条件和按钮功能
	if(flag == null) flag = "";
	String param = "SessionId=" + sessionId + "&CustomerId="+ customerId +"&RightType=" + rightType + "&Flag=" + flag;//参数
	
	String flag1 = CheckDataExist.checkData("HPIDR_RATE_REGCAP","SessionId" + "@CustomerId", sessionId + "@" + customerId, Sqlca);//注册资本是否存在记录
	String flag2 = CheckDataExist.checkData("HPIDR_RATE_MNSHAHODINF","SessionId" + "@CustomerId", sessionId + "@" + customerId, Sqlca);//主要出资人是否存在记录
	
  	//定义strip数组：
   	//参数：0.是否显示, 1.标题，2.高度，3.组件ID，4.URL，5，参数串，6.事件
	String sTabStrip[][] = {
		{flag1, "注册资本信息", "/PIDR/IntegatedQueryManage/HistoryDataManage/RateManage/HPidrRateRegcap/HPidrRateRegcapList.jsp", param,"","","false"},
		{flag2, "主要出资人信息", "/PIDR/IntegatedQueryManage/HistoryDataManage/RateManage/HPidrRateMnshahodinf/HPidrRateMnshahodinfList.jsp", param,"","","false"},
	};
%><%@ include file="/Resources/CodeParts/Tab01.jsp"%>
<%@ include file="/IncludeEnd.jsp"%>