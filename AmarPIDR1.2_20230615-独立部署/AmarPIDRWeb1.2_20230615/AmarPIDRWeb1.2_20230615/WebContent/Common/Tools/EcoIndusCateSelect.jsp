<%@ page contentType="text/html; charset=GBK"%><%@
 include file="/IncludeBeginMD.jsp"%>
 <%--  
	Author: nxxiong
	CreationDate: 2023-02-24
	Description: 国家标准行业选择
--%>
 <%
	String sEcoIndusCateValue = CurPage.getParameter("EcoIndusCateValue");
	String sEcoIndusCate = CurPage.getParameter("EcoIndusCate");
	if(sEcoIndusCate == null) sEcoIndusCate = "";
	String sOpen = "";
	String sDefaultItem = "";
	//增加判断，防止出现 null错误 
	if(sEcoIndusCate.length()>3) sDefaultItem = sEcoIndusCate.substring(0,3);
	if(sEcoIndusCate!=null&&sEcoIndusCate.length()>3) sOpen = "YES";
%>
<html>
<head>
<title>请选择行业类型</title>
<style>
.black9pt {font-size: 11pt; font-weight: bolder; color: #000000; text-decoration: none;}
</style>
</head>
<script type="text/javascript">
	//获取用户选择的行业种类
	function TreeViewOnClick(){
		var sEcoIndusCate=getCurTVItem().id;
		var sEcoIndusCateName=getCurTVItem().name;
		buff.EcoIndusCate.value=sEcoIndusCate+"@"+sEcoIndusCateName;
		//选择国标行业大类时可以自动触发右边节目
	<%	if(sEcoIndusCateValue == null){	%>
			newBusiness();
	<%	}%>
	}
	
	//modify by hwang,修改双击相应函数。function TreeViewOnDBClick()修改为function TreeViewOnDBLClick() 
	function TreeViewOnDBLClick(){
		newBusiness();
	}

	//新选一个行业种类
	function newBusiness(){
	//选择国标行业大类时可以自动触发右边节目
	<%	if(sEcoIndusCateValue == null){	%>
			if(buff.EcoIndusCate.value!=""){
				sReturnValue = buff.EcoIndusCate.value;
				parent.OpenPage("/Common/Tools/EcoIndusCateSelect.jsp?EcoIndusCateValue="+getCurTVItem().id,"frameright","");
			}else{
				alert(getMessageText("ALS70247"));//请选择行业种类细项！
			}
	<%	}else{ %>
			var s = buff.EcoIndusCate.value;
			s = s.split('@');
			var sValue = s[0];
			var sName = s[1];
			if(sValue == '9'){//9是未知，没有具体细项
				AsDialog.ClosePage(sValue+"@"+sName);
			}else if(typeof(sValue)=="undefined" || sValue.length<4){
				alert("请选择细项！");
			}else{
				if(sValue.length==4){				
					AsDialog.ClosePage(sValue+"@"+sName);
				}else{
					alert("请选择细项！");
				}
			}
	<%	}%>
	}
	//清空功能的实现
	function clearAll(){
		AsDialog.ClosePage('_CLEAR_');
	}
	//取消功能的实现
	function goBack(){
		AsDialog.ClosePage('CANCEL');
	}
	//将查询出的行业类型按照TreeView展示
	function startMenu(){
	<%
		OHTMLTreeView tviTemp = new OHTMLTreeView(CurPage, "行业类型列表","right");
		//选择行业类型一
		if(sEcoIndusCateValue == null)
			tviTemp.init(JBOFactory.getBizObjectManager("jbo.pidr.PIDR_CODE_LIBRARY"), "PBCode","PBItemName","PBCode","","from O where CodeNO='EcoIndusCate' and length(PBCode) < 4");
		else
			tviTemp.init(JBOFactory.getBizObjectManager("jbo.pidr.PIDR_CODE_LIBRARY"), "PBCode","PBItemName","PBCode","","from O where CodeNO='EcoIndusCate' and length(PBCode) < 5 and PBCode like '"+sEcoIndusCateValue+"%'");
		
		out.println(tviTemp.generateHTMLTreeView());
	%>
	}
</script>

<body bgcolor="#DCDCDC">
<center>
<form  name="buff">
<input type="hidden" name="EcoIndusCate" value="">
<table width="90%" align=center border='1' height="98%" cellspacing='0' bordercolor='#999999' bordercolordark='#FFFFFF'>
<tr>
	<td id="myleft"  colspan='3' align=center width=100%><iframe name="left" src="" width=100% height=100% frameborder=0 scrolling=no ></iframe></td>
</tr>
<tr height=4%>
	<%
		if(sEcoIndusCateValue == null){
	%>
	<span class="STYLE9"></span>
	<p align="left" class="black9pt">行业分类大类</p>
	<td nowrap align="right" class="black9pt" bgcolor="#F0F1DE" ></td>
	<%
		}else{
	%>
	<span class="STYLE9"></span>
	<p align="left" class="black9pt">行业分类中类</p>
	<td nowrap align="center" valign="baseline">
		<table>
	        <tr>
		       <td><%=new Button("确定","确定","newBusiness()","","").getHtmlText()%></td>
		       <td><%=new Button("取消","取消","goBack()","","").getHtmlText()%></td>
		       <td><%=new Button("清空","清空","clearAll()","","").getHtmlText()%></td>
	        </tr>
	    </table>
	</td>
	<%}%>
</tr>
</table>
</form>
</center>
</body>
</html>
<script type="text/javascript">
window.onload = function(){
	startMenu();
	AsLink.setShortcut("Ctrl+F", showTVSearch);
	expandNode('root');
	selectItem('<%=sDefaultItem%>');//自动点击树图，目前写死，也可以设置到 code_library中进行设定
	selectItem('<%=sEcoIndusCate%>');//自动点击树图，目前写死，也可以设置到 code_library中进行设定
	expandNode('<%=sEcoIndusCateValue%>');
}
</script>
<%@ include file="/IncludeEnd.jsp"%>