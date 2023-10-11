<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="/IncludeBegin.jsp"%>
<%--  
	Author:  kwwu 
	CreationDate:2023-03-21
    Description:任务运行-数据处理展示tab页
--%>
<%
 	//定义strip数组：
 	//参数：0.是否显示, 1.标题，2.高度，3.组件ID，4.URL，5，参数串，6.事件
	String sTabStrip[][] = {
			{"true","企业评级信息数据处理" ,"/PIDR/TaskManage/TaskRunnerInfoList.jsp","TaskName=PrepareRate","","","false" },
			{"true","企业信贷资产信息数据处理" ,"/PIDR/TaskManage/TaskRunnerInfoList.jsp","TaskName=PrepareCreass","","","false" },
	};
%>
<%@ include file="/Resources/CodeParts/Tab01.jsp"%>
<%@ include file="/IncludeEnd.jsp"%>