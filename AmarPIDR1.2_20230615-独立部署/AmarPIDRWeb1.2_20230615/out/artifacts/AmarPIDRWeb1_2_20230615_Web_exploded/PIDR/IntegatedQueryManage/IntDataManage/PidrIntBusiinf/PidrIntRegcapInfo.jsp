<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="/Frame/resources/include/include_begin_info.jspf"%>
<%@ page import="com.amarsoft.app.pidr.common.PIDRConstants"%>
<%@ page import="java.util.Date" %>
<%--  
	Author: hlsong
	CreationDate:2023-04-18
    Description:企业评级信息  接口数据 注册资本信息表详情页面
--%>
<%	
	ASObjectModel doTemp = new ASObjectModel("PidrIntBusiInfoInfo");

	// 功能按钮和数据筛选
	String customerId = CurPage.getParameter("CustomerId");// 客户编号
	if(customerId == null) customerId = "";
	
	doTemp.appendJboWhere("CustomerId = :CustomerId");
	String operationType = CurPage.getParameter("OperationType");// 区分新增还是详情的标志
	if(operationType == null) operationType = "";
	if(PIDRConstants.OPERATIONTYPE_ADD.equals(operationType)){//新增功能
		doTemp.setReadOnly("*", false);
		doTemp.setReadOnly("SessionId,OccurDate,RecordFlag,ManagerOrgName,ManagerUserName",true);//部分字段初始化给予默认值，只读
	}
	
	ASObjectWindow dwTemp = new ASObjectWindow(CurPage,doTemp,request);
	dwTemp.Style="2";      	     //--设置为Grid风格--
	dwTemp.setParameter("CustomerId", customerId);
	dwTemp.genHTMLObjectWindow("");

	//0、是否展示 1、	权限控制  2、 展示类型 3、按钮显示名称 4、按钮解释文字 5、按钮触发事件代码	6、	7、	8、	9、图标，CSS层叠样式 10、风格
	String sButtons[][] = {
		{"true","","Button","保存","保存记录","if(confirm('确实要保存吗?'))as_save(0)","","","","",""},
	};
%>
<%@include file="/Frame/resources/include/ui/include_info.jspf"%>
<%@ include file="/Frame/resources/include/include_end.jspf"%>