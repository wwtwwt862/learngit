<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="/Frame/resources/include/include_begin_list.jspf"%>
<%@ page import="com.amarsoft.app.pidr.common.PIDRConstants"%>
<%--  
	Author: swpeng
	CreationDate: 2023-04-20
	Description: 综合查询-接口数据-对外投资段信息表列表页面
--%>
<%	
	/*
		Content: 综合查询-接口数据-企业评级信息记录_对外投资段信息表列表页面
		History Log: 
	*/
	ASObjectModel doTemp = new ASObjectModel("PidrIntInvabroInfoList");
	doTemp.appendJboWhere("ManagerOrgId like '"+CurUser.getOrgID()+"%'");// 添加管户机构控制
	ASObjectWindow dwTemp = new ASObjectWindow(CurPage,doTemp,request);
	dwTemp.Style="1";      	     //--设置为Grid风格--
	dwTemp.ReadOnly = "1";	 //只读模式
	dwTemp.setPageSize(20);
	dwTemp.genHTMLObjectWindow("");
	String sButtons[][] = {
		//0、是否展示 1、	权限控制  2、 展示类型 3、按钮显示名称 4、按钮解释文字 5、按钮触发事件代码	6、	7、	8、	9、图标，CSS层叠样式 10、风格
		{"true","","Button","详情","详情","view()","","","","btn_icon_detail",""},
		{"true","","Button","删除","删除","if(confirm('确定删除吗？')) as_delete(0)","","","","btn_icon_delete",""},
	};
	
%>
<%@include file="/Frame/resources/include/ui/include_list.jspf"%>
<script type="text/javascript" src="<%=sWebRootPath%>/Frame/resources/js/layer.js"></script>
<script type="text/javascript">
	/*~[Describe=详情,InputParam=无,OutputParam=无]~*/
	function view(){
		var url = "/PIDR/IntegatedQueryManage/IntDataManage/PidrIntInvabroinf/PidrIntInvabroinfInfo.jsp";
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
	
</script>
<%@ include file="/Frame/resources/include/include_end.jspf"%>