<%@ page pageEncoding="UTF-8"%>
<%@ include file="/Frame/resources/include/include_begin_list.jspf"%>
 <%@ page import="com.amarsoft.app.pidr.common.PIDRConstants"%>
  <%--  
    Author:  hlsong 
    CreationDate:2023-02-22
    Description:企业评级信息  历史数据    现金流量表   列表页面
--%>
 <%
    ASObjectModel doTemp = new ASObjectModel("HPidrRateCashflowList");
 	String rightType = CurPage.getParameter("RightType");// 页面只读控制
	if(rightType == null) rightType = "ReadOnly";
    String checkStripHis = CurPage.getParameter("CheckStripHis");//查看历史界面判断返回按钮是否显示的参数,1代表显示,2代表不显示
    String customerId = CurPage.getParameter("CustomerId");
    String sessionId = CurPage.getParameter("SessionId");
    if(customerId==null) customerId="";
    if(sessionId==null) sessionId="";
	String fNo = CurPage.getParameter("fNo");//反馈处理编号
	if(fNo == null) fNo = "";
	String messageType = CurPage.getParameter("MessageType");//报文类型
	if(messageType == null) messageType = "";
    String flag = CurPage.getParameter("Flag");// 页面复用标志，用来控制list页面jboWhere条件和按钮功能
	if(flag == null) flag = "";
    //自当期转到历史，拼接的查询条件
    if(PIDRConstants.CHECKHIS_FLAG.equals(flag))  doTemp.appendJboWhere("CustomerId =:CustomerId ");
    //历史数据的全信息按钮，拼接的查询条件
    if(PIDRConstants.ALLMSG_FLAG.equals(flag)) doTemp.appendJboWhere("CustomerId =:CustomerId AND SessionId =:SessionId ");  
    String argsValue = "";
   	if(PIDRConstants.MDFC_FLAG.equals(flag)) {
   		doTemp.appendJboWhere("SessionId = :SessionId and CustomerId = :CustomerId");// 按段更正详情中待更正历史段列表打开控制显示
   	}else if( PIDRConstants.FEEDBACK_FLAG.equals(flag)){
   		doTemp.appendJboWhere("SessionId = :SessionId and CustomerId = :CustomerId");// 反馈错误打开控制显示
	}
    doTemp.appendJboWhere("ManagerOrgId like '"+CurUser.getOrgID()+"%'");
    ASObjectWindow dwTemp = new ASObjectWindow(CurPage,doTemp,request);
    dwTemp.Style="1";      //设置为Grid风格
    dwTemp.ReadOnly = "1"; //设置为只读
    dwTemp.setParameter("CustomerId", customerId);
    dwTemp.setParameter("SessionId", sessionId);
    dwTemp.genHTMLObjectWindow("");
    /*  按钮数组定义，依次为: 
    0.是否显示， "true"/"false",默认为true； 1.权限类型， 除了新增、删除和保存三个按钮可为空外，其他均设置为'All'； 2.类型， 类型，默认为Button； 3.按钮文字   
    4.提示文字  5.函数名   6.shortcutKey 快捷键   7.href 资源路径 8.parm 资源路径参数   9.iconCls 图标 CSS名称 (可用button.css中定义的样式，也可直接使用font-awesome的图标) 
 */  
    String sButtons[][] = {  
        {"true","","Button","详情","详情","viewRecord()","","","",""},  

    };
%><%@include file="/Frame/resources/include/ui/include_list.jspf"%>
<script type="text/javascript">

/*~[Describe=详情,InputParam=无,OutputParam=无]~*/
    function viewRecord(){
			var url = "/PIDR/IntegatedQueryManage/HistoryDataManage/RateManage/HPidrRateCashflow/HPidrRateCashflowInfoFrame.jsp";
			var customerId = getItemValue(0,getRow(0),'CustomerId');//客户号
			var finstaYear = getItemValue(0,getRow(0),'FinstaYear');//报表年份
			var sheetType = getItemValue(0,getRow(0),'SheetType');//报表类型
			var sheetTypeDivide = getItemValue(0,getRow(0),'SheetTypeDivide');//报表类型细分
			var sessionId = getItemValue(0,getRow(0),'SessionId');//序列号
			var fNo = "<%=fNo%>";
			var messageType = "<%=messageType%>";
			if(typeof(customerId)=="undefined" || customerId.length==0 ){
			   alert("请选择一条记录");
			   return ;
			}
			AsDialog.PopView(url,'CustomerId=' + customerId +'&FinstaYear=' + finstaYear +'&SheetType=' + sheetType +'&SheetTypeDivide=' + sheetTypeDivide +'&SessionId=' + sessionId +'&fNo='+fNo+'&MessageType='+messageType+ '&RightType=<%=rightType%>&Flag=<%=flag%>',{title:finstaYear+"年度现金流量表"},function(){
			 reloadSelf();
			});
    }
</script>
<%@ include file="/Frame/resources/include/include_end.jspf"%>