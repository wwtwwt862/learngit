<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="/Frame/resources/include/include_begin_list.jspf"%>
<%--  
	Author:  hcliu 
	CreationDate:2023-02-22
    Description:央评报送报文列表页面
--%>
<%	
 	String messageFileClass = CurPage.getParameter("MessageFileClass");
	if (messageFileClass==null) messageFileClass = ""; 
	ASObjectModel doTemp = new ASObjectModel("PidrSessionList");
	doTemp.setJboWhere("MessageFileClass = :MessageFileClass");
	ASObjectWindow dwTemp = new ASObjectWindow(CurPage,doTemp,request);
	dwTemp.Style="1";      	     //--设置为Grid风格--
	dwTemp.ReadOnly = "1";	 //只读模式
	dwTemp.setPageSize(20);
	dwTemp.setParameter("MessageFileClass",messageFileClass);
	dwTemp.genHTMLObjectWindow("");
	String home = ARE.getProperty("PIDR_HOME");
	String sButtons[][] = {
			//0、是否展示 1、	权限控制  2、 展示类型 3、按钮显示名称 4、按钮解释文字 5、按钮触发事件代码	6、	7、	8、	9、图标，CSS层叠样式 10、风格
			{"true","","Button","下载txt报文","下载txt报文","downloadfile()","","","","btn_icon_down",""},
			{"true","","Button","查看同期报文","查看同期报文","termReport()","","","","btn_icon_check",""},
		};
	
%>
<%@include file="/Frame/resources/include/ui/include_list.jspf"%>
<script type="text/javascript">
	/*~[Describe=下载txt报文, InputParam=无, OutputParam=无]~*/
	function downloadfile(){
		var fileName = getItemValue(0,getRow(0),'ReportFileName');
		if(typeof(fileName)=="undefined" || fileName.length==0 ){
			alert("请选择一条有效记录");
			return ;
		}
		var rows=getCheckedRows(0);
		if(rows.length>1){
			alert('只能选择一条记录');
			return;
		}		
		var filePath = getItemValue(0,getRow(),'FilePath').slice(1);
		var file = null;	
		var pidrHome = "<%=home%>";
		file = pidrHome + filePath + "/" + fileName;
		file = file.replace(/\\/g,"/");
		var fileExists = RunJavaMethod("com.amarsoft.app.pidr.util.FileIsExists","fileIsExists","file="+file);
		
		if(fileExists=="true") {
			document.download.action="<%=request.getContextPath()%>/PidrDownloadServlet?fileName="+encodeURI(encodeURI(file));
			var fileInfo = document.download.action.split("/");
			//退一级目录判断
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
	
	/*~[Describe=查看同期报文, InputParam=无, OutputParam=无]~*/
	function termReport() {
		 var sessionId = getItemValue(0,getRow(0),'SessionId');
		 var messageFileClass = getItemValue(0,getRow(0),'MessageFileClass');
		 if(typeof(sessionId)=="undefined" || sessionId.length==0 || typeof(messageFileClass)=="undefined" || messageFileClass.length==0) {
			 alert('请先选择一条记录!');
			 return ;
		 }
		 AsDialog.PopView("/PIDR/FileManage/RegularReportFile/PidrSessionRegularTeprtReportList.jsp","SessionId="+sessionId+"&MessageFileClass="+messageFileClass,'dialogWidth:1000px;dialogHeight:600px');
	}

</script>
<form id="download" name="download" method="post" action="PidrDownloadServlet" enctype="multipart/form-data"></form>
<%@ include file="/Frame/resources/include/include_end.jspf"%>