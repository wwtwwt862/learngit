<%@ page pageEncoding="UTF-8"%>
<%@ include file="/Frame/resources/include/include_begin_list.jspf"%>
 <%@ page import="com.amarsoft.app.pidr.common.PIDRConstants"%>
 <%--  
    Author:  hlsong 
    CreationDate:2023-02-22
    Description:企业评级信息  当期数据    利润表   列表页面
--%>
 <%
    ASObjectModel doTemp = new ASObjectModel("PidrRateIncomeList");
	String customerId=CurPage.getParameter("CustomerId");
	String flag=CurPage.getParameter("Flag");
	if(customerId==null)  customerId="";
	if(flag==null)  flag="";
	//全信息，拼接的查询条件
	if(PIDRConstants.ALLMSG_FLAG.equals(flag)||PIDRConstants.VALIDATEERROR_FLAG.equals(flag))   doTemp.appendJboWhere("CustomerId =:CustomerId ");
	doTemp.appendJboWhere("ManagerOrgId like '"+CurUser.getOrgID()+"%'");
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
	         {PIDRConstants.VALIDATEERROR_FLAG.equals(flag)?"false":"true","","Button","查看历史记录","查看历史记录","seeHis()","","","","btn_icon_check",""}, 
	         {PIDRConstants.VALIDATEERROR_FLAG.equals(flag)?"false":"true","","Button","按段更正","按段更正","mdfcInfo()","","","","btn_icon_detail",""},
	 };
%><%@include file="/Frame/resources/include/ui/include_list.jspf"%>
<script type="text/javascript" src="<%=sWebRootPath%>/Frame/resources/js/layer.js"></script>
<script type="text/javascript">
	/*~[Describe=新增,InputParam=无,OutputParam=无]~*/
	function add(){
		var url = "/PIDR/IntegatedQueryManage/CurrentDataManage/RateManage/PidrRateFinanceBs/PidrRateFinanceBsInfo.jsp";
		AsDialog.PopView(url,'TableName=PIDR_RATE_INCOME','dialogWidth:500px;dialogHeight:300px',function(){
			reloadSelf();
		});
	}
	/*~[Describe=删除,InputParam=无,OutputParam=无]~*/
	function del(){
		var customerId = getItemValue(0,getRow(0),'CustomerId');// 客户编号
		var recordFlag =getItemValue(0,getRow(0),'RecordFlag');// 记录标志
		layer.confirm("删除",{
			title:false,
			btn:['仅删除本记录','关联删除所有段记录']
		},function(index){
			//仅删除本段
			if(recordFlag != '<%=PIDRConstants.RECORDFLAG_A%>' ){
				layer.alert("该记录已经上报过，不可删除！");
				return;
			}else{
				if(!confirm("确定要删除本记录？")) return;
				var retValue = RunJavaMethodTrans("com.amarsoft.app.pidr.alldlt.PidrCascadeDelete", "deleteRateById", "customerId=" + customerId +",tableName="+'<%=PIDRConstants.TABLE_PIDR_RATE_INCOME%>');
				alert(retValue);
				layer.close(index);
				reloadSelf();	
			}
		},function(index){
			//级联删除所有段
			if(recordFlag != '<%=PIDRConstants.RECORDFLAG_A%>' ){
				layer.alert("该记录已经上报过，不可删除！");
				return;
			}else{
				if(!confirm("确定要关联删除所有段记录？")) return;
				//调后台方法，关联删除
				var retValue = RunJavaMethodTrans("com.amarsoft.app.pidr.alldlt.PidrCascadeDelete", "deleteRateAll", "customerId=" + customerId);
				alert(retValue);
				layer.close(index);
				reloadSelf();	
			}
		});
	}
	/*~[Describe=详情,InputParam=无,OutputParam=无]~*/
    function viewRecord(){
         var url = "/PIDR/IntegatedQueryManage/CurrentDataManage/RateManage/PidrRateIncome/PidrRateIncomeInfoFrame.jsp";
         var customerId = getItemValue(0,getRow(0),'CustomerId');//客户号
         var finstaYear = getItemValue(0,getRow(0),'FinstaYear');//报表年份
         var sheetType = getItemValue(0,getRow(0),'SheetType');//报表类型
         var sheetTypeDivide = getItemValue(0,getRow(0),'SheetTypeDivide');//报表类型细分
         if(typeof(customerId)=="undefined" || customerId.length==0 ){
            alert("请选择一条记录");
            return ;
         }
         AsDialog.PopView(url,'CustomerId=' + customerId +'&FinstaYear=' + finstaYear +'&SheetType=' + sheetType +'&SheetTypeDivide=' + sheetTypeDivide +'&OperationType=<%=PIDRConstants.OPERATIONTYPE_INFO%>',{title:finstaYear+"年度利润表"},function(){
        	 reloadSelf();
         });
    }
    /*~[Describe=查看历史记录,InputParam=无,OutputParam=无]~*/
    function seeHis(){
        var url = "/PIDR/IntegatedQueryManage/HistoryDataManage/RateManage/HPidrRateIncome/HPidrRateIncomeList.jsp";
        var customerId = getItemValue(0,getRow(0),'CustomerId');
        if(typeof(customerId)=="undefined" || customerId.length==0 ){
               alert("请选择一条记录");
               return ;
            }
        AsDialog.PopView(url,'Flag=2&CustomerId='+customerId,'dialogWidth:1300px;dialogHeight:750px');
   }
    /*~[Describe=按段更正,InputParam=无,OutputParam=无]~*/
    function mdfcInfo(){
    	var sessionId = getItemValue(0, getRow(0), "SessionId");
		var customerId = getItemValue(0, getRow(0), "CustomerId");
		var finstaYear = getItemValue(0,getRow(0),'FinstaYear');//报表年份
        var sheetType = getItemValue(0,getRow(0),'SheetType');//报表类型
        var sheetTypeDivide = getItemValue(0,getRow(0),'SheetTypeDivide');//报表类型细分
		var managerOrgId = getItemValue(0, getRow(0), "ManagerOrgId");
		if(typeof(sessionId)=="undefined"||sessionId.length==0) {
			alert("请选择一条记录！");
			return;
		}
		if(!confirm('确定要按段更正吗?')){
			return;
		}
		if(sessionId=="00000000000000") {
			alert("该记录为需要上报修改的新信息段");
			return;
		}
		var retValue=RunJavaMethodTrans("com.amarsoft.app.pidr.mdfc.ModifyRateFinanceInfo","modifyRateInfo",
				"CustomerId=" + customerId + ",MdfcSgmtCode=H, ManagerOrgId=" + managerOrgId 
				+ ",FinstaYear=" + finstaYear + ",SheetType=" + sheetType + ",SheetTypeDivide=" + sheetTypeDivide
				+ ",CurUserId=<%=CurUser.getUserID()%>,CurOrgId=<%=CurOrg.getOrgID()%>");
		if(retValue!="操作成功") {
			alert(retValue);
			return;
		}
		var url = "/PIDR/ReportManage/ModifyDataManage/MdfcInfoManage/HpidrRateMdfcFrame.jsp";
		var params = 'SessionId=<%=PIDRConstants.SESSIONID_14%>&CustomerId=' + customerId + '&MdfcSgmtCode=H' ;
		AsDialog.PopView(url,params,'dialogWidth:1000px;dialogHeight:600px',function(){
			reloadSelf();	
		});
    }
</script>
<%@ include file="/Frame/resources/include/include_end.jspf"%>