<%@ page contentType="text/html; charset=UTF-8"%><%@ include file="/IncludeBegin.jsp"%>
 <%--  
    Author:  hlsong 
    CreationDate:2023-02-22
    Description:企业评级信息  历史数据    资产负债表   上期详情页面
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
	String sessionId=CurPage.getParameter("SessionId");
	if(sessionId == null) sessionId = "";
	String fNo = CurPage.getParameter("fNo");//反馈处理编号
	if(fNo == null) fNo = "";
	String messageType = CurPage.getParameter("MessageType");//报文类型
	if(messageType == null) messageType = "";
    String rightType = CurPage.getParameter("RightType");// 页面只读控制
	if(rightType == null) rightType = "ReadOnly";
    String flag = CurPage.getParameter("Flag");// 页面复用标志：5-按段更正详情中的待更正历史段列表打开详情
	if(flag == null) flag = "";
%>
<%@include file="/Resources/CodeParts/Frame03.jsp"%>
<script type="text/javascript">
/*~[Describe=打开左侧本期数据详情,InputParam=无,OutputParam=无]~*/
 	function openLeft(){
		AsControl.OpenView("/PIDR/IntegatedQueryManage/HistoryDataManage/RateManage/HPidrRateBalancessheet/HPidrRateBalancessheetInfo.jsp","CustomerId=<%=customerId%>&FinstaYear=<%=finstaYear%>&SheetType=<%=sheetType%>&SheetTypeDivide=<%=sheetTypeDivide%>&SessionId=<%=sessionId%>&fNo=<%=fNo%>&MessageType=<%=messageType%>&Stage=1&RightType=<%=rightType%>&Flag=<%=flag%>","frameleft","");
	} 
    /*~[Describe=打开右侧上期数据详情,InputParam=无,OutputParam=无]~*/
	function openRight(){
		AsControl.OpenView("/PIDR/IntegatedQueryManage/HistoryDataManage/RateManage/HPidrRateBalancessheet/HPidrRateBalancessheetOldInfo.jsp","CustomerId=<%=customerId%>&FinstaYear=<%=finstaYear%>&SheetType=<%=sheetType%>&SheetTypeDivide=<%=sheetTypeDivide%>&SessionId=<%=sessionId%>&fNo=<%=fNo%>&MessageType=<%=messageType%>&Stage=2&RightType=<%=rightType%>&Flag=<%=flag%>","frameright","");
	}
	
	openLeft();
	openRight();
</script>	
<%@ include file="/IncludeEnd.jsp"%>