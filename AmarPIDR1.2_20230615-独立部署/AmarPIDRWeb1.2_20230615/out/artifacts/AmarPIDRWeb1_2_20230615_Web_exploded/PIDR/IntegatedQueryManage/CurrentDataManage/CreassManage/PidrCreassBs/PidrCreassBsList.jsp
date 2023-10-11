<%@ page pageEncoding="UTF-8"%>
<%@ include file="/Frame/resources/include/include_begin_list.jspf"%>
<%@ page import="com.amarsoft.app.pidr.common.PIDRConstants"%>
<%--  
	Author:  hcliu 
	CreationDate:2023-02-22
    Description:企业资产信贷信息当期表基础段列表页面
--%>
<%
 	String dueCode = CurPage.getParameter("DueCode");//全信息界面传递回来的借据号
	if(dueCode == null) dueCode = "";
 	String flag = CurPage.getParameter("Flag");//页面显示控制参数，控制JboWhere条件
	if(flag == null) flag = "";
 	String sessionId = CurPage.getParameter("SessionId");//页面显示控制参数，控制JboWhere条件
	if(sessionId == null) sessionId = "";
 	ASObjectModel doTemp = new ASObjectModel("PidrCreassBsList");
 	if(PIDRConstants.ALLMSG_FLAG.equals(flag)||PIDRConstants.VALIDATEERROR_FLAG.equals(flag)){
 		doTemp.appendJboWhere("DueCode = :DueCode");//全信息tab页面打开控制显示
 	}else if(PIDRConstants.FEEDBACK_FLAG.equals(flag)){
		doTemp.appendJboWhere("SessionId = :SessionId and DueCode = :DueCode");// 反馈错误打开控制显示
	}
	doTemp.appendJboWhere("ManagerOrgId like '"+CurUser.getOrgID()+"%'");//添加管户机构控制
	
 	ASObjectWindow dwTemp = new ASObjectWindow(CurPage,doTemp,request);
	dwTemp.Style="1";      //设置为Grid风格
	//填充参数
	dwTemp.setParameter("DueCode",dueCode);
	dwTemp.setParameter("SessionId",sessionId);
	dwTemp.genHTMLObjectWindow("");
	String sButtons[][] = {
			{PIDRConstants.ALLMSG_FLAG.equals(flag)?"false":"true","","Button","新增","新增","add()","","","","btn_icon_add",""},
			{PIDRConstants.ALLMSG_FLAG.equals(flag)?"false":"true","","Button","删除","删除","del()","","","","btn_icon_delete",""},
			{"true","","Button","详情","查看请求详情","view()","","","","btn_icon_detail",""},
			{(PIDRConstants.ALLMSG_FLAG.equals(flag)||PIDRConstants.VALIDATEERROR_FLAG.equals(flag))?"false":"true","","Button","全信息","查看记录全信息，仅基础段展示","allMsg()","","","","btn_icon_check",""},
			{PIDRConstants.VALIDATEERROR_FLAG.equals(flag)?"false":"true","","Button","查看历史记录","查看选中记录的历史报送数据","seeHis()","","","","btn_icon_check",""},
			{PIDRConstants.VALIDATEERROR_FLAG.equals(flag)?"false":"true","","Button","整笔删除","整笔删除","allDltInfo()","","","","btn_icon_detail",""},
			{PIDRConstants.VALIDATEERROR_FLAG.equals(flag)?"false":"true","","Button","标识变更","进行标识变更操作","idChange()","","","","btn_icon_detail",""},
		};
%>
<%@include file="/Frame/resources/include/ui/include_list.jspf"%>
<script type="text/javascript" src="<%=sWebRootPath%>/Frame/resources/js/layer.js"></script>
<script type="text/javascript">
		/*~[Describe=新增,InputParam=无,OutputParam=无]~*/
		function add(){
			var url = "/PIDR/IntegatedQueryManage/CurrentDataManage/CreassManage/PidrCreassBs/PidrCreassBsInfo.jsp";
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
					var retValue = RunJavaMethodTrans("com.amarsoft.app.pidr.alldlt.PidrCascadeDelete", "deleteCreassByDudCode", "dueCode=" + dueCode +",tableName="+'<%=PIDRConstants.TABLE_PIDR_CREASS_BS%>');
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
			var dueCode = getItemValue(0,getRow(), "DueCode");
			if(typeof(dueCode)=="undefined" || dueCode.length==0){
				alert(getMessageText('AWEW1001'));//请选择一条信息！
				return;
			}
			AsDialog.PopView("/PIDR/IntegatedQueryManage/CurrentDataManage/CreassManage/PidrCreassBs/PidrCreassBsInfo.jsp","DueCode="+dueCode+'&OperationType=<%=PIDRConstants.OPERATIONTYPE_INFO%>' , 'dialogWidth:1000px;dialogHeight:600px,title:"详情"',function(){
				 reloadSelf();
			 });
		}
		/*~[Describe=全信息, InputParam=无, OutputParam=无]~*/
		function allMsg(){
			 var url = "/PIDR/IntegatedQueryManage/CurrentDataManage/CreassManage/PidrCreassBs/PidrCreassBsAllMsg.jsp";
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
		/*~[Describe=查看历史记录, InputParam=无, OutputParam=无]~*/
		function seeHis(){
			 var url = "/PIDR/IntegatedQueryManage/HistoryDataManage/CreassManage/PidrCreassBs/HPidrCreassBsList.jsp";
			 var dueCode = getItemValue(0,getRow(0),'DueCode');
			 if(typeof(dueCode)=="undefined" || dueCode.length==0 ){
					alert("请选择一条记录");
					return ;
				 }
			 AsDialog.PopView(url,"DueCode="+dueCode+"&Flag=<%=PIDRConstants.CHECKHIS_FLAG%>",'dialogWidth:1000px;dialogHeight:600px');
		}
		
		
		/*~[Describe=整笔删除, InputParam=无, OutputParam=无]~*/
		function allDltInfo(){
			 var delDueCode = getItemValue(0,getRow(0),'DueCode');// 借据号
			 var delContractCode = getItemValue(0,getRow(0),'ContractCode');// 合同号
			 var inputOrgId = getItemValue(0,getRow(0),'InputOrgId');// 录入机构编号
			 var inputTime = getItemValue(0,getRow(0),'InputTime');// 录入时间
			 var inputUserId = getItemValue(0,getRow(0),'InputUserId');// 录入用户编号
			 var managerOrgId = getItemValue(0,getRow(0),'ManagerOrgId');// 管护机构编号
			 if(typeof(delDueCode)=="undefined" || delDueCode.length==0){
				 alert("请选择一条记录");
				 return;
			 }
			if(confirm('确定要整笔删除吗?')){ 
				 var result =  RunJavaMethodTrans("com.amarsoft.app.pidr.alldlt.PidrAllDelHandler", "addCreAssAllDel", "delDueCode="+delDueCode 
						                                                 + ",delContractCode=" + delContractCode +",inputOrgId="+inputOrgId
						                                                 + ",inputTime=" + inputTime +",inputUserId="+inputUserId);
				 if("SUCCESS" == result){
					 alert("添加整笔删除记录成功，可在报送管理-数据删除管理模块中查看!");
				 }else{
					 alert(result);
				 }
			}
		}
		/*~[Describe=标识变更, InputParam=无, OutputParam=无]~*/
		function idChange(){
			var url = "/PIDR/ReportManage/ModifyDataManage/IDChangeManage/HPidrCreAssIdChangeInfo.jsp";
			var dueCode = getItemValue(0,getRow(0),'DueCode');// 借据号
			var contractCode = getItemValue(0,getRow(0),'ContractCode');// 贷款合同编号
			var mngmtOrgCode = getItemValue(0, getRow(0), "MngmtOrgCode"); 
			var managerOrgId = getItemValue(0, getRow(0), "ManagerOrgId"); 
			var retValue =  RunJavaMethodTrans("com.amarsoft.app.pidr.idchange.PidrIdChangeHandler", "addCreAssIdChange", "oldDueCode="+dueCode
					 +",oldContractCode=" + contractCode+",operationType=<%=PIDRConstants.IDCHANGE_OPERATE_COMP%>");
			if(retValue == "<%=PIDRConstants.IDCHANGE_SAVE_IDCHANGED%>"){
				alert("该客户已存在标识变更记录，不可再次操作");
				return;
		   	} 
			if(!confirm('确定要标识变更吗?')){
				return;
			}
			var params = 'OldDueCode=' + dueCode + '&OldContractCode=' + contractCode 
				+ '&MngmtOrgCode=' + mngmtOrgCode  + '&ManagerOrgId=' + managerOrgId + '&OperationType=<%=PIDRConstants.IDCHANGE_OPERATE_COMP%>';
			AsDialog.PopView(url,params,'dialogWidth:1000px;dialogHeight:600px',function(){
				reloadSelf();
			});
		}
</script>
<%@ include file="/Frame/resources/include/include_end.jspf"%>