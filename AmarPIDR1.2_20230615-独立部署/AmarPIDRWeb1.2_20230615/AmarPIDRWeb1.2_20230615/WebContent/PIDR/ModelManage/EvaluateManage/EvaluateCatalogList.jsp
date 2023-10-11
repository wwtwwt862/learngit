<%@ page pageEncoding="UTF-8"%><%@
 include file="/Frame/resources/include/include_begin_list.jspf"%><%
	/*
		Content: 评估模型目录列表
	 */
	String sType =  CurPage.getParameter("Type");
	if(sType == null) sType = "";
	sASWizardHtml = "<div><font size=\"2pt\" color=\"#930055\">"+("Classify".equals(sType)?"分类":"评估")+"模型目录列表</font></div>";
	
	ASObjectModel doTemp = new ASObjectModel("EvaluateCatalogList");
	doTemp.setBusinessProcess("com.amarsoft.app.awe.pidr.dwhandler.PidrEvaluateCatalogHandler");
	//模型类型参见代码EvaluateModelType
	if("CreditLevel".equals(sType)){ //信用等级评估	(公司客户和个人)
		doTemp.appendJboWhere(" ModelType in ('010','012','015','017') ");
	}
	
	doTemp.appendHTMLStyle("","style=\"cursor: pointer;\" ondblclick=\"javascript:viewAndEdit()\"");
	
	ASObjectWindow dwTemp = new ASObjectWindow(CurPage,doTemp,request);
	dwTemp.Style="1";      //设置DW风格 1:Grid 2:Freeform
	dwTemp.ReadOnly = "1"; //设置是否只读 1:只读 0:可写
	dwTemp.setPageSize(200);
	dwTemp.genHTMLObjectWindow("");
	
	String sButtons[][] = {
		{"true","All","Button","新增","新增一条记录","newRecord()","","","",""},
		{"true","All","Button","删除","删除所选中的记录","deleteRecord()","","","",""},
		{"true","","Button","模型列表","查看/修改模型列表","viewModelList()","","","","btn_icon_edit"},
	};
%><%@include file="/Frame/resources/include/ui/include_list.jspf"%>
<script type="text/javascript">
	function newRecord(){
		parent.OpenDetail("");
		AsControl.OpenView("/Blank.jsp", "", "frameright");
	}

	/*~[Describe=查看/修改模型列表;]~*/
	function viewModelList(){
		var sModelNo = getItemValue(0,getRow(),"ModelNo");
		if(typeof(sModelNo)=="undefined" || sModelNo.length==0) {
			alert(getMessageText('AWEW1001'));//请选择一条信息！
			return ;
		}
		parent.parent.OpenModelList(sModelNo);
	}
	

	function deleteRecord(){
		var sModelNo = getItemValue(0,getRow(),"ModelNo");
		if(typeof(sModelNo)=="undefined" || sModelNo.length==0) {
			alert(getMessageText('AWEW1001'));//请选择一条信息！
			return ;
		}
		if(confirm(getMessageText('AWEW1050'))){
			as_delete(0);
		}
	}
	
	function mySelectRow(){
		var sModelNo = getItemValue(0,getRow(),"ModelNo");
		if(typeof(sModelNo)=="undefined" || sModelNo.length==0) {
			return;
		}
	  	parent.OpenDetail(sModelNo); //联动打开详情页面
	  	parent.parent.OpenModelList(sModelNo);
	}
	$(document).ready(function(){
		mySelectRow();
	});
</script>	
<%@ include file="/Frame/resources/include/include_end.jspf"%>