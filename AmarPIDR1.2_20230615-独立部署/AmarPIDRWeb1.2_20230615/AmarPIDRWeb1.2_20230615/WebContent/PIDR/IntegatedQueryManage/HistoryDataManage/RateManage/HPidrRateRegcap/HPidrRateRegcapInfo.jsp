<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="/Frame/resources/include/include_begin_info.jspf"%>
<%@ page import="com.amarsoft.app.pidr.common.PIDRConstants"%>
<%@ page import="com.amarsoft.app.pidr.util.FeedbackErrors" %>
<%--  
	Author: nxxiong
	CreationDate: 2023-02-22
	Description: 综合查询-历史数据-企业评级信息记录-注册资本信息表详情页面
--%>
<%
    String bsBusiIdSerialNo = CurPage.getParameter("CustomerId");//业务标示号
    if(bsBusiIdSerialNo==null) bsBusiIdSerialNo="";
    String fNo = CurPage.getParameter("fNo");//反馈处理编号
    if(fNo == null) fNo = "";
    String messageType = CurPage.getParameter("MessageType");//报文类型
    if(messageType == null) messageType = "";
    HashMap<String, String> errFieldMap= new HashMap<String, String>();
    if(fNo != null) {
        errFieldMap = FeedbackErrors.getfeedbackErrField(bsBusiIdSerialNo,messageType, Sqlca);
    }
  
%>
<%	
	ASObjectModel doTemp = new ASObjectModel("PidrRateRegcapInfo");
	doTemp.setJboClass("jbo.pidr.HPIDR_RATE_REGCAP");// 设置JBO对象

	// 功能按钮和数据筛选
	String rightType = CurPage.getParameter("RightType");// 页面只读控制
	if(rightType == null) rightType = "";
	String sessionId = CurPage.getParameter("SessionId");// 期次号
	if(sessionId == null) sessionId = "";
	String customerId = CurPage.getParameter("CustomerId");// 客户编号
	if(customerId == null) customerId = "";
	String errMsg = "";
    for(String errField :errFieldMap.keySet()){
        doTemp.setHTMLStyle(errField,"style={border:1px solid red}");//把所有的错误字段红框标出
        if(doTemp.getColumn(errField)!=null){
            errMsg += errFieldMap.get(errField)+"<br/>";
        }
    }
    out.println("<div style='font-weight:bold'>"+errMsg+"</div>");
	
	doTemp.appendJboWhere("SessionId = :SessionId and CustomerId = :CustomerId");
	String argsValue = sessionId + "," + customerId;
	
	ASObjectWindow dwTemp = new ASObjectWindow(CurPage,doTemp,request);
	dwTemp.Style="2";      	     //--设置为Grid风格--
	dwTemp.genHTMLObjectWindow(argsValue);

	//0、是否展示 1、	权限控制  2、 展示类型 3、按钮显示名称 4、按钮解释文字 5、按钮触发事件代码	6、	7、	8、	9、图标，CSS层叠样式 10、风格
	String sButtons[][] = {
		{PIDRConstants.RIGHTTYPE_READONLY.equals(rightType)? "false":"true","","Button","保存","保存","if(confirm('确定保存吗？')) as_save(0)","","","","",""},
	};
%>
<%@include file="/Frame/resources/include/ui/include_info.jspf"%>
<%@ include file="/Frame/resources/include/include_end.jspf"%>