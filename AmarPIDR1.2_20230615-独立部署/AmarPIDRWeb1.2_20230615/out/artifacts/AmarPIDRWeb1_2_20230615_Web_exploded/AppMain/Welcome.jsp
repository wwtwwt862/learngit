<%@ page pageEncoding="UTF-8"%>
<%@ include file="/Frame/resources/include/include_begin_ajax.jspf" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.amarsoft.app.pidr.index.*"  %>
<%
	String userId = CurPage.getUserId();//获取当前用户编号
    String orgId =CurPage.getOrgId();//获取当前机构编号
	Calendar now = Calendar.getInstance();
	int curHour = now.get(Calendar.HOUR_OF_DAY);//获取当前时间的小时
	StatisCountHandler statisHandler =  new StatisCountHandler();
	int[] error= statisHandler.getErrorCount();//获取校验错误和反馈错误数量
	int[] reportCount = statisHandler.getReportCount();//获取最新一次批量生成的各种报送数量
	String pidr_describe="企业央行内评批量";

	NoticeHandler notice = new NoticeHandler();
	notice.getNotices(request, userId);//获取公告信息
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
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<link rel="stylesheet" href="<%=sWebRootPath%>/AppMain/resources/css/welcome.css" />
<script type="text/javascript" src="<%=sWebRootPath%>/AppMain/resources/js/app_cust.js"></script>
<script type="text/javascript" src="<%=sWebRootPath%>/Frame/resources/js/jquery/jquery.min.js"></script>
<script type="text/javascript" src="<%=sWebRootPath%>/Frame/page/js/as_control.js"></script>
<script type="text/javascript" src="<%=sWebRootPath%>/Frame/page/js/as_widget.js"></script>
<script type="text/javascript" src="<%=sWebRootPath%>/Frame/resources/js/dialog/dialog-min.js"></script>
<script type="text/javascript" src="<%=sWebRootPath%>/Frame/resources/js/echarts.js"></script>

<script type="text/javascript" src="<%=sWebRootPath%>/Frame/page/js/sys/sys_common.js"></script>
<script type="text/javascript" charset="UTF-8" src="<%=sWebRootPath%>/Frame/resources/js/checkdatavalidity.js"></script>
<script type="text/javascript" charset="UTF-8" src="<%=sWebRootPath%>/Frame/resources/js/jquery/plugins/jquery.validate.min.js"></script>
<script type="text/javascript" charset="UTF-8" src="<%=sWebRootPath%>/Frame/resources/js/jquery/plugins/jquery.validate.extend.js"></script>
<script type="text/javascript">window.history.forward(1);var sCompClientID='<%=sCompClientID%>';var sWebRootPath='<%=sWebRootPath%>';var sSkinPath='<%=sSkinPath%>';</script>
<title>Welcome 欢迎界面</title>
</head>

<body>
	<div class="left">
		<div class="top">
			<div class="top-left">
				<div class="block todo" style="height: 100%;">
					<div class="title"> 
					    <img src="<%=sWebRootPath%>/AppMain/resources/images/main/icon_todo.png" style="width: 24px;height: 24px;"></img>
						<span>待办事项</span>
					</div>
					<div class="gipv" style="border: 1px solid #F0F4F8;"></div>
					<div class="body">
						<div class="todo_detail">
							<a onclick="parent.openMenu('700010')">
                           		<span class="todo_type">待修改的校验错误</span>
                           		<span class="todo_num"><em><%=error[0]%></em>条</span>
                           	</a>
						</div>
						<div class="todo_detail">
							<a onclick="parent.openMenu('700020')">
                           		<span class="todo_type">待修改的反馈错误</span>
                           		<span class="todo_num"><em><%=error[1]%></em>条</span>
                           	</a>
						</div>
					</div>
				</div>
			</div>
			<div class="top-right">
				<div class="block taskStatus" style="position: relative;">
					<div class="video-box">
						<div class="taskrun">
							<c:choose>
								<c:when test='<%=isIE%>'><!-- IE浏览器weblogic部署可能会识别不了mp4文件的mime类型，故使用图片 -->
									<img class="bg_taskStatus" src="<%=sWebRootPath%>/AppMain/resources/images/main/rate_taskStatus.png"/>
								</c:when>
								<c:otherwise>
									<video class="bg_taskStatus" preload="auto" loop autoplay src="<%=sWebRootPath%>/AppMain/resources/images/main/rate_taskStatus_3.mp4" tabindex="-1" muted="muted"></video>
								</c:otherwise>
							</c:choose>
						</div>
						<img class="bg_cycle" src="<%=sWebRootPath%>/AppMain/resources/images/main/bg_cycle.png"/>
						<div class="taskrun_date"></div>
						<div class="step">
							<img class="stepImg1" src="<%=sWebRootPath%>/AppMain/resources/images/main/bg_step_right.png"/>
							<span class="stepName1"></span>
							<div class="step1">步骤1</div>
							<img class="stepImg2" src="<%=sWebRootPath%>/AppMain/resources/images/main/bg_step_right.png"/>
							<span class="stepName2"></span>
							<div class="step2">步骤2</div>
							<img class="stepImg3" src="<%=sWebRootPath%>/AppMain/resources/images/main/bg_step_right.png"/>
							<span class="stepName3"></span>
							<div class="step3">步骤3</div>
							<img class="stepImg4" src="<%=sWebRootPath%>/AppMain/resources/images/main/bg_step_right.png"/>
							<span class="stepName4"></span>
							<div class="step4">步骤4</div>
							<img class="stepImg5" src="<%=sWebRootPath%>/AppMain/resources/images/main/bg_step_left.png"/>
							<span class="stepName5"></span>
							<div class="step5">步骤5</div>
							<img class="stepImg6" src="<%=sWebRootPath%>/AppMain/resources/images/main/bg_step_left.png"/>
							<span class="stepName6"></span>
							<div class="step6">步骤6</div>
						</div>
					</div>
					<div class="switch">
						<img class="switch1" onmouseover="changeStyle1(this,'.switchName1')" onmouseout="changeStyle2(this,'.switchName1')" src="<%=sWebRootPath%>/AppMain/resources/images/main/bg_map_switch_sel.png" />
						<span class="switchName1">评级信息</span>
						<img class="switch2" onmouseover="changeStyle1(this,'.switchName2')" onmouseout="changeStyle2(this,'.switchName2')" src="<%=sWebRootPath%>/AppMain/resources/images/main/bg_map_switch_nor.png" />
						<span class="switchName2">信贷资产</span>
					</div>
				</div>
			</div>
		</div>
		<div class="bottom">
			<div class="bottom-left">
				<div class="block calendardiv">
					<div class="title">
					 	<img src="<%=sWebRootPath%>/AppMain/resources/images/main/icon_calendar.png" style="width: 24px;height: 24px;"></img>
						<span>日历</span>
					</div>
					<div class="gipv" style="border: 1px solid #F0F4F8;"></div>
					<div class="body">
						<div style="float:left; width: 70%;height: 90%;">
							<table class="calendar">
								<thead>
								<tr>
									<td colspan="7">
										<a class="calendar-left"> </a>
										<select>
											<% for (int i = now.get(Calendar.YEAR) - 10; i < now.get(Calendar.YEAR) + 10; i++) { %>
											<option value="<%=i %>"><%=i %></option>
											<% } %>
										</select>
										<select>
											<option value="0">1月</option>
											<option value="1">2月</option>
											<option value="2">3月</option>
											<option value="3">4月</option>
											<option value="4">5月</option>
											<option value="5">6月</option>
											<option value="6">7月</option>
											<option value="7">8月</option>
											<option value="8">9月</option>
											<option value="9">10月</option>
											<option value="10">11月</option>
											<option value="11">12月</option>
										</select>
										<a class="calendar-right"> </a>
									</td>
								</tr>
								<tr>
									<td>日</td>
									<td>一</td>
									<td>二</td>
									<td>三</td>
									<td>四</td>
									<td>五</td>
									<td>六</td>
								</tr>
								</thead>
								<tbody></tbody>
							</table>
						</div>
						<div class="failedrecord" style="float:right; width:30%;height: 90%;">
							<div style="padding-bottom: 12px;">
								<span style="vertical-align: middle;cursor:default;">失败任务记录</span>&nbsp;&nbsp;
								<a class="showMore" onclick="showMoreFailedRecord()">更多<img src="<%=sWebRootPath%>/AppMain/resources/images/main/icon_more.png" style="vertical-align: middle;"></img></a>
							</div>
							<div class="failedRecordBody">
							</div>
						</div>
					</div>
				</div>
			</div>
			<div class="bottom-right">
				<div class="block dataStatistics">
					<div class="title">
						<img src="<%=sWebRootPath%>/AppMain/resources/images/main/icon_dataStatistics.png" style="width: 24px;height: 24px;"></img>
						<span>数据统计</span>
					</div>
					<div class="gipv" style="border: 1px solid #F0F4F8;"></div>
					<div class="body" id="icr_data_main"></div>
				</div>
			</div>
		</div>
	</div>
	<div class="right">
		<div class="top">
			<div class="block personalInfo">
				<!-- <div class="title"><span>我的信息</span></div> -->
				<div class="hello1">
					<div style="overflow: hidden; display:inline-block; vertical-align:middle;">
						<div id="welcome" style="overflow-x:scroll;height:40px;width:180px;color:#3B94F6;margin-bottom:-20px;white-space:nowrap;">
							<div id="welcome1" style="display:inline;">
							   嗨，欢迎登录央评报送系统！&nbsp;&nbsp;&nbsp;
							</div>
							<div id="welcome2" style="display:inline;">
							</div>
						</div>
					</div>			
					<span class="button">
						<button onclick="modifyUserInfo()">修改信息</button>&nbsp;&nbsp;
						<button onclick="modifyPass()">修改密码</button>
					</span>
				</div>
				<c:choose>
					<c:when test="<%=curHour<12%>">
						<div class="hello2">上午好，<%=CurUser.getUserName()%></div>
					</c:when>
					<c:otherwise>
						<div class="hello2">下午好，<%=CurUser.getUserName()%></div>
					</c:otherwise>
				</c:choose>
				<table class="info">
					<tr>
						<td><img class="icon_orgName" style="vertical-align: middle;" src="resources/images/main/icon_orgName.png" />&nbsp;<span class="orgName"><%=CurUser.getOrgName()%></span></td>
						<td><img class="icon_mobileTel" style="vertical-align: middle;" src="resources/images/main/icon_mobileTel.png" />&nbsp;<span class="mobileTel"><%=CurUser.getMobileTel()%></span></td>
					</tr>
					<tr>
						<td><img class="icon_email" style="vertical-align: middle;" src="resources/images/main/icon_email.png" />&nbsp;<span class="email"><%=CurUser.getEmail()%></span></td>
						<td><img class="icon_companyTel" style="vertical-align: middle;" src="resources/images/main/icon_companyTel.png" />&nbsp;<span class="companyTel"><%=CurUser.getCompanyTel()%></span></td>
					</tr>
				</table>
			</div>
		</div>
		<div class="middle">
			<div class="block infowarning">
				<div class="title">
					<img src="<%=sWebRootPath%>/AppMain/resources/images/main/icon_infowarning.png" style="width: 24px;height: 24px;"></img>
					<span>信息预警</span>
				</div>
				<div class="gipv" style="border: 1px solid #F0F4F8;"></div>
				<div class="body" id="main">
					<div class="validateerror" style="float:left"><div><%=error[0]%></div><div>校验错误数</div></div>
					<div class="feedbackerror" style="float:right"><div><%=error[1]%></div><div>反馈错误数</div></div>
				</div>
			</div>
		</div>
		<div class="bottom">
			<div class="block notice">
				<div class="title">
					<img src="<%=sWebRootPath%>/AppMain/resources/images/main/icon_notice.png" style="width: 24px;height: 24px;"></img>
					<span>公告信息</span>
				</div>
				<div class="gipv" style="border: 1px solid #F0F4F8;"></div>
				<div class="body">
					<div class="public-message">
						<div class="space"></div>
						<c:forEach items="${fileList}" var="file" varStatus="status">
							<c:choose>
								<c:when test="${file.isEject == 1}">
	                                  <c:if test="${file.isNew == 1}">
	                                  	<a onclick="openFile('${file.docNo}')">
	                                  		<span class="boardName"><img src="<%=sWebRootPath%>/AppMain/resources/images/main/icon_board_new.png" style="vertical-align: middle;"></img>&nbsp;${file.boardName}</span>
	                                  		<span class="boardTitle">${file.boardTitle}</span>
	                                  	</a>
	                                  </c:if>
	                                  <c:if test="${file.isNew == 2}">
	                                 	 <a onclick="openFile('${file.docNo}')">
	                                 	 	<span class="boardName">${file.boardName}</span>
	                                  		<span class="boardTitle">${file.boardTitle}</span>
	                                 	 </a>
	                                  </c:if>                                    
	                              </c:when>
	                              <c:otherwise>
	                                  <c:if test="${file.isNew == 1}">
	                                 	 <a>
		                                 	<span class="boardName"><img src="<%=sWebRootPath%>/AppMain/resources/images/main/icon_board_new.png" style="vertical-align: middle;"></img>&nbsp;${file.boardName}</span>
	                                  		<span class="boardTitle">${file.boardTitle}</span>
	                                 	 </a>
	                                  </c:if>
	                                  <c:if test="${file.isNew == 2}">
	                                  	<a>
	                                  		<span class="boardName">${file.boardName}</span>
	                                  		<span class="boardTitle">${file.boardTitle}</span>
	                                  	</a>
	                                  </c:if>
	                              </c:otherwise>
							</c:choose>
						</c:forEach>
						<div class="space"></div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<script type="text/javascript">
	var taskStatusData;//全局变量，存储点击日期之后加载的任务运行状况
	var runList;//有跑批记录的日期
	var isIE = <%=isIE%>;//判断是否为IE浏览器
	if(!isIE){
		$(".bg_taskStatus").height("100%");//其他浏览器会兼容object-fit属性，css中配置的cover-保证原有尺寸比例，保证铺满效果
	}
	//查看失败任务记录
	function showFailedRecord(date){
		AsDialog.PopView("/PIDR/Welcome/PidrFailedRecordList.jsp","InputDate="+date, {width:"1300px",height:"500px"});
	}
	//查看所有失败任务记录
	function showMoreFailedRecord(){
		AsDialog.PopView("/PIDR/Welcome/PidrFailedRecordList.jsp","", {width:"1300px",height:"500px"});
	}
	
	//查看附件
	function openFile(sDocNo){
	    AsDialog.PopView("/AppConfig/Document/AttachmentFrame.view", "DocNo="+sDocNo+"&RightType=ReadOnly", {width:"650px",height:"350px",title:"公告附件"});
	}
	// 日历
	(function(now){
		var calendar = $('.calendar'), calendarDate;
		var selects = calendar.find('select');
		var tbody = calendar.find('tbody');
		calendar.find('.calendar-left').on('click', function(){
			changeCalendar(new Date(calendarDate.getFullYear(), calendarDate.getMonth() - 1, 1));
		});
		calendar.find('.calendar-right').on('click', function(){
			changeCalendar(new Date(calendarDate.getFullYear(), calendarDate.getMonth() + 1, 1));
		});
		selects.eq(0).on('change', function(){
			changeCalendar(new Date(+this.value, calendarDate.getMonth(), 1));
		});
		selects.eq(1).on('change', function(){
			changeCalendar(new Date(calendarDate.getFullYear(), +this.value, 1));
		});
		
		function changeCalendar(date) {
			calendarDate = date;
			selects.get(0).value = ''+date.getFullYear();
			selects.get(1).value = ''+date.getMonth();
			// alert(selects.get(0).value);
			//tbody.html(getCalendarHtml(date));
			//加载日历
			getCalendarHtml(date);
			//根据日历月份加载失败任务记录
			var month = (date.getMonth()+1).toString();
			month = (month.length == 1) ? ("0" + month) : month;
			getFailedRecord(date.getFullYear() + '-' +month);
			//默认加载当天任务运行状态
			var curMonth = (now.getMonth()+1).toString();
			var curDate = now.getDate().toString();
			curMonth = (curMonth.length == 1) ? ("0" + curMonth) : curMonth;
			curDate = (curDate.length == 1) ? ("0" + curDate) : curDate;
			showTheDayTask(date.getFullYear() + '-' +curMonth + '-' + curDate,1,$('.today'));
		}
		//加载日历
		function getCalendarHtml(date) {
			var dateMonths = date.getFullYear() * 12 + date.getMonth();
			var calendar = new Date(date.getFullYear(), date.getMonth(), date.getDate() - date.getDay());
			//查询显示的日期的跑批状况
			var fromDate = calendar.getFullYear() + '-' + (calendar.getMonth() + 1) + '-' + calendar.getDate();//日期格式为yyyy-M-d
			$.ajax({  
	            type:"post",//请求方式  
	            url:"<%=request.getContextPath()%>/PidrMonthTaskRunServlet", //发送请求地址  
	            dataType:"json",  
	            //发送的数据
	            data:"Date=" + fromDate,
	            //请求成功后的回调函数有两个参数  
	            success:function(data){ 
	            	//加载日历
	            	runList = data;
	            	var aHtml = new Array();
	    			while(true) {
	    				var calendarMonths; 
	    				aHtml.push('<tr>');
	    				for (var i = 0; i < 7; i++) {
	    					calendarMonths = calendar.getFullYear() * 12 + calendar.getMonth();
	    					var year = calendar.getFullYear();
	    					var month = calendar.getMonth();
	    					var date = calendar.getDate();
	    					var title = '';
	    					
	    					var iDate = calendar.getDate();
	    					aHtml.push('<td class="calendar-date ');
	    					if (calendarMonths < dateMonths) {
	    						aHtml.push(' prev-month');
	    					}
	    					if (calendarMonths > dateMonths) {
	    						aHtml.push(' next-month');
	    					}
	    					if (year === now.getFullYear() && month === now.getMonth() && date === now.getDate()) {
	    						aHtml.push(' today');
	    						title = '今天';
	    					}
	    					var sCalendar = year + '/' + (month + 1) + '/' + date;
	    					//转换日期格式
	    					var sMonth = (month+1).toString();
	    					var sDate = date.toString();
	    					if(sMonth.length == 1){
	    						sMonth = "0" + sMonth;
	    					}
	    					if(sDate.length == 1){
	    						sDate = "0" + sDate;
	    					}
	    					var sFullDate = year + '-' + sMonth + '-' + sDate;//失败任务记录使用
	    					if(runList.indexOf(sFullDate) > -1){//有跑批记录的日期，小蓝点标出
	    						aHtml.push('" title="', title, '"><a onclick="showTheDayTask(\''+sFullDate+'\',2,this)">', iDate, '</a><span class="point"></span></td>');
	    					}else{
	    						aHtml.push('" title="', title, '"><a onclick="showTheDayTask(\''+sFullDate+'\',2,this)">', iDate, '</a><span></span></td>');
	    					}
	    					calendar.setDate(iDate + 1);
	    				}
	    				aHtml.push('</tr>');
	    				if (calendarMonths > dateMonths) break;
	    			}
	    			tbody.html(aHtml.join(''));
	            },
	            error: function (xhr,status,error) {
	                alert("'查询整月跑批任务记录失败!'");
	            }
	        }); 
		}
		
		changeCalendar(new Date(now.getFullYear(), now.getMonth(), 1));
	})(new Date(<%=now.get(Calendar.YEAR)%>, <%=now.get(Calendar.MONDAY)%>, <%=now.get(Calendar.DATE)%>));
	
	//日历点击某一天，展示选中日期当天的任务运行以及失败任务记录
	function showTheDayTask(date,type,obj){//type:1-初始加载或切换年月，2-点击切换日期
		if(type == 2){//切换日期
			//其余日期颜色恢复未选中样式
			$(".calendar-date a").css({
				"background-color":"#fff",
				"color":"#000"
			}); 
			$(".prev-month a, .next-month a").css({
			    "color":" #aaa"
			}); 
			//当天日期保持原状
			$(".calendar .today a").css({
			    "background-color": "#3B94F6",
			    "color": "#fff",
			    "border-radius": "50%"
			});
			//选中日期样式
			$(obj).css({
				"background-color": "#D8EAFD",
				"border-radius": "50%"
			});
			getFailedRecord(date);//点击日历某天，展示当天失败任务记录
		}
		var sDate = date.split("-");
		$(".taskrun_date").html(sDate[0] + "年" + sDate[1] + "月" + sDate[2] + "日");
		//展示选中日期当天的任务运行状况
		$.ajax({  
            type:"post",//请求方式  
            url:"<%=request.getContextPath()%>/PidrTaskRunServlet", //发送请求地址  
            dataType:"json",  
            //发送的数据
            data:"Date=" + date,
            //请求成功后的回调函数有两个参数  
            success:function(data){ 
            	taskStatusData = data;
            	$(".stepName1").html('数据文件加载<br/><span style="color:'+ data[0][1] +'">'+ data[0][0] + '</span>');
            	$(".step1").css("background-Color",data[0][2]);
            	$(".stepName2").html('导入企业评级信息<br/><span style="color:'+ data[1][1] +'">'+ data[1][0] + '</span>');
            	$(".step2").css("background-Color",data[1][2]);
            	$(".stepName3").html('数据评级<br/><span style="color:'+ data[2][1] +'">'+ data[2][0] + '</span>');
            	$(".step3").css("background-Color",data[2][2]);
            	$(".stepName4").html('数据校验<br/><span style="color:'+ data[4][1] +'">'+ data[4][0] + '</span>');
            	$(".step4").css("background-Color",data[4][2]);
            	$(".stepName5").html('数据迁移<br/><span style="color:'+ data[5][1] +'">'+ data[5][0] + '</span>');
            	$(".step5").css("background-Color",data[5][2]);
            	$(".stepName6").html('生成报文<br/><span style="color:'+ data[6][1] +'">'+ data[6][0] + '</span>');
            	$(".step6").css("background-Color",data[6][2]);
            	//绑定评级信息、信贷资产切换tab的点击事件
            	$(".switch1").click(function(){
            		showRateStatus(taskStatusData);
            	});
            	$(".switch2").click(function(){
            		showCreassStatus(taskStatusData);
            	});
            	//切换日期，初始展示评级信息情况
            	showRateStatus(taskStatusData);
            },
            error: function (xhr,status,error) {
                alert("'查询跑批任务记录失败!'");
            }
        }); 
	}
	//根据日历月份加载失败任务记录
	function getFailedRecord(date){
		var bHtml = "";
		$.ajax({  
            type:"post",//请求方式  
            url:"<%=request.getContextPath()%>/PidrFailedRecordServlet", //发送请求地址  
            dataType:"json",  
            //发送的数据
            data:"Date=" + date,
            //请求成功后的回调函数有两个参数  
            success:function(data){ 
            	if(date.length==7){
        			date = date.split("-")[0] + "年" + date.split("-")[1] + "月";
        		}else{
        			date = date.split("-")[0] + "年" + date.split("-")[1] + "月" + date.split("-")[2] + "日";
        		}
            	if(data.length == 0){
            		bHtml = bHtml+"<img class='noRecord' style='padding-top: 40px; display: block;margin: 0 auto;' src='<%=sWebRootPath%>/AppMain/resources/images/main/bg_default.png'></img><span class='noRecordDescribe'>"+date+"<br/>暂无失败记录</span>";
            	}else{
            		for(var i = 0;i<data.length;i++){
            			bHtml = bHtml+('<a onclick="showFailedRecord(\'' + data[i].inputDate + '\')">' + (i+1) + '.' + data[i].inputDate + ': <em>' + data[i].count + '条</em></a>');
                	}
            	}
            	$('.failedRecordBody').html(bHtml);
            },
            error: function (xhr,status,error) {
                alert("'查询跑批失败任务记录失败!'");
            }
        }); 
	}
	//任务提示
	//鼠标悬停
	function changeStyle1(obj,switchName){
		var src = $(obj).attr("src");
		if(src.endsWith("bg_map_switch_nor.png")){//非选中
			$(switchName).css({
				"color":"#3B94F6",
				"font-weight":"bold"
			});
		}
	}
	//鼠标离开
	function changeStyle2(obj,switchName){
		var src = $(obj).attr("src");
		if(src.endsWith("bg_map_switch_nor.png")){//非选中
			$(switchName).css({
				"color":"#717C8E",
				"font-weight":"normal"
			});
		}
	}
	//展示评级信息任务运行情况
	function showRateStatus(data){
   		if($(".switch1").attr("src") != "<%=sWebRootPath%>/AppMain/resources/images/main/bg_map_switch_sel.png"){
   			$(".switch1").attr("src","<%=sWebRootPath%>/AppMain/resources/images/main/bg_map_switch_sel.png");
   			$(".switch2").attr("src","<%=sWebRootPath%>/AppMain/resources/images/main/bg_map_switch_nor.png");
   			if(<%=isIE%>){
   				$(".taskrun").html('<img class="bg_taskStatus" src="<%=sWebRootPath%>/AppMain/resources/images/main/rate_taskStatus.png"/>');
   			}else{
   				$(".taskrun").html('<video class="bg_taskStatus" preload="auto" loop autoplay src="<%=sWebRootPath%>/AppMain/resources/images/main/rate_taskStatus_3.mp4" tabindex="-1" muted="muted"></video>');
   			}
   			$(".switchName1").css({
   				"color":"#FFFFFF",
   				"font-weight":"bold"
   			});
   			$(".switchName2").css({
   				"color":"#717C8E",
   				"font-weight":"normal"
   			});
   			$(".stepName2").html("导入企业评级信息<br><span style='color:"+ data[1][1] +"'>" + data[1][0] + "</span>");
   			$(".step2").css("background-Color",data[1][2]);
   			$(".stepName3").html("数据评级<br><span style='color:"+ data[2][1] +"'>" + data[2][0] + "</span>");
   			$(".step3").css("background-Color",data[2][2]);
   			$(".step4").show();
   			$(".stepImg4").show();
   			$(".stepName4").show();
   			$(".step5").html("步骤5");
   			$(".step6").html("步骤6");
   		}
   	}
   	//展示信贷资产信息任务运行情况
   	function showCreassStatus(data){
   		if($(".switch2").attr("src") != "<%=sWebRootPath%>/AppMain/resources/images/main/bg_map_switch_sel.png"){
   			$(".switch2").attr("src","<%=sWebRootPath%>/AppMain/resources/images/main/bg_map_switch_sel.png");
   			$(".switch1").attr("src","<%=sWebRootPath%>/AppMain/resources/images/main/bg_map_switch_nor.png");
   			if(<%=isIE%>){
   				$(".taskrun").html('<img class="bg_taskStatus" src="<%=sWebRootPath%>/AppMain/resources/images/main/creass_taskStatus.png"/>');
   			}else{
   				$(".taskrun").html('<video class="bg_taskStatus" preload="auto" loop autoplay src="<%=sWebRootPath%>/AppMain/resources/images/main/creass_taskStatus_3.mp4" tabindex="-1" muted="muted"></video>');
   			}
   			$(".switchName2").css({
   				"color":"#FFFFFF",
   				"font-weight":"bold"
   			});
   			$(".switchName1").css({
   				"color":"#717C8E",
   				"font-weight":"normal"
   			});
   			$(".stepName2").html("导入信贷资产信息<br><span style='color:"+ data[3][1] +"'>" + data[3][0] + "</span>");
   			$(".step2").css("background-Color",data[3][2]);
   			$(".stepName3").html("数据校验<br><span style='color:"+ data[4][1] +"'>" + data[4][0] + "</span>");
   			$(".step3").css("background-Color",data[4][2]);
   			$(".step4").hide();
   			$(".stepImg4").hide();
   			$(".stepName4").hide();
   			$(".step5").html("步骤4");
   			$(".step6").html("步骤5");
   		}
   	}
    //统计报送的信息记录数量
    statisReportCount();
    function statisReportCount(){
    	// 基于准备好的dom，初始化echarts图表
        var myChart3 = echarts.init(document.getElementById('icr_data_main')); 
        var option = {
            title : {
                text: '',
                subtext: ''
            },
            grid:{ // 控制图的大小，调整下面这些值就可以，
                x:30,
                y:60,
                x2:20,
                y2:60    // y2可以控制 X轴跟Zoom控件之间的间隔，避免以为倾斜后造成 label重叠到zoom上
            },
            //默认色板
            /* color: [
                '#26C0C0'
            ], */
            color:[
                '#3B94F6'
                ],
            //资源库
            tooltip: {
                show: true
            },
            xAxis : [
                {
                    type : 'category',
                    data : ["评级\n信息数","评级标识变更\n信息数","评级按段更正\n信息数","评级整笔删除\n信息数","信贷资产\n信息数","信贷资产标识变更\n记录数","信贷资产整笔删除\n记录数"],
                    axisLabel: {
	                    //这个是倾斜角度，也是考虑到文字过多的时候，方式覆盖采用倾斜
	                    rotate: 0,
	                    //这里是考虑到x轴文件过多的时候设置的，如果文字太多，默认是间隔显示，设置为0，标示全部显示，当然，如果x轴都不显示，那也就没有意义了
	                    interval :0,
	                    textStyle:{
                            fontSize:14,
                            color:'#999999'
                        }
                    },
                    axisLine:{
                    	//x轴样式
                    	lineStyle:{
                        	color:'#E6E8EA'
                        }
                    },
                    splitLine:{
                    	lineStyle:{
                        	color:'#F0F4F8'
                        }
                    }
                }
            ],
            yAxis : [
                {
                    type : 'value',
                    axisLabel: {
	                    textStyle:{
		                        color:'#999999'
                    	}
                    },
                    axisLine:{
                    	//y轴样式
	                    lineStyle:{
	                    	color:'#E6E8EA'
	                    }
                    },
                    splitLine:{
                    	lineStyle:{
                        	color:'#F0F4F8'
                        }
                    }
                }
            ],
            series : [
            	{
                    stack:"报送数据基本情况统计",
                    name:"评级信息数",
                    type:"bar",
                    barWidth:20,
                    data:[<%=reportCount[0]%>]
                },
                 {
                    stack:"报送数据基本情况统计",
                    name:"评级标识变更信息数",
                    type:"bar",
                    barWidth:20,
                    data:[0, <%=reportCount[1]%>]
                 },
                 {
                     stack:"报送数据基本情况统计",
                     name:"评级按段更正信息数",
                     type:"bar",
                     barWidth:20,
                     data:[0,0,<%=reportCount[2]%>]
                  },
                  {
                      stack:"报送数据基本情况统计",
                      name:"评级整笔删除信息数",
                      type:"bar",
                      barWidth:20,
                      data:[0,0,0,<%=reportCount[3]%>]
                   },
                   {
                       stack:"报送数据基本情况统计",
                       name:"信贷资产信息数",
                       type:"bar",
                       barWidth:20,
                       data:[0,0,0,0,<%=reportCount[4]%>]
                    },
                    {
                        stack:"报送数据基本情况统计",
                        name:"信贷资产标识变更信息数",
                        type:"bar",
                        barWidth:20,
                        data:[0,0,0,0,0,<%=reportCount[5]%>]
                     },
                     {
                         stack:"报送数据基本情况统计",
                         name:"信贷资产整笔删除信息数",
                         type:"bar",
                         barWidth:20,
                         data:[0,0,0,0,0,0,<%=reportCount[6]%>]
                      },
             ]
        };
        // 为echarts对象加载数据 
        myChart3.setOption(option); 
    }

    $(function(){
    	resizeFun();//初始化时，调用实现屏幕自适应
		// return; // 若不要滚动，请打开这段注释
		//公告滚动
		var time = null;
		var container = $(".public-message").mouseover(function(){
			clearTimeout(time);
		}).mouseleave(function(){
			notice();
		});
		$(".space", container).height("100%");
		
		notice();
		
		function notice(){
			//确保ratio大于等于1防止浏览器缩小导致无法滚动
			var ratio = parseFloat((1/window.devicePixelRatio).toFixed(2))+1.00;
			var top = container.scrollTop();
			container.scrollTop(top+1*ratio);
			if(container.scrollTop() == top)
				container.scrollTop(0);
			time = setTimeout(notice, 30);
		}

		//我的信息欢迎字段横向滚动
		var speed=45;
		welcome2.innerHTML=welcome1.innerHTML;  //克隆welcome1为welcome2
		function Marquee(){
			//确保ratio1大于等于1防止浏览器缩小导致无法滚动
			var ratio1 = parseFloat((1/window.devicePixelRatio).toFixed(2))+1.00;
			if(welcome2.offsetLeft-welcome.scrollLeft<=0)  //当滚动至welcome1与welcome2交界时
				welcome.scrollLeft-=welcome1.offsetWidth;  //welcome跳到最左端
			else{
				welcome.scrollLeft = welcome.scrollLeft + 1*ratio1;
			}
		}
		var MyMar=setInterval(Marquee,speed)  //设置定时器
		
		welcome.onmouseover=function() {//鼠标移上时清除定时器达到滚动停止的目的
		   clearInterval(MyMar);
		}
		welcome.onmouseout=function() { //鼠标移开时重设定时器
		   MyMar=setInterval(Marquee,speed);
		}
	});
    //我的信息模块，修改密码弹出页面
    function modifyPass(){
		parent.AsDialog.PopView("/AppMain/ModifyPassword.jsp","PasswordState=0", {width:"450px",height:"400px"});
	}
    //我的信息模块，修改信息弹出页面
    function modifyUserInfo (){
    	parent.AsDialog.PopView("/AppMain/ModifyUserInfo.jsp","", {width:"450px",height:"400px"},function(){
    		$(".personalInfo").load(location.href + " .personalInfo");
    	});
    }
    //屏幕自适应
    function resizeFun(){
    	var w = $(window).width();
    	var h = $(window).height();
    	var pw = w/1920;
    	var ph = h/915;
    	var left = (w-$("body").outerWidth())/2.0;
    	var top = (h-$("body").outerHeight())/2.0;
    	$("body").css({
    		"transform":"scale("+pw+","+ph+")",
    		"transform-origin" : "0 0"
    	});
    }
    //监听屏幕缩放，自适应
    $(window).resize(function(){
    	resizeFun();
    });
	</script>
</body>
</html>
<%@ include file="/Frame/resources/include/include_end_ajax.jspf" %>