<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="/Frame/resources/include/include_begin_list.jspf"%>
<%@ page import="com.amarsoft.app.pidr.common.PIDRConstants"%>
<%--  
	Author: nxxiong
	CreationDate: 2023-02-22
	Description: 综合查询-历史数据-企业评级信息记录-主要负责人段信息表列表页面
--%>
<%	
	ASObjectModel doTemp = new ASObjectModel("PidrRateLegrepinfList");
	doTemp.setJboClass("jbo.pidr.HPIDR_RATE_LEGREPINF");// 设置JBO对象
	doTemp.setColumnAttribute("SESSIONID", "COLVISIBLE", "1");// 设置期次号可见
	doTemp.setColumnAttribute("SESSIONID", "ISFILTER", "1");// 设置期次号可查询
	
	// 获取参数，设置条件筛选数据
	String rightType = CurPage.getParameter("RightType");// 页面只读控制
	if(rightType == null) rightType = "ReadOnly";
	String sessionId = CurPage.getParameter("SessionId");// 全信息界面传递回来的期次号
	if(sessionId == null) sessionId = "";
	String customerId = CurPage.getParameter("CustomerId");// 全信息界面或者当期表传递回来的客户编号
	if(customerId == null) customerId = "";
	String flag = CurPage.getParameter("Flag");// 页面复用标志，用来控制list页面jboWhere条件和按钮功能
	if(flag == null) flag = "";
	String fNo = CurPage.getParameter("fNo");//反馈处理编号
	if(fNo == null) fNo = "";
	String messageType = CurPage.getParameter("MessageType");//报文类型
	if(messageType == null) messageType = "";
	
	if(PIDRConstants.ALLMSG_FLAG.equals(flag) || PIDRConstants.MDFC_FLAG.equals(flag) || PIDRConstants.FEEDBACK_FLAG.equals(flag)) {
		doTemp.appendJboWhere("SessionId = :SessionId and CustomerId = :CustomerId");// 全信息tab页面、按段更正详情中待更正历史段列表打开控制显示
	}else if(PIDRConstants.CHECKHIS_FLAG.equals(flag)){
		doTemp.appendJboWhere("CustomerId = :CustomerId");// 当期表查看历史纪录控制显示
	}else if( PIDRConstants.FEEDBACK_FLAG.equals(flag)){
		doTemp.appendJboWhere("SessionId = :SessionId and CustomerId = :CustomerId");// 反馈错误打开控制显示
	}
	doTemp.appendJboWhere("ManagerOrgId like '"+CurUser.getOrgID()+"%'");// 添加管户机构控制
	
	ASObjectWindow dwTemp = new ASObjectWindow(CurPage,doTemp,request);
	dwTemp.Style="1";      	     //--设置为Grid风格--
	dwTemp.ReadOnly = "1";	 //只读模式
	dwTemp.setPageSize(20);
	dwTemp.setParameter("SessionId", sessionId);
	dwTemp.setParameter("CustomerId", customerId);
	dwTemp.genHTMLObjectWindow("");
	String sButtons[][] = {
		//0、是否展示 1、	权限控制  2、 展示类型 3、按钮显示名称 4、按钮解释文字 5、按钮触发事件代码	6、	7、	8、	9、图标，CSS层叠样式 10、风格
		{"true","","Button","详情","详情","view()","","","","btn_icon_detail",""},
	};
	
%>
<%@include file="/Frame/resources/include/ui/include_list.jspf"%>
<script type="text/javascript">
	/*~[Describe=详情,InputParam=无,OutputParam=无]~*/
	function view(){
		var url = "/PIDR/IntegatedQueryManage/HistoryDataManage/RateManage/HPidrRateLegrepinf/HPidrRateLegrepinfInfo.jsp";
		var sessionId = getItemValue(0,getRow(0),'SessionId');// 期次号
		var customerId = getItemValue(0,getRow(0),'CustomerId');// 客户编号
		var rightType = "<%=rightType%>";
		var fNo = "<%=fNo%>";
		var messageType = "<%=messageType%>";
		var params = 'SessionId=' + sessionId + '&CustomerId=' + customerId + '&RightType=' + rightType+'&fNo='+fNo+'&MessageType='+messageType+ '&Flag=<%=flag%>';
		if(typeof(sessionId)=="undefined" || sessionId.length==0 ){
			alert("请选择一条记录");
			return ;
		}
		AsDialog.PopView(url,params,'dialogWidth:1000px;dialogHeight:600px',function(){
			reloadSelf();
		});
	}
</script>
<%@ include file="/Frame/resources/include/include_end.jspf"%>