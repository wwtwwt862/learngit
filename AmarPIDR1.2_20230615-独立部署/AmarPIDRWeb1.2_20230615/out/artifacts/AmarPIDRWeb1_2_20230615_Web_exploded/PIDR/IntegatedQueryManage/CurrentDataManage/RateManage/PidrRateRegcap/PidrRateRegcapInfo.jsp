<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="/Frame/resources/include/include_begin_info.jspf"%>
<%@ page import="com.amarsoft.app.pidr.common.PIDRConstants"%>
<%@ page import="java.util.Date" %>
<%--  
	Author: nxxiong
	CreationDate: 2023-02-22
	Description: 综合查询-当期数据-企业评级信息记录-注册资本信息表详情页面
--%>
<%	
	ASObjectModel doTemp = new ASObjectModel("PidrRateRegcapInfo");

	// 功能按钮和数据筛选
	String customerId = CurPage.getParameter("CustomerId");// 客户编号
	if(customerId == null) customerId = "";
	
	doTemp.appendJboWhere("CustomerId = :CustomerId");
	String operationType = CurPage.getParameter("OperationType");// 区分新增还是详情的标志
	if(operationType == null) operationType = "";
	if(PIDRConstants.OPERATIONTYPE_ADD.equals(operationType)){//新增功能
		doTemp.setReadOnly("*", false);
		doTemp.setReadOnly("SessionId,OccurDate,RecordFlag,ManagerOrgName,ManagerUserName",true);//部分字段初始化给予默认值，只读
	}
	if("".equals(customerId))doTemp.setColInnerBtEvent("CustomerID","selectCustomer()");//提供客户号选择基础段已存在的信息
	ASObjectWindow dwTemp = new ASObjectWindow(CurPage,doTemp,request);
	dwTemp.Style="2";      	     //--设置为Grid风格--
	dwTemp.setParameter("CustomerId", customerId);
	dwTemp.genHTMLObjectWindow("");

	//0、是否展示 1、	权限控制  2、 展示类型 3、按钮显示名称 4、按钮解释文字 5、按钮触发事件代码	6、	7、	8、	9、图标，CSS层叠样式 10、风格
	String sButtons[][] = {
		{"true","","Button","保存","保存记录","saveRecord()","","","","",""},
	};
%>
<%@include file="/Frame/resources/include/ui/include_info.jspf"%>
<script type="text/javascript">
    var oldCustomerId = getItemValue(0,getRow(0),'CustomerId');
	/*~[Describe=选择客户号,InputParam=无,OutputParam=无]~*/
	function selectCustomer(){
	    AsDialog.SelectGridValue("PidrRateBsList","", "CustomerId@FinStaYear@SheetType@SheetTypeDivide", null,false, "", 
	            function(sReturn){
	        if(typeof(sReturn) != "undefined" &&  sReturn!="_CLEAR_" && sReturn.length != 0 ){
	            sReturn = sReturn.split('@');
	            var customerId = sReturn[0];
	            setItemValue(0,0,"CustomerId",customerId);
	        }
	    });
	}
	/*~[Describe=保存,InputParam=无,OutputParam=无]~*/
	function saveRecord(){
		var customerId = getItemValue(0,getRow(0),'CustomerId');// 客户编号
		if('<%=operationType%>' == '<%=PIDRConstants.OPERATIONTYPE_ADD%>'){//新增操作打开页面
			var flag = checkPrimaryKey("PIDR_RATE_REGCAP","CustomerId");//判断新增记录是否已存在
			if(flag){
				alert("该客户信息已存在，不可再次新增！");
				AsDialog.ClosePage();
				return;
			}
		}
		var recordFlag = getItemValue(0,getRow(0),'RecordFlag');// 记录标志
        if(isUserChanged() || getItemValue(0,getRow(0),'CustomerId') != oldCustomerId){//页面是否发生变化
			if(confirm("确定保存吗？")){
				if(recordFlag == '<%=PIDRConstants.RECORDFLAG_R%>'){//页面编辑修改后，若原本记录标志为R，需要修改记录标志
					setItemValue(0,0, "RecordFlag", "<%=PIDRConstants.RECORDFLAG_U%>" );
				}
				as_save(0,"handle()");//新增页面，保存之后的操作
			}
		}else{
			alert("页面信息未变化，无需保存");
		}
	}
	
	/*~[Describe=保存之后的操作,InputParam=无,OutputParam=无]~*/
	function handle(){
		var customerId = getItemValue(0,getRow(0),'CustomerId');// 客户编号
		if('<%=operationType%>' == '<%=PIDRConstants.OPERATIONTYPE_ADD%>'){//新增
			alert("新增时\n请确保除对外投资信息段、负面信息段外，其余信息段均有对应记录\n存在对外投资信息、负面信息则在对应信息段新增，不存在可不新增");
			//为了防止页面不关闭继续编辑保存时，会进行数据已存在的提示，故新增保存之后重新打开详情页面，可继续编辑
			var params = 'CustomerId=' + customerId +'&OperationType=<%=PIDRConstants.OPERATIONTYPE_INFO%>';
			AsControl.OpenView('/PIDR/IntegatedQueryManage/CurrentDataManage/RateManage/PidrRateRegcap/PidrRateRegcapInfo.jsp',
					params,"","");
		}else{//详情的保存
			var retValue = RunJavaMethodTrans("com.amarsoft.app.pidr.integatedquery.PIDRRateUpdateHandler", "reverseUpdate", "CustomerId=" + customerId +",TableName=PIDR_RATE_REGCAP");
			if("success" != retValue){
				alert("反向更新记录标志失败！");
			}
			reloadSelf();
		}
	}
	
	/*~[Describe=新增时初始化数据,InputParam=无,OutputParam=无]~*/
	function initRow() {
		if(getRowCount(0) == 0) {//新增
			setItemValue(0,getRow(),"SessionId","<%=PIDRConstants.SESSIONID_16%>");  
			setItemValue(0,getRow(),"OccurDate","<%=DateX.format(new Date(), "yyyy-MM-dd")%>"); 
			setItemValue(0,getRow(),"RecordFlag","<%=PIDRConstants.RECORDFLAG_A%>"); 
			setItemValue(0,getRow(),"ManagerOrgID","<%=CurUser.getOrgID()%>"); 
			setItemValue(0,getRow(),"ManagerOrgName","<%=CurUser.getOrgName()%>");
			setItemValue(0,getRow(),"ManagerUserID","<%=CurUser.getUserID()%>");
			setItemValue(0,getRow(),"ManagerUserName","<%=CurUser.getUserName()%>");
		}
	}
	initRow();
</script>
<%@ include file="/Frame/resources/include/include_end.jspf"%>