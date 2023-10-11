<%-- 页面说明: 公告详情 --%>
<%@ page pageEncoding="UTF-8"%><%@
 include file="/Frame/mvc/resources/include/include_begin_info.jspf"%>
  <a3ui:form readOnly="0" curPage="${root.curPage}" mapValues="${root.owresult}">
    <a3ui:ow doTemp="${root.doTemp}">
    </a3ui:ow>
    <a3ui:buttons >
        <c:forEach items="${root.buttonModels }" var="item">
        <a3ui:button enable="${item.enabled }" right="${item.right }"  type="${item.type }" text="${item.text}"  tips="${item.tips }" 
        action="${item.action }" shortcutKey="${item.shortcutKey }" href="${item.href }" param="${item.param}" iconCls="${item.iconCls }" />
        </c:forEach>
    </a3ui:buttons>
    <%@ include file="/Frame/mvc/resources/include/ui/include_info.jspf"%>
</a3ui:form>
<script type="text/javascript">
	function saveRecord(){
	    var boardNo= ${root.boardNo};
		if(boardNo){
			as_save('${root.updateUrl}',"myiframe0", "parent.OpenList()");
		}else{
			as_save('${root.insertUrl}',"myiframe0", "parent.OpenList()");
		}
	}
	$(function($) {
		// 调用服务获取数据
		AsControl.CallService("${root.getUrl}", {"boardNo": "${root.boardNo}"}, function(sm){
			var owresult = sm.body.owresult;
			for(var key in owresult){
				//console.log([key, owresult[key]]);
				setItemValue(0, 0, key, owresult[key]);
			}
			if(owresult.DOCNO == null) {//新增时文件编号的初始化
				var docNo = getSerialNo("DOC_LIBRARY","DocNo","","000000");
				setItemValue(0, getRow(), "DocNo", docNo);
			}
		});
	});
</script>	
<%@ include file="/Frame/mvc/resources/include/include_end.jspf"%>