<%@ page pageEncoding="UTF-8"%>
<%@ include file="/Frame/resources/include/include_begin_info.jspf"%>
<%@ page import="com.amarsoft.app.pidr.util.ValidateErrors" %>
<%@ page import="com.amarsoft.app.pidr.common.PIDRConstants"%>
<%--  
    Author:  hlsong 
    CreationDate:2023-04-18
    Description:企业评级信息  接口数据    利润表   上期详情页面
--%>
<%
    ASObjectModel doTemp = new ASObjectModel("PidrIntIncomeInfo");
	String customerId=CurPage.getParameter("CustomerId");
	if(customerId == null) customerId = "";
	String finstaYear=CurPage.getParameter("FinstaYear");
	if(finstaYear == null) finstaYear = "";
	String sheetType=CurPage.getParameter("SheetType");
	if(sheetType == null) sheetType = "";
	String sheetTypeDivide=CurPage.getParameter("SheetTypeDivide");
	if(sheetTypeDivide == null) sheetTypeDivide = "";
	String stage=CurPage.getParameter("Stage");
	if(stage == null) stage = "";
	String operationType = CurPage.getParameter("OperationType");// 区分新增还是详情的标志
	if(operationType == null) operationType = "";
	String managerOrgID=CurPage.getParameter("ManagerOrgID");
	if(managerOrgID == null) managerOrgID = "";
	String managerUserID=CurPage.getParameter("ManagerUserID");
	if(operationType == null) operationType = "";
	String operOrgID=CurPage.getParameter("OperOrgID");
	if(operOrgID == null) operOrgID = "";
	String operUserID=CurPage.getParameter("OperUserID");
	if(operUserID == null) operUserID = "";
	String occurDate=CurPage.getParameter("OccurDate");
	if(occurDate == null) occurDate = "";
    doTemp.setBusinessProcess("com.amarsoft.app.awe.pidr.dwhandler.PidrRateIncomeHandler");
	doTemp.setJboWhere("CustomerId = :CustomerId" + " and FinstaYear = :FinstaYear" + " and SheetType = :SheetType" + " and SheetTypeDivide = :SheetTypeDivide" + " and Stage = :Stage" );
    doTemp.setDefaultValue("CustomerId", customerId);
    doTemp.setDefaultValue("FinstaYear", finstaYear);
    doTemp.setDefaultValue("SheetType", sheetType);
    doTemp.setDefaultValue("SheetTypeDivide", sheetTypeDivide);
    doTemp.setDefaultValue("Stage", "2");
    doTemp.setDefaultValue("ManagerOrgID", managerOrgID);
    doTemp.setDefaultValue("ManagerUserID", managerUserID);
    doTemp.setDefaultValue("OperOrgID", operOrgID);
    doTemp.setDefaultValue("OperUserID", operUserID);
    doTemp.setDefaultValue("OccurDate", occurDate);
    
	ASObjectWindow dwTemp = new ASObjectWindow(CurPage,doTemp,request);
	dwTemp.Style="2";            //--设置为Grid风格--
    dwTemp.setParameter("CustomerId", customerId);
    dwTemp.setParameter("FinstaYear", finstaYear);
    dwTemp.setParameter("SheetType", sheetType);
    dwTemp.setParameter("SheetTypeDivide", sheetTypeDivide);
    dwTemp.setParameter("Stage", stage);
    dwTemp.genHTMLObjectWindow("" );
	/*  按钮数组定义，依次为: 
    0.是否显示， "true"/"false",默认为true； 1.权限类型， 除了新增、删除和保存三个按钮可为空外，其他均设置为'All'； 2.类型， 类型，默认为Button； 3.按钮文字   
    4.提示文字  5.函数名   6.shortcutKey 快捷键   7.href 资源路径 8.parm 资源路径参数   9.iconCls 图标 CSS名称 (可用button.css中定义的样式，也可直接使用font-awesome的图标) 
 */  
    String sButtons[][] = {  
        {"true","","Button","保存","保存","if(confirm('确实要保存吗?'))as_save(0)","","","","",""},
    };
%>
<%@include file="/Frame/resources/include/ui/include_info.jspf"%>
<script type="text/javascript">
    /* 处理详情页面的中文描述换行 问题 */
    window.onload = function(){
        $('.info_div_header').width('400px');
    }
</script>
<%@ include file="/Frame/resources/include/include_end.jspf"%>
