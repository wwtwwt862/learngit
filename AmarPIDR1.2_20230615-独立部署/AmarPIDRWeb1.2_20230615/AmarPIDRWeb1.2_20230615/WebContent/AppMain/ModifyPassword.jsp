<%@ page pageEncoding="UTF-8"%>
<%@ include file="/IncludeBegin.jsp"%>
<%@page import="com.amarsoft.awe.security.*"%><%
	String p8dState = CurPage.getParameter("PasswordState");
	if(StringX.isSpace(p8dState)) p8dState = new UserMarkInfo(Sqlca,CurUser.getUserID()).getPasswordState();
	if(p8dState == null) p8dState = "";
%><!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<script type="text/javascript">
	setDialogTitle("<%=LanguageManager.getSystemLanguage("修改密码")%>");
	function checkp8d(){
		var oldP8d  = document.getElementById("oldP8d").value;	
		var newP8d  = document.getElementById("newP8d").value;	
		var confirmNewP8d  = document.getElementById("confirmNewP8d").value;	
		if(oldP8d==""){
			showMessage("<%=LanguageManager.getSystemLanguage("请输入原来的密码!")%>");
			return;
		}
		if(newP8d=="" && confirmNewP8d==""){
			showMessage("<%=LanguageManager.getSystemLanguage("新密码不能为空!")%>");
			return;
		}
		if(newP8d != confirmNewP8d){
			showMessage("<%=LanguageManager.getSystemLanguage("两次输入的密码不一致!")%>");
			return;
		}
		var pattern = /^.*[^a-zA-Z0-9!@$*.]{1,}.*$/;
		if(pattern.exec(newP8d)){
			showMessage("<%=LanguageManager.getSystemLanguage("密码不能包含大小写字母、数字或者!@$*.之外的字符!")%>");
			return;
		}

		oldP8d = A3Sm2.encrypt(oldP8d); //AES.encrypt(oldP8d);
		newP8d = A3Sm2.encrypt(newP8d); //AES.encrypt(newP8d);
		AsControl.CallService("/MyInfo/changepassword.serv", {"UserID": "<%=CurUser.getUserID()%>", "OldPassword": oldP8d, "NewPassword": newP8d}, function(sm){
			if(sm.sysHead.responseMessage != "SUCCEEDED"){
				showMessage(sm.sysHead.responseMessage);
			}else{
				<%if(p8dState.equals(String.valueOf(SecurityAuditException.CODE_USER_FIRST_LOGON)) || p8dState.equals(String.valueOf(SecurityAuditException.CODE_PWD_OVERDUE))){%>
					showMessage("<%=LanguageManager.getSystemLanguage("密码修改成功！请重新登录系统!")%>");
					window.open("<%=sWebRootPath%>/index.html","_top");
				<%}else{%>
					showMessage("<%=LanguageManager.getSystemLanguage("密码修改成功!")%>");
				<%}%>
			}
		});
	}

	function showMessage(src){
		var o = document.getElementById("message");
		if(o.flag) window.clearTimeout(o.flag);
		
		o.innerHTML = src;
		o.style.display = "block";
		/* var flag = setTimeout(function(){
			o.style.display = "none";
			o.flag = "";
		}, 10000);
		o.flag = flag; */
	}
</script>
<link rel="stylesheet" type="text/css" href="<%=sWebRootPath%>/AppMain/resources/css/page.css"/>
<link rel="stylesheet" type="text/css" href="<%=sWebRootPath%><%=sSkinPath%>/css/page.css">
<link rel="stylesheet" type="text/css" href="<%=sWebRootPath%>/AppMain/resources/css/modifypassword.css"/>
<script type="text/javascript" src="<%=sWebRootPath%>/sso/js/crypto-js.min.js" ></script>
<%-- <script type="text/javascript" src="<%=sWebRootPath%>/sso/js/encrypt-util.min.js" ></script> --%>
<script type="text/javascript" src="<%=sWebRootPath%>/sso/js/sm2.js" ></script>
<script type="text/javascript" src="<%=sWebRootPath%>/sso/js/sm2_a3.js" ></script>
</head>
<body scroll="no" bgcolor="#fff">
	<div class="pwd_main" >
		<p id="message" style="display:block;">
			<%-- <img src="<%=sWebRootPath%>/AppMain/resources/images/info.png" style="width: 20px;height: 20px;"> --%>
			<%=LanguageManager.getSystemLanguage("请输入新密码并在确认字段中重新输入一次")%>
		</p>
		<div id="pass_word" >
			<table>
	        <tr><td style="text-align: right; padding-left:20px;"><label for="oldP8d"><%=LanguageManager.getSystemLanguage("旧密码")%>:</label>&nbsp;&nbsp;<input type="password" id="oldP8d" placeholder="请输入旧密码" autocomplete="off" /></td></tr>
	        <tr><td style="text-align: right; padding-left:20px;"><label for="newP8d"><%=LanguageManager.getSystemLanguage("新密码")%>:</label>&nbsp;&nbsp;<input type="password" id="newP8d" placeholder="请输入新密码" autocomplete="off" /></td></tr>
	        <tr><td style="text-align: right; padding-left:20px;"><label for="confirmNewP8d"><%=LanguageManager.getSystemLanguage("确认")%>:</label>&nbsp;&nbsp;<input type="password" id="confirmNewP8d" placeholder="请再次输入新密码" autocomplete="off" /></td></tr>
	       	</table>
	    </div>
	    <div class="nor_btnzone" >
	    	<table width="100%"><tr>
			<td align="center"><%=new Button(LanguageManager.getSystemLanguage("变更密码"),"","checkp8d()", "", "btn_icon_submit").getHtmlText()%></td><td  align="left">
	<%if(p8dState.equals(String.valueOf(SecurityAuditException.CODE_USER_FIRST_LOGON)) || p8dState.equals(String.valueOf(SecurityAuditException.CODE_PWD_OVERDUE))){
      	out.write(new Button(LanguageManager.getSystemLanguage("重新登录"),"","window.open('" + sWebRootPath + "/index.html','_top')").getHtmlText());
	}%>
      		</td></tr></table>
	    </div>
    </div>
</body>
</html>
<%@ include file="/IncludeEnd.jsp"%>