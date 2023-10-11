<%@ page contentType="text/html; charset=UTF-8"%><%@ include file="/IncludeBegin.jsp"%>
<%--  
    Author:  hlsong 
    CreationDate:2023-04-18
    Description:企业评级信息  接口数据    利润表   列表向详情的分发中转页面
--%>
<%
	String customerId=CurPage.getParameter("CustomerId");
	if(customerId == null) customerId = "";
	String finstaYear=CurPage.getParameter("FinstaYear");
	if(finstaYear == null) finstaYear = "";
	String sheetType=CurPage.getParameter("SheetType");
	if(sheetType == null) sheetType = "";
	String sheetTypeDivide=CurPage.getParameter("SheetTypeDivide");
	if(sheetTypeDivide == null) sheetTypeDivide = "";
	String operationType = CurPage.getParameter("OperationType");// 区分新增还是详情的标志
	if(operationType == null) operationType = "";
	String managerOrgID=CurPage.getParameter("ManagerOrgID");
	if(managerOrgID == null) managerOrgID = "";
	String managerUserID=CurPage.getParameter("ManagerUserID");
	if(managerUserID == null) managerUserID = "";
	String operOrgID=CurPage.getParameter("OperOrgID");
	if(operOrgID == null) operOrgID = "";
	String operUserID=CurPage.getParameter("OperUserID");
	if(operUserID == null) operUserID = "";
	String occurDate=CurPage.getParameter("OccurDate");
	if(occurDate == null) occurDate = "";
%>
<%@include file="/Resources/CodeParts/Frame03.jsp"%>
<script type="text/javascript">

 
/*~[Describe=打开左侧本期数据详情,InputParam=无,OutputParam=无]~*/
 	function openLeft(){
		AsControl.OpenView("/PIDR/IntegatedQueryManage/IntDataManage/PidrIntIncome/PidrIntIncomeInfo.jsp","CustomerId=<%=customerId%>&FinstaYear=<%=finstaYear%>&SheetType=<%=sheetType%>&SheetTypeDivide=<%=sheetTypeDivide%>&Stage=1&OperationType=<%=operationType%>","frameleft","");
 	} 
    /*~[Describe=打开右侧上期数据详情,InputParam=无,OutputParam=无]~*/
	function openRight(){
		AsControl.OpenView("/PIDR/IntegatedQueryManage/IntDataManage/PidrIntIncome/PidrIntIncomeOldInfo.jsp","CustomerId=<%=customerId%>&FinstaYear=<%=finstaYear%>&SheetType=<%=sheetType%>&SheetTypeDivide=<%=sheetTypeDivide%>&Stage=2&OperationType=<%=operationType%>&ManagerOrgID=<%=managerOrgID%>&ManagerUserID=<%=managerUserID%>&OperOrgID=<%=operOrgID%>&OperUserID=<%=operUserID%>&OccurDate=<%=occurDate%>","frameright","");
	}
	
	openLeft();
	openRight();
	
</script>	
<%@ include file="/IncludeEnd.jsp"%>