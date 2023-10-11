<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="/Frame/resources/include/include_begin_list.jspf"%>

<%	
     /*
     	白名单数据管理-数据展示列表
     	@author :hcliu
     	@date: 2023-05-05
     */
	ASObjectModel doTemp = new ASObjectModel("PidrWhiteDataList");
	ASObjectWindow dwTemp = new ASObjectWindow(CurPage,doTemp,request);
	dwTemp.Style="1";      	     //--设置为Grid风格--
	dwTemp.ReadOnly = "1";	 //只读模式
	dwTemp.setPageSize(20);
	dwTemp.genHTMLObjectWindow("");
	String sButtons[][] = {
			//0、是否展示 1、	权限控制  2、 展示类型 3、按钮显示名称 4、按钮解释文字 5、按钮触发事件代码	6、	7、	8、	9、图标，CSS层叠样式 10、风格
			{"true","","Button","新增","手动新增白名单数据","add()","","","","btn_icon_add",""},
			{"true","","Button","导入本期白名单","导入本期白名单数据","importExcel()","","","","btn_icon_add",""},
			{"true","","Button","清空","清空本期白名单数据","clean()","","","","btn_icon_delete",""},
			{"true","","Button","评级数据处理并校验","企业评级数据处理并校验","taskExcute('preparerate')","","","","btn_icon_add",""},
			{"true","","Button","批量数据评级","批量数据评级","taskExcute('rating')","","","","btn_icon_add",""},
			{"true","","Button","信贷资产数据处理并校验","企业信贷资产数据处理并校验","taskExcute('preparecreass')","","","","btn_icon_add",""},
			{"true","","Button","数据迁移","数据迁移","taskExcute('transfer')","","","","btn_icon_add",""},
			{"true","","Button","报文生成","报文生成","taskExcute('report')","","","","btn_icon_add",""},
		};
%>
<%@include file="/Frame/resources/include/ui/include_list.jspf"%>
<script type="text/javascript">
/*~[Describe=新增,InputParam=无,OutputParam=无]~*/
function add(){
	 var url = "/PIDR/IntegatedQueryManage/WhiteListDataManage/WhiteListDataInfo.jsp";
	 var operationType = "Add";
	AsDialog.PopView(url,'operationType='+operationType,'dialogWidth:500px;dialogHeight:400px',function(){
		reloadSelf();
	});
}

/*~[Describe=导入本期白名单,InputParam=无,OutputParam=无]~*/
function importExcel(){
    var url = "/PIDR/IntegatedQueryManage/WhiteListDataManage/WhiteImportExcel.jsp";
    AsDialog.PopView(url,"fileType=2","dialogWidth=800px;dialogHeight=300px;status:no;center:yes;help:no;minimize:no;maximize:no;border:thin;",function(){
        reloadSelf();
    }); 
}

/*~[Describe=查看白名单,InputParam=无,OutputParam=无]~*/
function edit(){
    var url = "/PIDR/IntegatedQueryManage/WhiteListDataManage/WhiteListDataInfo.jsp";
    var operationType = "Info";
    var customerID=getItemValue(0,getRow(0),'CustomerID'); //客户编号
   AsDialog.PopView(url,'operationType='+operationType+"&CustomerID="+customerID,'dialogWidth:500px;dialogHeight:400px',function(){
       reloadSelf();
   });
}

/*~[Describe=删除,InputParam=无,OutputParam=无]~*/
function del(){
	var customerId = getItemValue(0,getRow(0),'CustomerID');
	if(typeof(customerId)=="undefined" || customerId.length==0 ){
		alert("请选择一条记录");
		return ;
	}
	if(confirm('确定删除数据?')){
		as_delete(0);
	}
}

/*~[Describe=清空,InputParam=无,OutputParam=无]~*/
function clean(){
	if(confirm('确定清空本期白名单数据吗?')){
		var result = RunJavaMethodTrans("com.amarsoft.app.pidr.whitelist.PidrWhiteListHandler", "clearRecord","");
		reloadSelf();
	}
}

/*~[Describe=执行任务,InputParam=任务名称,OutputParam=无]~*/
function taskExcute(taskName){
	var taskMessage = "确定进行【0】？它将完成您所在机构企业【0】，该操作需要锁定并需要花费一定时间";//提示信息
	var taskDetail = "";
	if(taskName == "preparerate"){
		taskDetail = "企业评级数据处理并校验";
	}else if(taskName.startsWith("rating")){
		taskDetail = "批量数据评级";
	}else if(taskName == "preparecreass"){
		taskDetail = "企业信贷资产数据处理并校验";
	}else if(taskName == "transfer"){
		taskDetail = "数据迁移";
	}else if(taskName == "report"){
		taskDetail = "报文生成";
	}else if(taskName == "validate"){
		taskDetail = "数据校验";
	}
	if(confirm(taskMessage.replace(/【0】/g,taskDetail))){
		$.ajax({
	        type: "post",
	        data: "ActionType=RUNTASK&TaskName="+taskName+"&ScriptName=startup",
	        url: "<%=request.getContextPath()%>/PidrTaskScheduleServlet",
	        beforeSend: function(){
	        	openDWDialog('正在执行任务中，请勿进行其它操作...');
	        },
	        complete: function () {
	        	autoCloseDWDialog();
	        },
	        success: function (data) {
				if(taskName == "preparerate" || taskName == "preparecreass"){
					taskExcute("validate");
				}else if(taskName == "report"){
					showReport();	
				}else if(taskName == "validate"){
					showValidate();
				}
				alert(taskDetail + "成功");
				reloadSelf();
	        },
	        error: function (xhr,status,error) {
	        	alert(taskDetail + "失败，请前往日志管理查看日志");
	        }
		});
	}
	reloadSelf();
}

/*~[Describe=展示报文,InputParam=无,OutputParam=无]~*/
function showReport(){
	var url = "/PIDR/FileManage/RegularReportFile/NormalReportManage/PIDRNormalReportTab.jsp";
	 AsDialog.PopView(url,'','dialogWidth:1000px;dialogHeight:600px',function(){
	       reloadSelf();
	   });
}

/*~[Describe=展示校验结果,InputParam=无,OutputParam=无]~*/
function showValidate(){
	var url = "/PIDR/ErrorManage/ValidateManage/PIDRValidateErrorList.jsp";
	 AsDialog.PopView(url,'','dialogWidth:1000px;dialogHeight:600px',function(){
	       reloadSelf();
	   });
}

/*~[Describe=操作框,InputParam=无,OutputParam=无]~*/
function afterSearch(){
	for(var i=0;i<getRowCount(0);i++){
		getObj(0,i,"ACTION").innerHTML='<a class="fa fa-file-o fa-fw" style="align:left;" href=# onclick="javascript:edit()"></a>&nbsp;'+
			'<a class="fa fa-trash fa-lg fa-fw" style="align:right;color:red;" href=# onclick="javascript:del()"></a> ';
	}
}


</script>
<%@ include file="/Frame/resources/include/include_end.jspf"%>