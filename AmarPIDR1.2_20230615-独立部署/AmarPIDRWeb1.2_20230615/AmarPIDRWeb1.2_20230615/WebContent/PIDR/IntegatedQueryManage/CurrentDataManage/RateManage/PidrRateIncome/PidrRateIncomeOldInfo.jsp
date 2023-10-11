<%@ page pageEncoding="UTF-8"%>
<%@ include file="/Frame/resources/include/include_begin_info.jspf"%>
<%@ page import="com.amarsoft.app.pidr.util.ValidateErrors" %>
<%@ page import="com.amarsoft.app.pidr.common.PIDRConstants"%>
<%--  
    Author:  hlsong 
    CreationDate:2023-02-22
    Description:企业评级信息  当期数据    利润表   上期详情页面
--%>
<%
	String busiIdSerialNo = CurPage.getParameter("BusiIdSerialNo");//业务标示号
	String alertErrorKey = CurPage.getParameter("CustomerId");//修改校验错误出现段级错误，使用基础段主键查询
	if(busiIdSerialNo == null) busiIdSerialNo = "";
	if(alertErrorKey == null) alertErrorKey = "";
	String errMsg = "";
	HashMap<String, String> map=null;
	if(busiIdSerialNo != null && !PIDRConstants.VALUE_NULL.equals(busiIdSerialNo)) {
		map = ValidateErrors.getErrInfo(PIDRConstants.TABLE_PIDR_RATE_INCOME, busiIdSerialNo, Sqlca);
		for(String key : map.keySet()) {//提示信息英文名不用展示
		    errMsg += "错误字段"+map.get(key).substring(map.get(key).indexOf(":"))+"<br/>";
		}
	}else if(PIDRConstants.VALUE_NULL.equals(busiIdSerialNo)) {
		map = ValidateErrors.getNAErrInfo(PIDRConstants.TABLE_PIDR_RATE_INCOME, alertErrorKey, Sqlca);
		for(String key : map.keySet()) {//提示信息英文名不用展示
		    errMsg += "错误字段"+map.get(key).substring(map.get(key).indexOf(":"))+"<br/>";
		}
	}
	out.println("<div style='font-weight:bold'>"+errMsg+"</div>");
%>
<%
    ASObjectModel doTemp = new ASObjectModel("PidrRateIncomeInfo");
	if(busiIdSerialNo != null && map != null) {
		for(String key : map.keySet()) {
		    String msg=map.get(key);//获取提示信息集
	        String field = msg.substring(4,msg.indexOf(":"));//获取提示信息中的错误字段英文名
	        String[] fieldArr = field.split("@");//字段名可能有多个，均要标红
	        for(int i = 0;i<fieldArr.length;i++){
	            doTemp.setHTMLStyle(fieldArr[i],"style={border:1px solid red}");//把所有的错误字段红框标出
	            //doTemp.setReadOnly(fieldArr[i], false);
	        }
		}
	}
	String customerId=CurPage.getParameter("CustomerId");
	if(customerId == null) customerId = "";
	String finstaYear=CurPage.getParameter("FinstaYear");
	if(finstaYear == null) finstaYear = "";
	String sheetType=CurPage.getParameter("SheetType");
	if(sheetType == null) sheetType = "";
	String sheetTypeDivide=CurPage.getParameter("SheetTypeDivide");
	if(sheetTypeDivide == null) sheetTypeDivide = "";
	String stage=CurPage.getParameter("Stage");
	if(stage == null) stage = "";
	String operationType = CurPage.getParameter("OperationType");// 区分新增还是详情的标志
	if(operationType == null) operationType = "";
    doTemp.setBusinessProcess("com.amarsoft.app.awe.pidr.dwhandler.PidrRateIncomeHandler");
	doTemp.setJboWhere("CustomerId = :CustomerId" + " and FinstaYear = :FinstaYear" + " and SheetType = :SheetType" + " and SheetTypeDivide = :SheetTypeDivide" + " and Stage = :Stage" );
	
	ASObjectWindow dwTemp = new ASObjectWindow(CurPage,doTemp,request);
	dwTemp.Style="2";            //--设置为Grid风格--
    dwTemp.setParameter("CustomerId", customerId);
    dwTemp.setParameter("FinstaYear", finstaYear);
    dwTemp.setParameter("SheetType", sheetType);
    dwTemp.setParameter("SheetTypeDivide", sheetTypeDivide);
    dwTemp.setParameter("Stage", stage);
    dwTemp.genHTMLObjectWindow("" );
	/*  按钮数组定义，依次为: 
    0.是否显示， "true"/"false",默认为true； 1.权限类型， 除了新增、删除和保存三个按钮可为空外，其他均设置为'All'； 2.类型， 类型，默认为Button； 3.按钮文字   
    4.提示文字  5.函数名   6.shortcutKey 快捷键   7.href 资源路径 8.parm 资源路径参数   9.iconCls 图标 CSS名称 (可用button.css中定义的样式，也可直接使用font-awesome的图标) 
 */  
    String sButtons[][] = {  
        {"true","","Button","保存","保存","saveRecord()","","","","",""},
    };
%>
<%@include file="/Frame/resources/include/ui/include_info.jspf"%>
<script type="text/javascript">
	/*~[Describe=保存,InputParam=无,OutputParam=无]~*/
	function saveRecord(){
		var recordFlag = getItemValue(0,getRow(0),'RecordFlag');// 记录标志
		if(isUserChanged()){//页面是否发生变化
			if(confirm("确定保存吗？")){
				if(recordFlag == '<%=PIDRConstants.RECORDFLAG_R%>'){//页面编辑修改后，若原本记录标志为R，需要修改记录标志
					setItemValue(0,0, "RecordFlag", "<%=PIDRConstants.RECORDFLAG_U%>" );
				}
				as_save(0,"check()");//新增页面，保存之后的操作
			}
		}else{
			//alert("页面信息未变化，无需保存");
			as_save(0,"check()");//新增页面，保存之后的操作
		}
	}
    /*~[Describe=保存完,检查营业利润和净利润的规则,InputParam=无,OutputParam=无]~*/
    function check(){
        var operatingProfits = getItemValue(0,getRow(0),'OperatingProfits');
        var netProfit = getItemValue(0,getRow(0),'NetProfit');
        if(operatingProfits==0.00 && netProfit==0.00){
            alert("二、营业利润(亏损以“-”号填列)和四、净利润(净亏损以“-”号填列)不能同时为0，请重新修改合计");
        }
        //保存之后的处理
    	var customerId = getItemValue(0,getRow(0),'CustomerId');// 客户编号
    	var finstaYear = getItemValue(0,getRow(0),'FinstaYear');//报表年份
        var sheetType = getItemValue(0,getRow(0),'SheetType');//报表类型
        var sheetTypeDivide = getItemValue(0,getRow(0),'SheetTypeDivide');//报表类型细分
    	if('<%=operationType%>' == '<%=PIDRConstants.OPERATIONTYPE_ADD%>'){//新增
    		alert("新增时\n请确保除对外投资信息段、负面信息段外，其余信息段均有对应记录\n存在对外投资信息、负面信息则在对应信息段新增，不存在可不新增");
    	}else{//详情的保存
    		var retValue = RunJavaMethodTrans("com.amarsoft.app.pidr.integatedquery.PIDRRateUpdateHandler", "reverseUpdate", "CustomerId=" + customerId 
    				+",FinStaYear=" + finstaYear + ",SheetType=" + sheetType + ",SheetTypeDivide=" + sheetTypeDivide
    				+",TableName=PIDR_RATE_INCOME");
    		if("success" != retValue){
				alert("反向更新记录标志失败！");
			}
    		parent.reloadSelf();
    	}
    }
    /*~[Describe=查看历史记录,InputParam=无,OutputParam=无]~*/
    /* 处理详情页面的中文描述换行 问题 */
    window.onload = function(){
    	$('.info_td_left').width('400px');
    	$('.info_td_left_even').width('400px');
        $('.info_div_header').width('400px');
    }
</script>
<%@ include file="/Frame/resources/include/include_end.jspf"%>
<style type="text/css">
        #Title_1240{
            font-size:15px;
            font-weight:bolder;
        }
         #Title_1290{
            font-size:15px;
            font-weight:bolder;
        }
         #Title_1270{
            font-size:15px;
            font-weight:bolder;
        }
</style>
