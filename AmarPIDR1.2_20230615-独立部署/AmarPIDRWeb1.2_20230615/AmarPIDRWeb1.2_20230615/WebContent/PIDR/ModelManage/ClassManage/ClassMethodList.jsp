<%@ page pageEncoding="UTF-8"%><%@
 include file="/Frame/resources/include/include_begin_list.jspf"%><%
	/*
		Content:类及方法列表
	 */
	String PG_TITLE = "类及方法列表"; // 浏览器窗口标题 <title> PG_TITLE </title>
    //获得组件参数	
	String sClassName =  CurPage.getParameter("ClassName");
    if (sClassName == null) sClassName = "";
	
    ASObjectModel doTemp = new ASObjectModel("ClassMethodList");
	if(sClassName!=null && !sClassName.equals("")){
		doTemp.appendJboWhere(" And ClassName='"+sClassName+"'");
	}
	ASObjectWindow dwTemp = new ASObjectWindow(CurPage,doTemp,request);
	dwTemp.Style="1";      //设置DW风格 1:Grid 2:Freeform
	dwTemp.ReadOnly = "1"; //设置是否只读 1:只读 0:可写
	dwTemp.setPageSize(20);
	dwTemp.genHTMLObjectWindow("");

	String sButtons[][] = {
		{(sClassName.equals("")?"false":"true"),"","Button","新增","新增一条记录","newRecord()","","","",""},
		{"true","","Button","详情","查看/修改详情","viewAndEdit()","","","",""},
		{"true","All","Button","删除","删除所选中的记录","deleteRecord()","","","",""}
	};
%><%@include file="/Frame/resources/include/ui/include_list.jspf"%>
<script type="text/javascript">
	function newRecord(){
		AsDialog.PopView("/PIDR/ModelManage/ClassManage/ClassMethodInfo.jsp","ClassName=<%=sClassName%>",
				{width:"700px",height:"550px",title:"类及方法配置"},function(){reloadSelf();});
	}
	
	function viewAndEdit(){
       var sClassName = getItemValue(0,getRow(),"ClassName");
       var sMethodName = getItemValue(0,getRow(),"MethodName");
       if(typeof(sClassName)=="undefined" || sClassName.length==0){
			alert(getMessageText('AWEW1001'));//请选择一条信息！
			return ;
		}
		AsDialog.PopView("/PIDR/ModelManage/ClassManage/ClassMethodInfo.jsp","ClassName="+sClassName+"&MethodName="+sMethodName,
				{width:"700px",height:"550px",title:"类及方法配置"},function(){reloadSelf();});
	}
    
	function saveRecord(){
		as_save("myiframe0","");
	}

	function deleteRecord(){
		var sClassName = getItemValue(0,getRow(),"ClassName");
       	if(typeof(sClassName)=="undefined" || sClassName.length==0){
			alert(getMessageText('AWEW1001'));//请选择一条信息！
			return ;
		}
		if(confirm(getMessageText('AWEW1002'))){ //您真的想删除该信息吗？
			as_delete("myiframe0");
		}
	}
</script>	
<%@ include file="/Frame/resources/include/include_end.jspf"%>
