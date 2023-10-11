<%@ page pageEncoding="UTF-8"%>
<%@ include file="/Frame/resources/include/include_begin_list.jspf"%>
<%@ page import="com.amarsoft.app.pidr.common.PIDRConstants"%>
<%--  
	Author:  hcliu 
	CreationDate:2023-02-22
    Description:企业资产信贷信息基本信息段列表页面
--%>
<%
	String dueCode = CurPage.getParameter("DueCode");//全信息界面传递回来的借据号
	if(dueCode == null) dueCode = "";
	String flag = CurPage.getParameter("Flag");//全信息界面传递的标志，用来控制list页面jboWhere条件，1-显示，2-不显示（默认）
	if(flag == null) flag = "";
 	String sessionId = CurPage.getParameter("SessionId");//页面显示控制参数，控制JboWhere条件
	if(sessionId == null) sessionId = "";
 	ASObjectModel doTemp = new ASObjectModel("PidrCreassFsinfList");
 	if(PIDRConstants.ALLMSG_FLAG.equals(flag)||PIDRConstants.VALIDATEERROR_FLAG.equals(flag))	{
 		doTemp.appendJboWhere("DueCode = :DueCode");//全信息tab页面打开控制显示
 	}else if( PIDRConstants.FEEDBACK_FLAG.equals(flag)){
		doTemp.appendJboWhere("SessionId = :SessionId and DueCode = :DueCode");// 反馈错误打开控制显示
	}
	doTemp.appendJboWhere("ManagerOrgId like '"+CurUser.getOrgID()+"%'");//添加管户机构控制

 	ASObjectWindow dwTemp = new ASObjectWindow(CurPage,doTemp,request);
	dwTemp.Style="1";      //设置为Grid风格
	dwTemp.setParameter("DueCode",dueCode);
	dwTemp.setParameter("SessionId",sessionId);
	dwTemp.genHTMLObjectWindow("");
	String sButtons[][] = {
			{PIDRConstants.ALLMSG_FLAG.equals(flag)?"false":"true","","Button","新增","新增","add()","","","","btn_icon_add",""},
			{PIDRConstants.ALLMSG_FLAG.equals(flag)?"false":"true","","Button","删除","删除","del()","","","","btn_icon_delete",""},
			{"true","","Button","详情","查看请求详情","view()","","","","btn_icon_detail",""},
			{PIDRConstants.VALIDATEERROR_FLAG.equals(flag)?"false":"true","","Button","查看历史记录","查看选中记录的历史报送数据","seeHis()","","","","btn_icon_check",""},
		};
%>
<%@include file="/Frame/resources/include/ui/include_list.jspf"%>
<script type="text/javascript" src="<%=sWebRootPath%>/Frame/resources/js/layer.js"></script>
<script type="text/javascript">
		/*~[Describe=新增,InputParam=无,OutputParam=无]~*/
		function add(){
			var url = "/PIDR/IntegatedQueryManage/CurrentDataManage/CreassManage/PidrCreassFsinf/PidrCreassFsinfInfo.jsp";
			AsDialog.PopView(url,'OperationType=<%=PIDRConstants.OPERATIONTYPE_ADD%>','dialogWidth:1000px;dialogHeight:600px',function(){
				reloadSelf();
			});
		}
		/*~[Describe=删除,InputParam=无,OutputParam=无]~*/
		function del(){
			var dueCode = getItemValue(0,getRow(0),'DueCode');// 借据号
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
					var retValue = RunJavaMethodTrans("com.amarsoft.app.pidr.alldlt.PidrCascadeDelete", "deleteCreassByDudCode", "dueCode=" + dueCode +",tableName="+'<%=PIDRConstants.TABLE_PIDR_CREASS_FSINF%>');
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
					var retValue = RunJavaMethodTrans("com.amarsoft.app.pidr.alldlt.PidrCascadeDelete", "deleteCreassAll", "dueCode=" + dueCode);
					alert(retValue);
					layer.close(index);
					reloadSelf();	
				}
			});
		}
		/*~[Describe=详情, InputParam=无, OutputParam=无]~*/
		function view(){
			var dueCode = getItemValue(0,getRow(), "dueCode");
			if(typeof(dueCode)=="undefined" || dueCode.length==0){
				alert(getMessageText('AWEW1001'));//请选择一条信息！
				return;
			}
			AsDialog.PopView("/PIDR/IntegatedQueryManage/CurrentDataManage/CreassManage/PidrCreassFsinf/PidrCreassFsinfInfo.jsp","DueCode="+dueCode +'&OperationType=<%=PIDRConstants.OPERATIONTYPE_INFO%>', 'dialogWidth:1000px;dialogHeight:600px;title:"详情"',function(){
				reloadSelf();
			});
		}
		/*~[Describe=查看历史记录, InputParam=无, OutputParam=无]~*/
		function seeHis(){
			 var url = "/PIDR/IntegatedQueryManage/HistoryDataManage/CreassManage/PidrCreassFsinf/HPidrCreassFsinfList.jsp";
			 var dueCode = getItemValue(0,getRow(0),'dueCode');
			 if(typeof(dueCode)=="undefined" || dueCode.length==0 ){
					alert("请选择一条记录");
					return ;
				 }
			 AsDialog.PopView(url,"DueCode="+dueCode+"&Flag=<%=PIDRConstants.CHECKHIS_FLAG%>",'dialogWidth:1000px;dialogHeight:600px');
		}
		
</script>
<%@ include file="/Frame/resources/include/include_end.jspf"%>