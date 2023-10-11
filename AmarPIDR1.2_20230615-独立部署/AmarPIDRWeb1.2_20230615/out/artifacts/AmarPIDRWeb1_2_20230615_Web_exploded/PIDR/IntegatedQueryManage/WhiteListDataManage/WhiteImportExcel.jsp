<%@page import="com.amarsoft.app.pidr.common.PIDRConstants"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="/IncludeBegin.jsp"%>
<%@ page import="java.net.URL" %>
<%
  	session.setAttribute("curUserId", CurUser.getUserID());
	String closeFlag = DataConvert.toString(CurPage.getParameter("CloseFlag"));
    String path = request.getSession().getServletContext().getResource("/").getFile();
    String fileType=CurPage.getParameter("fileType");
    
%>

<html>
<head> 
<title>请输入附件信息</title>
<div id=div_process style="display:none">
<table border="0" width="100%" align="center" cellspacing="0" cellpadding="4" style="border-collapse: collapse" bgcolor="#DCDCDC" >
 <tr>  
  <td bgcolor="#99B0CE" style="font-size:12px;color:#ffffff" height=24>数据导入处理...</td>  
 </tr>  
 <tr>       
  <td style="font-size:12px;line-height:200%" align=center>数据文件正在导入中.请稍等...
  <marquee style="border:1px solid #000000" direction="right" width="300" scrollamount="5" scrolldelay="10" bgcolor="#ECF2FF">
  <table cellspacing="1" cellpadding="0">
  <tr height=8> 
  <td bgcolor=#99B0CE width=8></td>  
  <td></td>    
  <td bgcolor=#99B0CE width=8></td>
  <td></td>
  <td bgcolor=#99B0CE width=8></td>
  <td></td>
  <td bgcolor=#99B0CE width=8></td>
  <td></td>
  </tr>
  </table></marquee></td>
 </tr>
   <tr> 
  <td style="font-size:12px;line-height:200%">&nbsp;</td>                    
 </tr>
</table>
</div>
<style>
.black9pt {  font-size: 9pt; color: #000000; text-decoration: none}
</style>
</head>

<body bgcolor="#D3D3D3">
<form name="SelectAttachment" method="post" enctype="multipart/form-data" action="<%=request.getContextPath() %>/WhiteUpLoad" >
<table align="center" >
    <tr>
            <td class="black9pt"  align="left">
                <font size="2">请选择一个代码映射Excel文件作为附件上传:</font>
                <br>
            </td> 
        </tr>
        <tr>
            <td>    
                <input type="file" size=60  name="AttachmentFileName">&nbsp;
                <a href="<%=request.getContextPath() %>/WhiteDownLoad"><font color=red><b>[下载白名单代码模板]</b></font></a>
            </td>
        </tr>
        <tr>
            <td>
                &nbsp;&nbsp;            
                <input type=hidden name="FileName" value="" >
            </td> 
        </tr>
        <tr>
            <td width="40%" align="center">
                        <%=new Button("&nbsp;确&nbsp;定&nbsp;","确定","upload()","","").getHtmlText()%>
            </td>
            <td width="30%" align="left">
                        <%=new Button("&nbsp;取&nbsp;消&nbsp;","取消","parent.AsDialog.ClosePage('_CANCEL_');","","").getHtmlText()%>
            </td>    
    </tr>

 </table>
</form>
</body>
</html>
<script language=javascript>
   
    function upload() {
    	if (checkItems()) {
       		self.SelectAttachment.submit();
    	}
    }
    
	function checkItems()
	{
		var fileName="";
		fileName  = document.forms["SelectAttachment"].AttachmentFileName.value;
		document.forms["SelectAttachment"].FileName.value=fileName;
		if (fileName==""){
			alert("请选择一个文件名!");
			return false;
		}
        if(".xls"!=fileName.substr(fileName.length-4,fileName.length)){
        	alert("文件名要求为xls的Excel!");
        	return false;
        }
		if(fileName.indexOf("WhiteList")>-1 ){
			return true;
		}else {
			alert("当前入口与文件格式不匹配!");
            return false;
		}
		SelectAttachment.style.display="none";   
		div_process.style.display="block";
		
		return true;
	}	   

	if("<%=closeFlag%>"== "<%=PIDRConstants.IMPORTRESULT_1%>") {
		alert("导入成功！");
		AsDialog.ClosePage();
	}
	else if("<%=closeFlag%>"== "<%=PIDRConstants.IMPORTRESULT_2%>"){
		alert("上传出现问题");
		AsDialog.ClosePage();
	}
	else if("<%=closeFlag%>"== "<%=PIDRConstants.IMPORTRESULT_3%>"){
		alert("获取的文件为非excel正确格式");
		AsDialog.ClosePage();
	}
	else if("<%=closeFlag%>"=="<%=PIDRConstants.IMPORTRESULT_4%>"){
		alert("解析出现异常,请核对Excel文件中的数据");
		AsDialog.ClosePage();
	}
	else if("<%=closeFlag%>"== "<%=PIDRConstants.IMPORTRESULT_5%>"){
		alert("输出流异常");
		AsDialog.ClosePage();
	}
	else if("<%=closeFlag%>"== "<%=PIDRConstants.IMPORTRESULT_6%>"){
		alert("导入失败");
		AsDialog.ClosePage();
	}
	else if("<%=closeFlag%>" == "<%=PIDRConstants.IMPORTRESULT_7%>"){
		alert("不是multipart/form-data方式提交!");
		AsDialog.ClosePage();
	}
	
</script>
<%@ include file="/IncludeEnd.jsp"%>