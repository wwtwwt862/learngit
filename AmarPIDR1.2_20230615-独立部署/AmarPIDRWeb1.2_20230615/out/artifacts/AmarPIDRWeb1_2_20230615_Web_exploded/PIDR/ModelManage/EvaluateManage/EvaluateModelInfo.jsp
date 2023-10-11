<%@ page pageEncoding="UTF-8"%><%@
 include file="/Frame/resources/include/include_begin_info.jspf"%><%
	/*
		Content:    评估模型详情
	 */
	//获得组件参数 ModelNo：报表记录编号		ItemNo：阶段编号	
	String sModelNo =  CurPage.getParameter("ModelNo");
	String sItemNo =  CurPage.getParameter("ItemNo");
    if(sModelNo==null) sModelNo="";
	if(sItemNo==null) sItemNo="";

	ASObjectModel doTemp = new ASObjectModel("EvaluateModelInfo");
	doTemp.setBusinessProcess("com.amarsoft.awe.dw.handler.impl.CommonHandler");
	ASObjectWindow dwTemp = new ASObjectWindow(CurPage,doTemp,request);
	dwTemp.Style="2";      //设置DW风格 1:Grid 2:Freeform
	dwTemp.ReadOnly = "0"; //设置是否只读 1:只读 0:可写
    doTemp.setVisible("ValueCode", false);
	dwTemp.genHTMLObjectWindow(sModelNo+","+sItemNo);
	
	String sButtons[][] = {
		{"true","All","Button","保存并返回","保存修改并返回","saveRecordAndReturn()","","","",""},
		{"true","All","Button","保存并新增","保存修改并新增另一条记录","saveRecordAndAdd()","","","",""},
	};
%><%@include file="/Frame/resources/include/ui/include_info.jspf"%>
<script type="text/javascript">
	setDialogTitle("评估模型详情");
	setItemValue(0,0,"ModelNo","<%=sModelNo%>");
	setItemReadOnly(0,0,"ValueCode",true);
	var sOldItemNo = getItemValue(0, 0, "ItemNo");
	function saveRecord(sFun){
		as_save("myiframe0",sFun);
	}

	function saveRecordAndReturn(){
		saveRecord("AsDialog.ClosePage();");
	}
	
	function saveRecordAndAdd(){
		saveRecord("newRecord()");
	}
    
	function newRecord(){
		sModelNo = getItemValue(0,getRow(),"ModelNo");
		AsControl.OpenComp("/PIDR/ModelManage/EvaluateManage/EvaluateModelInfo.jsp","ModelNo="+sModelNo,"_self","");
	}

	function SelectCode(sType){
		if(sType == "ALL"){
			var sCodeNo = getItemValue(0,getRow(),"ValueCode");
			AsDialog.SetGridValue("CodeCatalogList", "", "ValueCode=CODENO", sCodeNo, false);
		}
	}
</script>	
<%@ include file="/Frame/resources/include/include_end.jspf"%>
