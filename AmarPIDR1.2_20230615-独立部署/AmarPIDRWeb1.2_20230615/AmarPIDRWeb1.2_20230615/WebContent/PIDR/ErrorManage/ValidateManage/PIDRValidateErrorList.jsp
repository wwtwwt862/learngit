<%@ page pageEncoding="UTF-8"%><%@
 include file="/Frame/resources/include/include_begin_list.jspf"%><%
 	/* 在线用户列表 */
	String time=DateX.format(new java.util.Date(), "yyyy/MM/dd");

 	ASObjectModel doTemp = new ASObjectModel("PidrValidateErrorList");
 	ASObjectWindow dwTemp = new ASObjectWindow(CurPage,doTemp,request);
	dwTemp.Style="1";      //设置为Grid风格
	dwTemp.ReadOnly = "1"; //设置为只读
	dwTemp.genHTMLObjectWindow(time);
	String sButtons[][] = {
			{"true","All","Button","执行校验","执行校验","ValidateTaskExcute()","","","","btn_icon_add",""},
			{"true","","Button","修改错误数据","修改错误数据","modifyError()","","","","btn_icon_detail",""},
	};
%><%@include file="/Frame/resources/include/ui/include_list.jspf"%>
<script type="text/javascript">
	/*~[Describe=执行校验，确认之后，调用校验批量程序,InputParam=无,OutputParam=无]~*/	
	function ValidateTaskExcute(){
		var index ;
		if(confirm('确定进行数据校验？它将完成您所在机构企业数据校验，该操作需要锁定并需要花费一定时间')) {
			$.ajax({
		        type: "post",
		        data: "ActionType=RUNTASK&TaskName=validate&OrgID=<%=CurUser.getOrgID()%>&bizType=2&UserID=<%=CurUser.getUserID()%>&ScriptName=startup",
		        url: "<%=request.getContextPath()%>/PidrTaskScheduleServlet",
		        beforeSend: function(){
		        	openDWDialog('正在执行任务中...');
		        },
		        complete: function () {
		        	autoCloseDWDialog();
		        },
		        success: function (data) {
		        	  alert("数据校验成功");
					   reloadSelf();
		        },
		        error: function (xhr,status,error) {
		        	// XMLHttpRequest 对象、错误信息、（可选）捕获的异常对象
		        	alert("数据校验失败");
		        }
		    });
		}
		reloadSelf();
	}
	/*~[Describe=修改错误数据，确认之后，跳转对应错误数据页面,InputParam=无,OutputParam=无]~*/	
	function modifyError(){
		var errTable1 = getItemValue(0, getRow(0), 'ErrTable');// 错误表名
		var busiIdSerialNo = getItemValue(0, getRow(0), 'BusiIdSerialNo');// 业务标示号
		var bsBusiIdSerialNo = getItemValue(0, getRow(0), 'BsBusiIdSerialNo');// 基础段业务标识号
		var validateLevel = getItemValue(0, getRow(0), 'ValidateLevel');// 校验级别
		var applicationCode = getItemValue(0, getRow(0), 'ApplicationCode');// 应用系统代码
		var errMsg = getItemValue(0, getRow(0), "ErrMsg");//错误信息
		if (typeof (errTable1) == "undefined" || errTable1.length == 0) {
			alert("请选择一条记录！");
			return;
		}
		if(typeof (busiIdSerialNo) == "undefined" || busiIdSerialNo.length == 0) {
			alert(errMsg);
			return;
		}
		var errTable = errTable1.toUpperCase();
		
		//企业评级基础信息
		if (errTable == "PIDR_RATE_BS") {
			if (validateLevel == "2") {//段级校验
				url = "/PIDR/IntegatedQueryManage/CurrentDataManage/RateManage/RateCurrentDataValidateTab.jsp";
				AsDialog.PopView(url, 'ValidateFlag=3'
						+ '&CustomerId=' + bsBusiIdSerialNo +'&ErrTable='+errTable
						+'&BsBusiIdSerialNo='+bsBusiIdSerialNo + '&BusiIdSerialNo=' + busiIdSerialNo,  'dialogWidth:1000px;dialogHeight:600px');
			}
			else {
				url = "/PIDR/IntegatedQueryManage/CurrentDataManage/RateManage/PidrRateBs/PidrRateBsInfo.jsp";
				AsDialog.PopView(url, 'ValidateFlag=3&BusiIdSerialNo=' + busiIdSerialNo + '&CustomerId=' + busiIdSerialNo,
						 'dialogWidth:1000px;dialogHeight:600px');
			}
		}
		//企业评级基本概况信息
		if (errTable == "PIDR_RATE_FSINF") {
			if (validateLevel == "2") {
				url = "/PIDR/IntegatedQueryManage/CurrentDataManage/RateManage/RateCurrentDataValidateTab.jsp";
				AsDialog.PopView(url, 'ValidateFlag=3'
						+ '&CustomerId=' +  bsBusiIdSerialNo +'&ErrTable='+errTable
						+'&BsBusiIdSerialNo='+bsBusiIdSerialNo + '&BusiIdSerialNo=' + busiIdSerialNo,  'dialogWidth:1000px;dialogHeight:600px');
			}
			else {				
				url = "/PIDR/IntegatedQueryManage/CurrentDataManage/RateManage/PidrRateFsinf/PidrRateFsinfInfo.jsp";
				AsDialog.PopView(url, 'ValidateFlag=3&BusiIdSerialNo=' + busiIdSerialNo + '&CustomerId=' +  busiIdSerialNo,
						 'dialogWidth:1000px;dialogHeight:600px');
			}
		}
		//企业评级主要负责人信息
		if (errTable == "PIDR_RATE_LEGREPINF") {
			if (validateLevel == "2") {
				url = "/PIDR/IntegatedQueryManage/CurrentDataManage/RateManage/RateCurrentDataValidateTab.jsp";
				AsDialog.PopView(url, 'ValidateFlag=3'
						+ '&CustomerId=' +  bsBusiIdSerialNo +'&ErrTable='+errTable
						+'&BsBusiIdSerialNo='+bsBusiIdSerialNo + '&BusiIdSerialNo=' + busiIdSerialNo,  'dialogWidth:1000px;dialogHeight:600px');
			}
			else {				
				url = "/PIDR/IntegatedQueryManage/CurrentDataManage/RateManage/PidrRateLegrepinf/PidrRateLegrepinfInfo.jsp";
				AsDialog.PopView(url, 'ValidateFlag=3&BusiIdSerialNo=' + busiIdSerialNo + '&CustomerId=' +  busiIdSerialNo,
						 'dialogWidth:1000px;dialogHeight:600px');
			}
		}
		//企业评级主要出资人信息
		if (errTable == "PIDR_RATE_MNSHAHODINF") {
			if (validateLevel == "2") {
				url = "/PIDR/IntegatedQueryManage/CurrentDataManage/RateManage/RateCurrentDataValidateTab.jsp";
				AsDialog.PopView(url, 'ValidateFlag=3'
						+ '&CustomerId=' +  bsBusiIdSerialNo +'&ErrTable='+errTable
						+'&BsBusiIdSerialNo='+bsBusiIdSerialNo + '&BusiIdSerialNo=' + busiIdSerialNo,  'dialogWidth:1000px;dialogHeight:600px');
			}
			else {				
				url = "/PIDR/IntegatedQueryManage/CurrentDataManage/RateManage/PidrRateMnshahodinf/PidrRateMnshahodinfInfo.jsp";
				var array = busiIdSerialNo.split("@");// 得到所有的主键
				AsDialog.PopView(url, 'ValidateFlag=3&BusiIdSerialNo=' + busiIdSerialNo + '&CustomerId=' +  array[0] + '&RelaId=' + array[1],
						 'dialogWidth:1000px;dialogHeight:600px');
			}
		}
		//企业评级对外投资信息
		if (errTable == "PIDR_RATE_INVABROINF") {
			if (validateLevel == "2") {
				url = "/PIDR/IntegatedQueryManage/CurrentDataManage/RateManage/RateCurrentDataValidateTab.jsp";
				AsDialog.PopView(url, 'ValidateFlag=3'
						+ '&CustomerId=' +  bsBusiIdSerialNo +'&ErrTable='+errTable
						+'&BsBusiIdSerialNo='+bsBusiIdSerialNo + '&BusiIdSerialNo=' + busiIdSerialNo,  'dialogWidth:1000px;dialogHeight:600px');
			}
			else {
				url = "/PIDR/IntegatedQueryManage/CurrentDataManage/RateManage/PidrRateInvabroinf/PidrRateInvAbroInfInfo.jsp";
				var array = busiIdSerialNo.split("@");// 得到所有的主键
				AsDialog.PopView(url, 'ValidateFlag=3&BusiIdSerialNo=' + busiIdSerialNo + '&CustomerId=' +  array[0] + '&RelaId=' + array[1],
						 'dialogWidth:1000px;dialogHeight:600px');
			}
		}		
		//企业评级负面信息段信息
		if (errTable == "PIDR_RATE_NEGINF") {
			if (validateLevel == "2") {
				url = "/PIDR/IntegatedQueryManage/CurrentDataManage/RateManage/RateCurrentDataValidateTab.jsp";
				AsDialog.PopView(url, 'ValidateFlag=3'
						+ '&CustomerId=' +  bsBusiIdSerialNo +'&ErrTable='+errTable
						+'&BsBusiIdSerialNo='+bsBusiIdSerialNo + '&BusiIdSerialNo=' + busiIdSerialNo,  'dialogWidth:1000px;dialogHeight:600px');
			}
			else {
                url = "/PIDR/IntegatedQueryManage/CurrentDataManage/RateManage/PidrRateNeginf/PidrRateNeginfInfo.jsp";
				var array = busiIdSerialNo.split("@");// 得到所有的主键
				AsDialog.PopView(url, 'ValidateFlag=3&BusiIdSerialNo=' + busiIdSerialNo + '&CustomerId=' +  array[0] + '&RelaId=' + array[1],
						 'dialogWidth:1000px;dialogHeight:600px');
			}
		}
		//企业评级资产负债表段信息
		if (errTable == "PIDR_RATE_BALANCESSHEET") {
			if (validateLevel == "2") {
				url = "/PIDR/IntegatedQueryManage/CurrentDataManage/RateManage/RateCurrentDataValidateTab.jsp";
				AsDialog.PopView(url, 'ValidateFlag=3'
						+ '&CustomerId=' +  bsBusiIdSerialNo +'&ErrTable='+errTable
						+'&BsBusiIdSerialNo='+bsBusiIdSerialNo + '&BusiIdSerialNo=' + busiIdSerialNo,  'dialogWidth:1000px;dialogHeight:600px');
			}
			else {
				url = "/PIDR/IntegatedQueryManage/CurrentDataManage/RateManage/PidrRateBalancessheet/PidrRateBalancessheetInfo.jsp";
				var array = busiIdSerialNo.split("@");// 得到所有的主键
				AsDialog.PopView(url, 'ValidateFlag=3&BusiIdSerialNo=' + busiIdSerialNo + '&CustomerId=' +  array[0] + '&Stage=' + array[1]
						+ '&FinstaYear=' + array[2] + '&SheetType=' + array[3] + '&SheetTypeDivide=' + array[4],
						 'dialogWidth:1000px;dialogHeight:600px');
			}
		}
		//企业评级利润表段信息
		if (errTable == "PIDR_RATE_INCOME") {
			if (validateLevel == "2") {
				url = "/PIDR/IntegatedQueryManage/CurrentDataManage/RateManage/RateCurrentDataValidateTab.jsp";
				AsDialog.PopView(url, 'ValidateFlag=3'
						+ '&CustomerId=' +  bsBusiIdSerialNo +'&ErrTable='+errTable
						+'&BsBusiIdSerialNo='+bsBusiIdSerialNo + '&BusiIdSerialNo=' + busiIdSerialNo,  'dialogWidth:1000px;dialogHeight:600px');
			}
			else {
				url = "/PIDR/IntegatedQueryManage/CurrentDataManage/RateManage/PidrRateIncome/PidrRateIncomeInfo.jsp";
				var array = busiIdSerialNo.split("@");// 得到所有的主键
				AsDialog.PopView(url, 'ValidateFlag=3&BusiIdSerialNo=' + busiIdSerialNo + '&CustomerId=' +  array[0] + '&Stage=' + array[1]
						+ '&FinstaYear=' + array[2] + '&SheetType=' + array[3] + '&SheetTypeDivide=' + array[4],
						 'dialogWidth:1000px;dialogHeight:600px');
			}
		}
		//企业评级现金流量表段信息
		if (errTable == "PIDR_RATE_CASHFLOW") {
			if (validateLevel == "2") {
				url = "/PIDR/IntegatedQueryManage/CurrentDataManage/RateManage/RateCurrentDataValidateTab.jsp";
				AsDialog.PopView(url, 'ValidateFlag=3'
						+ '&CustomerId=' +  bsBusiIdSerialNo +'&ErrTable='+errTable
						+'&BsBusiIdSerialNo='+bsBusiIdSerialNo + '&BusiIdSerialNo=' + busiIdSerialNo,  'dialogWidth:1000px;dialogHeight:600px');
			}
			else {
				url = "/PIDR/IntegatedQueryManage/CurrentDataManage/RateManage/PidrRateCashflow/PidrRateCashflowInfo.jsp";
				var array = busiIdSerialNo.split("@");// 得到所有的主键
				AsDialog.PopView(url, 'ValidateFlag=3&BusiIdSerialNo=' + busiIdSerialNo + '&CustomerId=' +  array[0] + '&Stage=' + array[1]
						+ '&FinstaYear=' + array[2] + '&SheetType=' + array[3] + '&SheetTypeDivide=' + array[4],
						 'dialogWidth:1000px;dialogHeight:600px');
			}
		}
		//企业信贷资产基础段信息
		if (errTable == "PIDR_CREASS_BS") {
			if (validateLevel == "2") {
				url = "/PIDR/IntegatedQueryManage/CurrentDataManage/CreassManage/CreassCurrentDataValidateTab.jsp";
				AsDialog.PopView(url, 'ValidateFlag=3'
						+ '&DueCode=' +  bsBusiIdSerialNo +'&ErrTable='+errTable
						+'&BsBusiIdSerialNo='+bsBusiIdSerialNo + '&BusiIdSerialNo=' + busiIdSerialNo,  'dialogWidth:1000px;dialogHeight:600px');
			}
			else {
				url = "/PIDR/IntegatedQueryManage/CurrentDataManage/CreassManage/PidrCreassBs/PidrCreassBsInfo.jsp";
				var array = busiIdSerialNo.split("@");// 得到所有的主键
				AsDialog.PopView(url, 'ValidateFlag=3&BusiIdSerialNo=' + busiIdSerialNo + '&DueCode=' +  busiIdSerialNo,
						 'dialogWidth:1000px;dialogHeight:600px');
			}
		}
		//企业信贷资产基本段信息
		if (errTable == "PIDR_CREASS_FSINF") {
			if (validateLevel == "2") {
				url = "/PIDR/IntegatedQueryManage/CurrentDataManage/CreassManage/CreassCurrentDataValidateTab.jsp";
				AsDialog.PopView(url, 'ValidateFlag=3'
						+ '&DueCode=' +  bsBusiIdSerialNo +'&ErrTable='+errTable
						+'&BsBusiIdSerialNo='+bsBusiIdSerialNo + '&BusiIdSerialNo=' + busiIdSerialNo,  'dialogWidth:1000px;dialogHeight:600px');
			}
			else {
				url = "/PIDR/IntegatedQueryManage/CurrentDataManage/CreassManage/PidrCreassFsinf/PidrCreassFsinfInfo.jsp";
				var array = busiIdSerialNo.split("@");// 得到所有的主键
				AsDialog.PopView(url, 'ValidateFlag=3&BusiIdSerialNo=' + busiIdSerialNo + '&DueCode=' +  busiIdSerialNo,
						 'dialogWidth:1000px;dialogHeight:600px');
			}
		}
	}
</script>
<%@ include file="/Frame/resources/include/include_end.jspf"%>