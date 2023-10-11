<%@ page pageEncoding="UTF-8"%><%@
 include file="/Frame/resources/include/include_begin_list.jspf"%>
<%@ page import="com.amarsoft.app.pidr.common.PIDRConstants"%><%
 	/* 在线用户列表 */
	String time=DateX.format(new java.util.Date(), "yyyy/MM/dd");

 	ASObjectModel doTemp = new ASObjectModel("PidrFeedbackErrorList");
 	ASObjectWindow dwTemp = new ASObjectWindow(CurPage,doTemp,request);
	dwTemp.Style="1";      //设置为Grid风格
	dwTemp.ReadOnly = "1"; //设置为只读
	dwTemp.genHTMLObjectWindow(time);
	String sButtons[][] = {
			{"true","","Button","修改","修改","modifyErrors()","","","","btn_icon_detail",""},
			{"true","All","Button","修改完成","修改完成","editfinish()","","","","btn_icon_delete",""},
			{"true","","Button","不再上报","不再上报","deReport()","","","","btn_icon_delete",""},
			
	};
%><%@include file="/Frame/resources/include/ui/include_list.jspf"%>
<script type="text/javascript">
/*~[Describe=不再上报，确认之后，刷新list页面,InputParam=无,OutputParam=无]~*/	 
	function deReport(){
		var bsbusiIdserialNo = getItemValue(0, getRow(0), 'BsBusiIdSerialNo');// 基础段业务标识号
		var messageType = getItemValue(0, getRow(0), 'MessageType');// 报文类型
		var fNo = getItemValue(0,getRow(0),'FNo');//反馈处理编号
		var fbSessionId = getItemValue(0,getRow(0),'SessionId');//反馈错误记录的sessionId，用于特殊报文反馈删除反馈错误表
		if (typeof (bsbusiIdserialNo) == "undefined"
			|| bsbusiIdserialNo.length == 0
			|| typeof (messageType) == "undefined" || messageType.length == 0) {
			alert("请选择一条记录");
			return;
		}
		if(!confirm('确认不再上报吗?')){
			return;
		}
		var sessionIDValue = "<%= PIDRConstants.SESSIONID_14_7%>";
		if(messageType=="<%=PIDRConstants.NORMALREPORT_RATE%>"||messageType=="<%=PIDRConstants.NORMALREPORT_CREASS%>"){
			sessionIDValue = "<%= PIDRConstants.SESSIONID_16_7%>";
		}
		var result = RunJavaMethodTrans("com.amarsoft.app.pidr.feedback.UpdateSessionId", "updateFeedbackSession", "sessionId="+fbSessionId 
				+ ",BsbusiIdserialNo=" + bsbusiIdserialNo+",fNo="+fNo+",MessageType="+messageType+",sessionIDValue="+sessionIDValue);
		if (result=="true"){
			alert("不再上报处理完成")
		} else {
			alert(result);
		}
		reloadSelf();
	}
	/*~[Describe=修改完成，确认之后，刷新list页面,InputParam=无,OutputParam=无]~*/	 
	function editfinish(){
		var sessionId = getItemValue(0,getRow(0),'SessionId');
		var bsbusiIdserialNo = getItemValue(0, getRow(0), 'BsBusiIdSerialNo');// 基础段业务标识号
		var fNo = "<%= CurPage.getParameter("fNo")%>";
		var messageType = getItemValue(0, getRow(0), 'MessageType');// 报文类型
		if (typeof (bsbusiIdserialNo) == "undefined"
			|| bsbusiIdserialNo.length == 0
			|| typeof (messageType) == "undefined" || messageType.length == 0) {
			alert("请选择一条记录");
			return;
		}
		if(!confirm('确认已经修改完成吗?')){
			return;
		}
		var sessionIDValue = "<%= PIDRConstants.SESSIONID_14%>";
		if(messageType=="<%=PIDRConstants.NORMALREPORT_RATE%>"||messageType=="<%=PIDRConstants.NORMALREPORT_CREASS%>"){
			sessionIDValue = "<%= PIDRConstants.SESSIONID_16%>";
		}
		var result = RunJavaMethodTrans("com.amarsoft.app.pidr.feedback.UpdateSessionId", "updateFeedbackSession", "sessionId=" + sessionId + ",BsbusiIdserialNo=" + bsbusiIdserialNo+",fNo="+fNo+",MessageType="+messageType+",sessionIDValue="+sessionIDValue);
		if (result=="true"){
			alert("修改完成")
		} else {
			alert(result);
		}
		reloadSelf();
	}
	/*~[Describe=修改按钮，确认之后，跳转到对应数据tab页,InputParam=无,OutputParam=无]~*/	 
	function modifyErrors(){
		var bsbusiIdserialNo = getItemValue(0, getRow(0), 'BsBusiIdSerialNo');// 基础段业务标识号
		var messageType = getItemValue(0, getRow(0), 'MessageType');// 报文类型
		var fNo = getItemValue(0,getRow(0),'FNo');//反馈处理编号

		if (typeof (bsbusiIdserialNo) == "undefined"
				|| bsbusiIdserialNo.length == 0
				|| typeof (messageType) == "undefined" || messageType.length == 0) {
			alert("请选择一条记录");
			return;
		}
		
		if (messageType == '<%=PIDRConstants.NORMALREPORT_RATE%>') { // 企业评级信息
			var sUrl = "/PIDR/IntegatedQueryManage/HistoryDataManage/RateManage/RateHistoryDataFeedbackTab.jsp";
			var array = bsbusiIdserialNo.split("@");// 得到基础段所有的主键
			AsDialog.PopView(sUrl, 'Flag=<%=PIDRConstants.FEEDBACK_FLAG%>&SessionId=<%=PIDRConstants.SESSIONID_16_9%>'
					+ '&BsBusiIdSerialNo=' + bsbusiIdserialNo
					+ '&MessageType=' + messageType +'&FNo='+fNo+  '&CustomerId=' + array[0], 'dialogWidth:1000px;dialogHeight:600px',function(){reloadSelf();});
		}
		if (messageType == '<%=PIDRConstants.NORMALREPORT_CREASS%>') { // 企业信贷资产信息
            var sUrl = "/PIDR/IntegatedQueryManage/HistoryDataManage/CreassManage/CreassHistoryDataFeedbackTab.jsp";
            var array = bsbusiIdserialNo.split("@");// 得到基础段所有的主键
            AsDialog.PopView(sUrl, 'Flag=<%=PIDRConstants.FEEDBACK_FLAG%>&SessionId=<%=PIDRConstants.SESSIONID_16_9%>'
                    + '&BsBusiIdSerialNo=' + bsbusiIdserialNo
                    + '&MessageType=' + messageType +'&FNo='+fNo+'&DueCode=' + array[0], 'dialogWidth:1000px;dialogHeight:600px',function(){reloadSelf();});
        }
		if(messageType == '<%=PIDRConstants.IDCHANGE_RATE%>'){//311-评级标识变更记录
			var sUrl = "/PIDR/ReportManage/ModifyDataManage/IDChangeManage/HPidrRateIdChangeInfo.jsp";
			var array = bsbusiIdserialNo.split("@");// 得到所有的主键
			AsDialog.PopView(sUrl, 'Flag=<%=PIDRConstants.FEEDBACK_FLAG%>&SessionId=<%=PIDRConstants.SESSIONID_14_9%>'
                    + '&BsBusiIdSerialNo=' + bsbusiIdserialNo
                    + '&MessageType=' + messageType +'&FNo='+fNo+ '&OldEntCertType=' + array[0] + '&OldEntCertNum=' + array[1] + '&operationType=Feedback', 
                    'dialogWidth:1000px;dialogHeight:600px',function(){reloadSelf();});
		}
		if (messageType == '<%=PIDRConstants.MDFCINFO_RATE%>') { // 企业评级按段更正
            var sUrl = "/PIDR/ReportManage/ModifyDataManage/MdfcInfoManage/HpidrRateMdfcFrame.jsp";
            var array = bsbusiIdserialNo.split("@");// 得到基础段所有的主键
            AsDialog.PopView(sUrl, 'Flag=<%=PIDRConstants.FEEDBACK_FLAG%>&SessionId=<%=PIDRConstants.SESSIONID_14_9%>'
                    + '&BsBusiIdSerialNo=' + bsbusiIdserialNo
                    + '&MessageType=' + messageType +'&FNo='+fNo+'&CustomerId=' + array[0] + '&MdfcSgmtCode=' + array[2], 'dialogWidth:1000px;dialogHeight:600px',function(){reloadSelf();});
        }
		if(messageType == '<%=PIDRConstants.ALLDELETE_RATE%>'){//313-评级整笔删除记录
			var sUrl = "/PIDR/ReportManage/DeleteDataManage/HPidrRateAlldelInfo.jsp";
			var array = bsbusiIdserialNo.split("@");// 得到所有的主键
			AsDialog.PopView(sUrl, 'Flag=<%=PIDRConstants.FEEDBACK_FLAG%>&sessionId=<%=PIDRConstants.SESSIONID_14_9%>'
                    + '&BsBusiIdSerialNo=' + bsbusiIdserialNo
                    + '&MessageType=' + messageType +'&FNo='+fNo+'&entCertType=' + array[0]+'&entCertNum=' + array[1] +'&operationType=Feedback', 
                    'dialogWidth:1000px;dialogHeight:600px',function(){reloadSelf();});
		}
		if(messageType == '<%=PIDRConstants.IDCHANGE_CREASS%>'){//411-信贷资产标识变更记录
			var sUrl = "/PIDR/ReportManage/ModifyDataManage/IDChangeManage/HPidrCreAssIdChangeInfo.jsp";
			var array = bsbusiIdserialNo.split("@");// 得到所有的主键
			AsDialog.PopView(sUrl, 'Flag=<%=PIDRConstants.FEEDBACK_FLAG%>&SessionId=<%=PIDRConstants.SESSIONID_14_9%>'
                    + '&BsBusiIdSerialNo=' + bsbusiIdserialNo
                    + '&MessageType=' + messageType +'&FNo='+fNo+ '&OldDueCode=' + array[0] + '&OldContractCode=' + array[1] + '&operationType=Feedback', 
                    'dialogWidth:1000px;dialogHeight:600px',function(){reloadSelf();});
		}
		if(messageType == '<%=PIDRConstants.ALLDELETE_CREASS%>'){//412-信贷资产整笔删除记录
			var sUrl = "/PIDR/ReportManage/DeleteDataManage/HPidrCreAssAlldelInfo.jsp";
			var array = bsbusiIdserialNo.split("@");// 得到所有的主键
			AsDialog.PopView(sUrl, 'Flag=<%=PIDRConstants.FEEDBACK_FLAG%>&sessionId=<%=PIDRConstants.SESSIONID_14_9%>'
                    + '&BsBusiIdSerialNo=' + bsbusiIdserialNo
                    + '&MessageType=' + messageType +'&FNo='+fNo+ '&delDueCode=' + array[0] + '&delContractCode=' + array[1] + '&operationType=Feedback', 
                    'dialogWidth:1000px;dialogHeight:600px',function(){reloadSelf();});
		}
		
	}
</script>
<%@ include file="/Frame/resources/include/include_end.jspf"%>