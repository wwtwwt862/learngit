<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="/Frame/resources/include/include_begin_info.jspf"%>
<%@ page import="java.util.Date" %>
<%@ page import="com.amarsoft.app.pidr.common.PIDRConstants"%>
<%@ page import="com.amarsoft.app.pidr.util.FeedbackErrors" %>
<%--
	Author:kwwu
	CreationDate:2023-02-21
	Description:企业评级信息标识变更详情页面
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
    String operationType = CurPage.getParameter("OperationType");//操作类型  详情/新增
    if(operationType == null) operationType = "";
	String sessionId = CurPage.getParameter("SessionId");// 期次号
	if(sessionId == null) sessionId = "";
	String oldEntCertType = CurPage.getParameter("OldEntCertType");// 原企业身份标识类型
	if(oldEntCertType == null) oldEntCertType = "";	
	String oldEntCertNum = CurPage.getParameter("OldEntCertNum");// 原企业身份标识号码
	if(oldEntCertNum == null) oldEntCertNum = "";
	String mngmtOrgCode = CurPage.getParameter("MngmtOrgCode");//业务管理金融机构代码
	if(mngmtOrgCode == null) mngmtOrgCode = "";
	String managerOrgId = CurPage.getParameter("ManagerOrgId");//管户机构
	if(managerOrgId == null) managerOrgId = "";
	String finStaYear = CurPage.getParameter("FinStaYear");//报表年份
	if(finStaYear == null) finStaYear = "";
	String rightType = CurPage.getParameter("RightType");
	if(rightType == null) rightType = "";
	ASObjectModel doTemp = new ASObjectModel("PidrRateIdChangeInfo");
	doTemp.appendJboWhere("SessionId = :SessionId and OldEntCertType = :OldEntCertType and OldEntCertNum = :OldEntCertNum");
	if(PIDRConstants.IDCHANGE_OPERATE_ADD.equalsIgnoreCase(operationType)){//如果是作为新增页面打开
		doTemp.setColumnAttribute("FinStaYear", "COLVISIBLE", "0");//报表年份由新增的需变更的标识查询获取
		doTemp.setColumnAttribute("MngmtOrgCode", "COLVISIBLE", "0");//业务管理金融机构代码由新增的需变更的标识查询获取
		doTemp.setColumnAttribute("ManagerOrgName", "COLVISIBLE", "0");//管户机构代码由新增的需变更的标识查询获取
	}
	if(PIDRConstants.IDCHANGE_OPERATE_INFO.equalsIgnoreCase(operationType) || PIDRConstants.IDCHANGE_OPERATE_COMP.equalsIgnoreCase(operationType)){//详情、综合查询标识变更按钮打开
		doTemp.setReadOnly("OldEntCertNum", true);
		doTemp.setReadOnly("FinStaYear", true);
	}
	if(PIDRConstants.IDCHANGE_OPERATE_COMP.equalsIgnoreCase(operationType)){//综合查询当期基础段的标识变更
		doTemp.setDefaultValue("OldEntCertType",oldEntCertType);
		doTemp.setDefaultValue("OldEntCertNum",oldEntCertNum);
		doTemp.setDefaultValue("FinStaYear",finStaYear);
		doTemp.setDefaultValue("MngmtOrgCode",mngmtOrgCode);
		doTemp.setDefaultValue("ManagerOrgId",managerOrgId);
	}
	String errMsg = "";
    for(String errField :errFieldMap.keySet()){
    	if("ThreeStandardID".equalsIgnoreCase(errField)){
    		String[] fields = {"NewEntCertNum","MngmtOrgCode","FinStaYear"};//三标
    		for(int i = 0; i < fields.length; i++){
    			doTemp.setHTMLStyle(fields[i],"style={border:1px solid red}");//把所有的错误字段红框标出
    	        if(doTemp.getColumn(fields[i])!=null){
    	            doTemp.setReadOnly(fields[i], false);
    	        }
    		}
    		errMsg += errFieldMap.get(errField)+"<br/>";
    	}else if("ExaStatus".equalsIgnoreCase(errField)){//资料审查状态无法通过页面修改，但需要提示
    		errMsg += errFieldMap.get(errField).replaceAll("库", "人行库")+"<br/>";
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
 	dwTemp.setParameter("OldEntCertType", oldEntCertType);
 	dwTemp.setParameter("OldEntCertNum", oldEntCertNum);

	dwTemp.Style="2";      	     //--设置为Grid风格--
	//dwTemp.ReadOnly="1";
	dwTemp.genHTMLObjectWindow("");

	//0、是否展示 1、	权限控制  2、 展示类型 3、按钮显示名称 4、按钮解释文字 5、按钮触发事件代码	6、	7、	8、	9、图标，CSS层叠样式 10、风格
	String sButtons[][] = {
			{"true","All","Button","保存","保存记录","save()","","","",""}
	};
%>
<%@include file="/Frame/resources/include/ui/include_info.jspf"%>
<script type="text/javascript">
/*~[Describe=新增时初始化数据,InputParam=无,OutputParam=无]~*/
function initRow() {
	if(getRowCount(0) == 0) {//新增
		setItemValue(0,getRow(),"SessionId","<%=PIDRConstants.SESSIONID_14%>"); 
		setItemValue(0,getRow(),"InfRecType","<%=PIDRConstants.IDCHANGE_RATE%>"); 
		setItemValue(0,getRow(),"OldEntCertType","<%=PIDRConstants.ENT_CERTTYPE_20%>"); //20-统一社会信用代码
		setItemValue(0,getRow(),"NewEntCertType","<%=PIDRConstants.ENT_CERTTYPE_20%>"); //20-统一社会信用代码
		setItemValue(0,getRow(),"InputOrgId","<%=CurUser.getOrgID()%>"); 
		setItemValue(0,getRow(),"InputOrgName","<%=CurUser.getOrgName()%>");
		setItemValue(0,getRow(),"InputUserId","<%=CurUser.getUserID()%>");
		setItemValue(0,getRow(),"InputUserName","<%=CurUser.getUserName()%>");
		setItemValue(0,getRow(),"InputTime","<%=DateX.format(new Date(), "yyyy-MM-dd")%>");
		setItemValue(0,getRow(),"OccurDate","<%=DateX.format(new Date(),"yyyy-MM-dd")%>");
	}
}
initRow();

/*~[Describe=保存,InputParam=无,OutputParam=无]~*/
function save(){
	var oldEntCertType = getItemValue(0,getRow(0),'OldEntCertType');// 原身份标识类型
	var oldEntCertNum = getItemValue(0,getRow(0),'OldEntCertNum');// 原身份标识号码
	var newEntCertNum = getItemValue(0,getRow(0),'NewEntCertNum');// 新身份标识号码
	if(newEntCertNum == oldEntCertNum){
		alert("新旧身份标识号码不能相同");
		return;
	}
	if("<%=PIDRConstants.IDCHANGE_OPERATE_ADD%>" == "<%=operationType%>"){//报送管理-标识变更新增
		var retValue =  RunJavaMethodTrans("com.amarsoft.app.pidr.idchange.PidrIdChangeHandler", "addRateIdChange", "oldEntCertType="+oldEntCertType
			 +",oldEntCertNum=" + oldEntCertNum+",operationType=<%=operationType%>");
		if(retValue == "<%=PIDRConstants.IDCHANGE_SAVE_NOTEXIST%>"){
			alert("不存在该记录，不可操作");
			return;
		} 
		if(retValue == "<%=PIDRConstants.IDCHANGE_SAVE_IDCHANGED%>"){
			alert("该客户已存在标识变更记录，不可再次操作");
			return;
	   	} 
		var mngmtorgCode = retValue.split("@")[0];
		var managerOrgId = retValue.split("@")[1];
		var finStaYear = retValue.split("@")[2];
		setItemValue(0,getRow(),"MngmtorgCode",mngmtorgCode);
		setItemValue(0,getRow(),"ManagerOrgId",managerOrgId);
		setItemValue(0,getRow(),"FinStaYear",finStaYear);
		if(!confirm('确定保存吗？')) return;
		as_save(0,"openInfo()");//新增页面，保存之后，页面不关闭继续编辑等同重新打开详情页面
	}else{
		if(!confirm('确定保存吗？')) return;
		as_save(0);
	}
}

/*~[Describe=新增页面，保存之后，页面不关闭继续编辑等同重新打开详情页面,InputParam=无,OutputParam=无]~*/
function openInfo(){
	var url = "/PIDR/ReportManage/ModifyDataManage/IDChangeManage/HPidrRateIdChangeInfo.jsp";
	var sessionId = getItemValue(0,getRow(0),'SessionId');// 期次号
	var oldEntCertType = getItemValue(0,getRow(0),'OldEntCertType');// 原证件类型
	var oldEntCertNum = getItemValue(0,getRow(0),'OldEntCertNum');// 原证件号码
	var params = 'SessionId=' + sessionId + '&OldEntCertType=' + oldEntCertType
		+'&OldEntCertNum='+oldEntCertNum+'&OperationType=<%=PIDRConstants.IDCHANGE_OPERATE_INFO%>';
	AsControl.OpenView(url,params,"","");
}
</script>
<%@ include file="/Frame/resources/include/include_end.jspf"%>