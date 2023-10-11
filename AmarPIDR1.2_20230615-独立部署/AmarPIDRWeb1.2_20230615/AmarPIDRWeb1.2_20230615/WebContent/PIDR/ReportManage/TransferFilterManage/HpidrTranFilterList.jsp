<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="/Frame/resources/include/include_begin_list.jspf"%>

<%	
     /*
     	拦截管理-数据过滤列表
     	@author :yyzang
     	@date: 2023-02-16
     */
	ASObjectModel doTemp = new ASObjectModel("PidrTranFilterList");
	ASObjectWindow dwTemp = new ASObjectWindow(CurPage,doTemp,request);
	dwTemp.Style="1";      	     //--设置为Grid风格--
	dwTemp.ReadOnly = "1";	 //只读模式
	dwTemp.setPageSize(20);
	dwTemp.genHTMLObjectWindow("");
	String sButtons[][] = {
			//0、是否展示 1、	权限控制  2、 展示类型 3、按钮显示名称 4、按钮解释文字 5、按钮触发事件代码	6、	7、	8、	9、图标，CSS层叠样式 10、风格
			{"true","","Button","删除","删除","del()","","","","btn_icon_delete",""},
		};
%>
<%@include file="/Frame/resources/include/ui/include_list.jspf"%>
<script type="text/javascript">
/*~[Describe=删除,InputParam=无,OutputParam=无]~*/
function del(){
	var busiIdSerialNo = getItemValue(0,getRow(0),'BusiIdSerialNo');
	if(typeof(busiIdSerialNo)=="undefined" || busiIdSerialNo.length==0 ){
		alert("请选择一条记录");
		return ;
	}
	if(confirm('确定删除吗?')){
		as_delete(0);
		var filterCause = getItemValue(0,getRow(0),"FilterCause");//过滤原因
		if(filterCause == 'S'){//web端人为干涉为暂缓上报，在删除拦截名单时，需要恢复评级结果表的标识
			RunJavaMethodTrans("com.amarsoft.app.pidr.creaditgrade.PIDRCreditGradeHandler", "regainReport", 
					 "customerId=" + busiIdSerialNo);
		}
	}
}

</script>
<%@ include file="/Frame/resources/include/include_end.jspf"%>