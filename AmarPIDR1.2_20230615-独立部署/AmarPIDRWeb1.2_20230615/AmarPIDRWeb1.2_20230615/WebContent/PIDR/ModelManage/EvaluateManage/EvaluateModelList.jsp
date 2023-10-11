<%@ page pageEncoding="UTF-8"%><%@
 include file="/Frame/resources/include/include_begin_list.jspf"%><%
	/*
		Content: 评估模型列表
	 */
 	sASWizardHtml = "<div><font size=\"2pt\" color=\"#930055\">模型项列表</font></div>";
    String sModelNo =  CurPage.getParameter("ModelNo");
	if (sModelNo == null) sModelNo = "";
	ASObjectModel doTemp = new ASObjectModel("EvaluateModelList");
	doTemp.appendHTMLStyle("","style=\"cursor: pointer;\" ondblclick=\"javascript:viewAndEdit()\"");
	doTemp.appendJboWhere(" and O.ModelNo=:ModelNo ");
	ASObjectWindow dwTemp = new ASObjectWindow(CurPage,doTemp,request);
	dwTemp.Style="1";      //设置DW风格 1:Grid 2:Freeform
	dwTemp.ReadOnly = "1"; //设置是否只读 1:只读 0:可写
	dwTemp.setPageSize(30);
	dwTemp.setParameter("ModelNo", sModelNo);
	dwTemp.genHTMLObjectWindow("");
	
	String sButtons[][] = {
		{"true","All","Button","新增","新增一条记录","newRecord()","","","",""},
		{"true","","Button","详情","查看/修改详情","viewAndEdit()","","","",""},
		{"true","All","Button","删除","删除所选中的记录","deleteRecord()","","","",""},
	};
%><%@include file="/Frame/resources/include/ui/include_list.jspf"%>
<script type="text/javascript">
	setDialogTitle("评估模型列表");
	function newRecord(){
		AsDialog.PopView("/PIDR/ModelManage/EvaluateManage/EvaluateModelInfo.jsp","ModelNo=<%=sModelNo%>","",function(){reloadSelf();});
	}
	
	function viewAndEdit(){
		var sModelNo = getItemValue(0,getRow(),"ModelNo");
       	var sItemNo = getItemValue(0,getRow(),"ItemNo");
       	if(typeof(sModelNo)=="undefined" || sModelNo.length==0) {
			alert(getMessageText('AWEW1001'));//请选择一条信息！
			return ;
		}
		AsDialog.PopView("/PIDR/ModelManage/EvaluateManage/EvaluateModelInfo.jsp","ModelNo="+sModelNo+"&ItemNo="+sItemNo,"",function(){reloadSelf();});
	}

	function deleteRecord(){
		var sItemNo = getItemValue(0,getRow(),"ItemNo");
		if(typeof(sItemNo)=="undefined" || sItemNo.length==0) {
			alert(getMessageText('AWEW1001'));//请选择一条信息！
			return ;
		}
		if(confirm(getMessageText('AWEW1002'))){
			as_delete("myiframe0");
		}
	}
</script>	
<%@ include file="/Frame/resources/include/include_end.jspf"%>
