<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="/Frame/resources/include/include_begin_list.jspf"%>
<%	
	/* 
			Author:  
			Content: 反馈报文列表页面
			History Log:  
	*/
	ASObjectModel doTemp = new ASObjectModel("PidrSessionBackList");
    doTemp.setJboWhere("substr(FeedBackFileName,30,1)=2 or substr(FeedBackFileName,30,1)=3");
	ASObjectWindow dwTemp = new ASObjectWindow(CurPage,doTemp,request);
	dwTemp.Style="1";      	     //--设置为Grid风格--
	dwTemp.ReadOnly = "1";	 //只读模式
	dwTemp.setPageSize(20);
	dwTemp.genHTMLObjectWindow("");

	String sButtons[][] = {
			//0、是否展示 1、	权限控制  2、 展示类型 3、按钮显示名称 4、按钮解释文字 5、按钮触发事件代码	6、	7、	8、	9、图标，CSS层叠样式 10、风格
			{"true","","Button","上传反馈","上传反馈","uploadFeedback()","","","","btn_icon_up",""},
			{"true","All","Button","解析报文","解析报文","parseReport()","","","","btn_icon_submit",""},
			{"false","","Button","查看解析日志","查看解析日志","queryParseLog()","","","","btn_icon_check",""},
			{"true","","Button","查看反馈数据","查看反馈数据","queryFeedback()","","","","btn_icon_check",""},
		};
%>
<%@include file="/Frame/resources/include/ui/include_list.jspf"%>
<script type="text/javascript">
	/*~[Describe=上传反馈,InputParam=无,OutputParam=无]~*/
	function uploadFeedback() {
		var url = "/PIDR/FileManage/FeedbackReportFile/FeedbackReportUpload.jsp";
		AsDialog.PopView(url,"","dialogWidth=550px;dialogHeight=350px;status:no;center:yes;help:no;minimize:no;maximize:no;border:thin;",function(){
			reloadSelf();			
		}); 
	}

	/*~[Describe=解析报文，暂不支持enc反馈报文的解析，因为预处理工具目前无法web调用,InputParam=无,OutputParam=无]~*/
	function parseReport() {	
		var index ;
		  if(confirm('确定解析反馈报文？它将完成您所在机构反馈报文解析，该操作需要锁定并需要花费一定时间')){
			  $.ajax({
			        type: "post",
			        data: "ActionType=RUNTASK&TaskName=feedback&ScriptName=startup",
			        url: "<%=request.getContextPath()%>/PidrTaskScheduleServlet",
			        beforeSend: function () {
			        	openDWDialog('正在执行任务中...');
			        },
			        success: function (data) {
			        	alert("解析反馈报文成功");
						reloadSelf();
					   /* window.parent.location.reload(); */
			        },
			        complete: function () {
			        	autoCloseDWDialog();
		       	 	},
			        error: function (xhr,status,error) {
			        	// XMLHttpRequest 对象、错误信息、（可选）捕获的异常对象
			        	alert("解析反馈报文失败");
			        }
			    });
		  }
		reloadSelf();
	}

	/*~[Describe=查看反馈数据，即跳转至错误维护模块的反馈错误维护页面,InputParam=无,OutputParam=无]~*/
	function queryFeedback() {
		parent.parent.openMenu('700020');
	}
</script>
<%@ include file="/Frame/resources/include/include_end.jspf"%>