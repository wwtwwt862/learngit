<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="/Frame/resources/include/include_begin_info.jspf"%>
<%@ page import="java.util.Date" %>
<%@ page import="com.amarsoft.app.pidr.util.FeedbackErrors" %>
<%--
	    Author:yyzang
       CreationDate:2023-02-22
       Description:整笔删除-信贷资产 详情页
 --%>
  <%
    String bsBusiIdSerialNo = CurPage.getParameter("BsBusiIdSerialNo");
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
    String operationType = CurPage.getParameter("operationType");//操作类型  详情/新增
    if(operationType == null) operationType = ""; 
	String sessionId = CurPage.getParameter("sessionId");// 期次号
	if(sessionId == null) sessionId = ""; 
	String delDueCode = CurPage.getParameter("delDueCode");// 借据号
	if(delDueCode == null)  delDueCode = "";
	String delContractCode = CurPage.getParameter("delContractCode");// 合同号
	if(delContractCode == null) delContractCode = "";	
	ASObjectModel doTemp = new ASObjectModel("PidrAllDltCreAssInfo");
	doTemp.appendJboWhere("SessionID = :SessionId and DelDueCode = :DelDueCode and DelContractCode = :DelContractCode ");
	if("Add".equals(operationType)){//如果是作为新增页面打开
		doTemp.setColumnAttribute("SessionId", "COLVISIBLE", "0");
		doTemp.setColumnAttribute("InfRecType", "COLVISIBLE", "0");
		doTemp.setColumnAttribute("DelMngmtOrgCode", "COLVISIBLE", "0");
		doTemp.setColumnAttribute("FbCode", "COLVISIBLE", "0");
		doTemp.setColumnAttribute("DelDueCode", "COLREQUIRED", "1");
		doTemp.setColumnAttribute("DelContractCode", "COLREQUIRED", "1");

	}
	String errMsg = "";
    for(String errField :errFieldMap.keySet()){
    	if("RecStatus".equalsIgnoreCase(errField)){//备案状态无法通过页面修改，但需要提示
    		errMsg += errFieldMap.get(errField)+"<br/>";
    	}else{
	        doTemp.setHTMLStyle(errField,"style={border:1px solid red}");//把所有的错误字段红框标出
	        if(doTemp.getColumn(errField)!=null){
	            errMsg += errFieldMap.get(errField)+"<br/>";
	            doTemp.setReadOnly(errField, false);
	        }
    	}
    }
    out.println("<div style='font-weight:bold'>"+errMsg+"</div>");
	ASObjectWindow dwTemp = new ASObjectWindow(CurPage,doTemp,request);
 	dwTemp.setParameter("SessionId", sessionId);
	dwTemp.setParameter("DelDueCode", delDueCode);
	dwTemp.setParameter("DelContractCode", delContractCode);

	dwTemp.Style="2";      	     //--设置为Grid风格--
	if("View".equals(operationType)){//如果是作为详情页面打开，则页面只读
		dwTemp.ReadOnly="1";
	}
	dwTemp.genHTMLObjectWindow("");

	//0、是否展示 1、	权限控制  2、 展示类型 3、按钮显示名称 4、按钮解释文字 5、按钮触发事件代码	6、	7、	8、	9、图标，CSS层叠样式 10、风格
	String sButtons[][] = {
			{("Add".equals(operationType) || "Feedback".equals(operationType))?"true":"false","","Button","保存","保存记录","save()","","","",""}
			
	};
%>
<%@include file="/Frame/resources/include/ui/include_info.jspf"%>
<script type="text/javascript">

/*~[Describe=初始化页面,InputParam=无,OutputParam=无]~*/
function initRow() {
	if(getRowCount(0) == 0) {
		setItemValue(0,getRow(),"ManagerOrgId","<%=CurUser.getOrgID()%>");
		setItemValue(0,getRow(),"ManagerOrgName","<%=CurUser.getOrgName()%>"); 
		setItemValue(0,getRow(),"InputOrgId","<%=CurUser.getOrgID()%>"); 
		setItemValue(0,getRow(),"InputUserId","<%=CurUser.getUserID()%>");
		setItemValue(0,getRow(),"InputOrgName","<%=CurUser.getOrgName()%>"); 
		setItemValue(0,getRow(),"InputUserName","<%=CurUser.getUserName()%>");
		setItemValue(0,getRow(),"InputTime","<%=DateX.format(new Date(), "yyyy-MM-dd")%>");
		setItemValue(0,getRow(),"OccurDate","<%=DateX.format(new Date(),"yyyy-MM-dd")%>");
	}
}
var type = '<%=operationType%>';
if("Add" == type){
	initRow();
}

/*~[Describe=保存记录,InputParam=无,OutputParam=无]~*/
function save(){
	 var delDueCode = getItemValue(0,getRow(0),'delDueCode');// 借据号
	 var delContractCode = getItemValue(0,getRow(0),'delContractCode');// 合同号
	 var inputOrgId = getItemValue(0,getRow(0),'InputOrgId');// 录入机构编号
	 var inputTime = getItemValue(0,getRow(0),'InputTime');// 录入时间
	 var inputUserId = getItemValue(0,getRow(0),'InputUserId');// 录入用户编号
	 var managerOrgId = getItemValue(0,getRow(0),'ManagerOrgId');// 管护机构编号
	 if(typeof(delDueCode)=="undefined" || delDueCode.length==0){
		 alert("借据号不能为空");
		 return;
	 }
	 if(typeof(delContractCode)=="undefined" || delContractCode.length==0){
		 alert("合同号不能为空");
		 return;
	 }
	 var result =  RunJavaMethodTrans("com.amarsoft.app.pidr.alldlt.PidrAllDelHandler", "addCreAssAllDel", "delDueCode="+delDueCode 
			                                                 +  ",delContractCode=" +  delContractCode +",inputOrgId="+inputOrgId
			                                                 +",inputTime="+inputTime +",inputUserId="+inputUserId );
	 if("SUCCESS" == result){
		 alert("新增整笔删除记录成功!");
	 }else{
		 alert(result);
	 }
	 AsDialog.ClosePage();
}

</script>
<%@ include file="/Frame/resources/include/include_end.jspf"%>