package com.amarsoft.app.pidr.util;



import com.amarsoft.are.ARE;
import com.amarsoft.awe.util.ASResultSet;
import com.amarsoft.awe.util.SqlObject;
import com.amarsoft.awe.util.Transaction;

public class CheckDataExist {

	/**
	 * 判断该主键下表中是否含有数据，若无数据，前台将不做展示<br>
	 * String TableName;//表名<br>
	 * String stringKey; //主键
	 * String stringValue; //键值
	 * @author zjxu
	 * */
	public static String checkData(String TableName,String stringKey,String stringValue,Transaction Sqlca){
		String  flag = "true";
		if(stringKey.contains("@")){//历史表
			String[] stringKey1 = stringKey.split("@");
			String[] stringValue1 =  stringValue.split("@");
			try {
				if(stringKey1.length!=stringValue1.length){
					ARE.getLog().info("键值匹配，请检查····!");
				}else{
					StringBuffer keyString = new StringBuffer("");
					StringBuffer sql = new StringBuffer("");
					keyString.append("[web]数据维护根据主键");
					sql.append("select 1 from "+TableName+" where 1=1 ");
					for(int i=0;i<stringKey1.length;i++){
						keyString.append("["+keyString+i+"] ");
						sql.append(" and "+stringKey1[i]+"="+"'"+stringValue1[i]+"'");
					}
					keyString.append("判断表["+TableName+"]中是否有数据操作开始执行");
					ARE.getLog().info(keyString.toString());
					ASResultSet s=Sqlca.getASResultSet(sql.toString());
					if (s.getRowCount()>0) {
						flag = "true";
					} else {
						flag = "false";
					}
					ARE.getLog().info("[web]"+sql);
					ARE.getLog().info("判断表["+TableName+"]中是否有数据操作执行成功");
				}
				
			} catch (Exception e) {
				ARE.getLog().info("判断表["+TableName+"]中是否有数据操作执行失败");
			}
		}else{
			try {
				ARE.getLog().info("[web]数据维护根据主键["+stringKey+"]判断表["+TableName+"]中是否有数据操作开始执行");
				String sql = "select 1 from "+TableName+" where "+stringKey+"='"+stringValue+"'";
				ASResultSet s=Sqlca.getASResultSet(sql.toString());
				if (s.getRowCount()>0) {
					flag = "true";
				} else {
					flag = "false";
				}
				ARE.getLog().info("[web]"+sql);
				ARE.getLog().info("[web]数据维护根据主键["+stringKey+"]判断表["+TableName+"]中是否有数据操作执行成功");
			} catch (Exception e) {
				ARE.getLog().info("[web]数据维护根据主键["+stringKey+"]判断表["+TableName+"]中是否有数据操作执行失败");
			}
		}
		return flag;
	}
	
}