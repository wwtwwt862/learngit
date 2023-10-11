<%@ page pageEncoding="UTF-8"%>
<%@ include file="/Frame/resources/include/include_begin_list.jspf"%>
<%@ page import="com.amarsoft.app.pidr.common.PIDRConstants"%>
<%--  
    Author:  hlsong 
    CreationDate:2023-02-22
    Description:企业评级信息  当期数据    现金流量表   列表页面
--%>
 <%
    ASObjectModel doTemp = new ASObjectModel("PidrFinanceStatementList");
	String customerId=CurPage.getParameter("CustomerId");
	String flag=CurPage.getParameter("Flag");
	if(customerId==null)  customerId="";
	if(flag==null)  flag="";
	//当期的全信息，拼接数据查询条件
	if(PIDRConstants.ALLMSG_FLAG.equals(flag)||PIDRConstants.VALIDATEERROR_FLAG.equals(flag))   doTemp.appendJboWhere("CustomerId =:CustomerId ");
/* 	doTemp.appendJboWhere("ManagerOrgId like '"+CurUser.getOrgID()+"%'"); */
    ASObjectWindow dwTemp = new ASObjectWindow(CurPage,doTemp,request);
    dwTemp.Style="1";      //设置为Grid风格
    dwTemp.ReadOnly = "1"; //设置为只读
    dwTemp.setParameter("CustomerId", customerId);
    dwTemp.genHTMLObjectWindow("");
    /*  按钮数组定义，依次为: 
    0.是否显示， "true"/"false",默认为true； 1.权限类型， 除了新增、删除和保存三个按钮可为空外，其他均设置为'All'； 2.类型， 类型，默认为Button； 3.按钮文字   
    4.提示文字  5.函数名   6.shortcutKey 快捷键   7.href 资源路径 8.parm 资源路径参数   9.iconCls 图标 CSS名称 (可用button.css中定义的样式，也可直接使用font-awesome的图标) 
 */  
	 String sButtons[][] = {
	         //0、是否展示 1、 权限控制  2、 展示类型 3、按钮显示名称 4、按钮解释文字 5、按钮触发事件代码  6、  7、  8、  9、图标，CSS层叠样式 10、风格
	         {PIDRConstants.ALLMSG_FLAG.equals(flag)?"false":"true","","Button","新增","新增","add()","","","","btn_icon_add",""},
	         {PIDRConstants.ALLMSG_FLAG.equals(flag)?"false":"true","","Button","删除","删除","del()","","","","btn_icon_delete",""},
	         {"true","","Button","详情","详情","viewRecord()","","","","btn_icon_detail",""},
	 };
%><%@include file="/Frame/resources/include/ui/include_list.jspf"%>
<script type="text/javascript" src="<%=sWebRootPath%>/Frame/resources/js/layer.js"></script>
<script type="text/javascript">
	/*~[Describe=新增,InputParam=无,OutputParam=无]~*/
	function add(){
		var url = "/PIDR/IntegatedQueryManage/CurrentDataManage/RateManage/PidrRateFinanceBs/PidrRateFinanceBsInfo.jsp";
		AsDialog.PopView(url,'TableName=PIDR_FINANCE_STATEMENT','dialogWidth:500px;dialogHeight:300px',function(){
			reloadSelf();
		});
	}
	/*~[Describe=删除,InputParam=无,OutputParam=无]~*/
	function del(){
		var customerId = getItemValue(0,getRow(0),'CustomerId');// 客户编号
	       if(typeof(customerId)=="undefined" || customerId.length==0 ){
	          alert("请选择一条记录");
	          return ;
	      }
	      if(confirm("确定要删除本记录？")){
			var retValue = RunJavaMethodTrans("com.amarsoft.app.pidr.alldlt.PidrCascadeDelete", "deleteRateById", "customerId=" + customerId +",tableName="+'<%=PIDRConstants.PIDR_FINANCE_STATEMENT%>');
			alert(retValue);
			reloadSelf();	
		}
		
	}
	/*~[Describe=详情,InputParam=无,OutputParam=无]~*/
    function viewRecord(){
         var url = "/PIDR/IntegatedQueryManage/CurrentDataManage/RateManage/PidrFinanceStatement/PidrFinanceStatementInfoFrame.jsp";
         var customerId = getItemValue(0,getRow(0),'CustomerId');//客户号
         var finstaYear = getItemValue(0,getRow(0),'FinstaYear');//报表年份
         var sheetType = getItemValue(0,getRow(0),'SheetType');//报表类型
         var sheetTypeDivide = getItemValue(0,getRow(0),'SheetTypeDivide');//报表类型细分
         if(typeof(customerId)=="undefined" || customerId.length==0 ){
            alert("请选择一条记录");
            return ;
         }
         AsDialog.PopView(url,'CustomerId=' + customerId +'&FinstaYear=' + finstaYear +'&SheetType=' + sheetType +'&SheetTypeDivide=' + sheetTypeDivide +'&OperationType=<%=PIDRConstants.OPERATIONTYPE_INFO%>',{title:finstaYear+"年度补充报表"},function(){
        	 reloadSelf();
         });
    }
</script>
<%@ include file="/Frame/resources/include/include_end.jspf"%>
