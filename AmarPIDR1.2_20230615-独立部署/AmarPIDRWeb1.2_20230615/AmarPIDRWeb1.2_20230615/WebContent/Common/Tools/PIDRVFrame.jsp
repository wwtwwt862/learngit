<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="/IncludeBegin.jsp"%>
<%@ page import="com.amarsoft.app.pidr.common.PIDRConstants"%>
<%--  
	Author: nxxiong
	CreationDate: 2023-02-24
	Description: 左右框架页面 ,判断选择展示选择框
--%>
<%
	String sAreaCode = CurPage.getParameter("AreaCode");// 行政区划代码
	if(sAreaCode == null) sAreaCode = "";
	String sEcoIndusCate = CurPage.getParameter("EcoIndusCate");// 行业分类代码
	if(sEcoIndusCate == null) sEcoIndusCate = "";
	String selectItem = CurPage.getParameter("SelectItem");// 选择框类型：AreaCode-行政区划，EcoIndusCate-行业分类
	if(selectItem == null) selectItem = "";
	
	String urlParams = "";
	if(PIDRConstants.SELECT_ITEM_AREACODE.equals(selectItem)){//行政区划选择页面
		urlParams = "/Common/Tools/AreaCodeSelect.jsp?AreaCode="+sAreaCode;
	}else if(PIDRConstants.SELECT_ITEM_ECOINDUSCATE.equals(selectItem)){//行业分类
		urlParams = "/Common/Tools/EcoIndusCateSelect.jsp?EcoIndusCate="+sEcoIndusCate;
	}
%><%@include file="/Resources/CodeParts/Frame03.jsp"%>
<script type="text/javascript">
	myleft.width=450;
	OpenPage("<%=urlParams%>","frameleft","");
	OpenPage("/Blank.jsp?TextToShow=请在左方列表中选择一项","frameright","");
</script>	
<%@ include file="/IncludeEnd.jsp"%>