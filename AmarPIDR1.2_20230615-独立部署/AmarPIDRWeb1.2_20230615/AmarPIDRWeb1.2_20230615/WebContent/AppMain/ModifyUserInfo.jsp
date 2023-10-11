<%@ page pageEncoding="UTF-8"%>
<%@ include file="/IncludeBegin.jsp"%><%
%><!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<script type="text/javascript">
	setDialogTitle("<%=LanguageManager.getSystemLanguage("修改信息")%>");
	function saveUserInfo(){
		var myValidRules = {
			rules: {
				email:{
					email : true
				},
				mobile:{
					phonecode : true
				},
				comptel:{
					phonecode : true
				}
			},
			messages : {
				email:{
					email : getMessageText("AWES2051") // Email填写错误！
				},
				mobile:{
					phonecode : getMessageText("AWES2052") // 手机号填写错误！
				},
				comptel:{
					phonecode : getMessageText("AWES2053") // 办公电话填写错误！
				}
			}
		};
		var result = $("#myinfo").validate(myValidRules).form();
		if(!result) return;
		if(!parent.confirm("确定修改保存吗？")) return;
		AsControl.CallService("/MyInfo/changeContact.serv", {"Email": $("#email").val(), "Mobile": $("#mobile").val(), "Comptel": $("#comptel").val()}, function(sm){
			var sReturn = sm.sysHead.responseMessage;
			if(sReturn){
				showMessage(sReturn);
			}else {
				showMessage(getMessageText("AWEW1004")); // 信息保存成功！
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
<link rel="stylesheet" type="text/css" href="<%=sWebRootPath%>/AppMain/resources/css/modifyinfopage.css"/>
<script type="text/javascript" src="<%=sWebRootPath%>/sso/js/crypto-js.min.js" ></script>
<%-- <script type="text/javascript" src="<%=sWebRootPath%>/sso/js/encrypt-util.min.js" ></script> --%>
<script type="text/javascript" src="<%=sWebRootPath%>/sso/js/sm2.js" ></script>
<script type="text/javascript" src="<%=sWebRootPath%>/sso/js/sm2_a3.js" ></script>
</head>
<body scroll="no" bgcolor="#fff">
	<div class="userinfo_main" >
		<p id="message" style="display:block;">
			<%-- <img src="<%=sWebRootPath%>/AppMain/resources/images/info.png" style="width: 20px;height: 20px;"> --%>
			<%=LanguageManager.getSystemLanguage("请编辑并保存信息")%>
		</p>
		<div id="userinfo_word" >
			<form id="myinfo">
				<table class="userinfo">
					<tr>
						<td class="columnName"><%=LanguageManager.getSystemLanguage("当前机构")%>:</td>
						<td><input readonly value="<%=CurUser.getOrgName()%>"/></td>
					</tr>
					<tr>
						<td class="columnName"><%=LanguageManager.getSystemLanguage("当前用户")%>:</td>
						<td><input readonly value="<%=CurUser.getUserName()%>"/></td>
					</tr>
					<tr>
						<td class="columnName"><%=LanguageManager.getSystemLanguage("邮箱")%>:</td>
						<td><input id="email" value="<%=CurUser.getEmail()%>" autocomplete="off"/></td>
					</tr>
					<tr>
						<td class="columnName"><%=LanguageManager.getSystemLanguage("手机号")%>:</td>
						<td><input id="mobile" value="<%=CurUser.getMobileTel()%>" maxlength=11 autocomplete="off"/></td>
					</tr>
					<tr>
						<td class="columnName"><%=LanguageManager.getSystemLanguage("办公电话")%>:</td>
						<td><input id="comptel" value="<%=CurUser.getCompanyTel()%>" maxlength=12 autocomplete="off"/></td>
					</tr>
				</table>
	       	</form>
	    </div>
	    <div class="nor_btnzone" >
	    	<table width="100%"><tr>
			<td align="center"><%=new Button(LanguageManager.getSystemLanguage("保存信息"),"","saveUserInfo()", "", "btn_icon_submit").getHtmlText()%></td></tr></table>
	    </div>
    </div>
</body>
</html>
<%@ include file="/IncludeEnd.jsp"%>