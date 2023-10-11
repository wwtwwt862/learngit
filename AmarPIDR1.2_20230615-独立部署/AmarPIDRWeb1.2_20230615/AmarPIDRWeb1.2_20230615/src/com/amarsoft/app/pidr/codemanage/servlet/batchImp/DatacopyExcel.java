package com.amarsoft.app.pidr.codemanage.servlet.batchImp;

import java.io.BufferedInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;
import java.util.Set;

import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellType;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

import com.amarsoft.app.pidr.common.PIDRConstants;
import com.amarsoft.app.pidr.util.CloseManager;
import com.amarsoft.are.ARE;
import com.amarsoft.are.sql.Connection;
import com.amarsoft.awe.util.DBKeyHelp;

public class DatacopyExcel {
	private Connection connection=null;
	private Statement pstatement=null;
	private int parserReportNumber = 500;
	private int resint = PIDRConstants.IMPORTRESULT_1;
	private SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
	
	/**
	 * 解析Excel
	 * @param fileName
	 * @param filePath
	 * @return
	 */
	public String getListByExcel(String fileName,String filePath) {
		String tableName = "";
		File file = new File(filePath);
		InputStream in = null;
		List<Map<String, String>> list = new ArrayList<Map<String, String>>();
		String result = String.valueOf(resint);
		Sheet sheet = null;//表格
		Row row = null;//行
		Row listNameRow = null;//字段名称行
		Cell cell = null;//单元格
		Cell listNameCell = null;//字段名称
		try {
			in = new BufferedInputStream(new FileInputStream(file));		
			Workbook workbook = getWorkboot(in, fileName);
			if (workbook == null) {
				ARE.getLog().info("Excel为空");
			}
			//上传前清空错误记录表
			deleteErrTable();
			//遍历sheet
			for (int i = 0; i < workbook.getNumberOfSheets()-1; i++) {
				sheet = workbook.getSheetAt(i);		
				tableName = sheet.getSheetName();				
				listNameRow = sheet.getRow(sheet.getFirstRowNum()+3);
				//遍历行
				for (int j = sheet.getFirstRowNum()+4; j < sheet.getLastRowNum()+1; j++) {
					row = sheet.getRow(j);
					if (row == null || row.getFirstCellNum()==j) {
						continue;
					}
					//遍历列
					Map<String, String> li = new LinkedHashMap<String, String>();
					for (int k = row.getFirstCellNum()+1; k < listNameRow.getLastCellNum(); k++) {
						//若该行第二列为空则判断数据全部读取完毕
						if ("".equals(getCellValue(row.getCell(row.getFirstCellNum()+1))) || getCellValue(row.getCell(row.getFirstCellNum()+1))==null) {
							break;
						}
						listNameCell = listNameRow.getCell(k);
						cell = row.getCell(k);
						li.put(listNameCell.toString(), getCellValue(cell).toString());
					}
					list.add(li);
				}
				//上传			
				datacopy(list,tableName);
				list.clear();
			}
			in.close();
		} catch (FileNotFoundException e) {
			ARE.getLog().error("未找到上传文件",e);
			resint = PIDRConstants.IMPORTRESULT_6;
		} catch (IOException e) {
			ARE.getLog().error("读取文件失败",e);
			resint = PIDRConstants.IMPORTRESULT_5;
		}catch (SQLException e) {
			ARE.getLog().error("解析异常：" + e.getMessage(),e);
			resint = PIDRConstants.IMPORTRESULT_4;
			result = resint + "@" + tableName + "@" + "" + "@" + "" + "@" + e.getMessage();
		}catch (Exception e) {
			ARE.getLog().error("解析异常",e);
			resint = PIDRConstants.IMPORTRESULT_4;
			result = resint + "@" + tableName + "@" + listNameCell + "@" + row.getRowNum() + "@" + e.getMessage();
		}finally {
			CloseManager.closeResource(connection);
			CloseManager.closeResource(pstatement);
		}
		return result;
	}
	
	/**
	 * 解析文件格式
	 * @param inStr
	 * @param fileName
	 * @return
	 */
	public Workbook getWorkboot(InputStream inStr, String fileName) {
		Workbook wb = null;
		String fileType = fileName.substring(fileName.lastIndexOf("."));
		try {
			if (".xls".equals(fileType)) {
				wb = new HSSFWorkbook(inStr);			
			}else if (".xlsx".equals(fileType)) {
				wb = new XSSFWorkbook(inStr);
			}else {
				ARE.getLog().info("解析文件格式有误");
			}
		} catch (IOException e) {
			ARE.getLog().error("文件读取失败",e);
		} 
		return wb;
		
	}
	/**
	 * 插入数据之前清除主键重复表内数据
	 * 
	 */
	public void deleteErrTable() {
		PreparedStatement ps =null;
		Connection conn = null;
		String sql = null;
		try {
			conn = ARE.getDBConnection(PIDRConstants.DATASOURCE_PIDR);
			sql = "delete from pidr_int_error";
			ps = conn.prepareStatement(sql);
			ps.executeUpdate();				
		} catch (SQLException e) {
			ARE.getLog().error("上传文件之前清空重复主键表失败",e);
		}finally {
			CloseManager.closeResource(ps);
			CloseManager.closeResource(conn);
		}		
		
		
	}
	
	/**
	 * 格式化获取到的数据
	 * @param cell
	 * @return
	 */
	public Object getCellValue(Cell cell) {
		Object value = null;
		DecimalFormat dFormat = new DecimalFormat("0");
		if (cell!=null) {
			cell.setCellType(CellType.STRING);
			switch (cell.getCellType()) {
			case STRING:
				value = cell.getRichStringCellValue().getString();
				break;
			case NUMERIC:
				if ("General".equals(cell.getCellStyle().getDataFormatString())) {
					value = dFormat.format(cell.getNumericCellValue());
				}else if ("m/d/yy".equals(cell.getCellStyle().getDataFormatString())) {
					value = sdf.format(cell.getNumericCellValue());
				}else {
					value = dFormat.format(cell.getNumericCellValue());
				}
				break;
			case BOOLEAN:
				value = cell.getBooleanCellValue();
				break;
			case BLANK:
				value = "";
			case FORMULA://单元格内存在函数
				try {
					value = String.valueOf(cell.getStringCellValue());
				} catch (Exception e) {
					value = String.valueOf(cell.getNumericCellValue());
				}
				
			default:
				break;
			}
		}else {
			value = "";
		}
		return value;
	}
	
	/**
	 * 数据入库语句拼接
	 * @param list
	 * @param tableName
	 */
	public void datacopy(List<Map<String, String>> list, String tableName) throws Exception {
		PreparedStatement ps =null;
		ResultSet rs = null;
		PreparedStatement ps1 =null;
		ResultSet rs1 = null;
		Connection conn = null;
		int lineNm = 0;//处理条数
		boolean ifExit = false;//是否存在主键冲突数据
		List<String> listSql=new ArrayList<String>();		
		Map<String, String> map = new HashMap<>();
		String errSql = null;//插入主键冲突错误表sql
		String serialNo = null;
		try {
			conn = ARE.getDBConnection(PIDRConstants.DATASOURCE_PIDR);			
			for (int i = 0; i < list.size(); i++) {
				serialNo = DBKeyHelp.getSerialNo("pidr_int_error","serialNo");
				errSql = "insert into pidr_int_error (SERIALNO,TABLENAME,ERRORKEY,ERRORKEYVALUE,OCCURDATE) values(?,?,?,?,?)";
				ps1 = conn.prepareStatement(errSql);
				ps1.setString(1, serialNo);
				ps1.setString(2, tableName);
				ifExit = false;
				map = list.get(i);
				StringBuffer sql= new StringBuffer();//拼接插入接口表数据sql
				StringBuffer sqlVaules= new StringBuffer();//拼接插入接口表数据sql
				sql.append(" insert into "+ tableName +" (");
				String keySql = null;//查询主键sql
				if (PIDRConstants.TABLE_PIDR_INT_ENTINFO.equals(tableName)) {
					String customerID =  map.get("CustomerID");
					keySql = "select 1 from "+tableName+" where customerID = ?";
					ps = conn.prepareStatement(keySql);
					ps.setString(1,customerID);
					rs = ps.executeQuery();
					if (rs.next()) {
						ifExit = true;
						ps1.setString(3, "customerID");
						ps1.setString(4, customerID);
					}
				}else if (PIDRConstants.TABLE_PIDR_INT_BUSIINFO.equals(tableName)) {
					String dueCode =  map.get("DueCode");
					keySql = "select 1 from "+tableName+" where dueCode = ?";
					ps = conn.prepareStatement(keySql);
					ps.setString(1,dueCode);
					rs = ps.executeQuery();
					if (rs.next()) {
						ifExit = true;
						ps1.setString(3, "dueCode");
						ps1.setString(4, dueCode);
					}
				}else if ((PIDRConstants.TABLE_PIDR_INT_MNSHAHODINFO+"@"+PIDRConstants.TABLE_PIDR_INT_INVABROINFO+"@"+PIDRConstants.TABLE_PIDR_INT_NEGINFO).indexOf(tableName)!=-1) {
					String relaId =  map.get("RelaId");
					String customerID =  map.get("CustomerID");
					keySql = "select 1 from "+tableName+" where relaId = ? and  customerID = ?";
					ps = conn.prepareStatement(keySql);
					ps.setString(1,relaId);
					ps.setString(2,customerID);
					rs = ps.executeQuery();
					if (rs.next()) {
						ifExit = true;	
						ps1.setString(3, "relaId@customerID");
						ps1.setString(4, relaId+"@"+customerID);
					}
				}else if ((PIDRConstants.TABLE_PIDR_INT_BALANCESHEET+"@"+PIDRConstants.TABLE_PIDR_INT_INCOME+"@"+PIDRConstants.TABLE_PIDR_INT_CASHFLOW+"@"+PIDRConstants.TABLE_PIDR_INT_FINSTATEMENT).indexOf(tableName)!=-1) {
					String customerID =  map.get("CustomerID");
					String stage =  map.get("Stage");
					keySql = "select 1 from "+tableName+" where customerID = ? and Stage = ?";
					ps = conn.prepareStatement(keySql);
					ps.setString(1,customerID);
					ps.setString(2,stage);
					rs = ps.executeQuery();
					if (rs.next()) {
						ifExit = true;
						ps1.setString(3, "customerID@stage");
						ps1.setString(4, customerID+"@"+stage);
					}
				}					
				if (ifExit==true) {//当存在主键冲突数据
					ps1.setString(5, sdf.format(new Date()));
					int res = ps1.executeUpdate();
					resint = PIDRConstants.IMPORTRESULT_0;
					ARE.getLog().info("存在"+res+"条主键冲突的数据，已记录到错误表中。");
					continue;
				}
				Set<Map.Entry<String, String>> liStrings = map.entrySet();
				for (Entry<String, String> str : liStrings) {
					sql.append(str.getKey()+",");//遍历表中获取到的字段名拼接
					if (str.getValue().length() == 0) {//字段值为空，拼接null
						sqlVaules.append("null,");
						continue;
					}
					sqlVaules.append("'"+str.getValue()+"',");//遍历表中获取到的数据拼接
				}
				if (sqlVaules.length() == 0) {//空白数据跳过
					continue;
				}
				//删除拼接最后的逗号
				sqlVaules.deleteCharAt(sqlVaules.length()-1);
				sql.deleteCharAt(sql.length()-1);
				sql.append(") Values(").append(sqlVaules).append(")");
				String endSql=new String(sql);
				listSql.add(endSql);
				lineNm++;
	
				if(lineNm % parserReportNumber == 0) {
					getInsertSQL(listSql,lineNm);
					listSql.clear();
				}
			}
		} catch (SQLException e) {
			ARE.getLog().error("查询主键冲突出错",e);
		} catch (Exception e) {
			ARE.getLog().error("生成错误表主键出错",e);
		} finally {
			CloseManager.closeResource(conn);
			CloseManager.closeResource(ps);
			CloseManager.closeResource(rs);
			CloseManager.closeResource(ps1);
			CloseManager.closeResource(rs1);
		}
		ARE.getLog().info("当前文件读取完毕,共计处理了"+lineNm+"行文本数据");
		getInsertSQL(listSql,lineNm);
	}
	
	/**
	 * 数据入库
	 * @param listSql
	 * @param lineNm
	 * @throws SQLException 
	 */
	public void getInsertSQL(List<String> listSql,int lineNm) throws Exception {
		if(listSql.size()>0) {
			try {
					if(connection==null)connection = ARE.getDBConnection(PIDRConstants.DATASOURCE_PIDR);//每读一个文件获取一次连接
					connection.setAutoCommit(false);
					if(pstatement==null)pstatement = connection.createStatement();
					for(int i=0;i<listSql.size();i++) {
						pstatement.addBatch(listSql.get(i).toString());
					}
					pstatement.executeBatch();				
					//若没有主键冲突则返回正常
					if (resint != PIDRConstants.IMPORTRESULT_0) {
						resint = PIDRConstants.IMPORTRESULT_1;
					}
					connection.commit();
					pstatement.clearBatch();
			}catch (Exception e){
				ARE.getLog().error("执行executeBatch失败,当前为"+lineNm+"行数据,请排查当前入库数据是否存在错误!",e);
				try {
					connection.rollback();
				} catch (SQLException e1) {
					ARE.getLog().error("回滚提交失败",e);
				}finally {
					throw e;//向上层抛出异常，方便处理
				}
			}
		}
	}

}
