<%@ page pageEncoding="UTF-8"%><%
	String sPageHead = "";
	String sPageHeadPlacement = PG_TITLE;

	if(sPageHeadPlacement.indexOf("@")>=0){
		sPageHead = StringFunction.getSeparate(sPageHeadPlacement,"@",1);
		sPageHeadPlacement = StringFunction.getSeparate(sPageHeadPlacement,"@",2);
	}
%>
<html>
<head>
<title><%=sPageHead%></title>
<style type="text/css">
	.no_select {
		-moz-user-select:none;
	}
</style>  
</head>
<body class="InfoPage" leftmargin="0" topmargin="0" style="overflow: hidden;" >
<%@ include file="/Frame/page/jspf/ui/widget/ow/info_context_menu.jspf"%>
<table border="0"  cellspacing="0" cellpadding="0" id=InfoTable height="100%" width="100%">
	<%if(sPageHeadPlacement.equals("PageTitle")){%>
	<tr height=1>
	    <td id="InfoTitle" class="InfoTitle"><%=sPageHead%></td>
	</tr>
	<%}%>
	<tr height=1  id="ButtonTR">
		<td valign=top id="InfoButtonArea" class="infodw_buttonarea_td" align="left" >
			<%@ include file="/Frame/resources/include/ui/include_buttonset_dw.jspf"%>
	    </td>
	</tr>
	<tr id="DWTR">
	    <td id="InfoDWArea" class="InfoDWArea">
			<iframe name="myiframe0" src="javascript:void(0)" marginwidth="0" marginheight="0" width=100% height=100% frameborder=0></iframe>			 
	    </td>
	</tr>
<%
String ShowDetailArea = (String)CurPage.getAttribute("ShowDetailArea");
if(ShowDetailArea!=null && ShowDetailArea.equalsIgnoreCase("true")){
%>
	<tr>
	    <td id="InfoHorizontalBar" class="InfoHorizontalBar">
			<div id="divDrag" class="divDrag" title="可拖拽改变窗口大小" style="height:1px;width:100%;font-size:0;z-index:0;cursor:n-resize;"></div>
	    </td>
	</tr>
	<tr>
	    <td id="InfoDetailAreaTD" class="InfoDetailAreaTD" >
			<table height=100% width=100% cellpadding=5>
				<tr>
					<td>
					<div class="groupboxmaxcontent">
						<iframe name="DetailFrame" src="<%=com.amarsoft.awe.util.Escape.getBlankJsp(sWebRootPath,CurPage.getAttribute("DetailFrameInitialText"))%>" width=100% height=100% frameborder=0></iframe>
					</div>
					</td>
				</tr>
			</table>
		</td>
	</tr>
<script type="text/javascript">
	<%
	String DetailAreaHeight = (String)CurPage.getAttribute("DetailAreaHeight");
	if(DetailAreaHeight!=null && !DetailAreaHeight.equals("")){
	%>
	InfoDWArea.height=<%=DetailAreaHeight%>;
	<%}else{%>
	InfoDWArea.height=232;	
	<%}%>
	$(function(){
		$("#divDrag").bind("mousedown", function(e){
			var myboard = $("#myboard").show();
			var mybody = $("body").addClass("no_select");
			$(document).bind("mousemove", dragmove).bind("mouseup", dragup);
			var y = e.clientY;
			var height = window.parseInt(InfoDWArea.height, 10);
			function dragmove(e){
				InfoDWArea.height = height + e.clientY - y;
			}
			function dragup(){
				$(document).unbind("mousemove", dragmove).unbind("mouseup", dragup);
				myboard.hide();
				mybody.removeClass("no_select");
			}
		});
	});
</script>
<%
}
%>
</table>
<div id="myboard" style="position: absolute; left: 0; top: 0; width: 100%; height: 100%; cursor: n-resize; display: none;"></div>
</body>
</html>
<script type="text/javascript">
$(function(){ if(typeof(bTrueDWPage)!="undefined"){bTrueDWPage=true;}});
function beforeIsModified(objname){
	// 如果页面只读，那么不做修改后关闭校验
	if(DZ[0][0][2]=="1") return false;
	if(!bManualModified) return false;
	return true;
}
if(screen.availWidth<1000) bFreeFormMultiCol=false;
</script>