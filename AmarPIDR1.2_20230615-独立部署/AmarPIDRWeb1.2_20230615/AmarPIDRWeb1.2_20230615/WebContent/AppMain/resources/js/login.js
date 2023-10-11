window.onload = function(){
	//防止其他浏览器小窗口出现空白问题（若不考虑元素居中与否，可同上面IE11空白的处理方式，加一个<img>，即去除c:if判断，并删除这部分处理）
	if(!isIE){
		$("video").height("100%");//其他浏览器会兼容object-fit属性，css中配置的cover-保证原有尺寸比例，保证铺满效果
	}
	//初始状态根据是否为空，设置输入框图标不同颜色效果
	if($('#account').val() != ''){
		$('#account').css({
			"background-image": "url(./AppMain/resources/images/login/icon_account.png)"
		});
	}else{
		$('#account').css({
			"background-image": "url(./AppMain/resources/images/login/icon_account_nor.png)"
		});
	}
	if($('#p8w').val() != ''){
		$('#p8w').css({
			"background-image": "url(./AppMain/resources/images/login/icon_password.png)"
		});
	}else{
		$('#p8w').css({
			"background-image": "url(./AppMain/resources/images/login/icon_password_nor.png)"
		});
	}
	//用户名、密码均不为空，登录按钮才是蓝色
	if($('#account').val() != '' && $('#p8w').val() != ''){
		$('#btn_submit').css({
			"background": "linear-gradient(91.3deg, #3B94F6 2.96%, #2A86EB 99.74%)",
			"border": "1px solid #3B94F6"
		});
		LogonForm.account.focus();
	}
}
/*~[Describe=失去焦点，不为空时，图标显示蓝色，否则灰色；focus时显示蓝色图标,InputParam=无,OutputParam=无]~*/
$('#account').blur(function(){
	if($('#account').val() != ''){
		$('#account').css({
			"background-image": "url(./AppMain/resources/images/login/icon_account.png)"
		});
	}else{
		$('#account').css({
			"background-image": "url(./AppMain/resources/images/login/icon_account_nor.png)"
		});
	}
});
$('#account').focus(function(){
	$('#account').css({
		"background-image": "url(./AppMain/resources/images/login/icon_account.png)"
	});
});
$('#p8w').blur(function(){
	if($('#p8w').val() != ''){
		$('#p8w').css({
			"background-image": "url(./AppMain/resources/images/login/icon_password.png)"
		});
	}else{
		$('#p8w').css({
			"background-image": "url(./AppMain/resources/images/login/icon_password_nor.png)"
		});
	}
});
$('#p8w').focus(function(){
	$('#p8w').css({
		"background-image": "url(./AppMain/resources/images/login/icon_password.png)"
	});
});

/*~[Describe=监听输入框，当用户、密码均不为空时，登录按钮显示蓝色,InputParam=无,OutputParam=无]~*/
$("input").bind("input propertychange",function(){
	var account = $("#account").val().replace(/(^\s*)|(\s*$)/g, "");
	var password = $("#p8w").val();
	if(account != '' && password != ''){
		$('#btn_submit').css({
			"background": "linear-gradient(91.3deg, #3B94F6 2.96%, #2A86EB 99.74%)",
			"border": "1px solid #3B94F6"
		});
	}else{
		$('#btn_submit').css({
			"background": "linear-gradient(91.3deg, #CFDAFF 0%, #C9D4FA 100%)",
			"border": "1px solid #F5F7FA"
		});
	}
});



