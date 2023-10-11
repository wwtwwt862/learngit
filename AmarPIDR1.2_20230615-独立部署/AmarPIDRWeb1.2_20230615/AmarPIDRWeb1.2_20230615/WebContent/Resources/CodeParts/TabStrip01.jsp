<%@ page pageEncoding="UTF-8"%><%@page import="com.amarsoft.are.lang.StringX"%>
<%@page import="com.amarsoft.are.util.json.JSONEncoder"%>
<%
	String[][] _sTabStrip = new String[sTabStrip.length][];
	// 参数：0.是否显示, 1.标题，2.URL，3，参数串, 4. Strip高度(默认600px)，5. 是否有关闭按钮(默认无) 6. 是否缓存(默认是)
	for(int _i = 0; _i < sTabStrip.length; _i++){
		_sTabStrip[_i] = new String[6];
		_sTabStrip[_i][0] = "true".equals(sTabStrip[_i][0])?"true":"false";
		_sTabStrip[_i][1] = LanguageManager.getPageLanguage(sTabStrip[_i][1]);
		_sTabStrip[_i][2] = "";
		if(!StringX.isSpace(sTabStrip[_i][2]))
			_sTabStrip[_i][2] = "AsControl.OpenComp('"+sTabStrip[_i][2]+"', '"+sTabStrip[_i][3]+"', 'TabContentFrame')";
		_sTabStrip[_i][3] = sTabStrip[_i].length>6&&"false".equals(sTabStrip[_i][6])?"false":"true";
		_sTabStrip[_i][4] = sTabStrip[_i].length>5&&"true".equals(sTabStrip[_i][5])?"true":"false";
		_sTabStrip[_i][5] = sTabStrip[_i].length>4&&!StringX.isSpace(sTabStrip[_i][4])?sTabStrip[_i][4]:"";
	}
	CurPage.setAttribute("TabStripType", "strip".equals(_sView)?"strip":"tab");
	CurPage.setAttribute("TabStrip", JsonEncoder.encode(_sTabStrip));
%>
<%@ include file="/Frame/resources/include/ui/include_tabstrip.jspf"%>