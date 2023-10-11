<%@ page pageEncoding="UTF-8"%><%@
 include file="/Frame/resources/include/include_begin_info.jspf"%><%
	/*
		Content:    评估模型目录详情
	 */
	String sModelNo =  CurPage.getParameter("ModelNo");
	if(sModelNo==null) sModelNo="";
	String sType =  CurPage.getParameter("Type");
	if(sType == null) sType = "";
	sASWizardHtml = "<div><font size=\"2pt\" color=\"#930055\">"+("Classify".equals(sType)?"分类":"评估")+"模型目录详情</font></div>";

	ASObjectModel doTemp = new ASObjectModel("EvaluateCatalogInfo");
	doTemp.setBusinessProcess("com.amarsoft.awe.dw.handler.impl.CommonHandler");
	if (!sModelNo.equals("")){
		doTemp.setReadOnly("ModelNo",true);
	}
	String sJbo = "jbo.sys.CODE_LIBRARY,ItemNo,ItemName,IsInUse='1' and CodeNo ='EvaluateModelType'";
	//模型类型参见代码EvaluateModelType
	if(sType.equals("Classify")){ //资产风险分类
		sJbo += " and ItemNo = '020' ";
	}else if(sType.equals("Risk")){ //风险度评估
		sJbo += " and ItemNo = '030' ";	
	}else if(sType.equals("CreditLine")){ //最高综合授信额度参考
		sJbo += " and ItemNo = '080' ";
	}else if(sType.equals("CreditLevel")){ //信用等级评估	(公司客户和个人)
		sJbo += " and ItemNo in ('010','012','015','017') ";
	}
	doTemp.setDDDWJbo("ModelType", sJbo);
	
	ASObjectWindow dwTemp = new ASObjectWindow(CurPage,doTemp,request);
	dwTemp.Style="2";      //设置DW风格 1:Grid 2:Freeform
	dwTemp.ReadOnly = "0"; //设置是否只读 1:只读 0:可写
	dwTemp.genHTMLObjectWindow(sModelNo);
	
	String sButtons[][] = {
		{"true","All","Button","保存","保存修改","saveRecord()","","","",""},
		{"true","","Button","转换方法美化","转换方法美化","my_formatIF()","","","","btn_icon_detail"},
	};
%><%@include file="/Frame/resources/include/ui/include_info.jspf"%>
<script type="text/javascript">
	setDialogTitle("评估模型目录详情");
	function saveRecord(){
		as_save("myiframe0","parent.OpenList();");
	}

	function my_formatIF(){
		try{
			var sValue = getItemValue(0,getRow(),"TransformMethod");
			sValue = sValue.replace(/[\r\n\s\f\t\v ]+/gm,""); 
			sValue = sValue.replace(/,if/ig,",\r\nif");
			setItemValue(0,getRow(),"TransformMethod",sValue);	
		} catch(e){}	
	}
</script>	
<%@ include file="/Frame/resources/include/include_end.jspf"%>