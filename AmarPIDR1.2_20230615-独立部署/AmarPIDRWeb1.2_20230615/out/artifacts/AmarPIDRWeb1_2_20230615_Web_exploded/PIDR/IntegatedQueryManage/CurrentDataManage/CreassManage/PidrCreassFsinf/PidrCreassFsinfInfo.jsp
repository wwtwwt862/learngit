<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="com.amarsoft.app.pidr.util.ValidateErrors" %>
<%@ include file="/Frame/resources/include/include_begin_info.jspf"%>
<%@ page import="com.amarsoft.app.pidr.common.PIDRConstants"%>
<%@ page import="java.util.Date" %>
<%--  
	Author:  hcliu 
	CreationDate:2023-02-22
    Description:企业资产信贷信息当期表基本信息段详情页面
--%>
<%
	String busiIdSerialNo = CurPage.getParameter("BusiIdSerialNo");//业务标示号
	if(busiIdSerialNo == null) busiIdSerialNo = "";
	String alertErrorKey = CurPage.getParameter("DueCode");//修改校验错误出现段级错误，使用基础段主键查询
	if(alertErrorKey == null) alertErrorKey = "";

	String errMsg = "";
	HashMap<String, String> map=null;
	if(busiIdSerialNo != null && !PIDRConstants.VALUE_NULL.equals(busiIdSerialNo)) {
		map = ValidateErrors.getErrInfo(PIDRConstants.TABLE_PIDR_CREASS_FSINF, busiIdSerialNo, Sqlca);
		for(String key : map.keySet()) {//提示信息英文名不用展示
		    errMsg += "错误字段"+map.get(key).substring(map.get(key).indexOf(":"))+"<br/>";
		}
	}else if(PIDRConstants.VALUE_NULL.equals(busiIdSerialNo)) {
		map = ValidateErrors.getNAErrInfo(PIDRConstants.TABLE_PIDR_CREASS_FSINF, alertErrorKey, Sqlca);
		for(String key : map.keySet()) {//提示信息英文名不用展示
		    errMsg += "错误字段"+map.get(key).substring(map.get(key).indexOf(":"))+"<br/>";
		}
	}
	out.println("<div style='font-weight:bold'>"+errMsg+"</div>");
%>
<%	
	String dueCode = CurPage.getParameter("DueCode");
	if(dueCode == null) dueCode = "";
	ASObjectModel doTemp = new ASObjectModel("PidrCreassFsinfInfo");
	String flag = CurPage.getParameter("ValidateFlag");//业务标示号
	if(PIDRConstants.VALIDATEERROR_FLAG.equals(flag)){
		doTemp.setReadOnly("*", true);		
	}
	if(busiIdSerialNo != null && map != null) {
		for(String key : map.keySet()) {
		    String msg=map.get(key);//获取提示信息集
            String field = msg.substring(4,msg.indexOf(":"));//获取提示信息中的错误字段英文名
            String[] fieldArr = field.split("@");//字段名可能有多个，均要标红
            for(int i = 0;i<fieldArr.length;i++){
	            doTemp.setHTMLStyle(fieldArr[i],"style={border:1px solid red}");//把所有的错误字段红框标出
	            doTemp.setReadOnly(fieldArr[i], false);
	        }
		}
	}
	String operationType = CurPage.getParameter("OperationType");// 区分新增还是详情的标志
	if(operationType == null) operationType = "";
	if(PIDRConstants.OPERATIONTYPE_ADD.equals(operationType)){//新增功能
		doTemp.setReadOnly("*", false);
		doTemp.setReadOnly("SessionId,OccurDate,OpenDate,DueDate,LatRpyDate,RecordFlag,ManagerOrgName,ManagerUserName",true);//部分字段初始化给予默认值，只读
	}
	doTemp.appendJboWhere("DueCode = :DueCode");
    if("".equals(dueCode))doTemp.setColInnerBtEvent("DueCode","selectDueCode()");//提供客户号选择基础段已存在的信息
	ASObjectWindow dwTemp = new ASObjectWindow(CurPage,doTemp,request);
	dwTemp.Style="2";     //设置为Grid风格
	dwTemp.MultiSelect = false; //不允许多选
	dwTemp.setParameter("DueCode", dueCode);
	dwTemp.genHTMLObjectWindow("");
	
	String sButtons[][] = {
		{"true","","Button","保存","保存记录","saveRecord()","","","","",""},
	};
%>
<%@ include file="/Frame/resources/include/ui/include_info.jspf"%>
<script type="text/javascript">
    var oldDueCode = getItemValue(0,getRow(0),'DueCode');
    /*~[Describe=选择客户号,InputParam=无,OutputParam=无]~*/
    function selectDueCode(){
        AsDialog.SelectGridValue("PidrCreassBsList","", "DueCode", null,false, "", 
                function(sReturn){
            if(typeof(sReturn) != "undefined" &&  sReturn!="_CLEAR_" && sReturn.length != 0 ){
                sReturn = sReturn.split('@');
                var oldDueCode = sReturn[0];
                setItemValue(0,0,"DueCode",oldDueCode);
            }
        });
    }
   var openDate = getItemValue(0,getRow(0),'OpenDate');//贷款发放日字段的值（isUserChanged()无法判断使用内置按钮选择日期方法下值的变化）
   var dueDate = getItemValue(0,getRow(0),'DueDate');//贷款到期日字段的值（isUserChanged()无法判断使用内置按钮选择日期方法下值的变化）
   var latRpyDate = getItemValue(0,getRow(0),'LatRpyDate');//最近一次还款日期字段的值（isUserChanged()无法判断使用内置按钮选择日期方法下值的变化）
	/*~[Describe=保存并返回;InputParam=无;OutPutParam=无;]~*/
	function saveRecord(){
		var dueCode = getItemValue(0,getRow(0),'DueCode');// 借据号
		if('<%=operationType%>' == '<%=PIDRConstants.OPERATIONTYPE_ADD%>'){//新增操作打开页面
			var flag = checkPrimaryKey("PIDR_CREASS_FSINF","DueCode");//判断新增记录是否已存在
			if(flag){
				alert("该信贷资产信息已存在，不可再次新增！");
				AsDialog.ClosePage();
				return;
			}
		}
		//日期
		var recordFlag = getItemValue(0,getRow(0),'OpenDate');// 记录标志  
		var recordFlag = getItemValue(0,getRow(0),'DueDate');// 记录标志
		var recordFlag = getItemValue(0,getRow(0),'LatRpyDate');// 记录标志
		var recordFlag = getItemValue(0,getRow(0),'RecordFlag');// 记录标志
		if(isUserChanged() || getItemValue(0,getRow(0),'OpenDate') != openDate 
				|| getItemValue(0,getRow(0),'DueDate') != dueDate || getItemValue(0,getRow(0),'LatRpyDate') != latRpyDate){//页面是否发生变化
			if(confirm("确定保存吗？")){
				if(recordFlag == '<%=PIDRConstants.RECORDFLAG_R%>'){//页面编辑修改后，若原本记录标志为R，需要修改记录标志
					setItemValue(0,0, "RecordFlag", "<%=PIDRConstants.RECORDFLAG_U%>" );
				}
				//保存前将日期格式整成YYYY-MM-dd
				//setItemValue(0,getRow(),"SessionId","<%=PIDRConstants.SESSIONID_16%>"); 
				
				as_save(0,"handle()");//新增页面，保存之后的操作
			}
		}else{
			alert("页面信息未变化，无需保存");
		}
	} 
	/*~[Describe=保存之后的操作,InputParam=无,OutputParam=无]~*/
	function handle(){
		var dueCode = getItemValue(0,getRow(0),'DueCode');// 借据号
		if('<%=operationType%>' == '<%=PIDRConstants.OPERATIONTYPE_ADD%>'){//新增
			alert("新增时请确保基础段存在相应的记录");
			//为了防止页面不关闭继续编辑保存时，会进行数据已存在的提示，故新增保存之后重新打开详情页面，可继续编辑
			var params = 'DueCode=' + dueCode +'&OperationType=<%=PIDRConstants.OPERATIONTYPE_INFO%>';
			AsControl.OpenView('/PIDR/IntegatedQueryManage/CurrentDataManage/CreassManage/PidrCreassFsinf/PidrCreassFsinfInfo.jsp',
					params,"","");
		}else{//基本信息段更新，基础段未更新，需要反向更新基础段
			var retValue = RunJavaMethodTrans("com.amarsoft.app.pidr.integatedquery.PIDRCreassUpdateHandler", "reverseUpdate", "DueCode=" + dueCode + ",TableName=PIDR_CREASS_BS");
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
