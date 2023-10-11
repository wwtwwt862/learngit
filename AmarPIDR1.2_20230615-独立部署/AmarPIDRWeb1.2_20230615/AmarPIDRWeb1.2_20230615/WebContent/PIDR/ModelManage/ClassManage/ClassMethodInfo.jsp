<%@ page pageEncoding="UTF-8"%><%@
 include file="/Frame/resources/include/include_begin_info.jspf"%><%
	/*
		Content:    类及方法记录详情
		Input Param:
                    ClassName：    类名称
                    MethodName：   方法名称
	 */
	//定义变量
	String sDiaLogTitle;
	//获得组件参数	
	String sClassName =  CurPage.getParameter("ClassName");
	String sMethodName =  CurPage.getParameter("MethodName");
	if(sClassName==null) sClassName="";
	if(sMethodName==null) sMethodName="";
	if (sClassName.equals("")){
		sDiaLogTitle = "【 新类新方法新增配置 】";	
	}else{
		if(sMethodName.equals("")){
			sDiaLogTitle = "类【"+ sClassName +"】方法新增配置";
		}else{
			sDiaLogTitle = "类【"+ sClassName +"】的方法【 "+sMethodName+"】查看修改配置";
		}
	}

	ASObjectModel doTemp = new ASObjectModel("ClassMethodInfo");
	doTemp.setBusinessProcess("com.amarsoft.awe.dw.handler.impl.CommonHandler");
	doTemp.setDefaultValue("ClassName",sClassName);
	if (!sMethodName.equals("")) {
	   	doTemp.setReadOnly("METHODNAME",true);
	}
	ASObjectWindow dwTemp = new ASObjectWindow(CurPage,doTemp,request);
	dwTemp.Style="2";      //设置DW风格 1:Grid 2:Freeform
	dwTemp.ReadOnly = "0"; //设置是否只读 1:只读 0:可写
	dwTemp.genHTMLObjectWindow(sClassName+","+sMethodName);
	
	String sButtons[][] = {
		{"true","All","Button","保存并返回","保存修改并返回","saveRecordAndReturn()","","","",""},
		{"true","All","Button","保存并新增","保存修改并新增另一条记录","saveRecordAndAdd()","","","",""},
	};
%><%@include file="/Frame/resources/include/ui/include_info.jspf"%>
<script type="text/javascript">
	setDialogTitle("<%=sDiaLogTitle%>");
	function saveRecord(sPostEvents){
		as_save("myiframe0",sPostEvents);	
	}
	
	function saveRecordAndReturn(){
		saveRecord("doReturn('Y');");
	}
	
	function saveRecordAndAdd(){
		saveRecord("newRecord()");
	}
	
	function doReturn(sIsRefresh){
		AsDialog.ClosePage();
	}
    
	function newRecord(){
   		var sClassName = getItemValue(0,getRow(),"CLASSNAME");
   		AsControl.OpenComp("/Common/Configurator/ClassManage/ClassMethodInfo.jsp","ClassName="+sClassName+"&MethodName=","_self");
	}
</script>	
<%@ include file="/Frame/resources/include/include_end.jspf"%>
