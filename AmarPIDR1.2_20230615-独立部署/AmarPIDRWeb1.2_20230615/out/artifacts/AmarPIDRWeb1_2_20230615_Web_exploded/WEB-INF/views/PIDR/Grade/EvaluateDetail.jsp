<%@page pageEncoding="UTF-8"%>
<%@include file="/Frame/mvc/resources/include/include_begin.jspf"%>
<html>
<head>
<title></title>
<style>
.nullPrompt{
    background:#F0E68C;
}
.astop {
    width: 40px;
    height: 40px;
    background-size: 100% 100%;
    background-image: url("<%=sWebRootPath%>/Frame/page/resources/images/common/top.jpg");
}
</style>
<script type="text/javascript" charset="UTF-8" src="<%=sWebRootPath%>/Frame/resources/js/jquery/plugins/jquery.serializejson.js"></script>
</head>
<%-- top锚点，返回顶部 --%>
<a name="top"></a>
<body leftmargin="0" topmargin="0" style="overflow: auto; height: 100%;">
<div style="display:block;z-index: 1000;position: fixed;right: 1px;bottom: 10%;width: 50px;opacity: 0.8;margin-right: 5px;">
  <a href="#top"><div class="astop"> </div></a>
</div>

<table align="center" style="width: 99%;border: 0;">
    <tr> 
        <td colspan=5>
        <c:forEach items="${root.buttonItems}" var="button">
            <a3ui:buttonPrint enable="${button.enabled}" type="${button.type}" text="${button.text}" tips="${button.tips}" 
                action="${button.action}" iconCls="${button.iconCls}" />
        </c:forEach>
        </td>

    </tr>
    <tr><td colspan="5"><hr></td><br>
    </tr>
    <tr><td nowrap align="center" colspan="5"  style="font-size:30px;">企业信用预评级</td></tr>
    <tr id="FinalResult" style="display:none;" > 
        <td nowrap align="center" colspan="5"><font size="4">企业名称：<b  id="TopTitle1"></b>行业分类：<b  id="TopTitle2"></b></font><font size="4">得分：<b id="evaluateScore"></b>结果：<b id="evaluateResult"></b></font></td>
    </tr>
    <tr> 
        <td colspan="5" align="center">
        <div style="z-index:1;">
        <form id="report" name="report" method="post">
            <table width="100%" align="left" class="dialog_table" border="0" cellspacing="0" cellpadding="0"></table>
        </form>
        </div>
        </td>
    </tr>
</table>
</body>
</html>
<script type="text/javascript">
    var modelNo="${modelNo}", objectType="${objectType}",entName="${entName}",ecoIndusCate="${ecoIndusCate}", customerID="${customerID}"; // 评级模型编号、对象类型、对象编号、对象名称、评估流水号
    $(function($) {
        // 调用服务获取数据
        AsControl.CallService("/Pidr/FinancialReportFlow/GetEvaluateData.serv", 
        		{
                 "evaluateObjectType":objectType,//模型
	        	  "evaluateCustomerId":customerID, //客户号
	        	   "evaluateEcoIndusCate":ecoIndusCate, //行业分类
	        	},
        		function(sm){
            $("title").html(sm.body.modelTypeName);
            $("#TopTitle1").html(entName+"&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;");
            $("#TopTitle2").html(ecoIndusCate+"&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;");
            if(sm.body.displayFinalResult == "Y"){
                $("#FinalResult").show();
                $("#evaluateScore").html(sm.body.evaluateScore+"&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;");
                $("#evaluateResult").html("&nbsp;"+sm.body.evaluateResult);
            }
            var table = $("#report>table");
            table.append("<tr><td height='21' nowrap align='center' class='title'>编号</td>"
                    +"<td height='21' nowrap align='center' class='title'>项目名称</td>"
                    +"<td height='21' nowrap align='center' class='title'>指标值</td>"
                    +"<td height='21' nowrap align='center' class='title'>评估/计算得分</td>"
                    +"<td height='21' nowrap align='center' class='title' width='"+sm.body.itemValueDisplayWidth+"'>人工调整得分</td>"
                   // +"<td height='21' nowrap align='center' class='title'>权重</td>"
                    +"<td height='21' nowrap align='center' class='title'>得分</td>"
                    +"<td height='21' nowrap align='center' class='title'>行业优秀值</td>"
                    +"<td height='21' nowrap align='center' class='title'>行业平均值</td>");
            var evaluatedatalist = sm.body.evaluatedatalist;
            var str=0;
            var endNum=0;
            var endStr="1";
            var cenStr="1";
            for(var i in evaluatedatalist){
                var data = evaluatedatalist[i];
                var isRealData=sm.body.displayItemScore;
                //分两类即可
                var row = "<tr height=\"25\"><td nowrap style=\"padding-left: 10px;\">"+data.displayNo+"</td>"
                                                                   +"<td nowrap>"+data.itemName+"</td>";
                var tfTdNorm="";//处理指标
                var tfTdData="";//评估/计算得分 ;人工调整得分
                var itemValue = data.itemValue;//人工调整得分
                if(itemValue=="null" || itemValue=="Null" ) itemValue="";
                var itemValue2=data.itemValue2;//评估计算得分
                if(itemValue2=="null" || itemValue2=="Null") itemValue2="";
              
                if(data.itemNo.length===5){
                	if(data.itemNo.substr(0,2)=='1.'){
                		tfTdNorm="<td nowrap>"+100+"</td>";
                	}else{
                		tfTdNorm="<td nowrap>"+itemValue2+"</td>";
                	}
                	tfTdData=tfTdNorm
				                   +"<td nowrap>"+data.evaluateScore2+"</td>"//评估/计算得分        应该是计算逻辑得出的，暂时没有算上权重和折扣的
				                   +"<td nowrap>"+
				                   "<input style=\"text-align: right;cursor: pointer;padding-right: 2px;height: 24px;\" type=text id=\""+data.itemNo+"\" name=\""+data.itemNo+"\" value=\""+itemValue+"\" "//人工调整
                                   +"onbeforepaste=\"clipboardData.setData('text',clipboardData.getData('text').replace(/[^\d^\.]/g,''))\" "
                                 //  +"onkeyup=\"value=value.replace(/[^\d^\.]/g,'')\" onblur=\"isMatch(value,name)\" maxlength=\"15\""
                                   +" \/>"
                                   +"</td>";
                }else {
                	tfTdData="<td nowrap>&nbsp;</td>"
				                   +"<td nowrap>&nbsp;</td>"
				                   +"<td nowrap>&nbsp;</td>";
                }
                row+=tfTdData;
                                                                 //  +"<td nowrap>"+"asd"+data.itemName+"</td>";
                if(sm.body.displayItemScore == 'Y'){
                    if(data.valueType!=null && data.valueType.length > 0){
                        row += "<td class=\"calculatedScore"+data.displayNo+"\" nowrap align=\"right\">"+data.evaluateScore+"</td>";//单项得分
                    }else{
                        row += "<td nowrap align=\"right\">&nbsp;</td>";
                    }
                } 
              var   excellentValueAndLowerValue="";
              var itemNoNum=data.itemNo;
              if(itemNoNum.length==5 && itemNoNum.substring(0,1)=="2"){
            	  var sendStr=itemNoNum.substring(itemNoNum.length-1);
            	  var ccenStr=itemNoNum.substring(2,3);
            	  if((endStr==sendStr) && (cenStr==ccenStr)) {
                      endStr=itemNoNum.substring(itemNoNum.length-1);
                      cenStr=itemNoNum.substring(2,3);
                      str=parseInt(endStr);
                  }else if(!(endStr==sendStr) && (cenStr==ccenStr)) {
                      endStr=itemNoNum.substring(itemNoNum.length-1);
                      cenStr=itemNoNum.substring(2,3);
                      str=endNum+parseInt(endStr);
                  }else if(!(endStr==sendStr) && !(cenStr==ccenStr)) {
                      endStr=itemNoNum.substring(itemNoNum.length-1);
                      cenStr=itemNoNum.substring(2,3);
                      endNum=str;
                      str=endNum+parseInt(endStr);
                  }
            	  var endString="0";
            	  if(str<10){
            		  var test="excellentValue"+endString+str.toString();
            		  var test2="lowerValue"+endString+str.toString();
            	      excellentValueAndLowerValue = "<td nowrap align=\"right\">"
                          + data[test] + "</td>"
                          + "<td nowrap align=\"right\">" + data[test2]
                          + "</td>";
            	  }else{
            		  var test="excellentValue"+str.toString();
                      var test2="lowerValue"+str.toString();
            	      excellentValueAndLowerValue = "<td nowrap align=\"right\">"
                          + data[test] + "</td>"
                          + "<td nowrap align=\"right\">" + data[test2]
                          + "</td>";
            	  }
              } else {
                  excellentValueAndLowerValue = "<td nowrap align=\"right\">&nbsp;</td>"
                      + "<td nowrap align=\"right\">&nbsp;</td>";
              }
              
			row += excellentValueAndLowerValue;
			/*     if(data.valueCodeOptions.length > 0){ 如果有代码则显示代码列表
			        row += "<td nowrap align=\"left\" ><select id='"+data.itemNo+"' name='"+data.itemNo+"' align=\"left\" onchange=\"SelectChange()\"><option value=\"0\"> </option>"+data.valueCodeOptions+"</select></td>";
			    }else if((data.valueMethod != null && data.valueMethod.trim().length > 0) || data.valueType==null || (data.valueType!=null && data.valueType.trim().length == 0)){
			        row += "<td nowrap height=\"22\" align=\"left\" id=\""+data.itemNo+"\" name=\""+data.itemNo+"\" >"+"一测"+data.itemValue+"&nbsp;</td>"
			                  +    "<td nowrap height=\"22\" align=\"left\" id=\""+data.itemNo+"\" name=\""+data.itemNo+"\" >"+"二测"+data.itemValue+"&nbsp;</td>"
			        ;
			    }else{
			        否则可以进行修改。改变信用等级评估模板的文本框在输入值时的约束，这里只能录入数字和小数点，并增加了失焦响应，用以对输入数值的判定
			        row += "<td nowrap align=\"left\" >"
			            +"<input style=\"text-align: right;cursor: pointer;padding-right: 2px;height: 24px;\" type=text id=\""+data.itemNo+"\" name=\""+data.itemNo+"\" value=\""+data.itemValue+"\" "
			            +"onbeforepaste=\"clipboardData.setData('text',clipboardData.getData('text').replace(/[^\d^\.]/g,''))\" "
			            +"onkeyup=\"value=value.replace(/[^\d^\.]/g,'')\" onblur=\"isMatch(value,name)\" maxlength=\"15\"/></td>";
			    }
			    if(sm.body.displayItemScore == 'Y'){
			        if(data.valueType!=null && data.valueType.length > 0){
			            row += "<td nowrap align=\"right\">"+data.evaluateScore+"</td>";
			        }else{
			            row += "<td nowrap align=\"right\">&nbsp;</td>";
			        }
			    } */
			row += "</tr>";
			table.append(row);
		}
	});
	
	});
    
    /** 表单数据校验 */
	function validForm() {
		var i;
		var b = true;
		for (i = 0; i <= document.forms[0].elements.length - 1; i++) {
			if (document.forms[0].elements[i].type.substr(0, 4) == "text"|| document.forms[0].elements[i].type.substr(0, 6) == "select") {
				 var vLength=document.forms[0].elements[i].value*1;
				if ((document.forms[0].elements[i].value == "" || document.forms[0].elements[i].value == "0" || vLength>100)&& document.forms[0].elements[i].disabled == false ) {
					document.forms[0].elements[i].focus();
					b = false;
					$(document.forms[0].elements[i].parentNode).addClass("nullPrompt");
					if ($(document.forms[0].elements[i]).next("span").html() == null && (document.forms[0].elements[i].value == "" || document.forms[0].elements[i].value == "0")) {
						$(document.forms[0].elements[i]).after("<span style='color:#F00'>&nbsp;&nbsp;* 项目不能为空</span>");
					} else if(vLength>100){//值不能大于100
						$(document.forms[0].elements[i]).after("<span style='color:#F00'>&nbsp;&nbsp;* 项目值不能大于100</span>");
					}else{
						$(document.forms[0].elements[i]).next("span").show();
					}
				} else {
					$(document.forms[0].elements[i].parentNode).removeClass("nullPrompt");
					$(document.forms[0].elements[i]).next("span").hide();
				}
			}
		}
		return b;
	}
	/**  测算 */
	function evaluateData() {
		var formData = JSON.stringify($("#report").serializeJSON());
	 	if (!validForm())
			return; 
		//数据汇总
		var postDatas = {
			"evaluateObjectType" : objectType,
			"evaluateCustomerId" : customerID,
			"evaluatedatas" :formData
		};
		//发起服务调用           
		AsControl.CallService('/Pidr/FinancialReportFlow/EvaluateCalc.serv', {
			      "evaluateObjectType":objectType,//模型
			      "evaluateCustomerId":customerID, //客户号
	              "evaluatedatas":formData, //行业分类
	            },
				function(sm) {
					alert(sm.sysHead.responseMessage);
					reloadSelf();
				});
	}
	/** 更新数据*/
	function updateData() {
		var formData = JSON.stringify($("#report").serializeJSON());
	      if (!validForm())
	            return; 
		//发起服务调用
		AsControl.CallService('/Pidr/FinancialReportFlow/EvaluateSave.serv',
				{
		            "evaluateObjectType" : objectType,
		            "evaluateCustomerID" : customerID,
		            "evaluatedatas" : formData
	            },
				function(sm) {
					if (sm.sysHead.responseCode == "0") {
						alert(sm.sysHead.responseMessage);
					}
				});
		 reloadSelf();
	}

	/*~[Describe=删除记录;]~*/
	function deleteData() {
		if (confirm("将要删除该期评估信息，继续吗？")) {
			var sParameter = {
				"evaluateObjectType" : objectType,
				"evaluateCustomerID" : customerID,
			};
			AsControl.CallService('/Pidr/FinancialReportFlow/EvaluateDelete.serv',
					sParameter, function(sm) {
						if (sm.sysHead.responseCode == "0") {
							alert(sm.sysHead.responseMessage);
							AsDialog.ClosePage();
						} else {
							alert(sm.sysHead.responseMessage);
						}
					});
		}
	}

	//对校验后的文本框做相应的处理
	function isMatch(sValue, sName) {
		var sResult = validateNum(sValue);
		if (sResult == "false") {
			alert(getMessageText("ALS70959"));//输入的值有误，请规范输入！
			document.forms[0].elements[sName].focus();//聚焦
			document.forms[0].elements[sName].value = "";//清空值        
		} else if (sResult == "true") {
		} else {
			sValue = sValue.substring(sResult);//去除输入值中无效的0
			document.forms[0].elements[sName].value = sValue;
		}
	}

	
</script>
<%@include file="/Frame/mvc/resources/include/include_end.jspf"%>

<style type="text/css">
        .calculatedScore{
            font-size:15px;
            font-weight:bolder;
        }
</style>



