<%@ page pageEncoding="UTF-8"%><%
boolean isFilterHTML = CurPage.isExistAttribute("FilterHTML");
if(isFilterHTML){
	String sFilterHTML = CurPage.getAttribute("FilterHTML");
	int iOccurTimes = StringFunction.getOccurTimes(sFilterHTML,"DOFilterOperatorSelect");
%>
<link rel="stylesheet" href="<%=sWebRootPath%>/Frame/page/resources/css/filter.css">
<div id="FilterArea" onmousedown="AsLink.moveBoxOnDown(event,this)" onmouseover="AsLink.opacityBoxOnOver(this);" onclick="AsLink.stopEvent(event);" class="list_search list_search_nohover" style="display: none;">
	<div style="font-weight:bold;padding-left:10px;padding-top:5px;background-color:#ddd; padding-bottom:10px;margin-top:-10px;margin-left:-10px;margin-right:-10px">
	<%=LanguageManager.getDWSystemLanguage("查询条件") %><div onclick="hideFilterArea();return false;" class="ow_righttop_close">&nbsp</div>
	</div>
	<form name="DOFilter" method=post >
		<input type=hidden name=DWCurPage id=DWCurPage value="0">
		<input type=hidden name=DWCurRow id=DWCurRow value="0">
		<input type=hidden name=DWInSearch value="true">
			<table align=center width="100%" cellspacing="0" cellpadding="3">
				<tr>
				<td>
				<%-- 如果查询条件有4个以上（DOFilterOperatorSelect在每个查询条件中出现1次）就显示垂直滚动条 --%>
				<div style="<%=(iOccurTimes>=4)?"overflow:auto;width:100%;height:120":""%>">
					<table><%=sFilterHTML%></table>
				</div>
				</td>
				</tr>
				<tr>
				<td class="FilterSubmitTd" align="center">
				<input type="submit" style="height:24px;line-height:12px;" value="<%=LanguageManager.getDWSystemLanguage("查询") %>" 
					onclick="if(this.unable){return false;}else{if(!checkDOFilterForm('DOFilter')) return false; else this.unable=true;}" />
				<input type="button" style="height:24px;line-height:12px;" value="<%=LanguageManager.getDWSystemLanguage("清空") %>" onclick="clearFilterForm('DOFilter')" />
				<input type="button" style="height:24px;line-height:12px;" value="<%=LanguageManager.getDWSystemLanguage("恢复") %>" onclick="resetFilterForm('DOFilter')" />
				<input type="button" style="height:24px;line-height:12px;" value="<%=LanguageManager.getDWSystemLanguage("取消") %>" onclick="hideFilterArea()" />
				<%--
				<%=new Button("查询","查询","if(!checkDOFilterForm('DOFilter')){}else{submitFilterForm('DOFilter');}","","","").getHtmlText()%>
				<%=new Button("清空","清空","clearFilterForm('DOFilter')","","","").getHtmlText()%>
				<%=new Button("恢复","恢复","resetFilterForm('DOFilter')","","","").getHtmlText()%>
				<%=new Button("取消","取消","hideFilterArea()","","","").getHtmlText()%>
				--%>
				</td>
				</tr>
			</table>
	</form>
</div>
<script type="text/javascript">
	function showFilterArea(tableIndex){
		var div = $("#FilterArea");
		var doc = $(document).add(myiframe0.document).unbind(".dwfilter");
		
		if(div.is(":hidden")){
			doc.bind("keyup.dwfilter", function(e){
				if(e.keyCode!=27) return;
				div.hide();
			});
			div.css({
				"top":35,
				"left":10
			}).show();
		}else{
			div.hide();
		}
	}
	function hideFilterArea(tableIndex){
		$(document).add(myiframe0.document).unbind(".dwfilter");
		$("#FilterArea").hide();
	}
</script>
<%}else {%>
<form name="DOFilter" method=post >
       <input type=hidden name=DWCurPage id=DWCurPage value="0">
       <input type=hidden name=DWCurRow id=DWCurRow value="0">
       <input type=hidden name=DWInSearch value="true">
</form>
<%}%>
        