<%@ page pageEncoding="UTF-8"%>
<%@ include file="/Frame/resources/include/include_begin_info.jspf"%>
<%@ page import="com.amarsoft.app.pidr.util.ValidateErrors" %>
<%@ page import="com.amarsoft.app.pidr.common.PIDRConstants"%>
<%@ page import="java.util.Date" %>
 <%--  
    Author:  hlsong 
    CreationDate:2023-02-22
    Description:企业评级信息  当期数据    资产负债表   上期详情页面
--%>
<%
	String busiIdSerialNo = CurPage.getParameter("BusiIdSerialNo");//业务标示号
	String alertErrorKey = CurPage.getParameter("CustomerId");//修改校验错误出现段级错误，使用基础段主键查询
	if(busiIdSerialNo == null) busiIdSerialNo = "";
	if(alertErrorKey == null) alertErrorKey = "";
	String errMsg = "";
	HashMap<String, String> map=null;
	if(busiIdSerialNo != null && !PIDRConstants.VALUE_NULL.equals(busiIdSerialNo)) {
		map = ValidateErrors.getErrInfo(PIDRConstants.TABLE_PIDR_RATE_BALANCESSHEET, busiIdSerialNo, Sqlca);
		for(String key : map.keySet()) {//提示信息英文名不用展示
		    errMsg += "错误字段"+map.get(key).substring(map.get(key).indexOf(":"))+"<br/>";
		}
	}else if(PIDRConstants.VALUE_NULL.equals(busiIdSerialNo)) {
		map = ValidateErrors.getNAErrInfo(PIDRConstants.TABLE_PIDR_RATE_BALANCESSHEET, alertErrorKey, Sqlca);
		for(String key : map.keySet()) {//提示信息英文名不用展示
		    errMsg += "错误字段"+map.get(key).substring(map.get(key).indexOf(":"))+"<br/>";
		}
	}
	out.println("<div style='font-weight:bold'>"+errMsg+"</div>");
%>
<%
    ASObjectModel doTemp = new ASObjectModel("PidrRateBalancessheetInfo");
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
    doTemp.setBusinessProcess("com.amarsoft.app.awe.pidr.dwhandler.PidrRateHandler");
    doTemp.setJboWhere("CustomerId = :CustomerId and FinstaYear = :FinstaYear and SheetType = :SheetType and SheetTypeDivide = :SheetTypeDivide and Stage = :Stage" );
    
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
	        {"true","All","Button","保存","保存所有修改","saveRecord()","","","",""},
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
/*~[Describe=保存数据后,检查资产总计=负债和所有者权益(或股东权益)总计,InputParam=无,OutputParam=无]~*/
function check(){
	var totalAssets = getItemValue(0,getRow(0),'TotalAssets');
	var totalEquityAndLiabilities = getItemValue(0,getRow(0),'TotalEquityAndLiabilities');
	if(totalAssets != totalEquityAndLiabilities){
		alert("资产总计与负债和所有者权益(或股东权益)总计不一致，请重新修改合计!");
	}
	if(totalAssets==0.00) alert("资产总计不应等于0，请重新修改合计!");
	//保存之后的处理
	var customerId = getItemValue(0,getRow(0),'CustomerId');// 客户编号
	var finstaYear = getItemValue(0,getRow(0),'FinstaYear');//报表年份
    var sheetType = getItemValue(0,getRow(0),'SheetType');//报表类型
    var sheetTypeDivide = getItemValue(0,getRow(0),'SheetTypeDivide');//报表类型细分
	if('<%=operationType%>' == '<%=PIDRConstants.OPERATIONTYPE_ADD%>'){//新增
		alert("新增时\n请确保除对外投资信息段、负面信息段外，其余信息段均有对应记录\n存在对外投资信息、负面信息则在对应信息段新增，不存在可不新增");
	}else{//详情的保存
		//反向更新操作
		var retValue = RunJavaMethodTrans("com.amarsoft.app.pidr.integatedquery.PIDRRateUpdateHandler", "reverseUpdate", "CustomerId=" + customerId 
				+",FinStaYear=" + finstaYear + ",SheetType=" + sheetType + ",SheetTypeDivide=" + sheetTypeDivide
				+",TableName=PIDR_RATE_BALANCESSHEET");
		if("success" != retValue){
			alert("反向更新记录标志失败！");
		}
		parent.reloadSelf();
	}
}
/*~[Describe=处理详情页面的中文描述换行,InputParam=无,OutputParam=无]~*/
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
        #Title_1430{
            font-size:15px;
            font-weight:bolder;
        }
        #Title_1440{
            font-size:15px;
            font-weight:bolder;
        }
        #Title_1580{
            font-size:15px;
            font-weight:bolder;
        }
        #Title_1690{
            font-size:15px;
            font-weight:bolder;
        }
        #Title_1700{
            font-size:15px;
            font-weight:bolder;
        }
        #Title_1810{
            font-size:15px;
            font-weight:bolder;
        }
          #Title_1820{
            font-size:15px;
            font-weight:bolder;
        }
</style>

