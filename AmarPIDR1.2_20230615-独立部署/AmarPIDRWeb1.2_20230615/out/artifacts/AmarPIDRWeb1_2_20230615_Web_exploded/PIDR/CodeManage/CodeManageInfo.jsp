<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="/Frame/resources/include/include_begin_info.jspf"%>
<%
/*
	Author:  wxli2 2018-10-31
	Content: 参数管理
	History Log: 
*/
	String prevUrl = CurPage.getParameter("PrevUrl");
    String codeNo = CurPage.getParameter("CodeNo");
    String subCodeNo = CurPage.getParameter("SubCodeNo");
    String pbCode = CurPage.getParameter("PbCode");
    String cbCode = CurPage.getParameter("CbCode");
	if(prevUrl == null) prevUrl = "";
	if(codeNo == null) codeNo = "";
	if(subCodeNo == null) subCodeNo = "";
	if(pbCode == null) pbCode = "";
	if(cbCode == null) cbCode = "";
	
	String templetNo = "PidrCodeLibrary";//--模板号--
	ASObjectModel doTemp = new ASObjectModel(templetNo);
	//详情部分字段只读
    doTemp.setReadOnly("CodeNo", true);
    doTemp.setReadOnly("PbCode", true);
    doTemp.setReadOnly("CbCode", true);
    doTemp.setReadOnly("SubCodeNo", true);
    
	doTemp.setJboWhere("CodeNo=:codeNo and SubCodeNo=:SubCodeNo and PbCode=:pbCode and CbCode=:CbCode");
	ASObjectWindow dwTemp = new ASObjectWindow(CurPage, doTemp,request);
	dwTemp.Style = "2";//freeform
	dwTemp.genHTMLObjectWindow(codeNo +"," + subCodeNo + "," +pbCode + "," +cbCode);
	String sButtons[][] = {
		{"true","All","Button","保存","保存所有修改","as_save(0)","","","",""},
		{"true","","Button","返回","返回列表","returnList()","","","",""}
	};
%>
<%@ include file="/Frame/resources/include/ui/include_info.jspf"%>
<script type="text/javascript">
	function returnList(){
		AsDialog.ClosePage();
	}
</script> 
<%@ include file="/Frame/resources/include/include_end.jspf"%>