<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="/Frame/resources/include/include_begin_list.jspf"%>
<%--  
	Author:  hcliu 
	CreationDate:2023-02-22
    Description:查看同期报文列表页面
--%>
<%	
	String sessionId = CurPage.getParameter("SessionId");
	if (sessionId==null) sessionId = "";
	String messageFileClass = CurPage.getParameter("MessageFileClass");
	if (messageFileClass==null) messageFileClass = "";
	ASObjectModel doTemp = new ASObjectModel("PidrSessionList");
	doTemp.appendJboWhere("MessageFileClass =  :messageFileClass and SessionId like :sessionId ");
	ASObjectWindow dwTemp = new ASObjectWindow(CurPage,doTemp,request);
	dwTemp.MultiSelect=true;
	dwTemp.Style="1";      	     //--设置为Grid风格--
	dwTemp.ReadOnly = "1";	 //只读模式
	dwTemp.setPageSize(20);
	dwTemp.setParameter("SessionId",sessionId.substring(0, 8) + "%");
	dwTemp.setParameter("MessageFileClass",messageFileClass);
	dwTemp.genHTMLObjectWindow("");
	String filePath=ARE.getProperty("IReportDir");
	String home = ARE.getProperty("PIDR_HOME");
	String sButtons[][] = {
			//0、是否展示 1、	权限控制  2、 展示类型 3、按钮显示名称 4、按钮解释文字 5、按钮触发事件代码	6、	7、	8、	9、图标，CSS层叠样式 10、风格
			{"true","","Button","批量下载txt报文","批量下载txt报文","downloadBatchFile()","","","","btn_icon_down",""},
		};
%>
<%@include file="/Frame/resources/include/ui/include_list.jspf"%>
<script type="text/javascript">
	/*~[Describe=批量下载报文, InputParam=无, OutputParam=无]~*/
	function downloadBatchFile() {
		 var mClass = getItemValue(0,getRow(0),'MessageFileClass');
		 if(typeof(mClass)=="undefined" || mClass.length==0){
			 alert("请至少选择一条有效记录");
			return ;
		 }
		 var	obj=document.getElementsByName('check_S_myiframe0'); //选择所有name="'check_S_myiframe0'"的对象，返回数组；取到对象数组后，我们来循环检测它是不是被选中
			var count = 0;
			for(var recordCount=0;recordCount < obj.length;recordCount++){
				if (obj[recordCount].checked) {
					count++;
				}
			}
			if(count == 0){
				 alert("请至少选择一条有效记录");
				 return ;
			}
		 
		var filePath = null; 
		var obj=document.getElementsByName('check_S_myiframe0'); //选择所有name="'check_S_myiframe0'"的对象，返回数组；取到对象数组后，我们来循环检测它是不是被选中
		var fileName = "";
		var pidrHome = "<%=home%>";
	    for (var recordCount=0;recordCount < obj.length;recordCount++) {
	    	if (obj[recordCount].checked) {
	    		var reportFileName = getItemValue(0,recordCount,'ReportFileName');	//获取选中记录的文件名
	    		filePath = pidrHome + "/" + getItemValue(0,recordCount,'FilePath') + "/";
	    		filePath = filePath.replace(/\\/g,"/");
	    		var fileExists = RunJavaMethod("com.amarsoft.app.pidr.util.FileIsExists","fileIsExists","file="+filePath + reportFileName);
	    		if (fileExists=="true") {
	    			if (recordCount!=0 && fileName != "") {
	    				fileName = fileName + "@";	    					
		    		}
		    		fileName = fileName + reportFileName;
	    		} else {
	    			alert("选择下载的文件" + reportFileName +"不存在，请稍后检查");
	    		}
	    	}
	    }
		if(typeof(fileName)!="undefined" && fileName.length!=0) {
			if(fileName.indexOf("@")==-1){//单个文件，则不用压缩，普通下载
				document.download.action="<%=request.getContextPath()%>/PidrDownloadServlet?fileName="+encodeURI(encodeURI(filePath + reportFileName));
			}else{
				document.download.action="<%=request.getContextPath()%>/PidrDownLoadBatchServlet?fileName="+encodeURI(encodeURI(filePath+"temp.zip")) + "&batchFileName="+fileName;
			}
		    var fileInfo = document.download.action.split("/");
		    var fileType = fileInfo[fileInfo.length-2];
		    if("report,modification,delete".indexOf(fileType)<0){ /* 防止路径被外界访问者替换，下载其他文件 */
				alert('文件路径不是报文的存放路径，不允许下载');
				return;
		    }
		    document.download.submit(); 
		} else {
				alert('没有文件可下载');
		}
	}
	
</script>
<form id="download" name="download" method="post" action="PidrDownloadBatchServlet" enctype="multipart/form-data"></form>
<%@ include file="/Frame/resources/include/include_end.jspf"%>