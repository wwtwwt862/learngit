<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="/Frame/resources/include/include_begin_list.jspf"%>
<%@ page import="com.amarsoft.app.pidr.common.PIDRConstants" %>
<%--
	Author:kwwu
	CreationDate:2023-02-21
	Description:企业信贷资产信息标识变更列表页面
--%>
<%	  
	ASObjectModel doTemp = new ASObjectModel("PidrCreAssIdChangeList");
	doTemp.appendJboWhere("ManagerOrgId like '"+CurUser.getOrgID()+"%'");//只查看管户机构为当前用户所属机构及其下属机构的记录
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
	 var url = "/PIDR/ReportManage/ModifyDataManage/IDChangeManage/HPidrCreAssIdChangeInfo.jsp";
	AsDialog.PopView(url,'OperationType=<%=PIDRConstants.IDCHANGE_OPERATE_ADD%>','dialogWidth:1000px;dialogHeight:600px',function(){
		reloadSelf();
	});
}

/*~[Describe=详情,InputParam=无,OutputParam=无]~*/
function view(){
	var url = "/PIDR/ReportManage/ModifyDataManage/IDChangeManage/HPidrCreAssIdChangeInfo.jsp";
	var sessionId = getItemValue(0,getRow(0),'SessionId');// 期次号
	var oldDueCode = getItemValue(0,getRow(0),'OldDueCode');// 原借据号
	var oldContractCode = getItemValue(0,getRow(0),'OldContractCode');// 原贷款合同编号
	if(typeof(sessionId)=="undefined" || sessionId.length==0 ){
		alert("请选择一条记录");
		return ;
	}
	var rightType="";
	if("<%=PIDRConstants.SESSIONID_14%>" != sessionId && "<%=PIDRConstants.SESSIONID_14_9%>" != sessionId){//已上报的标识变更记录，详情不可修改
	    rightType="ReadOnly";
	}
	var params = 'RightType='+rightType+'&SessionId=' + sessionId + '&OldDueCode=' + oldDueCode
		+'&OldContractCode='+oldContractCode+'&OperationType=<%=PIDRConstants.IDCHANGE_OPERATE_INFO%>';
	AsDialog.PopView(url,params,'dialogWidth:1000px;dialogHeight:600px',function(){
		reloadSelf();
	});
}

/*~[Describe=删除,InputParam=无,OutputParam=无]~*/
function del(){
	var sessionId = getItemValue(0,getRow(0),'SessionId');// 期次号
	if(typeof(sessionId)=="undefined" || sessionId.length==0 ){
		alert("请选择一条记录");
		return ;
	}
	//标识变更报文存在错误，可删除原标识变更报文重新生成
	<%-- if("<%=PIDRConstants.SESSIONID_14%>" != sessionId){
		alert("该记录已经生成报文，不可删除");
		return ;
	} --%>
	if(!confirm('确定要删除吗?')){
		return;
	}
	as_delete(0);
}
</script>
<%@ include file="/Frame/resources/include/include_end.jspf"%>