package com.amarsoft.app.pidr.whitelist;

import java.io.File;
import java.sql.Connection;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.LinkedHashMap;
import java.util.Map;

import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.ss.usermodel.WorkbookFactory;

import com.amarsoft.app.pidr.common.DBManager;
import com.amarsoft.are.ARE;

/**
 * 读取白名单的Excel类
 * @author hlsong
 */
public class ReadExcelWhiteList {
	private static Map<Integer, String> dataM = new LinkedHashMap<Integer, String>();
	private static Statement st=null;
	private static Connection con=null;
	private static String insertSQL="insert into PIDR_WHITELIST (CustomerId,EntName,EntCertType,EntCertNum,RunStatus,RunTime) values ";
	private static String deleteSQL="delete from PIDR_WHITELIST";
	private static int batchSize=5;
	private static String readFilePath="";
	private static int rowStartNum=2;
	private static boolean isSuccess=false;
	public static boolean isSuccess() {
		return isSuccess;
	}
	public static void setSuccess(boolean isSuccess) {
		ReadExcelWhiteList.isSuccess = isSuccess;
	}
	public ReadExcelWhiteList(String path) {
		getConnection();
		readFilePath=path;
		dataM.clear();
		try {
			con.prepareStatement(deleteSQL).executeUpdate();
			ARE.getLog().error("清空白名单表成功！");
		} catch (SQLException e) {
			ARE.getLog().error("清空白名单表失败！");
		}
	}
	public static void readExcel() throws Exception {
		ARE.getLog().info("读取上传的白名单的Excel文件");
		File xlsFile = new File(readFilePath);
		// xls工作表
		Workbook workbook = WorkbookFactory.create(xlsFile);
		Sheet sheet = workbook.getSheetAt(0);
		int rowNumbers = sheet.getLastRowNum() + 1;
		// 遍历行,读数据
		for (int row = rowStartNum; row < rowNumbers; row++) {
			Row nowRow = sheet.getRow(row);
			if(nowRow==null) {
				continue;
			}
			if(nowRow.getCell(0).getStringCellValue().replace(" ", "").length()==0) continue;
			dataM.put(row,insertSQL+"('"+nowRow.getCell(0).getStringCellValue()+"','"+ nowRow.getCell(1).getStringCellValue()+"','"+nowRow.getCell(2).getStringCellValue()+"','"+nowRow.getCell(3).getStringCellValue()+"','00','"+new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date())+"')");
			if(dataM.size()==batchSize) {
				if(runInsertSQL()) dataM.clear();
			}
		}
		if(dataM.size()==0) isSuccess=true;
		// 到这一过程判定全部处理
		if(dataM.size()>0) {
			boolean f=runInsertSQL();	
			if(f)ARE.getLog().info("数据入库成功!");
		}else if(dataM.size()==0) {
			ARE.getLog().info("数据入库成功!");
		}
		close();
	}
	/**
	 * 先行条件判断是否进入
	 * 反馈是否处理成功
	 * @return
	 */
	static boolean runInsertSQL(){
		ARE.getLog().info("当前执行白名单数据入库");
		try {
			if(con!=null)con.setAutoCommit(false);
			if(st==null)st=con.createStatement();
			for(Integer key:dataM.keySet()) {
				st.addBatch(dataM.get(key).toString());
			}
			st.executeBatch();
			con.commit();
			st.clearBatch();
			isSuccess=true;
			return true;
		}catch (SQLException e) {
			ARE.getLog().info("执行入库失败"+e);
			return false;
		}finally {
			ARE.getLog().info("执行数据入库");
		}
		
	}
	/** 获取数据库连接 */
	 static void getConnection() {
		ARE.getLog().info("解析白名单xls文件,获取数据库连接");
		try {
			con = DBManager.getConnection();
		} catch (SQLException e) {
			ARE.getLog().error("获取数据连接失败"+e);
		}
	}
	/** 关闭使用的资源连接 */
	static void close() throws SQLException {
		ARE.getLog().info("解析白名单xls文件,关闭相关资源的连接");
		if(st!=null) st.close();st=null;
		if(con!=null) con.close();con=null;
	}
	
	
}
