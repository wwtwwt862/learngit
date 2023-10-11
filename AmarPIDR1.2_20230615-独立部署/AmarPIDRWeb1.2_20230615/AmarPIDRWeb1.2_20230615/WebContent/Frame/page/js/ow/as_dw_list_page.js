function TablePage(tableId,rowCount,displayPageSize,pageCount,curPage){
	this.tableId = tableId;
	this.rowCount = rowCount;
	this.displayPageSize = 10;
	this.pageCount = pageCount;
	this.curPage = curPage+1;
	//alert(this.curPage);
}
TablePage.from = "";
//获得需要显示的首尾页码
TablePage.prototype.getShowPages = function(){
	var firstPage = this.curPage - Math.round(this.displayPageSize/2)  + 1;
	//alert(firstPage);
	var lastPage = this.curPage + Math.round(this.displayPageSize/2);
	if(this.pageCount<this.displayPageSize){
		firstPage = 1;
		lastPage = this.pageCount;
	}
	else if(firstPage<1){
		firstPage = 1;
		lastPage = this.displayPageSize;
	}
	else if(lastPage>this.pageCount){
		lastPage = this.pageCount;
		firstPage =  this.pageCount - this.displayPageSize+1;
	}
	//alert(firstPage + "|" + lastPage);
	return [firstPage,lastPage];
};

TablePage.prototype.createPageHTML = function(){
	var sbResult = new StringBuffer();
	sbResult.append('<div class="list_page_topdiv" id="Page_'+ this.tableId +'">');
	sbResult.append('<div class="list_page_subdiv">');
	//输出上一页
	var sCssPrePage = "list_page_nextpage";
	if(this.curPage<=1)sCssPrePage = "list_page_nolink";
	sbResult.append('<span class="'+ sCssPrePage +'" onclick="if(this.className!=\'list_page_nolink\')TablePage.changePage(\''+ this.tableId +'\','+ this.rowCount +','+ this.displayPageSize +','+ this.pageCount +','+ (this.curPage-1) +')">'+TablePage.PageTexts["上一页"]+'</span>');
	//页数输出
	var showPages = this.getShowPages();
	for(var i=showPages[0];i<=showPages[1];i++){
		if(i==this.curPage)
			sbResult.append('<span class="list_page_current">'+ i +'</span>');
		else
			sbResult.append('<a href="javascript:TablePage.changePage(\''+ this.tableId +'\','+ this.rowCount +','+ this.displayPageSize +','+ this.pageCount +','+ i +')"><span>'+ i +'</span></a>');
	}
	//输出下一页
	var sCssNextPage = "list_page_nextpage";
	if(this.curPage>=this.pageCount)sCssNextPage = "list_page_nolink";
	sbResult.append('<span class="'+ sCssNextPage +'" onclick="if(this.className!=\'list_page_nolink\')TablePage.changePage(\''+ this.tableId +'\','+ this.rowCount +','+ this.displayPageSize +','+ this.pageCount +','+ (this.curPage+1) +')">'+TablePage.PageTexts["下一页"]+'</span>');
	
	//输出页码及其他信息
	sbResult.append('<div class="list_page_pageinfo">');
	sbResult.append('<table class="countwarning"><tr><td>'); // 1样式按钮用
	//sbResult.append(TablePage.PageTexts["共pageCount页 rowCount条"].replace("pageCount", this.pageCount).replace("rowCount", this.rowCount)+'&nbsp;');
	sbResult.append("共"+this.pageCount+"页 "+this.rowCount+"条"+'&nbsp;');
	sbResult.append(TablePage.PageTexts["到第Page页"].replace("Page", "<input type=\"text\" id=\"Page_Input_"+ this.tableId +"\" onkeydown=\"if(event.keyCode==13){TablePage.changePage('"+this.tableId+"',"+this.rowCount+","+this.displayPageSize+","+this.pageCount+",'#');}\" size=\"4\" maxlength=\"5\">"));
	// sbResult.append('<input type="button"  class="search" onclick="TablePage.changePage(\''+ this.tableId +'\','+ this.rowCount +','+ this.displayPageSize +','+ this.pageCount +',\'#\')"');// 2硬画按钮图片用
	// sbResult.append('<input type="button"  value="确定" onclick="TablePage.changePage(\''+ this.tableId +'\','+ this.rowCount +','+ this.displayPageSize +','+ this.pageCount +',\'#\')"');// 3系统默认用
	sbResult.append("</td><td>");// 1样式按钮用
	
	//sbResult.append("<script type="text/javascript">hc_drawNewButtonWithTip(\"确定\",\"\",\"TablePage.changePage(\'"+ this.tableId +"\',"+ this.rowCount +","+ this.displayPageSize +","+ this.pageCount +",\'#\')\",\""+sDWResourcePath+"\");</script>"); // 1.1样式按钮用 失败
	//sbResult.append("<script type="text/javascript">hc_drawNewButtonWithTip(\"确定\",\"\",\"alert(1)\",\""+sDWResourcePath+"\");</script>"); // 1.1样式按钮用 失败
	//sbResult.append(hc_GetdrawNewButtonWithTip("确定","","TablePage.changePage('"+this.tableId+"',"+this.rowCount+","+this.displayPageSize+","+this.pageCount+",'#')",sWebRootPath + "/Frame/Resources/images/button"));
	sbResult.append("<input type=button value='"+TablePage.PageTexts["确定"]+"' onclick=\"javascript:TablePage.changePage('"+this.tableId+"',"+this.rowCount+","+this.displayPageSize+","+this.pageCount+",'#')\" >");
	
    sbResult.append("</td></tr></table>");
	sbResult.append('</div>	');
	
    var tableIndex = this.tableId.substring(8);
    if(DZ[tableIndex][0][11]==1){ //multy select
    	// 选择后将 s_c_p当前页码置为0, 每页条数置为选择值，然后提交查询
    	var ps = [10, 20, 50, 100, 200, 500];
    	sbResult.append('<select onchange="s_c_p['+ tableIndex +']=0;s_p_s['+ tableIndex +']=this.value;submitFilterArea();">');
    	for(var i in ps){
			var sel = '';
			if(ps[i]==s_p_s[tableIndex])sel = 'selected';
			sbResult.append('<option value="'+ ps[i] +'" '+ sel +'>'+ ps[i] +'</option>');
		}
    	sbResult.append('</select>');
    }
    
	sbResult.append('</div>');
	sbResult.append('</div>');
	return sbResult.toString();
};

TablePage.changePage = function(tableId,rowCount,displayPageSize,pageCount,pageCode){
//	var tableIndex = tableId.substring(8);
	if(window.beforeChangePage){
		window.beforeChangePage();
	}
	//获得页码
	if(pageCode=="#"){
		pageCode = document.getElementById("Page_Input_"+ tableId).value;
	}
	if(pageCode=='' || isNaN(pageCode) || pageCode <1){
		document.getElementById("Page_Input_"+ tableId).value = "";
		return;
	}
	pageCode = parseInt(pageCode);
	if(pageCode>pageCount)pageCode = pageCount;
	if(pageCode>20 && USE_MVC){
		alert('页码太大会造成系统缓慢，请减少页码查询！');
		return;
	}
	//alert(pageCount);
	//重新设置当前页码
	s_c_p[0]= pageCode-1;
	//重新显示界面
	//openDWDialog();
	submitFilterArea(TableFactory.SortParams, true);
	//TableFactory.search(tableIndex,undefined,v_g_DWIsSerializJbo,undefined,TablePage.from);
	if(aDWResultError.length==0 || aDWResultError[0].length==0)
		autoCloseDWDialog();
	openFilterArea('TableFilter_AREA',0);
};