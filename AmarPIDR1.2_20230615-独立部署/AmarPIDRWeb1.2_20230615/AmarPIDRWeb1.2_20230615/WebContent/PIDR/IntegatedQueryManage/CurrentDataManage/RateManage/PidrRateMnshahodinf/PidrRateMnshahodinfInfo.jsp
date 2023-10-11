<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="/Frame/resources/include/include_begin_info.jspf"%>
<%@ page import="com.amarsoft.app.pidr.util.ValidateErrors" %>
<%@ page import="com.amarsoft.app.pidr.common.PIDRConstants"%>
<%@ page import="java.util.Date" %>
<%--  
	Author: nxxiong
	CreationDate: 2023-02-22
	Description: 综合查询-当期数据-企业评级信息记录-主要出资人息表详情页面
--%>
<%
	String busiIdSerialNo = CurPage.getParameter("BusiIdSerialNo");//业务标示号
	if(busiIdSerialNo == null) busiIdSerialNo = "";
	String alertErrorKey = CurPage.getParameter("CustomerId");//修改校验错误出现段级错误，使用基础段主键查询
	if(alertErrorKey == null) alertErrorKey = "";
	String errMsg = "";
	HashMap<String, String> map=null;
	if(busiIdSerialNo != null && !PIDRConstants.VALUE_NULL.equals(busiIdSerialNo)) {
		map = ValidateErrors.getErrInfo(PIDRConstants.TABLE_PIDR_RATE_MNSHAHODINF, busiIdSerialNo, Sqlca);
		for(String key : map.keySet()) {//提示信息英文名不用展示
		    errMsg += "错误字段"+map.get(key).substring(map.get(key).indexOf(":"))+"<br/>";
		}
	}else if(PIDRConstants.VALUE_NULL.equals(busiIdSerialNo)) {
		map = ValidateErrors.getNAErrInfo(PIDRConstants.TABLE_PIDR_RATE_MNSHAHODINF, alertErrorKey, Sqlca);
		for(String key : map.keySet()) {//提示信息英文名不用展示
		    errMsg += "错误字段"+map.get(key).substring(map.get(key).indexOf(":"))+"<br/>";
		}
	}
	out.println("<div style='font-weight:bold'>"+errMsg+"</div>");
%>
<%	
	ASObjectModel doTemp = new ASObjectModel("PidrRateMnshahodinfInfo");
	doTemp.setHtmlEvent("SharHodCertType", "onchange", "changeSharHodCertType");  // 给出资人身份类别字段注册事件
	doTemp.setHtmlEvent("SharHodIDType", "onclick", "getSharHodCertType");  // 给出资人身份标识类型字段注册事件
	String flag = CurPage.getParameter("ValidateFlag");//业务标示号
	if(flag == null) flag = "";
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
	// 功能按钮和数据筛选
	String relaId = CurPage.getParameter("RelaId");// 关联编号
	if(relaId == null) relaId = "";
	String customerId = CurPage.getParameter("CustomerId");// 客户编号
	if(customerId == null) customerId = "";
	String operationType = CurPage.getParameter("OperationType");// 区分新增还是详情的标志
	if(operationType == null) operationType = "";
	if(PIDRConstants.OPERATIONTYPE_ADD.equals(operationType)){//新增功能
		doTemp.setReadOnly("*", false);
		doTemp.setReadOnly("SessionId,OccurDate,RecordFlag,ManagerOrgName,ManagerUserName",true);//部分字段初始化给予默认值，只读
	}
	
	doTemp.appendJboWhere("RelaId = :RelaId and CustomerId = :CustomerId");
	if("".equals(customerId))doTemp.setColInnerBtEvent("CustomerID","selectCustomer()");//提供客户号选择基础段已存在的信息
	ASObjectWindow dwTemp = new ASObjectWindow(CurPage,doTemp,request);
	dwTemp.Style="2";      	     //--设置为Grid风格--
	dwTemp.setParameter("RelaId", relaId);
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
			var flag = checkPrimaryKey("PIDR_RATE_MNSHAHODINF","CustomerId@RelaId");//判断新增记录是否已存在
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
		var relaId = getItemValue(0,getRow(0),'RelaId');// 关联编号
		if('<%=operationType%>' == '<%=PIDRConstants.OPERATIONTYPE_ADD%>'){//新增
			alert("新增时\n请确保除对外投资信息段、负面信息段外，其余信息段均有对应记录\n存在对外投资信息、负面信息则在对应信息段新增，不存在可不新增");
			//对于已有主要出资人再次添加时，基础段已有该客户信息，若未更新，需要反向更新
			var retValue = RunJavaMethodTrans("com.amarsoft.app.pidr.integatedquery.PIDRRateUpdateHandler", "reverseUpdate", "CustomerId=" + customerId +",TableName=PIDR_RATE_MNSHAHODINF");
			if("success" == retValue){
				//为了防止页面不关闭继续编辑保存时，会进行数据已存在的提示，故新增保存之后重新打开详情页面，可继续编辑
				var params = 'CustomerId=' + customerId + '&RelaId=' + relaId +'&OperationType=<%=PIDRConstants.OPERATIONTYPE_INFO%>';
				AsControl.OpenView('/PIDR/IntegatedQueryManage/CurrentDataManage/RateManage/PidrRateMnshahodinf/PidrRateMnshahodinfInfo.jsp',
						params,"","");
			}else{
				alert("反向更新记录标志失败！");
			}
		}else{//详情的保存
			var retValue = RunJavaMethodTrans("com.amarsoft.app.pidr.integatedquery.PIDRRateUpdateHandler", "reverseUpdate", "CustomerId=" + customerId +",TableName=PIDR_RATE_MNSHAHODINF");
			if("success" != retValue){
				alert("反向更新记录标志失败！");
			}
			reloadSelf();
		}
	}
	
	/*~[Describe=页面加载处理,InputParam=无,OutputParam=无]~*/
	window.onload = function () {
		var sharHodCertType = getItemValue("0","0","SharHodCertType");
		var sharHodIdType = getItemValue("0","0","SharHodIDType");
		if(sharHodIdType.length != 0 && typeof(sharHodIdType)!='undefined'){
			var params = "codeNo=CertType,subCodeNo=" + sharHodCertType + ",pbCode="+sharHodIdType ;
			changeSelectOptions("SharHodIDType",params); 
		}
	}
	
	/*~[Describe=获取出资人身份类别,InputParam=无,OutputParam=无]~*/
	function getSharHodCertType() {
		var sharHodCertType = getItemValue("0","0","SharHodCertType");
		if ((typeof(sharHodCertType) == 'undefined' || sharHodCertType.length == 0)) {
			alert('请先输入身份类别');
			return ;
		} 
	 } 
	
	/*~[Describe=变更出资人身份类别,InputParam=无,OutputParam=无]~*/
	function changeSharHodCertType() {
		var sharHodCertType = getItemValue("0","0","SharHodCertType");
		if ((typeof(sharHodCertType) == 'undefined' || sharHodCertType.length == 0)) {
			setItemValue(0,0, "SharHodIDType", "" );//身份类别清空，身份标识类型也清空
			changeSelectOptions("SharHodIDType","");//原本身份标识选项清空
			alert('请先输入身份类别');
			return ;
		}
		var params = "codeNo=CertType,subCodeNo="+sharHodCertType;
		changeSelectOptions("SharHodIDType",params);
	}
	
	/*~[Describe=获取码值,InputParam=无,OutputParam=无]~*/
	function changeSelectOptions(selectId,params) {
		var id = "#"+selectId.toUpperCase();
		var result = RunJavaMethodTrans("com.amarsoft.app.pidr.util.SelectOptionsAction","getSelectOptions",params);
		if(result=="NULL") {
			$(id).html("<option value=\"\">---请选择---</option>");
			return;
		}
		var opts = JSON.parse(result);
		var strOpt = "";
		strOpt += "<option value=\""+opts[opts.length-1].PbCode+"\">"+opts[opts.length-1].PbItemName+"</option>";
		for(var i=opts.length-2;i>=0;i--) {
			var opt = opts[i];
			if(opt.PbCode == opts[opts.length-1].PbCode){
				continue;
			}
			strOpt += "<option value=\""+opt.PbCode+"\">"+opt.PbItemName+"</option>";	
		}
		$(id).html(strOpt);
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