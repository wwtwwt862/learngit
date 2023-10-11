<%@ page pageEncoding="UTF-8"%>
<%@ include file="/Frame/resources/include/include_begin_list.jspf"%>
 <%@ page import="com.amarsoft.app.pidr.common.PIDRConstants"%>
 <%--  
    Author:  hlsong 
    CreationDate:2023-04-18
    Description:企业评级信息  接口数据    资产负债表   列表页面
--%>
 <%
    ASObjectModel doTemp = new ASObjectModel("PidrIntBalanceSheetList");
    doTemp.appendJboWhere("ManagerOrgId like '"+CurUser.getOrgID()+"%'");
    ASObjectWindow dwTemp = new ASObjectWindow(CurPage,doTemp,request);
    dwTemp.Style="1";      //设置为Grid风格
    dwTemp.ReadOnly = "1"; //设置为只读
    dwTemp.genHTMLObjectWindow("");
    /*  按钮数组定义，依次为: 
    0.是否显示， "true"/"false",默认为true； 1.权限类型， 除了新增、删除和保存三个按钮可为空外，其他均设置为'All'； 2.类型， 类型，默认为Button； 3.按钮文字   
    4.提示文字  5.函数名   6.shortcutKey 快捷键   7.href 资源路径 8.parm 资源路径参数   9.iconCls 图标 CSS名称 (可用button.css中定义的样式，也可直接使用font-awesome的图标) 
 */  
     String sButtons[][] = {
             //0、是否展示 1、 权限控制  2、 展示类型 3、按钮显示名称 4、按钮解释文字 5、按钮触发事件代码  6、  7、  8、  9、图标，CSS层叠样式 10、风格
             {"true","","Button","详情","详情","viewRecord()","","","","btn_icon_detail",""},
             {"true","","Button","删除","删除","if(confirm('确定删除吗？')) as_delete(0)","","","","btn_icon_delete",""},
     };
%><%@include file="/Frame/resources/include/ui/include_list.jspf"%>
<script type="text/javascript" src="<%=sWebRootPath%>/Frame/resources/js/layer.js"></script>
<script type="text/javascript">
	/*~[Describe=详情,InputParam=无,OutputParam=无]~*/
    function viewRecord(){
         var url = "/PIDR/IntegatedQueryManage/IntDataManage/PidrIntBalancessheet/PidrIntBalancessheetInfoFrame.jsp";
         var customerId = getItemValue(0,getRow(0),'CustomerId');//客户号
         var finstaYear = getItemValue(0,getRow(0),'FinstaYear');//报表年份
         var sheetType = getItemValue(0,getRow(0),'SheetType');//报表类型
         var sheetTypeDivide = getItemValue(0,getRow(0),'SheetTypeDivide');//报表类型细分
         var managerOrgID = getItemValue(0,getRow(0),'ManagerOrgID');//管户机构编号
         var managerUserID = getItemValue(0,getRow(0),'ManagerUserID');//管护用户编号
         var operOrgID = getItemValue(0,getRow(0),'OperOrgID');//操作机构编号
         var operUserID = getItemValue(0,getRow(0),'OperUserID');//操作用户编号
         var occurDate = getItemValue(0,getRow(0),'OccurDate');//数据日期
         if(typeof(customerId)=="undefined" || customerId.length==0  ){
            alert("请选择一条记录");
            return ;
         }
        AsDialog.PopView(url,'CustomerId=' + customerId +'&FinstaYear=' + finstaYear +'&SheetType=' + sheetType +'&SheetTypeDivide=' + sheetTypeDivide +'&ManagerOrgID=' + managerOrgID +'&ManagerUserID=' + managerUserID +'&OperOrgID=' + operOrgID +'&OperUserID=' + operUserID +'&OccurDate=' + occurDate +'&OperationType=<%=PIDRConstants.OPERATIONTYPE_INFO%>',{title:finstaYear+"年度资产负债表"},function (){
            reloadSelf();
        });
    }
</script>
<%@ include file="/Frame/resources/include/include_end.jspf"%>