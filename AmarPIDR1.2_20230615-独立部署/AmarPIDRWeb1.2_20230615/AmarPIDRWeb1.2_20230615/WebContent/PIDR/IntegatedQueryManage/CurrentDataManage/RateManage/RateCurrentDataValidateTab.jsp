<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="com.amarsoft.app.pidr.util.ValidateErrors" %>
<%@ page import="com.amarsoft.app.pidr.util.CheckDataExist"%>
<%@ page import="com.amarsoft.app.pidr.common.PIDRConstants"%>
<%@ include file="/IncludeBegin.jsp"%>
<%--  
	Author: swpeng
	CreationDate: 2023-02-22
	Description: 通过数组定义生成strip框架页面——企业评级信息校验展示Tab页面
--%>
<%	
 	String customerId = CurPage.getParameter("CustomerId");
    if(customerId==null) customerId="";
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
 	
 		String flag1 = CheckDataExist.checkData("PIDR_RATE_BS","CustomerId",customerId, Sqlca);
 	 	String flag2 = CheckDataExist.checkData("PIDR_RATE_FSINF","CustomerId",customerId, Sqlca);
 	 	String flag3 = CheckDataExist.checkData("PIDR_RATE_LEGREPINF","CustomerId",customerId, Sqlca);
 	 	String flag4 = CheckDataExist.checkData("PIDR_RATE_MNSHAHODINF","CustomerId",customerId, Sqlca);
 	 	String flag5 = CheckDataExist.checkData("PIDR_RATE_INVABROINF","CustomerId",customerId, Sqlca);
 	 	String flag6 = CheckDataExist.checkData("PIDR_RATE_NEGINF","CustomerId",customerId, Sqlca);
 	 	String flag7 = CheckDataExist.checkData("PIDR_RATE_BALANCESSHEET","CustomerId",customerId, Sqlca);
 	 	String flag8 = CheckDataExist.checkData("PIDR_RATE_INCOME","CustomerId",customerId, Sqlca);
 	 	String flag9 = CheckDataExist.checkData("PIDR_RATE_CASHFLOW","CustomerId",customerId, Sqlca);

 	 	if(PIDRConstants.VALIDATEFLAG_1.equals(validateFlag)){
 	 		flag2="false";
 			flag3="false";
 			flag4="false";
 			flag5="false";
 			flag6="false";
 			flag7="false";
 			flag8="false";
 			flag9="false";
 	 		if(PIDRConstants.TABLE_PIDR_RATE_BS.equalsIgnoreCase(errTable)){
 	 			flag1="true";
 	 		}
 	 		if(PIDRConstants.TABLE_PIDR_RATE_FSINF.equalsIgnoreCase(errTable)){
 	 			flag2="true";
 	 		}
 	 		if(PIDRConstants.TABLE_PIDR_RATE_LEGREPINF.equalsIgnoreCase(errTable)){
 	 			flag3="true";
 	 		}
 	 		if(PIDRConstants.TABLE_PIDR_RATE_MNSHAHODINF.equalsIgnoreCase(errTable)){
 	 			flag4="true";
 	 		}
 	 		if(PIDRConstants.TABLE_PIDR_RATE_INVABROINF.equalsIgnoreCase(errTable)){
 	 			flag5="true";
 	 		}
 	 		if(PIDRConstants.TABLE_PIDR_RATE_NEGINF.equalsIgnoreCase(errTable)){
 	 			flag6="true";
 	 		}
 	 		if(PIDRConstants.TABLE_PIDR_RATE_BALANCESSHEET.equalsIgnoreCase(errTable)){
 	 			flag7="true";
 	 		}
 	 		if(PIDRConstants.TABLE_PIDR_RATE_INCOME.equalsIgnoreCase(errTable)){
 	 			flag8="true";
 	 		}
 	 		if(PIDRConstants.TABLE_PIDR_RATE_CASHFLOW.equalsIgnoreCase(errTable)){
 	 			flag9="true";
 	 		}
 	 		
 	 	}
 	 	
 	//定义strip数组：
 	//参数：0.是否显示, 1.标题，2.高度，3.组件ID，4.URL，5，参数串，6.事件
	String sTabStrip[][] = {
		{flag1,"基础段" ,"/PIDR/IntegatedQueryManage/CurrentDataManage/RateManage/PidrRateBs/PidrRateBsList.jsp","CustomerId="+customerId+"&Flag="+validateFlag,"","","false" },
		{flag2,"基本概况段" ,"/PIDR/IntegatedQueryManage/CurrentDataManage/RateManage/PidrRateFsinf/PidrRateFsinfList.jsp","CustomerId="+customerId+"&Flag="+validateFlag,"","","false" },
		{flag3,"主要负责人段" ,"/PIDR/IntegatedQueryManage/CurrentDataManage/RateManage/PidrRateLegrepinf/PidrRateLegrepinfList.jsp","CustomerId="+customerId+"&Flag="+validateFlag,"","","false" },
		{"false","注册资本信息" ,"/PIDR/IntegatedQueryManage/CurrentDataManage/RateManage/PidrRateRegcap/PidrRateRegcapList.jsp","CustomerId="+customerId+"&Flag="+validateFlag,"","","false" },
		{flag4,"主要出资人信息" ,"/PIDR/IntegatedQueryManage/CurrentDataManage/RateManage/PidrRateMnshahodinf/PidrRateMnshahodinfList.jsp","CustomerId="+customerId+"&Flag="+validateFlag,"","","false" },
		{flag5,"对外投资段" ,"/PIDR/IntegatedQueryManage/CurrentDataManage/RateManage/PidrRateInvabroinf/PidrRateInvabroinfList.jsp","CustomerId="+customerId+"&Flag="+validateFlag,"","","false" },
		{flag6,"负面信息段" ,"/PIDR/IntegatedQueryManage/CurrentDataManage/RateManage/PidrRateNeginf/PidrRateNeginfList.jsp","CustomerId="+customerId+"&Flag="+validateFlag,"","","false" },
		{flag7,"资产负债表段" ,"/PIDR/IntegatedQueryManage/CurrentDataManage/RateManage/PidrRateBalancessheet/PidrRateBalancessheetList.jsp","CustomerId="+customerId+"&Flag="+validateFlag,"","","false" },
		{flag8,"利润表" ,"/PIDR/IntegatedQueryManage/CurrentDataManage/RateManage/PidrRateIncome/PidrRateIncomeList.jsp","CustomerId="+customerId+"&Flag="+validateFlag,"","","false" },
		{flag9,"现金流量表段" ,"/PIDR/IntegatedQueryManage/CurrentDataManage/RateManage/PidrRateCashflow/PidrRateCashflowList.jsp","CustomerId="+customerId+"&Flag="+validateFlag,"","","false" },
	};
%>
<%@ include file="/Resources/CodeParts/Tab01.jsp"%>
<%@ include file="/IncludeEnd.jsp"%>