<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="/Frame/resources/include/include_begin_info.jspf"%>
<%@ page import="com.amarsoft.app.pidr.util.ValidateErrors" %>
<%@ page import="com.amarsoft.app.pidr.common.PIDRConstants"%>
<%@ page import="java.util.Date" %>
<%--  
	Author: hlsong
	CreationDate:2023-04-18
    Description:企业评级信息  接口数据-对外投资段信息表详情页面
--%>
<%	
	ASObjectModel doTemp = new ASObjectModel("PidrIntInvabroInfoInfo");
	String flag = CurPage.getParameter("ValidateFlag");//业务标示号
	if(flag == null) flag = "";
	if(PIDRConstants.VALIDATEERROR_FLAG.equals(flag)){
		doTemp.setReadOnly("*", true);		
	}
	// 功能按钮和数据筛选
	String relaId = CurPage.getParameter("RelaId");// 关联编号
	if(relaId == null) relaId = "";
	String customerId = CurPage.getParameter("CustomerId");// 客户编号
	if(customerId == null) customerId = "";
	String operationType = CurPage.getParameter("OperationType");// 区分新增还是详情的标志
	if(operationType == null) operationType = "";
	if(PIDRConstants.OPERATIONTYPE_ADD.equals(operationType)){//新增功能
		doTemp.setReadOnly("*", false);
		doTemp.setReadOnly("SessionId,OccurDate,RecordFlag,ManagerOrgName,ManagerUserName",true);//部分字段初始化给予默认值，只读
		doTemp.setReadOnly("InvEntEstablishDate,InvDate",true);//日期字段，内置按钮选择填入，只读不手动填入
	}
	
	doTemp.appendJboWhere("RelaId = :RelaId and CustomerId = :CustomerId");
	
	ASObjectWindow dwTemp = new ASObjectWindow(CurPage,doTemp,request);
	dwTemp.Style="2";      	     //--设置为Grid风格--
	dwTemp.setParameter("RelaId", relaId);
	dwTemp.setParameter("CustomerId", customerId);
	dwTemp.genHTMLObjectWindow("");

	//0、是否展示 1、	权限控制  2、 展示类型 3、按钮显示名称 4、按钮解释文字 5、按钮触发事件代码	6、	7、	8、	9、图标，CSS层叠样式 10、风格
	String sButtons[][] = {
		{"true","","Button","保存","保存记录","if(confirm('确实要保存吗?'))as_save(0)","","","","",""},
	};
%>
<%@include file="/Frame/resources/include/ui/include_info.jspf"%>
<%@ include file="/Frame/resources/include/include_end.jspf"%>