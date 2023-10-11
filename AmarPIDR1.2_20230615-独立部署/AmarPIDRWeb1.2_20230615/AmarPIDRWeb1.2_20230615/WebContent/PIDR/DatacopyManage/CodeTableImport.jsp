<%@page import="com.amarsoft.app.pidr.common.PIDRConstants"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="/IncludeBegin.jsp"%>
<%@ page import="java.net.URL" %>

<%/*~BEGIN~可编辑区~[Editable=true;CodeAreaID=Main00;Describe=注释区;]~*/%>
	<%
	/*
	Author:   pcui 2012-03-06
	Tester: 
  	Content: 业务信息批量删除excel导入
  	Input Param:
 			DocNo:   
  	Output param:
  	History Log:
			
	*/
	%>
<%/*~END~*/%>


<%
  	session.setAttribute("curUserId", CurUser.getUserID());
	String closeFlag = DataConvert.toString(CurPage.getParameter("CloseFlag"));
	String[] resultStr = (String[])request.getAttribute("ResultStr");
	String errTable = "";
	String errName = "";
	String errRowNo = "";
	String errMsg = "";
	 if(resultStr != null && resultStr.length > 1){
	 	errTable = resultStr[1];
		errName = resultStr[2];
		errRowNo = resultStr[3];
		errMsg = resultStr[4].replace("\r", "").replace("\n", "").replace("\t", "").replace("\"","\'");//替换错误信息里的特殊字符
	} 
    String path = request.getSession().getServletContext().getResource("/").getFile();
    request.setAttribute("ResultStr",null);
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
<form name="SelectAttachment" method="post" enctype="multipart/form-data" action="<%=request.getContextPath() %>/PidrExcelDatacopyServlet?CompClientID=<%=CurComp.getClientID()%>" >
<table align="center" >
	<tr>
    		<td class="black9pt"  align="left">
    			<font size="2">请选择一个标准接口Excel文件作为附件上传:</font>
    			<br>
    			
    		</td> 
    	</tr>
    	<tr>
    		<td>    
    			<input type="file" size=60  name="AttachmentFileName">&nbsp;
    			<a href="<%=request.getContextPath() %>/PidrDownloadServlet?fileName=<%=path+ARE.getProperty("PIDRBatchImpFile")+"/LIST_PIDR.xlsx"%>&CompClientID=<%=CurComp.getClientID()%>"><font color=red><b>[下载央行内评标准接口模板]</b></font></a>
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
		var delay="";

		fileName  = document.forms["SelectAttachment"].AttachmentFileName.value;
		document.forms["SelectAttachment"].FileName.value=fileName;
		if (fileName=="")			
		{
			alert("请选择一个文件名!");
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
		if("<%=errRowNo%>" != ""){
			alert("解析出现异常,请核对Excel文件中的数据\r\n" 
					+ "错误表格：" + "<%=errTable%>" + "\r\n"
					+ "出错行号：" + "<%=errRowNo%>" + "\r\n"
					+ "错误字段名：" + "<%=errName%>" + "\r\n"
			);
		}else{
			alert("解析出现异常,请核对Excel文件中的数据\r\n" 
					+ "错误表格：" + "<%=errTable%>" + "\r\n"
					+ "错误提示：" + "<%=errMsg%>" 
			);
		}
		
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
	else if("<%=closeFlag%>" == "<%=PIDRConstants.IMPORTRESULT_8%>"){
		alert("记录文件信息失败!");
		AsDialog.ClosePage();
	}else if("<%=closeFlag%>" == "<%=PIDRConstants.IMPORTRESULT_0%>"){
		alert("数据导入成功，存在主键重复数据!");
		AsDialog.PopView("/PIDR/DatacopyManage/PidrIntErrorList.jsp","","dialogWidth:1000px;dialogHeight:600px");
	}
	
</script>
<%@ include file="/IncludeEnd.jsp"%>