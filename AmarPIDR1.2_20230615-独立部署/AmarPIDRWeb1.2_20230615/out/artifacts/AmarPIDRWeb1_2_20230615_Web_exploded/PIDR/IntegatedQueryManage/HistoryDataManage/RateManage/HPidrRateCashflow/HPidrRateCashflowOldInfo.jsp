<%@ page pageEncoding="UTF-8"%>
<%@ include file="/Frame/resources/include/include_begin_info.jspf"%>
<%@ page import="com.amarsoft.app.pidr.common.PIDRConstants"%>
<%@ page import="com.amarsoft.app.pidr.util.FeedbackErrors" %>
 <%--  
    Author:  hlsong 
    CreationDate:2023-02-22
    Description:企业评级信息  历史数据    现金流量表   上期详情页面
--%>
<%
    String bsBusiIdSerialNo = CurPage.getParameter("CustomerId");//业务标示号
    if(bsBusiIdSerialNo==null) bsBusiIdSerialNo="";
    String fNo = CurPage.getParameter("fNo");//反馈处理编号
    if(fNo == null) fNo = "";
    String messageType = CurPage.getParameter("MessageType");//报文类型
    if(messageType == null) messageType = "";
    HashMap<String, String> errFieldMap= new HashMap<String, String>();
    if(fNo != null) {
        errFieldMap = FeedbackErrors.getfeedbackErrField(bsBusiIdSerialNo,messageType, Sqlca);
    }
  
    ASObjectModel doTemp = new ASObjectModel("HPidrRateCashflowInfo");
	String customerId=CurPage.getParameter("CustomerId");
	if(customerId == null) customerId = "";
	String finstaYear=CurPage.getParameter("FinstaYear");
	if(finstaYear == null) finstaYear = "";
	String sheetType=CurPage.getParameter("SheetType");
	if(sheetType == null) sheetType = "";
	String sheetTypeDivide=CurPage.getParameter("SheetTypeDivide");
	if(sheetTypeDivide == null) sheetTypeDivide = "";
	String sessionId=CurPage.getParameter("SessionId");
	if(sessionId == null) sessionId = "";
	String stage=CurPage.getParameter("Stage");
	if(stage == null) stage = "";
	String errMsg = "";
    for(String errField :errFieldMap.keySet()){
        doTemp.setHTMLStyle(errField,"style={border:1px solid red}");//把所有的错误字段红框标出
        if(doTemp.getColumn(errField)!=null){
            errMsg += errFieldMap.get(errField)+"<br/>";
        }
    }
    out.println("<div style='font-weight:bold'>"+errMsg+"</div>");
	String rightType = CurPage.getParameter("RightType");// 页面只读控制
	if(rightType == null) rightType = "ReadOnly";
	doTemp.setJboWhere("CustomerId = :CustomerId and FinstaYear = :FinstaYear and SheetType = :SheetType and SheetTypeDivide = :SheetTypeDivide and SessionId = :SessionId and Stage = :Stage" );
    doTemp.setBusinessProcess("com.amarsoft.app.awe.pidr.dwhandler.PidrRateCashflowHandler");
	ASObjectWindow dwTemp = new ASObjectWindow(CurPage,doTemp,request);
	dwTemp.Style="2";            //--设置为Grid风格--
    dwTemp.setParameter("SessionId", sessionId);
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
    	{PIDRConstants.RIGHTTYPE_READONLY.equals(rightType)? "false":"true","","Button","保存","保存","if(confirm('确定保存吗？')) as_save(0)","","","","",""},
    };
%>
<%@include file="/Frame/resources/include/ui/include_info.jspf"%>
<script type="text/javascript">
/*~[Describe=处理详情页面的中文描述换行,InputParam=无,OutputParam=无]~*/
    window.onload = function(){
    	$('.info_td_left').width('400px');
    	$('.info_td_left_even').width('400px');
        $('.info_div_header').width('400px');
    }
</script>
<%@ include file="/Frame/resources/include/include_end.jspf"%>
<style type="text/css">
        #Title_1140{
            font-size:15px;
            font-weight:bolder;
        }
         #Title_1190{
            font-size:15px;
            font-weight:bolder;
        }
        #Title_1200{
            font-size:15px;
            font-weight:bolder;
        }
         #Title_1260{
            font-size:15px;
            font-weight:bolder;
        }
         #Title_1310{
            font-size:15px;
            font-weight:bolder;
        }
        #Title_1320{
            font-size:15px;
            font-weight:bolder;
        }
         #Title_1360{
            font-size:15px;
            font-weight:bolder;
        }
         #Title_1400{
            font-size:15px;
            font-weight:bolder;
        }
         #Title_1410{
            font-size:15px;
            font-weight:bolder;
        }
         #Title_1430{
            font-size:15px;
            font-weight:bolder;
        }
         #Title_1450{
            font-size:15px;
            font-weight:bolder;
        }
</style>
