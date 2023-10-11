<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="/Frame/resources/include/include_begin_info.jspf"%>
<%@ page import="com.amarsoft.app.pidr.util.ValidateErrors" %>
<%@ page import="com.amarsoft.app.pidr.common.PIDRConstants"%>
<%@ page import="java.util.Date" %>
<%--  
	Author: hlsong
	CreationDate:2023-04-18
    Description:企业评级信息  接口数据-主要出资人息表详情页面
--%>
<%	
	ASObjectModel doTemp = new ASObjectModel("PidrIntMnshahodInfoInfo");
	doTemp.setHtmlEvent("SharHodCertType", "onchange", "changeSharHodCertType");  // 给出资人身份类别字段注册事件
	doTemp.setHtmlEvent("SharHodIDType", "onclick", "getSharHodCertType");  // 给出资人身份标识类型字段注册事件
	String flag = CurPage.getParameter("ValidateFlag");//业务标示号
	if(flag == null) flag = "";
	if(PIDRConstants.VALIDATEERROR_FLAG.equals(flag)){
		doTemp.setReadOnly("*", true);		
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
		doTemp.setReadOnly("SessionId,CustomerId",true);//部分字段初始化给予默认值，只读
	}
	doTemp.setHtmlEvent("SharHodCertType", "onchange", "changeSharHodCertType");  // 给出资人身份类别字段注册事件
    doTemp.setHtmlEvent("SharHodIDType", "onclick", "getSharHodCertType");  // 给出资人身份标识类型字段注册事件
    
	doTemp.appendJboWhere("RelaId = :RelaId and CustomerId = :CustomerId");
	
	ASObjectWindow dwTemp = new ASObjectWindow(CurPage,doTemp,request);
	dwTemp.Style="2";      	     //--设置为Grid风格--
	dwTemp.setParameter("RelaId", relaId);
	dwTemp.setParameter("CustomerId", customerId);
	dwTemp.genHTMLObjectWindow("");

	//0、是否展示 1、	权限控制  2、 展示类型 3、按钮显示名称 4、按钮解释文字 5、按钮触发事件代码	6、	7、	8、	9、图标，CSS层叠样式 10、风格
	String sButtons[][] = {
		{"true","","Button","保存","保存记录","if(confirm('确实要保存吗?'))as_save(0)","","","","",""},
	};
%>
<%@include file="/Frame/resources/include/ui/include_info.jspf"%>
<script type="text/javascript">
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
	
</script>
<%@ include file="/Frame/resources/include/include_end.jspf"%>