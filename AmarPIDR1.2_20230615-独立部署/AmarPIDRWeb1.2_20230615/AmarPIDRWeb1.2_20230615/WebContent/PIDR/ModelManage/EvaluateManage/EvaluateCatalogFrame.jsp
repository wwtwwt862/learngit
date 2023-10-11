<%@ page pageEncoding="UTF-8"%><%@ include file="/IncludeBegin.jsp"%><%
	String sType =  CurPage.getParameter("Type");
	if(sType == null) sType = "CreditLevel";
%><%@include file="/Resources/CodeParts/Frame02.jsp"%>
<script type="text/javascript">
	mytoptd.height=350;
	OpenList();
	function OpenList(){
		AsControl.OpenView("/PIDR/ModelManage/EvaluateManage/EvaluateCatalogList.jsp","Type=<%=sType%>","rightup");
	}
	
	function OpenDetail(modelNo){
		AsControl.OpenView("/PIDR/ModelManage/EvaluateManage/EvaluateCatalogInfo.jsp", "ModelNo="+modelNo+"&Type=<%=sType%>", "rightdown");
	}
</script>
<%@ include file="/IncludeEnd.jsp"%>