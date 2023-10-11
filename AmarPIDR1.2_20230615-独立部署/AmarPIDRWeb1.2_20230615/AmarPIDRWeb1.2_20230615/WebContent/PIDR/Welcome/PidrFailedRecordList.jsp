<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="/Frame/resources/include/include_begin_list.jspf"%>
<%@page import="com.amarsoft.app.pidr.common.CheckDBKind" %>
<%@ page import="com.amarsoft.app.pidr.common.PIDRConstants"%>
<% 
    /*
        Author:  jyshen 2023-02-23
        Content: 主页失败任务记录列表
        History Log: 
    */
    ASObjectModel doTemp = new ASObjectModel("PidrFailedRecordList");
    String inputDate = CurPage.getParameter("InputDate");
    if(inputDate == null) inputDate = "";
    if(StringX.isEmpty(ARE.getProperty("DBKind"))) 
        new CheckDBKind().initDBKind();//判断数据库类型
    String dbKind = ARE.getProperty("DBKind");
    if(StringX.isEmpty(inputDate)){//主页点击“更多”，展示所有的失败记录
    	doTemp.appendJboWhere("status = '2'");
    }else{//主页点击某条失败任务记录，展示选中日期的失败记录具体情况
    	if(PIDRConstants.DBKIND_MYSQL.equals(dbKind)|| PIDRConstants.DBKIND_DB2.equals(dbKind)) {//mysql、db2
            doTemp.appendJboWhere("status = '2' and O.inputdate like '"+inputDate+"%'");
        }else{//oracle
            doTemp.appendJboWhere("status = '2' and v.to_char(O.inputdate,'yyyy-MM-dd')='"+inputDate+"'");
        }
    }
    doTemp.setJboOrder("inputDate desc");//倒序排序
    ASObjectWindow dwTemp = new ASObjectWindow(CurPage,doTemp,request);
    dwTemp.Style="1";            //--设置为Grid风格--
    dwTemp.ReadOnly = "1";   //只读模式
    dwTemp.setPageSize(20);
    dwTemp.genHTMLObjectWindow("");
    //0、是否展示 1、 权限控制  2、 展示类型 3、按钮显示名称 4、按钮解释文字 5、按钮触发事件代码  6、  7、  8、  9、图标，CSS层叠样式 10、风格
    String sButtons[][] = {
        {"true","","Button","返回","返回","returnList()","","","","",""},
    };
%><%@include file="/Frame/resources/include/ui/include_list.jspf"%>
<script type="text/javascript">
	function returnList(){
	    AsDialog.ClosePage();
	}
</script>
<%@ include file="/Frame/resources/include/include_end.jspf"%>