<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="/Frame/resources/include/include_begin_list.jspf"%>
<%--
	Author:kwwu
	CreationDate:2023-02-16
	Description:任务运行列表页面
--%>
<%	
	ASObjectModel doTemp = new ASObjectModel("PidrTaskRunList");
	String taskName = CurPage.getParameter("TaskName");
	if(taskName == null) taskName = "";
	doTemp.appendJboWhere("TASKNAME like '%"+taskName+"%' and StatusType = 'task'");
	
	ASObjectWindow dwTemp = new ASObjectWindow(CurPage,doTemp,request);
	dwTemp.Style="1";      	     //--设置为Grid风格--
	dwTemp.ReadOnly = "1";	 //只读模式
	dwTemp.setPageSize(20);
	dwTemp.genHTMLObjectWindow("");
	String sButtons[][] = {
			//0、是否展示 1、	权限控制  2、 展示类型 3、按钮显示名称 4、按钮解释文字 5、按钮触发事件代码	6、	7、	8、	9、图标，CSS层叠样式 10、风格
			{"true","All","Button","执行任务","执行任务","taskExcute()","","","","btn_icon_add",""},
		};
%>
<%@include file="/Frame/resources/include/ui/include_list.jspf"%>
<script type="text/javascript">
/*~[Describe=执行任务,InputParam=无,OutputParam=无]~*/
function taskExcute(){
	var taskMessage = "确定进行【0】？它将完成您所在机构企业【0】，该操作需要锁定并需要花费一定时间";//提示信息
	var taskName = "";//任务名称
	if("<%=taskName%>" == "DataCopy"){
		taskName = "数据加载";
	}else if("<%=taskName%>".startsWith("Prepare")){
		taskName = "数据处理";
	}else if("<%=taskName%>" == "Rating"){
		taskName = "数据评级";
	}else if("<%=taskName%>" == "Validate"){
		taskName = "数据校验";
	}else if("<%=taskName%>" == "Transfer"){
		taskName = "数据迁移";
	}else{
		taskName = "报文生成";
	}
	var index ;
	if(confirm(taskMessage.replace(/【0】/g,taskName))){
		$.ajax({
	        type: "post",
	        data: "ActionType=RUNTASK&TaskName=<%=taskName%>&ScriptName=startup",
	        url: "<%=request.getContextPath()%>/PidrTaskScheduleServlet",
	        beforeSend: function(){
	        	openDWDialog('正在执行任务中，请勿进行其它操作...');
	        },
	        complete: function () {
	        	autoCloseDWDialog();
	        },
	        success: function (data) {
	        	alert(taskName + "成功");
				reloadSelf();
	        },
	        error: function (xhr,status,error) {
	        	alert(taskName + "失败");
	        }
		});
	}
	reloadSelf();
}
</script>
<%@ include file="/Frame/resources/include/include_end.jspf"%>