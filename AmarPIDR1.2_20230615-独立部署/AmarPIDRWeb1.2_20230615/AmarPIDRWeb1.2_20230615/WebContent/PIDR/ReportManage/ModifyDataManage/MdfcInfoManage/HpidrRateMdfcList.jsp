<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="/Frame/resources/include/include_begin_list.jspf"%>
<%@ page import="com.amarsoft.app.pidr.common.PIDRConstants" %>
<%--
	Author:kwwu
	CreationDate:2023-02-17
	Description:企业评级信息按段更正列表页面
--%>
<%	
	ASObjectModel doTemp = new ASObjectModel("HpidrRateMdfcList");
	doTemp.appendJboWhere("ManagerOrgId like '"+CurUser.getOrgID()+"%'");//只查看管户机构为当前用户所属机构及其下属机构的记录
	ASObjectWindow dwTemp = new ASObjectWindow(CurPage,doTemp,request);
	dwTemp.Style="1";      	     //--设置为Grid风格--
	dwTemp.ReadOnly = "1";	 //只读模式
	dwTemp.setPageSize(20);
	dwTemp.genHTMLObjectWindow("");
	String sButtons[][] = {
			//0、是否展示 1、	权限控制  2、 展示类型 3、按钮显示名称 4、按钮解释文字 5、按钮触发事件代码	6、	7、	8、	9、图标，CSS层叠样式 10、风格
			{"true","","Button","详情","详情","view()","","","","btn_icon_detail",""},
			{"true","","Button","删除","删除","del()","","","","btn_icon_delete",""},
		};
%>
<%@include file="/Frame/resources/include/ui/include_list.jspf"%>
<script type="text/javascript">
/*~[Describe=详情,InputParam=无,OutputParam=无]~*/
function view(){
	var url = "/PIDR/ReportManage/ModifyDataManage/MdfcInfoManage/HpidrRateMdfcFrame.jsp";
	var sessionId = getItemValue(0,getRow(0),'SessionId');// 上报期次
	var customerId = getItemValue(0,getRow(0),'CustomerId');// 客户编号
	var mdfcSgmtCode = getItemValue(0,getRow(0),'MdfcSgmtCode');// 待更正段标
	var params = 'SessionId=' + sessionId + '&CustomerId=' + customerId+'&MdfcSgmtCode='+mdfcSgmtCode;
	if(typeof(sessionId)=="undefined" || sessionId.length==0 ){
		alert("请选择一条记录");
		return ;
	}
	AsDialog.PopView(url,params,'dialogWidth:1000px;dialogHeight:600px',function(){
		reloadSelf();
	});
}

/*~[Describe=删除,InputParam=无,OutputParam=无]~*/
function del(){
	var sessionId = getItemValue(0,getRow(0),'SessionId');// 上报期次
	var customerId = getItemValue(0,getRow(0),'CustomerId');// 客户编号
	var mdfcSgmtCode = getItemValue(0,getRow(0),'MdfcSgmtCode');// 待更正段标
	var finstaYear = getItemValue(0,getRow(0),'FinstaYear');//报表年份
	if(typeof(sessionId)=="undefined" || sessionId.length==0 ){
		alert("请选择一条记录");
		return ;
	}
	if(sessionId != "<%=PIDRConstants.SESSIONID_14%>" ){
		alert("该记录已经生成报文，不可删除");
		return ;
	}
	if(!confirm('确定要删除吗?')){
		return;
	}
	//删除待更正段历史记录
	var retValue = RunJavaMethodTrans("com.amarsoft.app.pidr.mdfc.DeleteRateMdfcInfo", "delMdfcInfo", ",CustomerId=" +customerId + ",MdfcSgmtCode=" + mdfcSgmtCode + ",FinstaYear=" + finstaYear);
	//删除按段更正记录
	if(retValue=="删除成功"){
		as_delete(0);
	}
}
</script>
<%@ include file="/Frame/resources/include/include_end.jspf"%>