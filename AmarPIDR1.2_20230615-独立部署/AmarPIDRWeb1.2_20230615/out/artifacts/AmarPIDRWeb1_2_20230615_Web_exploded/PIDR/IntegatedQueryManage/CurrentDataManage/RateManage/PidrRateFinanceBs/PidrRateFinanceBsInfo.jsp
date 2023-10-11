<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="/Frame/resources/include/include_begin_info.jspf"%>
<%@ page import="com.amarsoft.app.pidr.common.PIDRConstants"%>
<%--  
	Author: kwwu
	CreationDate: 2023-03-20
	Description: 综合查询-当期数据-企业评级信息记录-资产负债表、利润表、现金流量表新增时，填写基本信息的页面
--%>
<%	
	ASObjectModel doTemp = new ASObjectModel("PidrFinanceBsInfo");
	String tableName=CurPage.getParameter("TableName");
	if(tableName==null)  tableName = "";//区分三张财报表名
	doTemp.setJboClass("jbo.pidr." + tableName);
	doTemp.setColInnerBtEvent("CustomerID","selectCustomer()");
	ASObjectWindow dwTemp = new ASObjectWindow(CurPage,doTemp,request);
	dwTemp.Style="2";      	     //--设置为Grid风格--
	dwTemp.genHTMLObjectWindow("");

	//0、是否展示 1、	权限控制  2、 展示类型 3、按钮显示名称 4、按钮解释文字 5、按钮触发事件代码	6、	7、	8、	9、图标，CSS层叠样式 10、风格
	String sButtons[][] = {
		{"true","","Button","确定","确定","doSure()","","","","",""},
	};
%>
<%@include file="/Frame/resources/include/ui/include_info.jspf"%>
<script type="text/javascript">
	function selectCustomer(){
		AsDialog.SelectGridValue("PidrRateBsList","", "CustomerId@FinStaYear@SheetType@SheetTypeDivide", null,false, "", 
				function(sReturn){
			if(typeof(sReturn) != "undefined" &&  sReturn!="_CLEAR_" && sReturn.length != 0 ){
				sReturn = sReturn.split('@');
				var customerId = sReturn[0];
				setItemValue(0,0,"CustomerId",customerId);
				setItemValue(0,0,"FinStaYear",sReturn[1]);
				setItemValue(0,0,"SheetType",sReturn[2]);
				setItemValue(0,0,"SheetTypeDivide",sReturn[3]);
			}
		});
	}
	/*~[Describe=填写基本信息，并点击确定弹出页面进行数据编辑,InputParam=无,OutputParam=无]~*/
	function doSure(){
        var customerId = getItemValue(0,getRow(0),'CustomerId');//客户号
        var finstaYear = getItemValue(0,getRow(0),'FinstaYear');//报表年份
        var sheetType = getItemValue(0,getRow(0),'SheetType');//报表类型
        var sheetTypeDivide = getItemValue(0,getRow(0),'SheetTypeDivide');//报表类型细分
        setItemValue(0,0, "Stage", "1" );
   		var flag = checkPrimaryKey("<%=tableName%>","CustomerId@Stage");//判断新增记录是否已存在
   		if(flag){
   			alert("该客户信息已存在，不可再次新增！");
   			AsDialog.ClosePage();
   			return;
   		}
        if(!confirm("确定新增吗？")) return;
        //非as_save保存时的输入字段验证
        if(!iV_all(0)) return;
        //往表中插入两条记录，分别为本期信息、上期信息
		var retValue = RunJavaMethodTrans("com.amarsoft.app.pidr.integatedquery.PIDRRateFinanceInsertBs", "insetFinanceBs", 
				"TableName=<%=tableName%>,CustomerId=" + customerId 
				+ ",FinstaYear=" + finstaYear + ",SheetType=" + sheetType + ",SheetTypeDivide=" + sheetTypeDivide
				+ ",ManagerOrgId=<%=CurUser.getOrgID()%>,ManagerUserId=<%=CurUser.getUserID()%>" );
        if(retValue == "操作成功"){
        	var url = "";
        	if("<%=tableName%>" == "PIDR_RATE_BALANCESSHEET"){//资产负债表
            	url = "/PIDR/IntegatedQueryManage/CurrentDataManage/RateManage/PidrRateBalancessheet/PidrRateBalancessheetInfoFrame.jsp";
        	}else if("<%=tableName%>" == "PIDR_RATE_INCOME"){//利润表
        		url = "/PIDR/IntegatedQueryManage/CurrentDataManage/RateManage/PidrRateIncome/PidrRateIncomeInfoFrame.jsp";
        	}else if("<%=tableName%>" == "PIDR_RATE_CASHFLOW"){//现金流量表
        		url = "/PIDR/IntegatedQueryManage/CurrentDataManage/RateManage/PidrRateCashflow/PidrRateCashflowInfoFrame.jsp";
        	}else if("<%=tableName%>" == "PIDR_FINANCE_STATEMENT"){//补充报表
                url = "/PIDR/IntegatedQueryManage/CurrentDataManage/RateManage/PidrFinanceStatement/PidrFinanceStatementInfoFrame.jsp";
            }
        	//打开页面进行具体信息填写
        	AsDialog.PopView(url,'CustomerId=' + customerId +'&FinstaYear=' + finstaYear +'&SheetType=' + sheetType +'&SheetTypeDivide=' + sheetTypeDivide +'&OperationType=<%=PIDRConstants.OPERATIONTYPE_ADD%>','',function (){
        		AsDialog.ClosePage();
            });
        }else{
        	alert(retValue);
        }
	}
</script>
<%@ include file="/Frame/resources/include/include_end.jspf"%>