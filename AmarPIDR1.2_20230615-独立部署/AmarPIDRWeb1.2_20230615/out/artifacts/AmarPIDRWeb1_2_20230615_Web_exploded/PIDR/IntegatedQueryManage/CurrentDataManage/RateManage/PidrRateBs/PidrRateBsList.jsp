<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="/Frame/resources/include/include_begin_list.jspf"%>
<%@ page import="com.amarsoft.app.pidr.common.PIDRConstants"%>
<%--  
	Author: nxxiong
	CreationDate: 2023-02-22
	Description: 综合查询-当期数据-企业评级信息记录-基础段信息表列表页面
--%>
<%	
	ASObjectModel doTemp = new ASObjectModel("PidrRateBsList");

	// 获取参数，设置条件筛选数据
	String customerId = CurPage.getParameter("CustomerId");// 全信息界面传递回来的客户编号
	if(customerId == null) customerId = "";// 从菜单跳转过来置为""
	String flag = CurPage.getParameter("Flag");// 页面复用标志，用来控制list页面jboWhere条件和按钮功能
	if(flag == null) flag = "";
	
	if(PIDRConstants.ALLMSG_FLAG.equals(flag)||PIDRConstants.VALIDATEERROR_FLAG.equals(flag)) {
		doTemp.appendJboWhere("CustomerId = :CustomerId");// 全信息tab页面打开控制显示
	}
	doTemp.appendJboWhere("ManagerOrgId like '"+CurUser.getOrgID()+"%'");// 添加管户机构控制
	
	ASObjectWindow dwTemp = new ASObjectWindow(CurPage,doTemp,request);
	dwTemp.Style="1";      	     //--设置为Grid风格--
	dwTemp.ReadOnly = "1";	 //只读模式
	dwTemp.setPageSize(20);
	dwTemp.setParameter("CustomerId", customerId);
	dwTemp.genHTMLObjectWindow("");
	String sButtons[][] = {
		//0、是否展示 1、	权限控制  2、 展示类型 3、按钮显示名称 4、按钮解释文字 5、按钮触发事件代码	6、	7、	8、	9、图标，CSS层叠样式 10、风格
		{PIDRConstants.ALLMSG_FLAG.equals(flag)?"false":"true","","Button","新增","新增","add()","","","","btn_icon_add",""},
		{PIDRConstants.ALLMSG_FLAG.equals(flag)?"false":"true","","Button","删除","删除","del()","","","","btn_icon_delete",""},
		{"true","","Button","详情","详情","view()","","","","btn_icon_detail",""},
		{(PIDRConstants.ALLMSG_FLAG.equals(flag)||PIDRConstants.VALIDATEERROR_FLAG.equals(flag))?"false":"true","","Button","全信息","全信息","allMsg()","","","","btn_icon_detail",""},
		{PIDRConstants.VALIDATEERROR_FLAG.equals(flag)?"false":"true","","Button","查看历史记录","查看历史记录","seeHis()","","","","btn_icon_check",""},	
		{PIDRConstants.VALIDATEERROR_FLAG.equals(flag)?"false":"true","","Button","整笔删除","整笔删除","allDltInfo()","","","","btn_icon_detail",""},
		{PIDRConstants.VALIDATEERROR_FLAG.equals(flag)?"false":"true","","Button","按段更正","按段更正","mdfcInfo()","","","","btn_icon_detail",""},
		{PIDRConstants.VALIDATEERROR_FLAG.equals(flag)?"false":"true","","Button","标识变更","标识变更","idChange()","","","","btn_icon_detail",""},
		{"true","","Button","发起预评级","发起预评级","runEvalucation()","","","","btn_icon_detail",""},
		{"true","","Button","查看预评级","查看预评级","viewEvalucation()","","","","btn_icon_detail",""},
	};
	
%>
<%@include file="/Frame/resources/include/ui/include_list.jspf"%>
<script type="text/javascript" src="<%=sWebRootPath%>/Frame/resources/js/layer.js"></script>
<script type="text/javascript">
	/*~[Describe=新增,InputParam=无,OutputParam=无]~*/
	function add(){
		var url = "/PIDR/IntegatedQueryManage/CurrentDataManage/RateManage/PidrRateBs/PidrRateBsInfo.jsp";
		AsDialog.PopView(url,'OperationType=<%=PIDRConstants.OPERATIONTYPE_ADD%>','dialogWidth:1000px;dialogHeight:600px',function(){
			reloadSelf();
		});
	}
	/*~[Describe=删除,InputParam=无,OutputParam=无]~*/
	function del(){
		var customerId = getItemValue(0,getRow(0),'CustomerId');// 客户编号
		var recordFlag =getItemValue(0,getRow(0),'RecordFlag');// 记录标志
		layer.confirm("删除",{
			title:false,
			btn:['仅删除本记录','关联删除所有段记录']
		},function(index){
			//仅删除本段
			if(recordFlag != '<%=PIDRConstants.RECORDFLAG_A%>' ){
				layer.alert("该记录已经上报过，不可删除！");
				return;
			}else{
				if(!confirm("确定要删除本记录？")) return;
				var retValue = RunJavaMethodTrans("com.amarsoft.app.pidr.alldlt.PidrCascadeDelete", "deleteRateById", "customerId=" + customerId +",tableName="+'<%=PIDRConstants.TABLE_PIDR_RATE_BS%>');
				alert(retValue);
				layer.close(index);
				reloadSelf();	
			}
		},function(index){
			//级联删除所有段
			if(recordFlag != '<%=PIDRConstants.RECORDFLAG_A%>' ){
				layer.alert("该记录已经上报过，不可删除！");
				return;
			}else{
				if(!confirm("确定要关联删除所有段记录？")) return;
				//调后台方法，关联删除
				var retValue = RunJavaMethodTrans("com.amarsoft.app.pidr.alldlt.PidrCascadeDelete", "deleteRateAll", "customerId=" + customerId);
				alert(retValue);
				layer.close(index);
				reloadSelf();	
			}
		});
	}
	/*~[Describe=详情,InputParam=无,OutputParam=无]~*/
	function view(){
		var url = "/PIDR/IntegatedQueryManage/CurrentDataManage/RateManage/PidrRateBs/PidrRateBsInfo.jsp";
		var customerId = getItemValue(0,getRow(0),'CustomerId');// 客户编号
		var params = 'CustomerId=' + customerId +'&OperationType=<%=PIDRConstants.OPERATIONTYPE_INFO%>';
		if(typeof(customerId)=="undefined" || customerId.length==0 ){
			alert("请选择一条记录");
			return ;
		}
		AsDialog.PopView(url,params,'dialogWidth:1000px;dialogHeight:600px',function(){
			reloadSelf();
		});
	}
	
	/*~[Describe=全信息,InputParam=无,OutputParam=无]~*/
	function allMsg(){
		var url = "/PIDR/IntegatedQueryManage/CurrentDataManage/RateManage/PidrRateBs/PidrRateBsAllMsg.jsp";
		var customerId = getItemValue(0,getRow(0),'CustomerId');// 客户编号
		var params = 'CustomerId=' + customerId ;
		if(typeof(customerId)=="undefined" || customerId.length==0 ){
				alert("请选择一条记录");
				return ;
		}
		AsDialog.PopView(url,params,'_self','');
	}
	
	/*~[Describe=查看历史记录,InputParam=无,OutputParam=无]~*/
	function seeHis(){
		var url = "/PIDR/IntegatedQueryManage/HistoryDataManage/RateManage/HPidrRateBs/HPidrRateBsList.jsp";
		var customerId = getItemValue(0,getRow(0),'CustomerId');// 客户编号
		var params = 'CustomerId=' + customerId + '&Flag=<%=PIDRConstants.CHECKHIS_FLAG%>';
		if(typeof(customerId)=="undefined" || customerId.length==0 ){
			alert("请选择一条记录");
			return ;
		}
		AsDialog.PopView(url,params,'dialogWidth:1000px;dialogHeight:600px');
	}
	
	/*~[Describe=整笔删除,InputParam=无,OutputParam=无]~*/
	function allDltInfo(){
		var entCertType = getItemValue(0,getRow(0),'EntCertType');// 客户身份标识类型
		var entCertNum = getItemValue(0,getRow(0),'EntCertNum');// 身份标识号码
		var finStaYear = getItemValue(0,getRow(0),'FinStaYear');// 报表年份
		var inputOrgId = getItemValue(0,getRow(0),'OperOrgID');// 录入机构编号
		var inputUserId = getItemValue(0,getRow(0),'OperUserID');// 录入用户编号
		var managerOrgId = getItemValue(0,getRow(0),'ManagerOrgId');// 管护机构编号
		var inputTime = getItemValue(0,getRow(0),'OperTime');// 录入机构编号
		if(typeof(entCertNum)=="undefined" || entCertNum.length==0 ){
				alert("请选择一条记录");
				return ;
		}
		if(confirm('确定要整笔删除吗?')){
			 var result =  RunJavaMethodTrans("com.amarsoft.app.pidr.alldlt.PidrAllDelHandler", "addRateAllDel", "entCertType="+entCertType 
	                 + ",entCertNum=" + entCertNum +",inputOrgId="+inputOrgId
	                 + ",inputTime=" + inputTime +",inputUserId="+inputUserId);
			 if("SUCCESS" == result){
				 alert("添加整笔删除记录成功，可在报送管理-数据删除管理模块中查看!");
			 }else{
				 alert(result);
			 }
		}
	}
	
	/*~[Describe=按段更正,InputParam=无,OutputParam=无]~*/
	function mdfcInfo(){
		var sessionId = getItemValue(0, getRow(0), "SessionId");
		var customerId = getItemValue(0, getRow(0), "CustomerId");
		var managerOrgId = getItemValue(0, getRow(0), "ManagerOrgId");
		if(typeof(sessionId)=="undefined"||sessionId.length==0) {
			alert("请选择一条记录！");
			return;
		}
		if(sessionId=="<%=PIDRConstants.SESSIONID_14%>") {
			alert("该记录为需要上报修改的新信息段");
			return;
		}
		if(!confirm('确定要按段更正吗?')){
			return;
		}
		var retValue=RunJavaMethodTrans("com.amarsoft.app.pidr.mdfc.ModifyRateInfo","modifyRateInfo",
				"CustomerId=" + customerId + ",MdfcSgmtCode=A, ManagerOrgId=" + managerOrgId + ",CurUserId=<%=CurUser.getUserID()%>,CurOrgId=<%=CurOrg.getOrgID()%>");
		if(retValue!="操作成功") {
			alert(retValue);
			return;
		}
		var url = "/PIDR/ReportManage/ModifyDataManage/MdfcInfoManage/HpidrRateMdfcFrame.jsp";
		var params = 'SessionId=<%=PIDRConstants.SESSIONID_14%>&CustomerId=' + customerId + '&MdfcSgmtCode=A' ;
		AsDialog.PopView(url,params,'dialogWidth:1000px;dialogHeight:600px',function(){
			reloadSelf();	
		});
	}
	
	/*~[Describe=标识变更,InputParam=无,OutputParam=无]~*/
	function idChange(){
		var url = "/PIDR/ReportManage/ModifyDataManage/IDChangeManage/HPidrRateIdChangeInfo.jsp";
		var entCertType = getItemValue(0,getRow(0),'EntCertType');// 企业身份标识类型
		var entCertNum = getItemValue(0,getRow(0),'EntCertNum');// 企业身份标识号码
		var finStaYear = getItemValue(0,getRow(0),'FinStaYear');// 报表年份
		var mngmtOrgCode = getItemValue(0, getRow(0), "MngmtOrgCode"); 
		var managerOrgId = getItemValue(0, getRow(0), "ManagerOrgId"); 
		var retValue =  RunJavaMethodTrans("com.amarsoft.app.pidr.idchange.PidrIdChangeHandler", "addRateIdChange", "oldEntCertType="+entCertType
				 +",oldEntCertNum=" + entCertNum+",operationType=<%=PIDRConstants.IDCHANGE_OPERATE_COMP%>");
		if(retValue == "<%=PIDRConstants.IDCHANGE_SAVE_IDCHANGED%>"){
			alert("该客户已存在标识变更记录，不可再次操作");
			return;
	   	} 
		if(!confirm('确定要标识变更吗?')){
			return;
		}
		var params = 'OldEntCertType=' + entCertType + '&OldEntCertNum=' + entCertNum + '&FinStaYear=' + finStaYear 
		 + '&MngmtOrgCode=' + mngmtOrgCode  + '&ManagerOrgId=' + managerOrgId + '&OperationType=<%=PIDRConstants.IDCHANGE_OPERATE_COMP%>';
		AsDialog.PopView(url,params,'dialogWidth:1000px;dialogHeight:600px',function(){
			reloadSelf();
		});
	}
	
	function runEvalucation(){
		var objectType="PIDRCreditGrade";
        var modelNo="PIDRCreditGrade";
		var customerId=getItemValue(0,getRow(0),'CustomerId');
		var finStaYear=getItemValue(0,getRow(0),'FinStaYear');
        var entName = getItemValue(0,getRow(0),'EntName');// 企业名称
        var entCertType = getItemValue(0,getRow(0),'EntCertType');// 企业身份标识类型
        var entCertNum = getItemValue(0,getRow(0),'EntCertNum');// 企业身份标识号码
		var userId=getItemValue(0,getRow(0),'OperUserID');
		var orgId=getItemValue(0,getRow(0),'OperOrgID');
		var params="objectType="+objectType+
		                       ",CustomerId="+customerId+
		                        ",modelNo="+modelNo+
								",FinStaYear="+finStaYear+
								",EntName="+entName+
								",EntCertType="+entCertType+
								",EntCertNum="+entCertNum+",userId="+userId+",orgId="+orgId;
        var retValue=RunJavaMethodTrans("com.amarsoft.app.awe.pidr.dwhandler.PidrRunEvaluate","runEvaluate",params+",Flag=1");
        if(retValue=="新增成功") {
            alert(retValue);
        	evaluateData(customerId+"@",objectType)
        }else if(retValue=="该数据已有评级数据，是否覆盖更新原有评级"){
        	   if(confirm(retValue)){
                   var retValue2=RunJavaMethodTrans("com.amarsoft.app.awe.pidr.dwhandler.PidrRunEvaluate","runEvaluate",params+",Flag=2");
                   if(retValue2=="更新成功"){
                       evaluateData(customerId+"@",objectType)
                       alert(retValue2);
                   }else{
                	   alert(retValue2); 
                   }
               }
               return;
        }else{
        	alert(retValue); 
        }
	}
	   //查看评级信息
	   function viewEvalucation(){
		   var customerId=getItemValue(0,getRow(0),'CustomerId');
		   var finStaYear=getItemValue(0,getRow(0),'FinStaYear');
	        //获取评级记录表内的ObjectType,ModelNo
		   var retValue=RunJavaMethodTrans("com.amarsoft.app.awe.pidr.dwhandler.PidrRunEvaluate","getViewInfo","FinStaYear="+finStaYear+ ",CustomerId="+customerId);
		   if(retValue!="当前记录不存在评级信息，请先发起评级！"){
		        var customerId = getItemValue(0,getRow(),"CustomerId");
	            var entName = getItemValue(0,getRow(),"EntName");
	            var finStaYear = getItemValue(0,getRow(),"FinStaYear");
	            if (typeof(customerId)=="undefined" || customerId.length==0 || typeof(finStaYear)=="undefined" || finStaYear.length==0){
	                alert("请选择一条记录!");
	                return;
	            }
	            var sParam = "Action=display&Editable=true&CustomerID="+customerId+"&EntName="+entName+retValue;
	            AsDialog.PopView("/Pidr/FinancialReportFlow/EvaluateDetail.view",sParam,{title:entName+" ("+finStaYear+")的预评级"},function(){
	                reloadSelf();
	            });
		   }else{
			   alert(retValue);
		   }
	
	    }
	   /** 为了新增完毕后进行初次评级及后续更新评级的 */
	   function evaluateData(customerID,objectType) {
	        var formData = "";
	        //发起服务调用            
	        AsControl.CallService('/Pidr/FinancialReportFlow/EvaluateCalc.serv', 
	                {
	                  "evaluateObjectType":objectType,//模型
	                  "evaluateCustomerId":customerID, //客户号
	                  "evaluatedatas":formData, //行业分类
	                },
	                function(sm) {
	                	viewEvalucation();
	                });
	    }
</script>
<%@ include file="/Frame/resources/include/include_end.jspf"%>