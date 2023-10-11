<%@ page pageEncoding="UTF-8"%><%String _sView = "tab";%>
<%@ include file="/Resources/CodeParts/TabStrip01.jsp"%>
<script type="text/javascript"><%try{
if("true".equals(CurPage.getAttribute("TabNowrap"))){%>$(".tabs_button >ul").width(3000);<%}
if(CurPage.getAttribute("AfterTabHtml") != null){%>
	$('<%=CurPage.getAttribute("AfterTabHtml").replace("'", "\\'")%>').appendTo('#divine_handle_'+tabCompent.getID());
<%}}catch(Exception e){}%>
 
function addTabItem(sTitle, sUrl, sParas, bOpen){
	addTabStripItem(sTitle, sUrl, sParas, bOpen);
}
/**
 * 关闭Tab标签前调用方法
 * @returns {Boolean} false tab标签不关闭
 */
function closeTab(sItemName, sFrameName){
	//alert([sItemName, sFrameName]); // 标签名称、标签对应页面的名称
	//alert(frames[sFrameName]); // 取标签的window对象
	//alert($("body", frames[sFrameName].document).html()); // 操作标签页面的属相、方法

	/*
	// 打开一个页面到标签页里去，返回false以防止关闭标签
	AsControl.OpenView("/AppMain/Blank.jsp", "", sFrameName);
	return false;
	*/
	
	return true;
}

$(function(){ // 延迟加载，方便后续代码修改closeTab方法
	tabCompent.setCloseCallback(closeTab);
});
</script>