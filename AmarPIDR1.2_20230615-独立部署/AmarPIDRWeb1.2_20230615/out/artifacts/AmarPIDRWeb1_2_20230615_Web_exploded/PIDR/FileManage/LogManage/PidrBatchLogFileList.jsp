<%@ page contentType="text/html; charset=UTF-8"%><%@
 include file="/Frame/resources/include/include_begin_list.jspf"%>
<%@page import="java.lang.StringBuffer"%>
<%@page import="java.util.Date"%>
<%--  
	Author:  hcliu 
	CreationDate:2023-02-22
    Description:前后台日志展示列表页面
--%>
<%
	//此种模式不支持导出
	String date = DateX.format(new Date(), "yyyyMMdd");
	String dataHome = ARE.getProperty("PIDR_LOG") + "/" + date;
	String jsonDa = "";
	StringBuffer sb = new StringBuffer(jsonDa);
	java.io.File logDir = new java.io.File(dataHome);
	if (!logDir.isDirectory()) logDir = logDir.getParentFile();
	if (logDir == null) {
		out.println("<font color='red'>No Directory Define</font>");
	}
	if(logDir.exists() && logDir.isDirectory()){
		FileFilter filefilter = new FileFilter() {
	        public boolean accept(File file) {
	            if(file.getName().endsWith(".log")){
	            	return true;
	            }
	            return false;
	        }
	    };
		java.io.File lf[] = logDir.listFiles(filefilter);
		for(int j=0;j<lf.length;j++){
			String sFile = lf[j].getPath().replaceAll("\\\\","/");
			if(j==0){
					sb.append("[");
			}
			
			sb.append("{\"NAME\":\""+lf[j].getName()+"\",\"FILEPATH\":\""+lf[j].getPath().replaceAll("\\\\","/")+"\",\"LASTTIME\":\""+new java.util.Date(lf[j].lastModified()).toLocaleString()+"\",\"SIZE(K)\":\""+(lf[j].length()/1024+1)+"\",\"SIZE(M)\":\""+(lf[j].length()/1024/1024+1)+"\"}");
			if(j==lf.length-1){
				sb.append("]");
			} else {
				sb.append(",");
			}
		}
	}
	jsonDa = sb.toString();
	String jsonASObject="{\"columns\":[{\"colName\":\"NAME\",\"colHeader\":\"日志文件名\"}"
		+ ",{\"colName\":\"FILEPATH\",\"colHeader\":\"文件路径\"}"
		+ ",{\"colName\":\"LASTTIME\",\"colHeader\":\"最后修改时间\"}"
		+ ",{\"colName\":\"SIZE(K)\",\"colHeader\":\"大小(K)\",\"colUnit\":\"(K)\"}"
		+ ",{\"colName\":\"SIZE(M)\",\"colHeader\":\"大小(M)\",\"colUnit\":\"(M)\"}]}";
	String jsonData = jsonDa;
	ASObjectModel doTemp = ASObjectModel.createASObjectModelfromJSON(jsonASObject);
	doTemp.setVisible("FILEPATH", false);
	doTemp.setDataQueryClass("com.amarsoft.awe.dw.ui.htmlfactory.imp.JsonListHtmlGenerator");
	ASObjectWindow dwTemp = new ASObjectWindow(CurPage, doTemp,request);
	dwTemp.Style = "1";//freeform
	dwTemp.ReadOnly = "1";//只读模式
	dwTemp.setPageSize(20);
	dwTemp.MultiSelect=true;
	dwTemp.genHTMLObjectWindow(jsonData);
	String sButtons[][] = {
		{"true","","Button","下载","下载","downloadLog()","","","","btn_icon_down",""},
		{"true","","Button","删除","删除","deleteLog()","","","","btn_icon_delete",""}
	};
%>
<%@include file="/Frame/resources/include/ui/include_list.jspf"%>
<script type="text/javascript">
	/*~[Describe=下载日志, InputParam=无, OutputParam=无]~*/
	function downloadLog(){
		var checkRows = getCheckedRows(0);
		if(checkRows.length==0){
			alert("请选择至少一条数据！");
			return;
		}
		var fileName = "";
		var filePath = "";
		for (var i = 0; i < checkRows.length; i++) {
			var fileExists = RunJavaMethod("com.amarsoft.app.pidr.util.FileIsExists","fileIsExists","file="+getItemValue(0,checkRows[i],'FilePath'));
			if(fileExists=="true"){
				if(i == checkRows.length-1){
					fileName += getItemValue(0,checkRows[i],'Name'); 
				}else{
					fileName += getItemValue(0,checkRows[i],'Name') + "@";
				}
			}else{
				alert("选择下载的文件" + getItemValue(0,checkRows[i],'Name') +"不存在，请稍后检查");
			}
		}
		var filePathInfo = getItemValue(0,checkRows[0],'FilePath').split("/");
		for (var i = 0; i < filePathInfo.length-1; i++) {
			filePath += filePathInfo[i] + "/";				
		}
		document.download.action="<%=request.getContextPath()%>/PidrDownLoadBatchServlet?fileName="+encodeURI(encodeURI(filePath+"BatchLogtemp.zip")) + "&batchFileName="+fileName;
		document.download.submit(); 
	}
	/*~[Describe=删除日志, InputParam=无, OutputParam=无]~*/
	function deleteLog(){
		var checkRows = getCheckedRows(0);
		if(checkRows.length == 0) {
			alert("请选择至少一条数据！")
			return;
		}
		if(!confirm("确定要删除吗？")){
            return;
        }
		var fileName = "";
		for(var i = 0;i < checkRows.length;i++){
			var fileExists = RunJavaMethod("com.amarsoft.app.pidr.util.FileIsExists","fileIsExists","file="+getItemValue(0,checkRows[i],'FilePath'));
			if(fileExists=="true"){
				fileName = getItemValue(0,checkRows[i],'FilePath');
				var deleteFile = RunJavaMethod("com.amarsoft.app.pidr.util.FileDelete","deleteFile","fileName="+fileName);
				if(deleteFile=="true"){
					alert("文件" + getItemValue(0,checkRows[i],'Name') + "删除成功！");
				} else {
					alert("文件" + getItemValue(0,checkRows[i],'Name') + "删除失败！");
				}
			}else{
				alert("选择删除的文件" + getItemValue(0,checkRows[i],'Name') + "不存在，请稍后检查");
			}
		}
		window.location.reload();
	}
</script>
<form id="download" name="download" method="post" action="PidrDownloadServlet"></form>
<%@include file="/Frame/resources/include/include_end.jspf"%>