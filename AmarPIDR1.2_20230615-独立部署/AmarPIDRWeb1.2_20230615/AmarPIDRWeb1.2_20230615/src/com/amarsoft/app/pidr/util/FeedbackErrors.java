package com.amarsoft.app.pidr.util;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import com.amarsoft.app.pidr.common.DBManager;
import com.amarsoft.app.pidr.common.PIDRConstants;
import com.amarsoft.are.ARE;
import com.amarsoft.awe.util.ASResultSet;
import com.amarsoft.awe.util.SqlObject;
import com.amarsoft.awe.util.Transaction;

public class FeedbackErrors {

	/**
	 * 修改反馈错误数据,查出某个对应的表的所有错误字段,返回错误提示内容到前台<br>
	 * String errTableName;//错误表名<br>
	 * String busiidserialNo; //主键  业务标识号
	 * 
	 * @author lyyin
	 */
	
	public static HashMap<String, String> getfeedbackErrInfo(String bsBusiIdSerialno,String MessageType,Transaction Sqlca) {//反馈错误查询
		HashMap<String, String> errMap = new HashMap<String, String>();
		ASResultSet ars = null;
		try {
			String sql = "SELECT FNO,DIGEST FROM PIDR_FEEDBACK WHERE BSBUSIIDSERIALNO =:bsBusiIdSerialno and MESSAGETYPE=:MessageType";

			SqlObject sqlObject = new SqlObject(sql);
			sqlObject.setParameter("bsBusiIdSerialno", bsBusiIdSerialno);
			sqlObject.setParameter("MessageType", MessageType);
			ars = Sqlca.getASResultSet(sqlObject);// 查出一个表对应的所有错误
			while (ars.next()) {
				String errMsg = ars.getString("DIGEST");// 错误信息
				String fNo = ars.getString("FNO");// 错误编号
				String oneErr =  "</span>&nbsp&nbsp错误信息:<span style='color:red;'>" + errMsg + "</span></br>";// 对应一条错误
				errMap.put(fNo, oneErr);
			}
		} catch (Exception e) {
			ARE.getLog().error("查询错误字段失败");
		}finally {
			if(ars != null){
				try {
					ars.close();
				} catch (SQLException e) {
					ARE.getLog().error("数据库结果集关闭失败···"+e);
				}
			}
		}
		return errMap;
	}
	
	/**
     * 修改反馈错误数据,查出反馈错误表中该账户的（错误字段，错误信息）map，便于前端对错误字段标红，以及info页面错误字段对应的错误信息的展示
     * @param bsBusiIdSerialno：标识号
     * @param MessageType：报文类型
     * @author kwwu
     */
    public static HashMap<String, String> getfeedbackErrField(String bsBusiIdSerialno,String MessageType,Transaction Sqlca) {
        HashMap<String, String> errFieldMap = new HashMap<String, String>();
        ASResultSet ars = null;
        try {
            String sql = "SELECT UPPER(ERRMSG) as ERRMSG,DIGEST FROM PIDR_FEEDBACK WHERE BSBUSIIDSERIALNO =:bsBusiIdSerialno and MESSAGETYPE=:MessageType";

            SqlObject sqlObject = new SqlObject(sql);
            sqlObject.setParameter("bsBusiIdSerialno", bsBusiIdSerialno);
            sqlObject.setParameter("MessageType", MessageType);
            ars = Sqlca.getASResultSet(sqlObject);
            while (ars.next()) {
                String errField = ars.getString("ERRMSG");// 错误字段
                if(PIDRConstants.XFiled.contains(errField)) 
                    errField=errField+"NAME";//使用了虚字段的字段，在发馈错误提示标红框时，需要标出虚字段
                String errMsg = ars.getString("DIGEST");// 错误信息
                errFieldMap.put(errField, "错误信息:<span style='color:red;'>" + errMsg + "</span></br>");
            }
        } catch (Exception e) {
            ARE.getLog().error("查询错误字段失败");
        }finally {
            if(ars != null){
                try {
                    ars.close();
                } catch (SQLException e) {
                    ARE.getLog().error("数据库结果集关闭失败···"+e);
                }
            }
        }
        return errFieldMap;
    }
}