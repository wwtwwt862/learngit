<%@ page pageEncoding="UTF-8"%><%@
 include file="/Frame/resources/include/include_begin_list.jspf"%><%
	/*
		Content: 类及方法目录列表
	 */
	String sClassName =  CurPage.getParameter("ClassName");   //类名
	if (sClassName == null) sClassName = "";
	
	ASObjectModel doTemp = new ASObjectModel("ClassCatalogList");
	doTemp.setBusinessProcess("com.amarsoft.app.awe.pidr.dwhandler.PidrClassCatalogHandler");
	ASObjectWindow dwTemp = new ASObjectWindow(CurPage,doTemp,request);
	dwTemp.Style="1";      //设置DW风格 1:Grid 2:Freeform
	dwTemp.ReadOnly = "1"; //设置是否只读 1:只读 0:可写
	dwTemp.setPageSize(8);
	dwTemp.setParameter("CLASSNAME", sClassName);
	dwTemp.genHTMLObjectWindow("");
	
	String sButtons[][] = {
		{"true","All","Button","新增","新增一条记录","newRecord()","","","",""},
		{"true","","Button","详情","查看/修改详情","viewAndEdit()","","","",""},
		{"false","All","Button","保存","保存修改","saveRecord()","","","",""},
		{"true","All","Button","删除","删除所选中的记录","deleteRecord()","","","",""}
	};
%><%@include file="/Frame/resources/include/ui/include_list.jspf"%>
<script type="text/javascript">
	function newRecord(){
		AsDialog.PopView("/PIDR/ModelManage/ClassManage/ClassCatalogInfo.jsp","",{width:"650px",height:"450px",title:"新增类及方法"},function(){reloadSelf();});
	}
	function viewAndEdit(){
	  	var sClassName = getItemValue(0,getRow(),"ClassName");
	  	var sClassDescribe = getItemValue(0,getRow(),"ClassDescribe");
	  	if(typeof(sClassName)=="undefined" || sClassName.length==0) {
				alert(getMessageText('AWEW1001'));//请选择一条信息！
				return ;
		}
	  	AsDialog.PopView("/PIDR/ModelManage/ClassManage/ClassCatalogInfo.jsp","ClassName="+sClassName+"&ClassDescribe="+sClassDescribe,
  			{width:"650px",height:"450px",title:"类及方法"},function(){reloadSelf();});
	}
	function saveRecord(){
		as_save("myiframe0","");
	}
	function mySelectRow(){
	  	var sClassName = getItemValue(0,getRow(),"ClassName");
	  	var sClassDescribe = getItemValue(0,getRow(),"ClassDescribe");
	  	parent.OpenInfo(sClassName,sClassDescribe); //联动打开详情页面
	  	parent.selectedRow = getRow(0); //记下选中行
	  	//记下翻页信息
	  	parent.pageInfo.rowCount= s_r_c[0];
	  	parent.pageInfo.displayPageSize= s_p_s[0];
	  	parent.pageInfo.pageCount= s_p_c[0];
	  	parent.pageInfo.curPage= s_c_p[0];
		
	}
	function deleteRecord(){
		var sClassName = getItemValue(0,getRow(),"ClassName");
		if(typeof(sClassName)=="undefined" || sClassName.length==0) {
			alert(getMessageText('AWEW1001'));//请选择一条信息！
			return ;
		}
		if(confirm(getMessageText('AWEW1054'))){
			as_delete(0);
		}
	}
	
	$(document).ready(function(){
		var selectedRow = parent.selectedRow; //先获取选中行，避免被后面操作刷掉
		if(parent.pageInfo.curPage != 0){ //不是第一页，则先做翻页
			TablePage.changePage("myiframe0", parent.pageInfo.rowCount, parent.pageInfo.displayPageSize, parent.pageInfo.pageCount, parent.pageInfo.curPage+1);
		}
		if(selectedRow && selectedRow != 0){ //不是第一行，则选中指定行
			lightRow(0, selectedRow);
		}
		mySelectRow();
	});
</script>	
<%@ include file="/Frame/resources/include/include_end.jspf"%>