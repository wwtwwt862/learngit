<%@ page language="java" contentType="text/html; charset=UTF-8" session="false"%><%@ 
taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%><%@
page import="com.amarsoft.awe.sso.SSOService"%><%@
page import="com.amarsoft.awe.control.model.ParameterUtil"%><%
	response.setHeader("Cache-Control","no-store");
	response.setHeader("Pragma","no-cache");
	response.setDateHeader("Expires",0);
	boolean isSwitchTop=true;
	String sSwitchTop = ParameterUtil.getSafeHtml((String)request.getAttribute("isSwitchTop"));
	if ("false".equals(sSwitchTop)) {isSwitchTop=false;}
	String continueUrl = ParameterUtil.getSafeParamter(request.getParameter("continue"));
	if (continueUrl==null) {continueUrl = ParameterUtil.getSafeParamter((String)request.getAttribute(SSOService.SSO_GO_URL));}
	String errorMessage = ParameterUtil.getSafeHtml((String)request.getAttribute("ErrorMessage"));
	//判断是否为IE浏览器
	boolean isIE = false;
	String userAgent = request.getHeader("USER-AGENT");//获取浏览器类型
	String[] IEBrowserSignals = {"MSIE","Trident","Edge"};
	for(String signal : IEBrowserSignals){
	    if(userAgent.contains(signal)){
	        isIE = true;
	        break;
	    }
	}
	
%><!-- <!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"> -->
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>系统登录窗口</title>
<link rel="stylesheet" type="text/css" href="AppMain/resources/css/login.css"/>
<script type="text/javascript" src="Frame/resources/js/jquery/jquery.min.js"></script>
<script type="text/javascript" src="sso/js/crypto-js.min.js" ></script>
<!-- <script type="text/javascript" src="sso/js/encrypt-util.min.js" ></script> -->
<script type="text/javascript" src="sso/js/sm2.js" ></script>
<script type="text/javascript" src="sso/js/sm2_a3.js" ></script>
<link rel="shortcut icon" href="favicon.ico"/>
</head>
<body scroll="no"  class="logon_body">
<!-- 动态登录背景 -->
<div class="video-box">
	<c:choose>
		<c:when test='<%=isIE%>'><!-- IE浏览器weblogic部署可能会识别不了mp4文件的mime类型，故使用图片 -->
			<img class="video-background" src="AppMain/resources/images/login/login_bg.png"/>
		</c:when>
		<c:otherwise>
			 <video class="video-background" preload="auto" loop autoplay src="AppMain/resources/images/login/login_bg4.mp4" tabindex="-1" muted="muted"></video>
		</c:otherwise>
	</c:choose>
</div>
<div class="logon_mid_center" align="center">
	<form id="LogonForm" name="LogonForm" method="post" action="ssoservice" onsubmit="return false;">
		<img class="logo" src="AppMain/resources/images/login/logo1.png" /><span id="logo-title">安硕央行内评数据报送软件V1.2</span>
		<div class="logon_user">
			<input type="text" id="account" placeholder="请输入用户名" name="account" onblur="javascript:myTrim();" autocomplete="off" class="input_class"/>
		</div>
		<div class="logon_password">
			<input type="password" id="p8w" placeholder="请输入密码" name="p8w" autocomplete="off" class="input_class"/>
		</div>
		<div class="remember">
			<label><input type="checkbox" name="remember"/>记住密码</label>
		</div>
		<%-- <div class="logon_user" style="white-space: nowrap; margin-left: 15px;">
			验证码：<span style="display: inline-block;"><input type="text" name="captcha" onKeyPress="javascript:pressEnter(3, event);" class="input_class" style=" width: 110px;"/>
			<img src="Kaptcha" onclick="this.src='Kaptcha?time='+new Date().getTime()" id="image1" title="点击刷新验证码" style="width: 120px;height: 30px; cursor: pointer;vertical-align: bottom;"/>
	 		<a href="#" onclick="$('#image1').attr('src', 'Kaptcha?time='+new Date().getTime())">看不清，换一张</a></span>
		</div> --%>
	 	<span id='amarhidden' style='display:none' class="hiddenspan">正在检查用户请稍等.....</span>
		<button type="submit" id="btn_submit" onclick="doSubmit()">登录</button>
		<div class="logon_error"><%=errorMessage==null?"":errorMessage%>      </div>
	</form>
</div>
<%-- <div class="logon_footer">
   <div class="copyright">©&nbsp;2001-<%=new com.amarsoft.are.lang.DateX().getYear()%>&nbsp;上海安硕信息技术股份有限公司</div>
</div> --%>

<!-- 部分登录效果处理在js中实现 -->
<script type="text/javascript" src="AppMain/resources/js/login.js" ></script>
<a class="logon_sysstyle" href="javascript:void(0)"></a>
<script type="text/javascript">
var isIE = <%=isIE%>;//判断是否为IE浏览器
<%if(isSwitchTop){ %> if (top != self)  {top.location=self.location;}<%}%>
var LogonForm = document.getElementById("LogonForm");
//LogonForm.account.focus();

function change(obj){
 	var style = obj.style;
	window.status='';
}
function over_change(index,src,clrOver){
	if (!src.contains(event.fromElement)){ 
 		src.style.cursor = 'pointer';
 		src.background = clrOver;
	}
}
function out_change(index,src,clrIn){
	if (!src.contains(event.toElement)){
		src.style.cursor = 'default';
		src.background = clrIn;
	}
}
function writeCookie(name, value, hours) {
	var expire = "";
	if (hours != null) {
		expire = new Date((new Date()).getTime() + hours * 3600000);
		expire = "; expires=" + expire.toGMTString();
	}
	document.cookie = name + "=" + escape(value) + expire;
}

function readCookie(name) {
	var cookieValue = "";
	var search = name + "=";
	if (document.cookie.length > 0) {
		offset = document.cookie.indexOf(search);
		if (offset != -1) {
			offset += search.length;
			end = document.cookie.indexOf(";", offset);
			if (end == -1) end = document.cookie.length;
			cookieValue = unescape(document.cookie.substring(offset, end))
		}
	}
	return cookieValue;
}
function chkForm(theForm){
	//防止拼凑用户名的BUG  add by xhgao 2009/04/03
    if(theForm.account.value.indexOf("=")>0 || theForm.account.value.indexOf("'")>0 || theForm.account.value.indexOf(" ")>0){
	   alert("输入用户名错误");
	   theForm.account.focus();
	   return false;
	}
	if(theForm.account.value.length<1){
		alert("请输入用户名！");
		theForm.account.focus();
		return false;
	}

	if(theForm.p8w.value.length<1){
		alert("请输入密码！");
		theForm.p8w.focus();
		return false;
	}
	writeCookie("account", LogonForm.account.value, 240);
	writeCookie("remember", "1", LogonForm.remember.checked ? 240 : 0);
	writeCookie("p8w", LogonForm.p8w.value, LogonForm.remember.checked ? 240 : 0);
	return true;
}

function doSubmit(){
	var form = document.getElementById("LogonForm");
	if(chkForm(form)){
		/* $("#p8w").val(AES.encrypt($("#p8w").val())); */
		$("#p8w").val(A3Sm2.encrypt($("#p8w").val()));
		
		//处理password类型的输入框提交时，浏览器提示记住密码问题，下次登录自动填入密码，影响登录一些效果配置
		var realPassword = $("#p8w").val();//存储输入的密码
		//var cssText = document.getElementById('p8w').style.cssText;
		$("#p8w").remove();//input的type不可动态修改，故先移除再重新拼接
		//隐藏文本框用于提交
		$('.logon_password').append('<input type="hidden" id="p8w" placeholder="请输入密码" name="p8w" autocomplete="off" class="input_class"/>');
		$("#p8w").val(realPassword);//填入前面输入的密码
		//text文本框用于展示，防止由于type为password导致浏览器记住密码，故改为text
		$('.logon_password').append('<input type="text" id="p8wShow" placeholder="请输入密码" name="p8wShow" autocomplete="off" class="input_class"/>');
		$("#p8wShow").css("cssText","width:402px; height:62px; margin: 50px 42px 0 ; border-radius: 8px; background: #F5F7FA 12px center no-repeat; "
			+" border: 1px solid #F5F7FA;padding-left:60px;background-image: url(./AppMain/resources/images/login/icon_password.png);");
		$("#p8wShow").val("•••••••••");
		
		<%if(!isSwitchTop&&continueUrl!=null){ %> form.action="ssoservice?continue=<%=ParameterUtil.getURLEncoder(continueUrl)%>"; <%}%>
		form.submit();
        document.getElementById("amarhidden").style.display="";
        document.getElementById("btn_submit").style.display="none";
        //document.getElementById("btn_reset").style.display="none";
	}
}

function pressEnter(arg, e){
	var e = e || window.event;
	if(e.keyCode==13){
		if(arg==3){
			doSubmit();
			return false;
		}else if(arg==0){
			document.getElementById("LogonForm").account.focus();
		}else if(arg==1){
			document.getElementById("LogonForm").p8w.focus();
		}else if(arg==2){
			var checkCode = document.getElementById("LogonForm").CheckCode;
			if(!checkCode) pressEnter(3, e);
			else checkCode.focus();
		}
	}else{
		return true;
	}
}

function myTrim(){
	var obj = document.getElementById("LogonForm").account;
	obj.value = obj.value.replace(/(^\s*)|(\s*$)/g, "");
}

LogonForm.account.value = readCookie("account");
//LogonForm.account.focus();
if (readCookie("remember") === "1") {//记住密码
	LogonForm.p8w.value = readCookie("p8w");
	LogonForm.remember.checked = true;
}
</script>
</body>
</html>