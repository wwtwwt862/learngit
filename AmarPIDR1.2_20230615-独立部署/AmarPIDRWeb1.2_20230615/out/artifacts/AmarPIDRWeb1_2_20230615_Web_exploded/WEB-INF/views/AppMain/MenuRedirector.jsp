<%@ page pageEncoding="UTF-8"%><%@
 include file="/Frame/resources/include/include_begin_ajax.jspf"%><%
	//取系统名称
	String sImplementationName = CurConfig.getConfigure("ImplementationName");
	String PG_TITLE = sImplementationName == null ? "" : sImplementationName;
	String mid = CurPage.getParameter("MID");
%><%@ include file="/AppMain/resources/include/jsp_mainmenu.jspf"%>
<script type="text/javascript">
$(function($){
	<%if(mid != null){%>
	AsControl.OpenView("/AppMain/MenuTabContainer.jsp", "MID=<%=mid%>", "mainpage");
	<%-- <%} else if(CurUser.hasRole("099")){%>
	AsControl.OpenView("/AdminDashboard.jsp","","mainpage");
	//AsControl.OpenView("/Main.jsp","","mainpage"); --%>
	<%} else {%>
	AsControl.OpenView("/AppMain/Welcome.jsp","","mainpage");
	<%}%>
});
</script>
<%@ include file="/Frame/resources/include/include_end_ajax.jspf"%><%@
include file="/AppMain/resources/include/app_tail.jspf"%>