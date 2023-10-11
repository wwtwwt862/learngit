<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="/Frame/resources/include/include_begin_list.jspf"%>
<%	
/*
	Author:  wxli2 2018-10-31
	Content: 参数管理
	History Log: 
*/
		
	ASObjectModel doTemp = new ASObjectModel("PidrCodeLibrary");
	ASObjectWindow dwTemp = new ASObjectWindow(CurPage,doTemp,request);
	dwTemp.Style="1";      	     //--设置为Grid风格--
	dwTemp.ReadOnly = "1";	 //只读模式
	dwTemp.setPageSize(20);
	dwTemp.genHTMLObjectWindow("");

	String sButtons[][] = {
			//0、是否展示 1、	权限控制  2、 展示类型 3、按钮显示名称 4、按钮解释文字 5、按钮触发事件代码	6、	7、	8、	9、图标，CSS层叠样式 10、风格
			{"true","All","Button","新增","新增","add()","","","","btn_icon_add",""},
			{"true","","Button","详情","详情","edit()","","","","btn_icon_detail",""},
			{"true","","Button","删除","删除","if(confirm('确实要删除吗?'))as_delete(0)","","","","btn_icon_delete",""},
			{"true","","Button","导入代码映射表","批量导入代码映射表","impExcel()","","","","btn_icon_add",""}
		};
%>
<%@include file="/Frame/resources/include/ui/include_list.jspf"%>

<script type="text/javascript">
	function add(){
		 var prevUrl="/PIDR/CodeManage/CodeManageList.jsp";
		 var url = "/PIDR/CodeManage/CodeManageAdd.jsp";
		 AsDialog.PopView(url,"&PrevUrl="+prevUrl,'dialogWidth:1000px;dialogHeight:600px',function(){
			 reloadSelf();
		 });
	}
	function edit(){
		 var prevUrl="/PIDR/CodeManage/CodeManageList.jsp";
		 var url = "/PIDR/CodeManage/CodeManageInfo.jsp";
		 var codeNo = getItemValue(0,getRow(0),'CodeNo');
		 var subCodeNo = getItemValue(0,getRow(0),'SubCodeNo');
		 var pbCode = getItemValue(0,getRow(0),'PbCode');
		 var cbCode = getItemValue(0,getRow(0),'CbCode');
		 if(typeof(codeNo)=="undefined" || codeNo.length==0 || typeof(subCodeNo)=="undefined" || subCodeNo.length==0
				 || typeof(pbCode)=="undefined" || pbCode.length==0 || typeof(cbCode)=="undefined" || cbCode.length==0){
			alert("参数不能为空！");
			return ;
		 }
		 AsDialog.PopView(url,'CodeNo='+codeNo+"&SubCodeNo="+subCodeNo+"&PbCode="+pbCode+"&CbCode="+cbCode+"&PrevUrl="+prevUrl ,'dialogWidth:1000px;dialogHeight:600px',function(){
			 reloadSelf();
		});
	}
	
	
	function impExcel() {
		var url = "/PIDR/CodeManage/CodeTableImport.jsp";
		AsDialog.PopView(url,"","dialogWidth=1000px;dialogHeight=600px;status:no;center:yes;help:no;minimize:no;maximize:no;border:thin;",function(){
			reloadSelf();
		}); 
	}
</script>
<%@ include file="/Frame/resources/include/include_end.jspf"%>