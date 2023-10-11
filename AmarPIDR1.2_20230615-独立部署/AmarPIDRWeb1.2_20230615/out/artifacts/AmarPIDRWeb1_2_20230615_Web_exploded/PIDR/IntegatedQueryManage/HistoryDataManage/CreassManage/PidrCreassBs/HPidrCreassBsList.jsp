<%@ page pageEncoding="UTF-8"%>
<%@ include file="/Frame/resources/include/include_begin_list.jspf"%>
<%@ page import="com.amarsoft.app.pidr.common.PIDRConstants"%>
<%--  
	Author:  hcliu 
	CreationDate:2023-02-22
    Description:企业资产信贷信息历史表基础段列表页面
--%>
<%
 	String dueCode = CurPage.getParameter("DueCode");//全信息界面||当期表传递回来的借据号
	if(dueCode == null) dueCode = "";
 	String flag = CurPage.getParameter("Flag");//页面显示控制参数
	if(flag == null) flag = "";
	String fNo = CurPage.getParameter("fNo");//反馈处理编号
	if(fNo == null) fNo = "";
	String messageType = CurPage.getParameter("MessageType");//报文类型
	if(messageType == null) messageType = "";
	String sessionId = CurPage.getParameter("SessionId");
	if(sessionId == null) sessionId = "";
	String rightType = CurPage.getParameter("RightType");// 页面只读控制
	if(rightType == null) rightType = "ReadOnly";
	
 	ASObjectModel doTemp = new ASObjectModel("HPidrCreassBsList");
 	if(PIDRConstants.ALLMSG_FLAG.equals(flag)){
 		doTemp.appendJboWhere("DueCode = :DueCode");//全信息页面打开控制显示
 	}else if(PIDRConstants.CHECKHIS_FLAG.equals(flag)){
 		doTemp.appendJboWhere("DueCode = :DueCode");//查看历史打开控制显示
 	}else if( PIDRConstants.FEEDBACK_FLAG.equals(flag)){
		doTemp.appendJboWhere("SessionId = :SessionId and DueCode = :DueCode");// 反馈错误打开控制显示
	}
	doTemp.appendJboWhere("ManagerOrgId like '"+CurUser.getOrgID()+"%'");//添加管户机构控制

 	ASObjectWindow dwTemp = new ASObjectWindow(CurPage,doTemp,request);
	dwTemp.Style="1";      //设置为Grid风格
	dwTemp.setParameter("SessionId", sessionId);
	dwTemp.setParameter("DueCode", dueCode);
	dwTemp.genHTMLObjectWindow("");
	String sButtons[][] = {
			{"true","","Button","详情","查看请求详情","view()","","","","btn_icon_detail",""},
			{PIDRConstants.ALLMSG_FLAG.equals(flag)||PIDRConstants.FEEDBACK_FLAG.equals(flag)?"false":"true","","Button","全信息","查看记录全信息，仅基础段展示","allMsg()","","","","btn_icon_check",""},
		};
%>
<%@include file="/Frame/resources/include/ui/include_list.jspf"%>
<script type="text/javascript">
		/*~[Describe=详情, InputParam=无, OutputParam=无]~*/
		function view(){
			var dueCode = getItemValue(0,getRow(), "dueCode");
			var fNo = "<%=fNo%>";
			var messageType = "<%=messageType%>";
			if(typeof(dueCode)=="undefined" || dueCode.length==0){
				alert(getMessageText('AWEW1001'));//请选择一条信息！
				return;
			}
			AsDialog.PopView("/PIDR/IntegatedQueryManage/HistoryDataManage/CreassManage/PidrCreassBs/HPidrCreassBsInfo.jsp","DueCode="+dueCode+"&fNo="+fNo+"&MessageType="+messageType+ '&RightType=<%=rightType%>' , 'dialogWidth:1000px;dialogHeight:600px',function(){
				reloadSelf();
			});
		}
		/*~[Describe=全信息, InputParam=无, OutputParam=无]~*/
		function allMsg(){
			 var url = "/PIDR/IntegatedQueryManage/HistoryDataManage/CreassManage/PidrCreassBs/HPidrCreassBsAllMsg.jsp";
			 var dueCode = getItemValue(0,getRow(0),'DueCode');
			 if(dueCode == null){
				 dueCode = "";
			 }
			 if(typeof(dueCode)=="undefined" || dueCode.length==0 ){
					alert("请选择一条记录");
					return ;
				 }
			 AsDialog.PopView(url,'DueCode='+dueCode ,'_self','');
		}
</script>
<%@ include file="/Frame/resources/include/include_end.jspf"%>