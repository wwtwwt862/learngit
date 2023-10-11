<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="/Frame/resources/include/include_begin_list.jspf"%>
<%@ page import="com.amarsoft.app.pidr.common.PIDRConstants"%>
<%--  
	Author: swpeng
	CreationDate: 2023-04-20
	Description: 综合查询-接口表数据-基础段信息表列表页面
--%>
<%	
	ASObjectModel doTemp = new ASObjectModel("PidrIntEntInfoList");


	
	doTemp.appendJboWhere("ManagerOrgId like '"+CurUser.getOrgID()+"%'");// 添加管户机构控制
	
	ASObjectWindow dwTemp = new ASObjectWindow(CurPage,doTemp,request);
	dwTemp.Style="1";      	     //--设置为Grid风格--
	dwTemp.ReadOnly = "1";	 //只读模式
	dwTemp.setPageSize(20);
	dwTemp.MultiSelect=true;
	dwTemp.genHTMLObjectWindow("");
	String sButtons[][] = {
		//0、是否展示 1、	权限控制  2、 展示类型 3、按钮显示名称 4、按钮解释文字 5、按钮触发事件代码	6、	7、	8、	9、图标，CSS层叠样式 10、风格
		{"true","","Button","导入标准接口数据","导入标准接口数据","impExcel()","","","","btn_icon_add",""},
		{"true","","Button","详情","详情","view()","","","","btn_icon_detail",""},
		{"true","","Button","删除","删除","if(confirm('确定删除吗？')) as_delete(0)","","","","btn_icon_delete",""},	
		{"true","","Button","加入白名单","插入白名单数据","insertWhiteList()","","","","btn_icon_add",""},		
	};
	
%>
<%@include file="/Frame/resources/include/ui/include_list.jspf"%>
<script type="text/javascript" src="<%=sWebRootPath%>/Frame/resources/js/layer.js"></script>
<script type="text/javascript">
	/*~[Describe=详情,InputParam=无,OutputParam=无]~*/
	function view(){
		var url = "/PIDR/IntegatedQueryManage/IntDataManage/PidrIntEnt/PidrIntBsInfo.jsp";
		var customerId = getItemValue(0,getRow(0),'CustomerId');// 客户编号
		var params = 'CustomerId=' + customerId +'&OperationType=<%=PIDRConstants.OPERATIONTYPE_INFO%>';
		if(typeof(customerId)=="undefined" || customerId.length==0 ){
			alert("请选择一条记录");
			return ;
		}
		AsDialog.PopView(url,params,'dialogWidth:1200px;dialogHeight:800px',function(){
			reloadSelf();
		});
	}
	function impExcel() {
		var url = "/PIDR/DatacopyManage/CodeTableImport.jsp";
		AsDialog.PopView(url,"","dialogWidth=1000px;dialogHeight=600px;status:no;center:yes;help:no;minimize:no;maximize:no;border:thin;",function(){
			reloadSelf();
		}); 
	}
	/*~[Describe=插入白名单,InputParam=无,OutputParam=无]~*/
	function insertWhiteList(){
		var checkRows = getCheckedRows(0);
		if(checkRows.length==0){
			alert("请选择至少一条数据！");
			return;
		}
		var result = "";
		for (var i = 0; i < checkRows.length; i++) {
			var customerId = getItemValue(0,checkRows[i],'CustomerID');
			var entName = getItemValue(0,checkRows[i],'EntName');
			var entCertType = getItemValue(0,checkRows[i],'EntCertType');
			var entCertNum = getItemValue(0,checkRows[i],'EntCertNum');
			var param = "CustomerID=" + customerId + ",EntName=" + entName + ",EntCertType=" + entCertType + ",EntCertNum=" + entCertNum ;
			result = RunJavaMethodTrans("com.amarsoft.app.pidr.whitelist.PidrWhiteListHandler","insertWhiteList",param);
			if(result == "EXISTS"){// 已存在白名单中，给出提示，继续循环
				alert("客户编号：" + customerId + "已存在");
				continue;
			}else if (result != "SUCCESS"){// 报错，打断循环
				alert(result + " 客户编号为：" + customerId);
				break;
			}
		}
		if(result == "SUCCESS" || result == "EXISTS") alert("插入白名单数据完成");
	}
</script>
<%@ include file="/Frame/resources/include/include_end.jspf"%>
