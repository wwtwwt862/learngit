<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="/Frame/resources/include/include_begin_info.jspf"%>
<%@ page import="java.util.Date" %>
<%
	String prevUrl = CurPage.getParameter("PrevUrl");
	if(prevUrl == null) prevUrl = "";

	String templetNo = "PidrCodeLibrary";//--模板号--

 	ASObjectModel doTemp = new ASObjectModel(templetNo);
	doTemp.setJboWhere("1=2");
	ASObjectWindow dwTemp = new ASObjectWindow(CurPage,doTemp,request);
	dwTemp.Style = "2";//freeform
	dwTemp.genHTMLObjectWindow("");
	String sButtons[][] = {
		{"true","All","Button","保存","保存所有修改","save()","","","",""},
		{String.valueOf(!com.amarsoft.are.lang.StringX.isSpace(prevUrl)),"All","Button","返回","返回列表","returnList()","","","",""}
	};
%>
<%@ include file="/Frame/resources/include/ui/include_info.jspf"%>
<script type="text/javascript">
    function save(){
    	if(checkPrimaryKey("PIDR_CODE_LIBRARY","APPLICATIONCODE@CODENO@PBCODE@CBCODE@SUBCODENO")){
            alert("该参数信息已存在！");
            return;
        }else{
            as_save(0,"returnList()");
        }
    }
	function returnList(){
		AsDialog.ClosePage();
	}
	function initRow(){
        if(getRowCount(0)==0){
            setItemValue(0, getRow(), "INPUTUSER", "<%=CurUser.getUserID()%>");
            setItemValue(0, getRow(), "INPUTUSERName", "<%=CurUser.getUserName()%>");
            setItemValue(0, getRow(), "INPUTORG", "<%=CurUser.getOrgID()%>");
            setItemValue(0, getRow(), "INPUTORGName", "<%=CurUser.getOrgName()%>");
            setItemValue(0, getRow(), "INPUTTIME", "<%=DateX.format(new Date(), "yyyy-MM-dd HH:mm:ss")%>");
            setItemValue(0, getRow(), "UPDATEUSER", "<%=CurUser.getUserID()%>");
            setItemValue(0, getRow(), "UPDATEUSERName", "<%=CurUser.getUserName()%>");
            setItemValue(0, getRow(), "UPDATETIME", "<%=DateX.format(new Date(), "yyyy-MM-dd HH:mm:ss")%>");
        }
    }
    initRow();
</script>
<%@ include file="/Frame/resources/include/include_end.jspf"%>