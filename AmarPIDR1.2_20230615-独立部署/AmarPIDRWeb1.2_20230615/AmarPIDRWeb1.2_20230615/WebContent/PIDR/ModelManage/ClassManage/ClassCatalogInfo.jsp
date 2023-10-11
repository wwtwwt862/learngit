<%@ page pageEncoding="UTF-8"%><%@
 include file="/Frame/resources/include/include_begin_info.jspf"%><%
		/*
		Content:    类及方法目录详情
		Input Param:
                    ClassName：    类名称
	 */
	//定义变量
	String sDiaLogTitle;
	//获得组件参数	
	String sClassName =  CurPage.getParameter("ClassName");
	String sClassDescribe =  CurPage.getParameter("ClassDescribe");
	if(sClassName==null || sClassName.length() == 0){
		sClassName="";
		sDiaLogTitle = "【 类新增 】";
	}else{
		sDiaLogTitle = "【"+sClassDescribe+"】类名：『"+sClassName+"』查看修改配置";	
	}

	ASObjectModel doTemp = new ASObjectModel("ClassCatalogInfo");
	doTemp.setBusinessProcess("com.amarsoft.awe.dw.handler.impl.CommonHandler");
 	if (sClassName != "")	doTemp.setReadOnly("ClassName",true);
 	ASObjectWindow dwTemp = new ASObjectWindow(CurPage,doTemp,request);
	dwTemp.Style="2";      //设置DW风格 1:Grid 2:Freeform
	dwTemp.ReadOnly = "0"; //设置是否只读 1:只读 0:可写
	dwTemp.genHTMLObjectWindow(sClassName);
	
	String sButtons[][] = {
		{"true","All","Button","保存","保存修改","saveRecord()","","","",""},
		{"true","All","Button","保存并新增","保存修改并新增另一条记录","saveRecordAndAdd()","","","",""},
	};
%><%@include file="/Frame/resources/include/ui/include_info.jspf"%>
<script type="text/javascript">
	setDialogTitle("<%=sDiaLogTitle%>");
	function saveRecord(sPostEvents){
		as_save("myiframe0",sPostEvents);
	}
	function saveRecordAndAdd(){
		saveRecord("newRecord()");
	}
	function newRecord(){
		OpenComp("ClassCatalogInfo","/PIDR/ModelManage/ClassManage/ClassCatalogInfo.jsp","ClassName=","_self","");
	}
</script>	
<%@ include file="/Frame/resources/include/include_end.jspf"%>
