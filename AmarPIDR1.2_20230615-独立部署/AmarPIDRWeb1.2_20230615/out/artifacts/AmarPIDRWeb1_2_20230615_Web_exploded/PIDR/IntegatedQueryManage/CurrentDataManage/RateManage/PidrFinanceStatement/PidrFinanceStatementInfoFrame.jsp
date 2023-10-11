<%@ page contentType="text/html; charset=UTF-8"%><%@ include file="/IncludeBegin.jsp"%>
<%--  
    Author:  hlsong 
    CreationDate:2023-02-22
    Description:企业评级信息  当期数据    现金流量表   列表向详情的分发中转页面
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
%>
<%@include file="/Resources/CodeParts/Frame03.jsp"%>
<script type="text/javascript">
/*~[Describe=打开左侧本期数据详情,InputParam=无,OutputParam=无]~*/
 	function openLeft(){
		AsControl.OpenView("/PIDR/IntegatedQueryManage/CurrentDataManage/RateManage/PidrFinanceStatement/PidrFinanceStatementInfo.jsp","CustomerId=<%=customerId%>&FinstaYear=<%=finstaYear%>&SheetType=<%=sheetType%>&SheetTypeDivide=<%=sheetTypeDivide%>&Stage=1&OperationType=<%=operationType%>","frameleft","");
	} 
    /*~[Describe=打开右侧上期数据详情,InputParam=无,OutputParam=无]~*/
	function openRight(){
		AsControl.OpenView("/PIDR/IntegatedQueryManage/CurrentDataManage/RateManage/PidrFinanceStatement/PidrFinanceStatementOldInfo.jsp","CustomerId=<%=customerId%>&FinstaYear=<%=finstaYear%>&SheetType=<%=sheetType%>&SheetTypeDivide=<%=sheetTypeDivide%>&Stage=2&OperationType=<%=operationType%>","frameright","");
	}
	
	openLeft();
	openRight();
</script>	
<%@ include file="/IncludeEnd.jsp"%>