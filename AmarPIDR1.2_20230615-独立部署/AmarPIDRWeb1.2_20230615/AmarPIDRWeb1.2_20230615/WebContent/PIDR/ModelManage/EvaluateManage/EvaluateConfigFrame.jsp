<%@ page pageEncoding="UTF-8"%><%@
 include file="/IncludeBegin.jsp"%><%
/*
	页面说明: 左右联动框架页面
 */
 	String sType =  CurPage.getParameter("Type");
	if(sType == null) sType = "";
%><%@include file="/Resources/CodeParts/Frame03.jsp"%>
<script type="text/javascript">
	myleft.width=800;
	OpenCatalogList();
	function OpenCatalogList(){
		AsControl.OpenView("/PIDR/ModelManage/EvaluateManage/EvaluateCatalogFrame.jsp","Type=<%=sType%>","frameleft");
	}
	
	function OpenModelList(modelNo){
		AsControl.OpenView("/PIDR/ModelManage/EvaluateManage/EvaluateModelList.jsp", "ModelNo="+modelNo, "frameright");
	}
</script>
<%@ include file="/IncludeEnd.jsp"%>