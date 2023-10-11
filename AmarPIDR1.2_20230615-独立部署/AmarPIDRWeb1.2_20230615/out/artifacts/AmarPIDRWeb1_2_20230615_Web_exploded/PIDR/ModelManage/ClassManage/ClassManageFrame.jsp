<%@ page pageEncoding="UTF-8"%>
<%@ include file="/IncludeBegin.jsp"%>
<%-- 页面说明: 上下框架页面 --%>
<%@include file="/Resources/CodeParts/Frame02.jsp"%>
<script type="text/javascript">


	mytoptd.height=300;
	var selectedRow, pageInfo={};
	OpenList();
	function OpenList(){
		AsControl.OpenView("/PIDR/ModelManage/ClassManage/ClassCatalogList.jsp","","rightup","");
	}
	
	function OpenInfo(className,classDescribe){
		if(typeof(className)=="undefined" || className.length==0) {
			AsControl.OpenView("/Blank.jsp","TextToShow=请先选择相应的信息!","rightdown","");
		}else{
			AsControl.OpenView("/PIDR/ModelManage/ClassManage/ClassMethodList.jsp","ClassName="+className+"&ClassDescribe="+classDescribe,"rightdown","");
		}		
	}
	
</script>
<%@ include file="/IncludeEnd.jsp"%>