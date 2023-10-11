<%@ page contentType="text/html; charset=UTF-8"%><%@ include file="/IncludeBeginMDAJAX.jsp"%><%
/*
 * Content: 根据传入的参数，检查该记录的主键是否重复
 * Input Param: 
 *      Type:检查判断
 *          PRIMARYKEY:主键检查     
 *      TableName :表名
 *      FieldName1 :列名1
 *      FieldValue1 :列名1对应的值
 *      FieldName2 :列名2
 *      FieldValue2 :列名2对应的值
 *      FieldName3 :列名3
 *      FieldValue3 :列名3对应的值
 *      FieldName4 :列名4
 *      FieldValue4 :列名4对应的值    
 *      FieldName4 :列名5
 *      FieldValue4 :列名5对应的值    
 * Output param:
 *      ReturnValue:存在标志(TRUE－主键重复，FALSE－主键不重复)
 */
    //获取类型、表名、列名1、列名1对应的值、列名2、列名2对应的值、列名3、列名3对应的值、列名4、列名4对应的值、列名5、列名5对应的值
    String sType  = CurPage.getParameter("Type");
    String sTableName  = CurPage.getParameter("TableName");
    String sFieldName1  = CurPage.getParameter("FieldName1");
    String sFieldValue1 = CurPage.getParameter("FieldValue1");
    String sFieldName2 = CurPage.getParameter("FieldName2");
    String sFieldValue2  = CurPage.getParameter("FieldValue2");
    String sFieldName3 = CurPage.getParameter("FieldName3");
    String sFieldValue3 = CurPage.getParameter("FieldValue3");
    String sFieldName4 = CurPage.getParameter("FieldName4");
    String sFieldValue4 = CurPage.getParameter("FieldValue4");
    String sFieldName5 = CurPage.getParameter("FieldName5");
    String sFieldValue5 = CurPage.getParameter("FieldValue5");
    
    String sSql = "",sReturnValue = "FALSE";
    int iCount = 0;
    
    if(sType.equals("PRIMARYKEY")){
        if(sFieldName1 !=null && sFieldName1 !="") {
            String sWhere = sFieldName1+" = :"+sFieldName1;
            if(sFieldName2 !=null && sFieldName2 !="") sWhere = sWhere + " and "+sFieldName2+" = :"+sFieldName2;
            if(sFieldName3 !=null && sFieldName3 !="") sWhere = sWhere + " and "+sFieldName3+" = :"+sFieldName3;
            if(sFieldName4 !=null && sFieldName4 !="") sWhere = sWhere + " and "+sFieldName4+" = :"+sFieldName4;
            if(sFieldName5 !=null && sFieldName5 !="") sWhere = sWhere + " and "+sFieldName5+" = :"+sFieldName5;
            sSql = " select count(1) from "+sTableName+" where  "+sWhere;
            SqlObject  sqlObject=new SqlObject(sSql);
            sqlObject.setParameter(sFieldName1, sFieldValue1);
            if(sFieldName2 !=null && sFieldName2 !="") sqlObject.setParameter(sFieldName2, sFieldValue2);
            if(sFieldName3 !=null && sFieldName3 !="") sqlObject.setParameter(sFieldName3, sFieldValue3);
            if(sFieldName4 !=null && sFieldName4 !="") sqlObject.setParameter(sFieldName4, sFieldValue4);
            if(sFieldName5 !=null && sFieldName5 !="") sqlObject.setParameter(sFieldName5, sFieldValue5);
            ASResultSet rs  = Sqlca.getASResultSet(sqlObject);
            if(rs.next()){
                iCount = rs.getInt(1);
                if(iCount > 0)
                    sReturnValue = "TRUE";          
                else
                    sReturnValue = "FALSE";
            }else
                sReturnValue = "FALSE";
            rs.getStatement().close();  
        }
    }
    out.print(sReturnValue); 
%><%@ include file="/IncludeEndAJAX.jsp"%>