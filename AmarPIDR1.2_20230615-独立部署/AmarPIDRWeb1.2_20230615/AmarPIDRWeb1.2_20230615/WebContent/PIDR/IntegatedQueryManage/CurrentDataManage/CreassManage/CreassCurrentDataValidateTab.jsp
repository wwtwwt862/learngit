<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="/IncludeBegin.jsp"%>
<%@ page import="com.amarsoft.app.pidr.util.CheckDataExist"%>
<%@ page import="com.amarsoft.app.pidr.util.ValidateErrors"%>
<%@ page import="com.amarsoft.app.pidr.common.PIDRConstants"%>
<%--  
	Author:  swpeng 
	CreationDate:2023-02-22
    Description:企业资产信贷信息当期表校验Tab页面
--%>
<%
 	String dueCode = CurPage.getParameter("DueCode");
    if(dueCode==null) dueCode="";
 	String busiIdSerialNo = CurPage.getParameter("BusiIdSerialNo");
	if(busiIdSerialNo == null) busiIdSerialNo = "";
	String bsBusiIdSerialNo = CurPage.getParameter("BsBusiIdSerialNo");
    if(bsBusiIdSerialNo == null) bsBusiIdSerialNo = "";
	String errMsg = "";
    String validateFlag = CurPage.getParameter("ValidateFlag");
    if(validateFlag==null) validateFlag=PIDRConstants.VALIDATEERROR_FLAG;
    String errTable = CurPage.getParameter("ErrTable");
    HashMap<String, String> map=null;
 	//否则对于联合主键的，一个账户的两笔记录错误一样会重复显示（后续优化，段级校验错误，对于一个账户下只有一个是错误的，tab页不会均展示同一账户没有错误的）
 		if(busiIdSerialNo != null&&!PIDRConstants.VALUE_NULL.equals(busiIdSerialNo)) {
 			map = ValidateErrors.getErrInfo(errTable, busiIdSerialNo, Sqlca);
 			for(String key : map.keySet()) {//提示信息英文名不用展示
 	            errMsg += "错误字段"+map.get(key).substring(map.get(key).indexOf(":"))+"<br/>";
 	        }
 		}
 		//缺少段的段级校验错误，使用业务标识号（N/A）去查询时，会把其余账户的缺少情况一起展示出来
 		if(PIDRConstants.VALUE_NULL.equals(busiIdSerialNo)) {
 	        map = ValidateErrors.getNAErrInfo(errTable, bsBusiIdSerialNo, Sqlca);
 	        for(String key : map.keySet()) {//提示信息英文名不用展示
 	            errMsg += "错误字段"+map.get(key).substring(map.get(key).indexOf(":"))+"<br/>";
 	        }
 	    }
 		CurPage.setAttribute("BeforeTabStripHtml", "<div style='font-weight:bold'>"+errMsg+"</div>");
 		String flag1 = CheckDataExist.checkData(PIDRConstants.TABLE_PIDR_CREASS_BS,"DueCode",dueCode, Sqlca);
 	 	String flag2 = CheckDataExist.checkData(PIDRConstants.TABLE_PIDR_CREASS_FSINF,"DueCode",dueCode, Sqlca);
 	 	if(PIDRConstants.VALIDATEFLAG_1.equals(validateFlag)){
 	 		if(PIDRConstants.TABLE_PIDR_CREASS_BS.equalsIgnoreCase(errTable)){
 	 			flag1="true";
 	 			flag2="false";
 	 		}
 	 		if(PIDRConstants.TABLE_PIDR_CREASS_FSINF.equalsIgnoreCase(errTable)){
 	 			flag2="true";
 	 		}
 	 	}
 	//定义strip数组：
 	//参数：0.是否显示, 1.标题，2.高度，3.组件ID，4.URL，5，参数串，6.事件
	String sTabStrip[][] = {
			{flag1,"基础段" ,"/PIDR/IntegatedQueryManage/CurrentDataManage/CreassManage/PidrCreassBs/PidrCreassBsList.jsp","DueCode="+dueCode+"&Flag="+validateFlag,"","","false" },
			{flag2,"基本信息段" ,"/PIDR/IntegatedQueryManage/CurrentDataManage/CreassManage/PidrCreassFsinf/PidrCreassFsinfList.jsp","DueCode="+dueCode+"&Flag="+validateFlag,"","","false" },
			};
%>
<%@ include file="/Resources/CodeParts/Tab01.jsp"%>
<%@ include file="/IncludeEnd.jsp"%>