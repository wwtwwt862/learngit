<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="/Frame/resources/include/include_begin_list.jspf"%>
<%@ page import="com.amarsoft.app.pidr.common.PIDRConstants"%>
<%--  
	Author: nxxiong
	CreationDate: 2023-02-22
	Description: 综合查询-当期数据-企业评级信息记录-对外投资段信息表列表页面
--%>
<%	
	/*
		Content: 综合查询-当期数据-企业评级信息记录_对外投资段信息表列表页面
		History Log: 
	*/
	ASObjectModel doTemp = new ASObjectModel("PidrRateInvabroinfList");

	//获取参数，设置条件筛选数据
	String customerId = CurPage.getParameter("CustomerId");// 全信息界面传递回来的客户编号
	if(customerId == null) customerId = "";// 从菜单跳转过来置为""
	String flag = CurPage.getParameter("Flag");// 页面复用标志，用来控制list页面jboWhere条件和按钮功能
	if(flag == null) flag = "";
	
	if(PIDRConstants.ALLMSG_FLAG.equals(flag)||PIDRConstants.VALIDATEERROR_FLAG.equals(flag)) {
		doTemp.appendJboWhere("CustomerId = :CustomerId");// 全信息tab页面打开控制显示
	}
	doTemp.appendJboWhere("ManagerOrgId like '"+CurUser.getOrgID()+"%'");// 添加管户机构控制
	
	ASObjectWindow dwTemp = new ASObjectWindow(CurPage,doTemp,request);
	dwTemp.Style="1";      	     //--设置为Grid风格--
	dwTemp.ReadOnly = "1";	 //只读模式
	dwTemp.setPageSize(20);
	dwTemp.setParameter("CustomerId", customerId);
	dwTemp.genHTMLObjectWindow("");
	String sButtons[][] = {
		//0、是否展示 1、	权限控制  2、 展示类型 3、按钮显示名称 4、按钮解释文字 5、按钮触发事件代码	6、	7、	8、	9、图标，CSS层叠样式 10、风格
		{PIDRConstants.ALLMSG_FLAG.equals(flag)?"false":"true","","Button","新增","新增","add()","","","","btn_icon_add",""},
		{PIDRConstants.ALLMSG_FLAG.equals(flag)?"false":"true","","Button","删除","删除","del()","","","","btn_icon_delete",""},
		{"true","","Button","详情","详情","view()","","","","btn_icon_detail",""},
		{PIDRConstants.VALIDATEERROR_FLAG.equals(flag)?"false":"true","","Button","查看历史记录","查看历史记录","seeHis()","","","","btn_icon_check",""},	
		{PIDRConstants.VALIDATEERROR_FLAG.equals(flag)?"false":"true","","Button","按段更正","按段更正","mdfcInfo()","","","","btn_icon_detail",""},
	};
	
%>
<%@include file="/Frame/resources/include/ui/include_list.jspf"%>
<script type="text/javascript" src="<%=sWebRootPath%>/Frame/resources/js/layer.js"></script>
<script type="text/javascript">
	/*~[Describe=新增,InputParam=无,OutputParam=无]~*/
	function add(){
		var url = "/PIDR/IntegatedQueryManage/CurrentDataManage/RateManage/PidrRateInvabroinf/PidrRateInvabroinfInfo.jsp";
		AsDialog.PopView(url,'OperationType=<%=PIDRConstants.OPERATIONTYPE_ADD%>','dialogWidth:1000px;dialogHeight:600px',function(){
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
				var retValue = RunJavaMethodTrans("com.amarsoft.app.pidr.alldlt.PidrCascadeDelete", "deleteRateById", "customerId=" + customerId +",tableName="+'<%=PIDRConstants.TABLE_PIDR_RATE_INVABROINF%>');
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
	function view(){
		var url = "/PIDR/IntegatedQueryManage/CurrentDataManage/RateManage/PidrRateInvabroinf/PidrRateInvabroinfInfo.jsp";
		var relaId = getItemValue(0,getRow(0),'RelaId');// 关联编号
		var customerId = getItemValue(0,getRow(0),'CustomerId');// 客户编号
		var params = 'CustomerId=' + customerId + '&RelaId=' + relaId +'&OperationType=<%=PIDRConstants.OPERATIONTYPE_INFO%>';
		if(typeof(customerId)=="undefined" || customerId.length==0 ){
			alert("请选择一条记录");
			return ;
		}
		AsDialog.PopView(url,params,'dialogWidth:1000px;dialogHeight:600px',function(){
			reloadSelf();
		});
	}
	
	/*~[Describe=查看历史记录,InputParam=无,OutputParam=无]~*/
	function seeHis(){
		var url = "/PIDR/IntegatedQueryManage/HistoryDataManage/RateManage/HPidrRateInvabroinf/HPidrRateInvabroinfList.jsp";
		var customerId = getItemValue(0,getRow(0),'CustomerId');// 客户编号
		var params = 'CustomerId=' + customerId + '&Flag=<%=PIDRConstants.CHECKHIS_FLAG%>';
		if(typeof(customerId)=="undefined" || customerId.length==0 ){
			alert("请选择一条记录");
			return ;
		}
		AsDialog.PopView(url,params,'dialogWidth:1000px;dialogHeight:600px');
	}
	
	/*~[Describe=按段更正,InputParam=无,OutputParam=无]~*/
	function mdfcInfo(){
		var sessionId = getItemValue(0, getRow(0), "SessionId");
		var customerId = getItemValue(0, getRow(0), "CustomerId");
		var managerOrgId = getItemValue(0, getRow(0), "ManagerOrgId");
		if(typeof(sessionId)=="undefined"||sessionId.length==0) {
			alert("请选择一条记录！");
			return;
		}
		var effStatus = getItemValue(0, getRow(0), "EffStatus");
		if(effStatus == '<%=PIDRConstants.EFFSTATUS_0%>'){//无效
			alert("该对外投资无效，不可进行按段更正！");
			return;
		}
		if(!confirm('确定要按段更正吗?')){
			return;
		}
		if(sessionId=="<%=PIDRConstants.SESSIONID_14%>") {
			alert("该记录为需要上报修改的新信息段");
			return;
		}
		var retValue=RunJavaMethodTrans("com.amarsoft.app.pidr.mdfc.ModifyRateInfo","modifyRateInfo",
				"CustomerId=" + customerId + ",MdfcSgmtCode=E, ManagerOrgId=" + managerOrgId + ",CurUserId=<%=CurUser.getUserID()%>,CurOrgId=<%=CurOrg.getOrgID()%>");
		if(retValue!="操作成功") {
			alert(retValue);
			return;
		}
		var url = "/PIDR/ReportManage/ModifyDataManage/MdfcInfoManage/HpidrRateMdfcFrame.jsp";
		var params = 'SessionId=<%=PIDRConstants.SESSIONID_14%>&CustomerId=' + customerId + '&MdfcSgmtCode=E' ;
		AsDialog.PopView(url,params,'dialogWidth:1000px;dialogHeight:600px',function(){
			reloadSelf();	
		});
	}
</script>
<%@ include file="/Frame/resources/include/include_end.jspf"%>