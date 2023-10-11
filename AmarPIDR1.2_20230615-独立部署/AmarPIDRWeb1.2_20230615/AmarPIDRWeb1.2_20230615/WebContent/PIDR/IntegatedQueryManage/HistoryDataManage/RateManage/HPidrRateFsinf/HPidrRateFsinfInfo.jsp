<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="/Frame/resources/include/include_begin_info.jspf"%>
<%@ page import="com.amarsoft.app.pidr.common.PIDRConstants"%>
<%@ page import="com.amarsoft.app.pidr.util.FeedbackErrors" %>
<%--  
	Author: nxxiong
	CreationDate: 2023-02-22
	Description: 综合查询-历史数据-企业评级信息记录-基本概况段信息表详情页面
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
  
%>
<%	
	ASObjectModel doTemp = new ASObjectModel("PidrRateFsinfInfo");
	doTemp.setJboClass("jbo.pidr.HPIDR_RATE_FSINF");// 设置JBO对象

	// 功能按钮和数据筛选
	String rightType = CurPage.getParameter("RightType");// 页面只读控制
	if(rightType == null) rightType = "";
	String sessionId = CurPage.getParameter("SessionId");// 期次号
	if(sessionId == null) sessionId = "";
	String customerId = CurPage.getParameter("CustomerId");// 客户编号
	if(customerId == null) customerId = "";
	String errMsg = "";
    for(String errField :errFieldMap.keySet()){
        doTemp.setHTMLStyle(errField,"style={border:1px solid red}");//把所有的错误字段红框标出
        if(doTemp.getColumn(errField)!=null){
            errMsg += errFieldMap.get(errField)+"<br/>";
        }
    }

	doTemp.appendJboWhere("SessionId = :SessionId and CustomerId = :CustomerId");
	if(PIDRConstants.RIGHTTYPE_READONLY.equals(rightType)) {// 移除日期选择事件
		doTemp.setColInnerBtEvent("EstablishDate", null);
	}else {
		doTemp.setHtmlEvent("AdmDivOfRegName", "onClick", "getRegionCode");
		doTemp.setHtmlEvent("EcoIndusCateName", "onClick", "getEcoIndusCate");
	}
	
	ASObjectWindow dwTemp = new ASObjectWindow(CurPage,doTemp,request);
	dwTemp.Style="2";      	     //--设置为Grid风格--
	dwTemp.setParameter("SessionId", sessionId);
	dwTemp.setParameter("CustomerId", customerId);
	dwTemp.genHTMLObjectWindow("");

	//0、是否展示 1、	权限控制  2、 展示类型 3、按钮显示名称 4、按钮解释文字 5、按钮触发事件代码	6、	7、	8、	9、图标，CSS层叠样式 10、风格
	String sButtons[][] = {
		{PIDRConstants.RIGHTTYPE_READONLY.equals(rightType)? "false":"true","","Button","保存","保存","if(confirm('确定保存吗？')) as_save(0)","","","","",""},
	};
%>
<%@include file="/Frame/resources/include/ui/include_info.jspf"%>
<script type="text/javascript">
	/*~[Describe=弹出行政规划选择窗口，并置将返回的值设置到指定的域;InputParam=无;OutPutParam=无;]~*/
	function getRegionCode(){
		var admDivOfReg = getItemValue(0,getRow(),"AdmDivOfReg");
		var admDivOfRegName = getItemValue(0,getRow(),"AdmDivOfRegName");
		AsDialog.PopView("/Common/Tools/PIDRVFrame.jsp","AreaCode="+admDivOfReg+"&SelectItem=AreaCode","dialogWidth=1000px;dialogHeight=600px;center:yes;status:no;statusbar:no",function(areaCodeInfo){
			//增加清空功能的判断
			if(areaCodeInfo == "NO" || areaCodeInfo == '_CLEAR_'|| areaCodeInfo == '_NONE_'){
				setItemValue(0,getRow(),"AdmDivOfReg","");
				setItemValue(0,getRow(),"AdmDivOfRegName","");
			}else if(areaCodeInfo == "CANCEL" || areaCodeInfo == ''){
				setItemValue(0,getRow(),"AdmDivOfReg",admDivOfReg);
				setItemValue(0,getRow(),"AdmDivOfRegName",admDivOfRegName);
			}else{
				 if(typeof(areaCodeInfo) != "undefined" && areaCodeInfo != ""){
					areaCodeInfo = areaCodeInfo.split('@');
					areaCodeValue = areaCodeInfo[0];//-- 行政区划代码
					areaCodeName = areaCodeInfo[1];//--行政区划名称
					setItemValue(0,getRow(),"AdmDivOfReg",areaCodeValue);
					setItemValue(0,getRow(),"AdmDivOfRegName",areaCodeName);				
				}
			}
		});
	}
	
	/*~[Describe=弹出行业分类选择窗口，并置将返回的值设置到指定的域;InputParam=无;OutPutParam=无;]~*/
	function getEcoIndusCate(){
		 var ecoIndusCate = getItemValue(0,getRow(),"EcoIndusCate");
		 var ecoIndusCateName = getItemValue(0,getRow(),"EcoIndusCateName");
			AsDialog.PopView("/Common/Tools/PIDRVFrame.jsp","EcoIndusCate="+ecoIndusCate+"&SelectItem=EcoIndusCate","dialogWidth=1000px;dialogHeight=600px;center:yes;status:no;statusbar:no",function(ecoIndusCateInfo){
				//增加清空功能的判断
				if(ecoIndusCateInfo == "NO" || ecoIndusCateInfo == '_CLEAR_'|| ecoIndusCateInfo == '_NONE_'){
					setItemValue(0,getRow(),"EcoIndusCate","");
					setItemValue(0,getRow(),"EcoIndusCateName","");
				}else if(ecoIndusCateInfo == "CANCEL" || ecoIndusCateInfo == ''){
					setItemValue(0,getRow(),"EcoIndusCate",ecoIndusCate);
					setItemValue(0,getRow(),"EcoIndusCateName",ecoIndusCateName);
				}else{
					 if(typeof(ecoIndusCateInfo) != "undefined" && ecoIndusCateInfo != ""){
						ecoIndusCateInfo = ecoIndusCateInfo.split('@');
						ecoIndusCateValue = ecoIndusCateInfo[0];//-- 行业分类代码
						ecoIndusCateName = ecoIndusCateInfo[1];//--行业分类名称
						setItemValue(0,getRow(),"EcoIndusCate",ecoIndusCateValue);
						setItemValue(0,getRow(),"EcoIndusCateName",ecoIndusCateName);				
					}
				}
			});
	 }

	/*~[Describe=调整详情界面字段描述长度,InputParam=无,OutputParam=无]~*/
	window.onload = function(){
        $('.info_div_header').width('180px');
    }
</script>
<%@ include file="/Frame/resources/include/include_end.jspf"%>