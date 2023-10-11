<%@ page contentType="text/html; charset=GBK"%><%@
 include file="/IncludeBeginMD.jsp"%>
 <%--  
	Author: nxxiong
	CreationDate: 2023-02-24
	Description: ���ұ�׼��ҵѡ��
--%>
 <%
	String sEcoIndusCateValue = CurPage.getParameter("EcoIndusCateValue");
	String sEcoIndusCate = CurPage.getParameter("EcoIndusCate");
	if(sEcoIndusCate == null) sEcoIndusCate = "";
	String sOpen = "";
	String sDefaultItem = "";
	//�����жϣ���ֹ���� null���� 
	if(sEcoIndusCate.length()>3) sDefaultItem = sEcoIndusCate.substring(0,3);
	if(sEcoIndusCate!=null&&sEcoIndusCate.length()>3) sOpen = "YES";
%>
<html>
<head>
<title>��ѡ����ҵ����</title>
<style>
.black9pt {font-size: 11pt; font-weight: bolder; color: #000000; text-decoration: none;}
</style>
</head>
<script type="text/javascript">
	//��ȡ�û�ѡ�����ҵ����
	function TreeViewOnClick(){
		var sEcoIndusCate=getCurTVItem().id;
		var sEcoIndusCateName=getCurTVItem().name;
		buff.EcoIndusCate.value=sEcoIndusCate+"@"+sEcoIndusCateName;
		//ѡ�������ҵ����ʱ�����Զ������ұ߽�Ŀ
	<%	if(sEcoIndusCateValue == null){	%>
			newBusiness();
	<%	}%>
	}
	
	//modify by hwang,�޸�˫����Ӧ������function TreeViewOnDBClick()�޸�Ϊfunction TreeViewOnDBLClick() 
	function TreeViewOnDBLClick(){
		newBusiness();
	}

	//��ѡһ����ҵ����
	function newBusiness(){
	//ѡ�������ҵ����ʱ�����Զ������ұ߽�Ŀ
	<%	if(sEcoIndusCateValue == null){	%>
			if(buff.EcoIndusCate.value!=""){
				sReturnValue = buff.EcoIndusCate.value;
				parent.OpenPage("/Common/Tools/EcoIndusCateSelect.jsp?EcoIndusCateValue="+getCurTVItem().id,"frameright","");
			}else{
				alert(getMessageText("ALS70247"));//��ѡ����ҵ����ϸ�
			}
	<%	}else{ %>
			var s = buff.EcoIndusCate.value;
			s = s.split('@');
			var sValue = s[0];
			var sName = s[1];
			if(sValue == '9'){//9��δ֪��û�о���ϸ��
				AsDialog.ClosePage(sValue+"@"+sName);
			}else if(typeof(sValue)=="undefined" || sValue.length<4){
				alert("��ѡ��ϸ�");
			}else{
				if(sValue.length==4){				
					AsDialog.ClosePage(sValue+"@"+sName);
				}else{
					alert("��ѡ��ϸ�");
				}
			}
	<%	}%>
	}
	//��չ��ܵ�ʵ��
	function clearAll(){
		AsDialog.ClosePage('_CLEAR_');
	}
	//ȡ�����ܵ�ʵ��
	function goBack(){
		AsDialog.ClosePage('CANCEL');
	}
	//����ѯ������ҵ���Ͱ���TreeViewչʾ
	function startMenu(){
	<%
		OHTMLTreeView tviTemp = new OHTMLTreeView(CurPage, "��ҵ�����б�","right");
		//ѡ����ҵ����һ
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
	<p align="left" class="black9pt">��ҵ�������</p>
	<td nowrap align="right" class="black9pt" bgcolor="#F0F1DE" ></td>
	<%
		}else{
	%>
	<span class="STYLE9"></span>
	<p align="left" class="black9pt">��ҵ��������</p>
	<td nowrap align="center" valign="baseline">
		<table>
	        <tr>
		       <td><%=new Button("ȷ��","ȷ��","newBusiness()","","").getHtmlText()%></td>
		       <td><%=new Button("ȡ��","ȡ��","goBack()","","").getHtmlText()%></td>
		       <td><%=new Button("���","���","clearAll()","","").getHtmlText()%></td>
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
	selectItem('<%=sDefaultItem%>');//�Զ������ͼ��Ŀǰд����Ҳ�������õ� code_library�н����趨
	selectItem('<%=sEcoIndusCate%>');//�Զ������ͼ��Ŀǰд����Ҳ�������õ� code_library�н����趨
	expandNode('<%=sEcoIndusCateValue%>');
}
</script>
<%@ include file="/IncludeEnd.jsp"%>