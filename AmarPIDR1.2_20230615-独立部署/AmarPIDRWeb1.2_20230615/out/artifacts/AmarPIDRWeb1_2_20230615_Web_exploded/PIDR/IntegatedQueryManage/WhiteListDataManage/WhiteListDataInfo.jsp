<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="/Frame/resources/include/include_begin_info.jspf"%>
<%@ page import="java.util.Date" %>
<%	
	/*
		白名单数据管理-新增/详情页面
		@author :hcliu
		@date: 2023-05-05
	*/
	
    String operationType = CurPage.getParameter("operationType");//操作类型  详情/新增
    if(operationType == null) operationType = "";
    String customerID = CurPage.getParameter("CustomerID");//操作类型  详情/新增
    if(customerID == null) customerID = "";
	ASObjectModel doTemp = new ASObjectModel("PidrWhiteDataInfo");
	if("Add".equals(operationType)){//如果是作为新增页面打开
		doTemp.setReadOnly("CustomerID", false);
		doTemp.setVisible("RunTime", false);
		doTemp.setDefaultValue("RunStatus", "00");
	}else if("Info".equals(operationType)){
		doTemp.appendJboWhere("CustomerID = :CustomerID");
	}
	ASObjectWindow dwTemp = new ASObjectWindow(CurPage,doTemp,request);
	dwTemp.Style="2";      	     //--设置为Grid风格--
	 if("Info".equals(operationType)){//如果是作为详情页面打开，则页面只读
		dwTemp.setParameter("CustomerID" , customerID);
	}
	dwTemp.genHTMLObjectWindow("");
	//0、是否展示 1、	权限控制  2、 展示类型 3、按钮显示名称 4、按钮解释文字 5、按钮触发事件代码	6、	7、	8、	9、图标，CSS层叠样式 10、风格
	String sButtons[][] = {
			{"Add".equals(operationType)?"true":"false","","Button","保存","保存新增记录","save()","","","",""},
			{"Info".equals(operationType)?"true":"false","","Button","保存","保存修改记录","edit()","","","",""}
	};
%>
<%@include file="/Frame/resources/include/ui/include_info.jspf"%>
<script type="text/javascript">
/*~[Describe=保存新增记录,InputParam=无,OutputParam=无]~*/
function save(){
	var customerId = getItemValue(0,getRow(0),'CustomerID'); //客户编号
	var entName = getItemValue(0,getRow(0),'EntName'); // 企业名称
	var entCertType = getItemValue(0,getRow(0),'EntCertType');// 企业证件类型
	var entCertNum = getItemValue(0,getRow(0),'EntCertNum');// 企业证件号码	 
	var PBCEvalScore = getItemValue(0,getRow(0),'PBCEvalScore');//人行评估得分
	if(typeof(customerId)=="undefined" || customerId.length==0){
		 alert("客户编号不能为空");
		 return;
	 }
	 var result = RunJavaMethodTrans("com.amarsoft.app.pidr.whitelist.PidrWhiteListHandler", "saveRecord", "CustomerID="+customerId
			 +",EntName=" + entName
			 +",EntCertType=" + entCertType 
             +",EntCertNum=" + entCertNum 
             +",PBCEvalScore=" + PBCEvalScore);

	 if("SUCCESS" == result){
		 alert("新增白名单客户记录成功!");
	 }else{
		 alert(result);
	 }
	 AsDialog.ClosePage();
}
/*~[Describe=保存新增记录,InputParam=无,OutputParam=无]~*/
function edit(){
	as_save(0);
}
</script>
<%@ include file="/Frame/resources/include/include_end.jspf"%>