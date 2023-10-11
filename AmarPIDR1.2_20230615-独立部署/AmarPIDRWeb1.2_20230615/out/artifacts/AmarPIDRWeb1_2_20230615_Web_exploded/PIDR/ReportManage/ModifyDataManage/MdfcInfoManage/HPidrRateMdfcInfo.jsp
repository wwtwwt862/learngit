<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="/Frame/resources/include/include_begin_info.jspf"%>
<%@ page import="com.amarsoft.app.pidr.util.FeedbackErrors" %>
<%--
	Author:kwwu
	CreationDate:2023-02-17
	Description:企业评级信息按段更正详情页面
--%>
<%
    String bsBusiIdSerialNo = CurPage.getParameter("BsBusiIdSerialNo");
    if(bsBusiIdSerialNo==null) bsBusiIdSerialNo="";
    String fNo = CurPage.getParameter("fNo");//反馈处理编号
    if(fNo == null) fNo = "";
    String messageType = CurPage.getParameter("MessageType");//报文类型
    if(messageType == null) messageType = "";
    String errMsg = "";
    HashMap<String, String> errFieldMap= new HashMap<String, String>();
    if(fNo != null) {
        errFieldMap = FeedbackErrors.getfeedbackErrField(bsBusiIdSerialNo,messageType, Sqlca);
        for(String key : errFieldMap.keySet()) {
			errMsg += errFieldMap.get(key)+"<br/>";
		}
    }
    out.println("<div style='font-weight:bold'>"+errMsg+"</div>");
%>
<%	
	String sessionId = CurPage.getParameter("SessionId");// 上报期次
	if(sessionId == null) sessionId = "";
	String customerId = CurPage.getParameter("CustomerId");// 待更正客户编号
	if(customerId == null) customerId = "";	
	String mdfcSgmtCode = CurPage.getParameter("MdfcSgmtCode");// 待更正段段标
	if(mdfcSgmtCode == null) mdfcSgmtCode = "";	
	ASObjectModel doTemp = new ASObjectModel("HpidrRateMdfcInfo");
	doTemp.appendJboWhere("SessionID = :SessionId and CustomerId = :CustomerId and MdfcSgmtCode = :MdfcSgmtCode");

	ASObjectWindow dwTemp = new ASObjectWindow(CurPage,doTemp,request);
	dwTemp.Style="2";      	     //--设置为Grid风格--
	dwTemp.ReadOnly="1";
	dwTemp.setParameter("SessionId", sessionId);
	dwTemp.setParameter("CustomerId", customerId);
	dwTemp.setParameter("MdfcSgmtCode", mdfcSgmtCode);
	dwTemp.genHTMLObjectWindow("");

	//0、是否展示 1、	权限控制  2、 展示类型 3、按钮显示名称 4、按钮解释文字 5、按钮触发事件代码	6、	7、	8、	9、图标，CSS层叠样式 10、风格
	String sButtons[][] = {};
%>
<%@include file="/Frame/resources/include/ui/include_info.jspf"%>
<script type="text/javascript">
</script>
<%@ include file="/Frame/resources/include/include_end.jspf"%>