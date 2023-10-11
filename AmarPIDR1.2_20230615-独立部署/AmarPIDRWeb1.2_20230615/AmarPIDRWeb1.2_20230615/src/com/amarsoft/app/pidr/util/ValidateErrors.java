package com.amarsoft.app.pidr.util;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import com.amarsoft.are.ARE;
import com.amarsoft.awe.util.ASResultSet;
import com.amarsoft.awe.util.SqlObject;
import com.amarsoft.awe.util.Transaction;

public class ValidateErrors {

	/**
	 * 修改校验错误数据,查出某个对应的表的所有错误字段,返回错误提示内容和字段到前台<br>
	 * String errTableName;//错误表名<br>
	 * String busiidserialNo; //主键  业务标识号
	 * 
	 * @author lyyin
	 */
	
	//查出错误信息
	public static String getErrMsg(String errTableName, String busiidserialNo, Transaction Sqlca) {

		StringBuffer sCONTENT = new StringBuffer();// 弹出层错误提示内容
		ASResultSet ars = null;
		int sERRCOUNT = 1;// 错误数统计
		try {
			String sql = "SELECT ERRMSG,ERRFIELDNAME FROM PIDR_VALIDATEERRORS WHERE UPPER(ERRTABLE)= :ERRTABLE AND BUSIIDSERIALNO= :BUSIIDSERIALNO";
			SqlObject sqlObject = new SqlObject(sql);
			sqlObject.setParameter("ERRTABLE", errTableName);
			sqlObject.setParameter("BUSIIDSERIALNO", busiidserialNo);
			ars = Sqlca.getASResultSet(sqlObject);// 查出一个表对应的所有错误
			while (ars.next()) {
				String sERRMSG = ars.getString("ERRMSG");// 错误信息
				String sERRFIELDNAME = ars.getString("ERRFIELDNAME");// 错误字段中文
				String sONEERR = "错误字段" + (sERRCOUNT++) + ":<span style='color:red';>" + sERRFIELDNAME
						+ "</span>&nbsp&nbsp错误信息:<span style='color:red;'>" + sERRMSG + "</span></br>";// 对应一条错误
				sCONTENT.append(sONEERR);// 添加到弹出层内容
			}
		} catch (SQLException e) {
			ARE.getLog().error("查询错误信息失败");

		}finally {
			if(ars != null){
				try {
					ars.close();
				} catch (SQLException e) {
					ARE.getLog().error("数据库结果集关闭失败···"+e);
				}
			}
			
		}
		return sCONTENT.toString();
	}
	
	//查出错误字段
	public static List<String> getErrField(String errTableName, String busiidserialNo, Transaction Sqlca) {

		List<String> sErrField = new ArrayList<String>();
		ASResultSet ars = null;
		try {
			String sql = "SELECT ERRFIELD FROM PIDR_VALIDATEERRORS WHERE UPPER(ERRTABLE)=:ERRTABLE AND BUSIIDSERIALNO= :BUSIIDSERIALNO";
			SqlObject sqlObject = new SqlObject(sql);
			sqlObject.setParameter("ERRTABLE", errTableName);
			sqlObject.setParameter("BUSIIDSERIALNO", busiidserialNo);
			ars = Sqlca.getASResultSet(sqlObject);// 查出一个表对应的所有错误
			while (ars.next()) {
				String sERRFIELD = ars.getString("ERRFIELD");// 错误字段
				sErrField.add(sERRFIELD);
			}
		} catch (SQLException e) {
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
		return sErrField;
	}
	
	public static HashMap<String, String> getErrInfo(String errTableName, String busiIdSerialNo,Transaction Sqlca) {
		HashMap<String, String> errMap = new HashMap<String, String>();
		ASResultSet ars = null;
		try {
			String sql = "SELECT ErrNo,ErrField,ErrMsg,ErrFieldName FROM PIDR_VALIDATEERRORS WHERE UPPER(ErrTable)=:ErrTable and BusiIdSerialNo=:BusiIdSerialNo";
			SqlObject sqlObject = new SqlObject(sql);
			sqlObject.setParameter("ErrTable", errTableName);
			sqlObject.setParameter("BusiIdSerialNo", busiIdSerialNo);
			ars = Sqlca.getASResultSet(sqlObject);// 查出一个表对应的所有错误
			while (ars.next()) {
				String errField = ars.getString("ErrField");// 错误字段
				String errMsg = ars.getString("ErrMsg");// 错误信息
				String errFieldName = ars.getString("ErrFieldName");// 错误字段中文
				String errNo = ars.getString("ErrNo");// 错误编号
				String oneErr = "错误字段" + errField + ":<span style='color:red';>" + errFieldName
						+ "</span>&nbsp&nbsp错误信息:<span style='color:red;'>" + errMsg + "</span></br>";// 对应一条错误
				errMap.put(errNo, oneErr);
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
	
	//缺少段的段级校验错误，使用业务标识号（N/A）去查询时，会把其余账户的缺少情况一起展示出来，所以使用基础段业务标识码
	public static HashMap<String, String> getNAErrInfo(String errTableName, String bsBusiIdSerialNo,Transaction Sqlca) {
        HashMap<String, String> errMap = new HashMap<String, String>();
        ASResultSet ars = null;
        try {
            String sql = "SELECT ErrNo,ErrField,ErrMsg,ErrFieldName FROM PIDR_VALIDATEERRORS WHERE UPPER(ErrTable)=:ErrTable and BsBusiIdSerialNo=:BsBusiIdSerialNo";
            SqlObject sqlObject = new SqlObject(sql);
            sqlObject.setParameter("ErrTable", errTableName);
            sqlObject.setParameter("BsBusiIdSerialNo", bsBusiIdSerialNo);
            ars = Sqlca.getASResultSet(sqlObject);// 查出一个表对应的所有错误
            while (ars.next()) {
                String errField = ars.getString("ErrField");// 错误字段
                String errMsg = ars.getString("ErrMsg");// 错误信息
                String errFieldName = ars.getString("ErrFieldName");// 错误字段中文
                String errNo = ars.getString("ErrNo");// 错误编号
                String oneErr = "错误字段" + errField + ":<span style='color:red';>" + errFieldName
                        + "</span>&nbsp&nbsp错误信息:<span style='color:red;'>" + errMsg + "</span></br>";// 对应一条错误
                errMap.put(errNo, oneErr);
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
	
	
	
	
	
	
	
}