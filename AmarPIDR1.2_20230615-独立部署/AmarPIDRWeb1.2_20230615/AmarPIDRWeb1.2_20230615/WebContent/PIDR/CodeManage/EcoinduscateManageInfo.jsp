<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="/Frame/resources/include/include_begin_info.jspf"%>
<%@ page import="com.amarsoft.app.pidr.common.PIDRConstants"%>
<%
/*
	Author:  wxli2 2018-10-31
	Content: 参数管理
	History Log: 
*/
	String ecoinduscate = CurPage.getParameter("Ecoinduscate");
    String modelNo = CurPage.getParameter("ModelNo");
    String flag = CurPage.getParameter("Flag");
	if(ecoinduscate == null) ecoinduscate = "";
    if(modelNo == null) modelNo = "";
    if(flag == null) flag = "";
	String templetNo = "EcoinduscateManageInfo";//--模板号--
	ASObjectModel doTemp = new ASObjectModel(templetNo);
	//详情部分字段只读
	doTemp.appendJboWhere("Ecoinduscate = :Ecoinduscate and ModelNo = :ModelNo");
	if(PIDRConstants.FLAG_TRUE.equals(flag)){
		doTemp.setReadOnly("*", false);
	}
	ASObjectWindow dwTemp = new ASObjectWindow(CurPage, doTemp,request);
	dwTemp.Style = "2";//freeform
	dwTemp.setParameter("Ecoinduscate", ecoinduscate);
	dwTemp.setParameter("ModelNo", modelNo);
	dwTemp.genHTMLObjectWindow("");
	String sButtons[][] = {
		{"true","All","Button","保存","保存所有修改","save()","","","",""},
		{"true","","Button","返回","返回列表","returnList()","","","",""}
	};
%>
<%@ include file="/Frame/resources/include/ui/include_info.jspf"%>
<script type="text/javascript">
function save(){
    if(checkPrimaryKey("PIDR_ECOINDUSCATE_LIBRARY","MODELNO@ECOINDUSCATE")){
        alert("该参数信息已存在！");
        return;
    }else{
    	as_save(0,"returnList()");
    }
}
	function returnList(){
		AsDialog.ClosePage();
	}
	/** 页面字段的显示长度调整 */
	window.onload = function(){
	     $('.info_div_header').width('300px');
	 }
</script> 
<%@ include file="/Frame/resources/include/include_end.jspf"%>