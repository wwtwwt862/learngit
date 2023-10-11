<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="/Frame/resources/include/include_begin_list.jspf"%>
<%@ page import="com.amarsoft.app.pidr.common.PIDRConstants"%>
<%--  
	Author: nxxiong
	CreationDate: 2023-02-22
	Description: 综合查询-当期数据-企业评级信息记录-基础段信息表列表页面
--%>
<%	
	ASObjectModel doTemp = new ASObjectModel("PIDRCreditGrade");
	String customerId = CurPage.getParameter("CustomerId");
	if(customerId == null) customerId = "";
	String viewHisFlag = CurPage.getParameter("ViewHisFlag");//1-查看历年评级结果标志
	if(viewHisFlag == null) viewHisFlag = "";
	if(PIDRConstants.VIEW_HIS_FLAG.equals(viewHisFlag)){
		doTemp.appendJboWhere("O.CustomerId = :CustomerId and O.ObjectType = :ObjectType ");
	}else{//默认列表展示客户最新年份评级结果
		doTemp.appendJboWhere(" O.FinStaYear = (select max(per.FinStaYear) from jbo.pidr.PIDR_EVALUATE_RECORD per where per.objectType = O.objectType and per.customerId = O.customerId) " 
			+ " and O.EvaluateScore > :EvaluateScore");
	}
	ASObjectWindow dwTemp = new ASObjectWindow(CurPage,doTemp,request);
	dwTemp.Style="1";      	     //--设置为Grid风格--
	dwTemp.ReadOnly = "1";	 //只读模式
	if(PIDRConstants.VIEW_HIS_FLAG.equals(viewHisFlag)){//查看历年评级结果，不需要多选
		dwTemp.MultiSelect = false;
	}else{
		dwTemp.MultiSelect = true;
	}
	dwTemp.setPageSize(20);
	dwTemp.setParameter("CustomerId", customerId);
	dwTemp.setParameter("EvaluateScore", PIDRConstants.QUALIFIED_EVALUATE_SCORE);
	dwTemp.setParameter("ObjectType", PIDRConstants.EVALUATE_OBJECT_TYPE);
	dwTemp.genHTMLObjectWindow("");
	String sButtons[][] = {
		//0、是否展示 1、	权限控制  2、 展示类型 3、按钮显示名称 4、按钮解释文字 5、按钮触发事件代码	6、	7、	8、	9、图标，CSS层叠样式 10、风格
		{"1".equals(viewHisFlag)?"false":"true","","Button","查看历年评级结果","查看历年评级结果","viewHis()","","","","btn_icon_detail",""},
		{"1".equals(viewHisFlag)?"false":"true","","Button","暂缓上报","暂缓上报","suspendReport()","","","","btn_icon_check",""},
		{"1".equals(viewHisFlag)?"false":"true","","Button","恢复上报","恢复上报","recoverReport()","","","","btn_icon_check",""},
	};
	
%>
<%@include file="/Frame/resources/include/ui/include_list.jspf"%>
<script type="text/javascript">
	/*~[Describe=查看历年评级结果,InputParam=无,OutputParam=无]~*/
	function viewHis(){
		var customerId = getItemValueArray(0,"CustomerId").toString();
		if(customerId.indexOf(",")>-1){//多选
			alert("该操作不可进行多选，请重新选择");
			return;
		}
		if(typeof(customerId)=="undefined" || customerId.length==0 ){
			alert("请勾选一条记录");
			return ;
		}
		var url = "/PIDR/Grade/PidrCreditGrade.jsp";
		AsDialog.PopView(url,'CustomerId=' + customerId + "&ViewHisFlag=1",'dialogWidth:1000px;dialogHeight:600px',function(){
			reloadSelf();
		});
	}
	
	/*~[Describe=暂缓上报,InputParam=无,OutputParam=无]~*/
	function suspendReport(){
		var customerIds = getItemValueArray(0,"CustomerId").toString();//多选的客户编号，以逗号分隔
		var finStaYears = getItemValueArray(0,"FinStaYear").toString();//多选的报表年份，以逗号分隔
		if(typeof(customerIds)=="undefined" || customerIds.length==0 ){
			alert("请至少选择一条记录");
			return ;
		}
		var reportStatus = getItemValueArray(0,"ReportStatus").toString();
		if(reportStatus.indexOf("0")>-1){//多选的记录存在已经处理暂缓的
			alert("多选记录中存在已经处理过暂缓上报的，无需重复操作，请先取消其勾选");
			return;
		}
		customerIds = customerIds.replace(/,/g,"@");//逗号影响参数传递，替换为@
		finStaYears = finStaYears.replace(/,/g,"@");
		if(!confirm("确定暂缓上报吗？")) return;
		var retValue = RunJavaMethodTrans("com.amarsoft.app.pidr.creaditgrade.PIDRCreditGradeHandler", "suspendReport", 
				 "customerIds=" + customerIds + ",finStaYears=" + finStaYears);
		alert(retValue);
		reloadSelf();
	}
	
	/*~[Describe=恢复上报,InputParam=无,OutputParam=无]~*/
	function recoverReport(){
		var customerIds = getItemValueArray(0,"CustomerId").toString();//多选的客户编号，以逗号分隔
		var finStaYears = getItemValueArray(0,"FinStaYear").toString();//多选的报表年份，以逗号分隔
		if(typeof(customerIds)=="undefined" || customerIds.length==0 ){
			alert("请至少选择一条记录");
			return ;
		}
		var reportStatus = getItemValueArray(0,"ReportStatus").toString();
		if(reportStatus.indexOf("1")>-1){//多选的记录存在已经是正常上报的
			alert("多选记录中存在已经是正常上报的，无需重复操作，请先取消其勾选");
			return;
		}
		customerIds = customerIds.replace(/,/g,"@");//逗号影响参数传递，替换为@
		finStaYears = finStaYears.replace(/,/g,"@");
		if(!confirm("确定恢复上报吗？")) return;
		var retValue = RunJavaMethodTrans("com.amarsoft.app.pidr.creaditgrade.PIDRCreditGradeHandler", "recoverReport", 
				 "customerIds=" + customerIds + ",finStaYears=" + finStaYears);
		alert(retValue);
		reloadSelf();
	}
</script>
<%@ include file="/Frame/resources/include/include_end.jspf"%>