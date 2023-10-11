<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="/IncludeBegin.jsp"%>
<%--  
	Author:  hcliu 
	CreationDate:2023-02-22
    Description:按段更正报文下载Tab页面
--%>
<%
 	//定义strip数组：
 	//参数：0.是否显示, 1.标题，2.高度，3.组件ID，4.URL，5，参数串，6.事件
	String sTabStrip[][] = {
			{"true","企业评级信息按段更正请求报文" ,"/PIDR/FileManage/RegularReportFile/PidrSessionRegularList.jsp","MessageFileClass=312","","","false" },
			};
%>
<%@ include file="/Resources/CodeParts/Tab01.jsp"%>
<%@ include file="/IncludeEnd.jsp"%>