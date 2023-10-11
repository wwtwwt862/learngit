<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="/Frame/resources/include/include_begin.jspf"%>
<%
	/*
		--页面说明:参数管理主页面--
	 */
	String PG_TITLE = "参数管理主页面"; // 浏览器窗口标题 <title> PG_TITLE </title>
	String PG_CONTENT_TITLE = "&nbsp;&nbsp;参数管理主页面&nbsp;&nbsp;"; //默认的内容区标题
	String PG_CONTNET_TEXT = "请点击左侧列表";//默认的内容区文字
	String PG_LEFT_WIDTH = "200";//默认的treeview宽度

	//获得页面参数

	//定义Treeview
	OHTMLTreeView tviTemp = new OHTMLTreeView(CurPage,"参数管理主页面","right");

	//定义树图结构
	String sFolder1=tviTemp.insertFolder("root","参数管理","",1);
	tviTemp.insertPage(sFolder1,"央行内评参数管理","",1);
	tviTemp.insertPage(sFolder1,"行业标准代码管理","",2);
	//另外两种定义树图结构的方法：SQL生成和代码生成   参见View的生成 ExampleView.jsp和ExampleView01.jsp
%><%@ include file="/Frame/resources/include/include_main.jspf"%>
<script type="text/javascript"> 
	function TreeViewOnClick(){
		//如果tviTemp.TriggerClickEvent=true，则在单击时，触发本函数
		var sCurItemID = getCurTVItem().id;
		var sCurItemname = getCurTVItem().name;
		if(sCurItemname=='参数管理'){
			AsControl.OpenView("/PIDR/CodeManage/CodeManageList.jsp","","right");
		}else if(sCurItemname=='央行内评参数管理'){
			AsControl.OpenView("/PIDR/CodeManage/CodeManageList.jsp","","right");
		}else if(sCurItemname=='行业标准代码管理'){
			AsControl.OpenView("/PIDR/CodeManage/EcoinduscateManageList.jsp","","right");
		}else{
			return;
		}
		setTitle(getCurTVItem().name);
	}
	
	<%/*~[Describe=生成treeview;]~*/%>
	function initTreeView(){
		<%=tviTemp.generateHTMLTreeView()%>
		expandNode('root');
		selectItemByName("参数管理");	//默认打开的(叶子)选项	
	}
	
	initTreeView();
</script>
<%@ include file="/Frame/resources/include/include_end.jspf"%>