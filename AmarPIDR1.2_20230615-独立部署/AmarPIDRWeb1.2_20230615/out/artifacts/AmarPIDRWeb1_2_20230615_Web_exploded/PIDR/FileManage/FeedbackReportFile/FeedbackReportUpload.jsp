<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="/IncludeBegin.jsp"%>
<%@page import="com.amarsoft.app.pidr.common.PIDRConstants"%>
<%--
	Author:kwwu
	CreationDate:2023-02-24
	Description:反馈报文上传页面
--%>
<%
  	session.setAttribute("curUserId", CurUser.getUserID());
	String closeFlag = DataConvert.toString(CurPage.getParameter("CloseFlag"));//上传之后的返回标志
%>
<html>
<head>
	<title>请输入文件信息</title>
<div id=div_process style="display:none">
<table border="0" width="100%" align="center" cellspacing="0" cellpadding="4" style="border-collapse: collapse" bgcolor="#DCDCDC" >
<tr>  
	<td bgcolor="#99B0CE" style="font-size:12px;color:#ffffff" height=24>文件正在上传...</td>  
</tr>  
<tr>       
	<td style="font-size:12px;line-height:200%" align=center>文件正在上传中.请稍等...
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
			 </table>
		</marquee>
	</td>
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

<body bgcolor="#E4E4E4">
<form name="SelectAttachment" method="post" enctype="multipart/form-data" action="<%=request.getContextPath()%>/PidrFeedbackFileUploadServlet?CompClientID=<%=CurComp.getClientID()%>">
<table align="center" width="100%">
	<tr>
		<td>
			<table width='100%' border='1' cellpadding='0' cellspacing='10' bgcolor='#DDDDDD'>
				<tr>
					<td colspan="4">
						<font size="2">请选择反馈报文文件...</font>
					</td>
				</tr>
                
                <tr>
                  <td align="center">
                    <input type="file" size="60"  name="AttachmentFileName" >
                  </td>
                  <td>
      			    &nbsp;&nbsp;   			
    			    <input type=hidden name="FileName" value="" >
    		      </td>
                </tr>	
			</table>
		</td>
	</tr>
	<tr height=1>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td colspan=4>
			<table style="width: 100%;">
				<tr>
					<td width="40%" align="center">
						<%=new Button("&nbsp;确&nbsp;定&nbsp;","确定","upload()","","").getHtmlText()%>
					</td>
					<td width="30%" align="left">
						<%=new Button("&nbsp;取&nbsp;消&nbsp;","取消","parent.AsDialog.ClosePage('_CANCEL_');","","").getHtmlText()%>
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>
</form>
</body>
</html>
<script type="text/javascript">
/*~[Describe=上传反馈,InputParam=无,OutputParam=无]~*/
 function upload() {
	var sFileName="";
	sFileName  = document.forms["SelectAttachment"].AttachmentFileName.value;
	document.forms["SelectAttachment"].FileName.value=sFileName;
	
	var reportName = "";//原报文名称
	var feedbackName = "";//反馈报文名
	sFileName = sFileName.replace(/\\/g,"/"); //将文件名分隔符替换成'/'
	var n = sFileName.split('/');
	feedbackName = n[n.length-1]; //获取反馈报文名称
	if(!feedbackName.endsWith(".txt")){//暂不支持enc反馈报文的解析，因为预处理工具目前无法web调用
		alert("请上传符合格式的文档");
		return ;
	}
	reportName = substring(feedbackName, 0, 29);
	reportName = reportName + "0.txt"; //通过反馈报文名获取报文名称
	if (sFileName==""){
		alert("请选择一个文件名!");
		return ;
	}
	var action = document.forms["SelectAttachment"].action;
	document.forms["SelectAttachment"].action = action+"&FileName="+feedbackName;//修改表单提交的action，添加文件名的传值
	//进行更新session表信息
	var result = RunJavaMethodTrans("com.amarsoft.app.pidr.feedback.UpdateSession", "updateFeedbackSession", "reportName=" + reportName + ",feedbackName=" + feedbackName);
	if (result=="true"){
		self.SelectAttachment.submit();
	} else {
		alert("未找到相应的报文记录，未上传成功");
	}
 }
if("<%=closeFlag%>"== "<%=PIDRConstants.IMPORTRESULT_1%>") {
	alert("上传成功！");
	AsDialog.ClosePage();
}else if("<%=closeFlag%>"== "<%=PIDRConstants.IMPORTRESULT_2%>"){
	alert("上传出现问题");
	AsDialog.ClosePage();
}else if("<%=closeFlag%>"== "<%=PIDRConstants.IMPORTRESULT_5%>"){
	alert("输出流异常");
	AsDialog.ClosePage();
}else if("<%=closeFlag%>" == "<%=PIDRConstants.IMPORTRESULT_7%>"){
	alert("不是multipart/form-data方式提交!");
	AsDialog.ClosePage();
}
</script> 
<%@ include file="/IncludeEnd.jsp"%>