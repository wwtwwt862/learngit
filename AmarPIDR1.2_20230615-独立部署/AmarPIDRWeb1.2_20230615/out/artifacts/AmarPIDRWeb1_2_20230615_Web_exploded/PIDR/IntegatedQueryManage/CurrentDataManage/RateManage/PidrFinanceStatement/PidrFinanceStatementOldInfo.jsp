<%@ page pageEncoding="UTF-8"%>
<%@ include file="/Frame/resources/include/include_begin_info.jspf"%>
<%@ page import="com.amarsoft.app.pidr.util.ValidateErrors" %>
<%@ page import="com.amarsoft.app.pidr.common.PIDRConstants"%>
 <%--  
    Author:  hlsong 
    CreationDate:2023-02-22
    Description:企业评级信息  当期数据    现金流量表   上期详情页面
--%>
<%
	String busiIdSerialNo = CurPage.getParameter("BusiIdSerialNo");//业务标示号
	String alertErrorKey = CurPage.getParameter("CustomerId");//修改校验错误出现段级错误，使用基础段主键查询
	if(alertErrorKey == null) alertErrorKey = "";	
	if(busiIdSerialNo == null) busiIdSerialNo = "";
	String errMsg = "";
	HashMap<String, String> map=null;
	if(busiIdSerialNo != null && !PIDRConstants.VALUE_NULL.equals(busiIdSerialNo)) {
		map = ValidateErrors.getErrInfo(PIDRConstants.TABLE_PIDR_RATE_CASHFLOW, busiIdSerialNo, Sqlca);
		for(String key : map.keySet()) {//提示信息英文名不用展示
		    errMsg += "错误字段"+map.get(key).substring(map.get(key).indexOf(":"))+"<br/>";
		}
	}else if(PIDRConstants.VALUE_NULL.equals(busiIdSerialNo)) {
		map = ValidateErrors.getNAErrInfo(PIDRConstants.TABLE_PIDR_RATE_CASHFLOW, alertErrorKey, Sqlca);
		for(String key : map.keySet()) {//提示信息英文名不用展示
		    errMsg += "错误字段"+map.get(key).substring(map.get(key).indexOf(":"))+"<br/>";
		}
	}
	out.println("<div style='font-weight:bold'>"+errMsg+"</div>");
%>
<%
    ASObjectModel doTemp = new ASObjectModel("PidrFinanceStatementInfo");
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
	    as_save(0);//新增页面，保存之后的操作
	}
	 $('input').each(function(){
			if($(this).val() == ''){
				$(this).val('0.00');
			}
		});
</script>
<%@ include file="/Frame/resources/include/include_end.jspf"%>
