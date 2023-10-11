<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="/Frame/resources/include/include_begin_list.jspf"%>
<%@ page import="com.amarsoft.app.pidr.common.PIDRConstants" %>
<%--
	    Author:yyzang
       CreationDate:2023-02-22
       Description:整笔删除-评级信息 列表页面
 --%>
<%	
	ASObjectModel doTemp = new ASObjectModel("PidrAllDltRateList");
	ASObjectWindow dwTemp = new ASObjectWindow(CurPage,doTemp,request);
	dwTemp.Style="1";      	     //--设置为Grid风格--
	dwTemp.ReadOnly = "1";	 //只读模式
	dwTemp.setPageSize(20);
	dwTemp.genHTMLObjectWindow("");
	String sButtons[][] = {
			//0、是否展示 1、	权限控制  2、 展示类型 3、按钮显示名称 4、按钮解释文字 5、按钮触发事件代码	6、	7、	8、	9、图标，CSS层叠样式 10、风格
 			{"true","","Button","新增","新增","add()","","","","btn_icon_add",""},
			{"true","","Button","详情","详情","view()","","","","btn_icon_detail",""},
			{"true","","Button","删除","删除","del()","","","","btn_icon_delete",""},
		};
%>
<%@include file="/Frame/resources/include/ui/include_list.jspf"%>
<script type="text/javascript">

/*~[Describe=新增,InputParam=无,OutputParam=无]~*/
function add(){
	 var url = "/PIDR/ReportManage/DeleteDataManage/HPidrRateAlldelInfo.jsp";
	 var operationType = "Add";
	AsDialog.PopView(url,'operationType='+operationType,'dialogWidth:1000px;dialogHeight:600px',function(){
		reloadSelf();
	});
}
/*~[Describe=查看详情,InputParam=无,OutputParam=无]~*/
function view(){
	 var url = "/PIDR/ReportManage/DeleteDataManage/HPidrRateAlldelInfo.jsp";
	 var sessionId = getItemValue(0,getRow(0),'SessionId');// 期次号
	 var entCertType = getItemValue(0,getRow(0),'entCertType');// 证件类型
	 var entCertNum = getItemValue(0,getRow(0),'entCertNum');// 证件号码
	 var finStaYear = getItemValue(0,getRow(0),'FinStaYear');// 年份
	 var operationType = "View";
	 var params = 'sessionId=' + sessionId + '&entCertType=' + entCertType+'&entCertNum='+entCertNum+'&finStaYear='+finStaYear+'&operationType='+operationType;
	 if(typeof(sessionId)=="undefined" || sessionId.length==0 ){
		alert("请选择一条记录");
		return ;
	 }
	AsDialog.PopView(url,params,'dialogWidth:1000px;dialogHeight:600px');
}

/*~[Describe=删除记录,InputParam=无,OutputParam=无]~*/
function del(){
	 var sessionId = getItemValue(0,getRow(0),'SessionId');// 期次号
	 if(typeof(sessionId)=="undefined" || sessionId.length==0 ){
			alert("请选择一条记录");
			return ;
	 }
<%-- 	 if("<%=PIDRConstants.SESSIONID_14%>" != sessionId){
		 alert("该记录已经生成报文，不可删除");
			return ;
	 }else{
		 if(confirm('确定删除吗?')){
			 as_delete(0);
		 }
	 } --%>
	 if(confirm('确定删除吗?')){
		 as_delete(0);
	 }
}
</script>
<%@ include file="/Frame/resources/include/include_end.jspf"%>