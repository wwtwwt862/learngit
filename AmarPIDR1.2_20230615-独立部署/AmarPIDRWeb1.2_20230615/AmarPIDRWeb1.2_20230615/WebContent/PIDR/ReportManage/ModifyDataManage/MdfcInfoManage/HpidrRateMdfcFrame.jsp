<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="com.amarsoft.app.pidr.common.PIDRConstants" %>
<%@ include file="/IncludeBegin.jsp"%>
<%--
	Author:kwwu
	CreationDate:2023-02-21
	Description:企业评级信息按段更正详情打开的上下frame页面
--%>
<%
	String sessionId = CurPage.getParameter("SessionId");//上报期次
	if(sessionId == null) sessionId = "";
	String customerId = CurPage.getParameter("CustomerId");//待更正客户编号
	if(customerId == null) customerId = "";
	String mdfcSgmtCode = CurPage.getParameter("MdfcSgmtCode");//待更正段标
	if(mdfcSgmtCode == null) mdfcSgmtCode = "";
	String messageType = CurPage.getParameter("MessageType");
	if(messageType == null) messageType = "";
	String bsBusiIdSerialNo = CurPage.getParameter("BsBusiIdSerialNo");
	if(bsBusiIdSerialNo == null) bsBusiIdSerialNo = "";//反馈错误表标识号
	String rightType="";
	//除了新增的按段更正记录与反馈错误记录，其余情况按段更正只读
	if(!PIDRConstants.SESSIONID_14.equals(sessionId)&&!PIDRConstants.SESSIONID_14_9.equals(sessionId)){
        rightType="ReadOnly";
    }
%>
<%@include file="/Resources/CodeParts/Frame02.jsp"%>
<script type="text/javascript">
mytoptd.height=240;
/*~[Describe=上下结构页面-上,InputParam=无,OutputParam=无]~*/
function openUp(){
	AsControl.OpenView("/PIDR/ReportManage/ModifyDataManage/MdfcInfoManage/HPidrRateMdfcInfo.jsp","SessionId=<%=sessionId%>&CustomerId=<%=customerId%>&MdfcSgmtCode=<%=mdfcSgmtCode%>&MessageType=<%=messageType%>&BsBusiIdSerialNo=<%=bsBusiIdSerialNo%>","rightup","");
}
/*~[Describe=上下结构页面-下,InputParam=无,OutputParam=无]~*/
function openDown(mdfcsgmtCode){
	if("<%=mdfcSgmtCode%>" == "A") {//基础段
		AsControl.OpenView("/PIDR/IntegatedQueryManage/HistoryDataManage/RateManage/HPidrRateBs/HPidrRateBsList.jsp","SessionId=<%=sessionId%>&CustomerId=<%=customerId%>&RightType=<%=rightType%>&Flag=5","rightdown","");
	}else if("<%=mdfcSgmtCode%>" == "B"){//基本概况段
		AsControl.OpenView("/PIDR/IntegatedQueryManage/HistoryDataManage/RateManage/HPidrRateFsinf/HPidrRateFsinfList.jsp","SessionId=<%=sessionId%>&CustomerId=<%=customerId%>&RightType=<%=rightType%>&Flag=5","rightdown","");
	}else if("<%=mdfcSgmtCode%>" == "C"){//主要负责人段
		AsControl.OpenView("/PIDR/IntegatedQueryManage/HistoryDataManage/RateManage/HPidrRateLegrepinf/HPidrRateLegrepinfList.jsp","SessionId=<%=sessionId%>&CustomerId=<%=customerId%>&RightType=<%=rightType%>&Flag=5","rightdown","");
	}else if("<%=mdfcSgmtCode%>" == "D"){//注册资本及主要出资人段（展示tab页，分为注册资本信息、主要出资人信息）
		AsControl.OpenView("/PIDR/ReportManage/ModifyDataManage/MdfcInfoManage/HpidrMnShaHodInfTab.jsp","SessionId=<%=sessionId%>&CustomerId=<%=customerId%>&RightType=<%=rightType%>&Flag=5","rightdown","");
	}else if("<%=mdfcSgmtCode%>" == "E"){//对外投资信息段
		AsControl.OpenView("/PIDR/IntegatedQueryManage/HistoryDataManage/RateManage/HPidrRateInvabroinf/HPidrRateInvabroinfList.jsp","SessionId=<%=sessionId%>&CustomerId=<%=customerId%>&RightType=<%=rightType%>&Flag=5","rightdown","");
	}else if("<%=mdfcSgmtCode%>" == "F"){//负面信息段
		AsControl.OpenView("/PIDR/IntegatedQueryManage/HistoryDataManage/RateManage/HPidrRateNeginf/HPidrRateNeginfList.jsp","SessionId=<%=sessionId%>&CustomerId=<%=customerId%>&RightType=<%=rightType%>&Flag=5","rightdown","");
	}else if("<%=mdfcSgmtCode%>" == "G"){//资产负债表段
		AsControl.OpenView("/PIDR/IntegatedQueryManage/HistoryDataManage/RateManage/HPidrRateBalancessheet/HPidrRateBalancessheetList.jsp","SessionId=<%=sessionId%>&CustomerId=<%=customerId%>&RightType=<%=rightType%>&Flag=5","rightdown","");
	}else if("<%=mdfcSgmtCode%>" == "H"){//利润表段
		AsControl.OpenView("/PIDR/IntegatedQueryManage/HistoryDataManage/RateManage/HPidrRateIncome/HPidrRateIncomeList.jsp","SessionId=<%=sessionId%>&CustomerId=<%=customerId%>&RightType=<%=rightType%>&Flag=5","rightdown","");
	}else if("<%=mdfcSgmtCode%>" == "I"){//现金流量表段
		AsControl.OpenView("/PIDR/IntegatedQueryManage/HistoryDataManage/RateManage/HPidrRateCashflow/HPidrRateCashflowList.jsp","SessionId=<%=sessionId%>&CustomerId=<%=customerId%>&RightType=<%=rightType%>&Flag=5","rightdown","");
	}
}
openUp();
openDown();
</script>	
<%@ include file="/IncludeEnd.jsp"%>