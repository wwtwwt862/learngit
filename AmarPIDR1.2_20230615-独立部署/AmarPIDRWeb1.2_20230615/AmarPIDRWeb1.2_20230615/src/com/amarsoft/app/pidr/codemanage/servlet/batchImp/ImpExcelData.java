package com.amarsoft.app.pidr.codemanage.servlet.batchImp;

import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.poifs.filesystem.POIFSFileSystem;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellType;
import org.apache.poi.ss.usermodel.Row;

import com.amarsoft.app.pidr.common.PIDRConstants;
import com.amarsoft.are.ARE;

/**
 * 根据模板解析文件
 * @author jyshen
 * @since 2023-02-15
 */
public class ImpExcelData {
	private POIFSFileSystem poiFS = null;
	//Excel工作平台poi对象
	private HSSFWorkbook workBook = null;
	//Excel sheet对象
	private HSSFSheet sheet = null;
	private HSSFRow row = null;
	private FileInputStream fis = null;
	
	private Connection conn = null;
	private PreparedStatement pstmt = null;
	private ResultSet rs = null;
	
	/**
	 * 获取Sheet
	 * @param sheetName
	 * @param dataExcelFile
	 * @return
	 */
	public HSSFSheet getSheet(String sheetName, String dataExcelFile) {
		try {
			ARE.getLog().info("获取模板为：" + dataExcelFile);
			fis = new FileInputStream(dataExcelFile);
			this.poiFS = new POIFSFileSystem(this.fis);
			this.workBook = new HSSFWorkbook(this.poiFS);
			this.sheet = this.workBook.getSheetAt(0);
			return this.sheet;
		}catch (RuntimeException e){
			ARE.getLog().error(e);
			throw e;
		}catch (FileNotFoundException e) {
			ARE.getLog().error("未找到文件");
			return null;
		} catch(IOException e){
			ARE.getLog().error("文件解析失败");
			return null;
		} finally {
			if (null != this.fis) {
				try {
					this.fis.close();
					ARE.getLog().info("fis已被关闭");
				} catch (IOException e) {
					ARE.getLog().error("fis关闭失败");
				}
			}
		}
	}

	/**
	 * excel配置
	 * @param sheetName
	 * @param dataExcelFile
	 * @return
	 * @throws IOException
	 */
	public boolean parseExcel(String sheetName, String dataExcelFile) throws IOException {
		if (!initDB()) { // 初始化数据库
			ARE.getLog().debug("获取数据库连接出现异常!");
			return false;
		}

		StringBuilder buffInsert = new StringBuilder();

		buffInsert.append("insert into ");
		this.sheet = getSheet(sheetName, dataExcelFile);
		int iRowNum = 0;
		int iCellCount = 0;
		String keyStr = "";
		if (this.sheet != null) {
			this.row = this.sheet.getRow(0); // excel第0行配置信息为表名,主健
			keyStr = this.row.getCell(5).getStringCellValue(); // 获取主健字符串

			String tableName = this.row.getCell(1).getStringCellValue();
			ARE.getLog().info("获取的表名为:" + tableName);
			buffInsert.append(tableName); // 拼接表名

			buffInsert.append(" ("); // 拼接左括号
			this.row = this.sheet.getRow(2); // 取得DB表头所在列；；excel第2行配置信息为DB表头字段

			ARE.getLog().info(("keyStr:" + keyStr));

			while (!("#").equals(this.row.getCell(iCellCount).getStringCellValue()
					)) {
				iCellCount++;
			}
			ARE.getLog().info("表头总字段数为：" + (iCellCount - 1));
			for (int iHeadNum = 1; iHeadNum < iCellCount; iHeadNum++) { // 拼接DB表头
				if (iHeadNum != 1) {
					buffInsert.append(","); // 若不是第一个字段和最后一个字段，则先拼接","
				}
				buffInsert.append(this.row.getCell(iHeadNum)
						.getStringCellValue().trim());
			}

			buffInsert.append(") values ("); // 拼接右括号及values(

			for (int iHeadNum = 1; iHeadNum < iCellCount; iHeadNum++) { // 拼接"?"
				if (iHeadNum != 1) {
					buffInsert.append(","); // 若不是第一个字段和最后一个字段，则先拼接","
				}
				buffInsert.append("?");
			}

			buffInsert.append(")"); // 拼接右括号
			
			FileOutputStream fos = null;
			try {
				this.conn.setAutoCommit(false);
				this.pstmt = this.conn.prepareStatement(buffInsert.toString()); // insert
																				// sql绑定
																				// PreparedStatement对象
				ARE.getLog().info("拼接的insert SQL语句:" + buffInsert.toString());
				
				for(int i = 1;i<=this.sheet.getLastRowNum();) {//防止空行被识别为有效行的影响
                    Row row = this.sheet.getRow(i);
                    Cell cell = null;
                    if(row!=null) {
                        cell = row.getCell(1);//括号中是确认不为空的一列，从0开始算，该处为1的意思是某一行第二列要是空，下面判断会作为空行处理
                    }
                    if(row==null||cell==null||cell.getStringCellValue().trim().length()==0) {
                        if (row == null) 
                            row = this.sheet.createRow(i);//若行为null，要先创建
                        if(i>=0) 
                            this.sheet.removeRow(row);
                        if(i<this.sheet.getLastRowNum())
                            this.sheet.shiftRows(i+1, this.sheet.getLastRowNum(), -1);
                        fos = new FileOutputStream(dataExcelFile);
                        this.workBook.write(fos);
                    }else {
                        i++;
                    }
                }
				
				iRowNum = this.sheet.getLastRowNum();
				ARE.getLog().info("【excel实际行数】:" + iRowNum);

				ARE.getLog().info("【填充的excel总记录数为】：" + (iRowNum - 2));
				for (int rowIdx = 3; rowIdx <= iRowNum; rowIdx++) { // 循环遍历excel每行填充的数据，得判断是否存在
					this.row = this.sheet.getRow(rowIdx);
					// 判断row为null情况
					if (this.row == null) {
						this.sheet.createRow(rowIdx);
					}

					for (int cellIdx = 1; cellIdx < iCellCount; cellIdx++) {

						// 判断cell为null情况
						if (this.row.getCell(cellIdx) == null) {
							this.row.createCell(cellIdx).setCellValue("");
						}

						this.row.getCell(cellIdx).setCellType(
								CellType.STRING);
						setPreparedInsertSql(this.pstmt, cellIdx, this.row
								.getCell(cellIdx).getStringCellValue().trim());
					}
					String valueStr = "";
					StringBuffer buffer = new StringBuffer();
					for (int j = 1; j <= keyStr.split("#").length; j++) { // 拼接value值
						if (j != 1) {
							buffer.append("#");
						}
						buffer.append(this.row.getCell(j+1).getStringCellValue());
					}
					valueStr = buffer.toString();
					String[] str = valueStr.split("#");
					for (int i = 0; i < str.length; i++) {
						if ("".equals(str[i]) || str[i] == null) {
							return false;
						}
					}
					ARE.getLog().info("valueStr:" + valueStr);

					if (checkDataExists(this.conn, tableName, keyStr, valueStr)) {
						delData(this.conn, tableName, keyStr, valueStr);
						ARE.getLog().info("-----------已存在该记录");
					}
					this.pstmt.executeUpdate();
				}
				this.conn.commit();
				clearResource(this.conn, this.pstmt);
				return true;
			} catch (SQLException e) {
				clearResource(this.conn, this.pstmt);
				ARE.getLog().debug("数据库操作出现异常!");
				return false;
			}finally {
			    if (fos != null) {
                    try {
                        fos.close();
                    }catch (IOException e){
                        ARE.getLog().error("关闭流出现错误"+e);
                    }
                }
            }
		}
		return false;
	}

	
	public void setPreparedInsertSql(PreparedStatement pstmt, int indx,
			String columnValue) {
		try {
			pstmt.setString(indx, columnValue);
		} catch (SQLException e) {
			ARE.getLog().error("插入失败");
		}
	}

	
	public void delData(Connection conn, String tableName, String keyStr,
			String value) {
		StringBuilder buff = new StringBuilder();
		String[] keyArr = keyStr.split("#");
		String[] valueArr = value.split("#");
		buff.append("delete from " + tableName + " where ");
		for (int i = 0; i < keyArr.length; i++) {
			if (i != 0) {
				buff.append(" and ");
			}
			buff.append(keyArr[i] + "='" + valueArr[i] + "'");
		}
		ARE.getLog().info("拼接的delete SQL语句:" + buff.toString());
		try(PreparedStatement pstmt = conn.prepareStatement(buff.toString())){
			pstmt.executeUpdate();
			conn.commit();
		} catch (SQLException e) {
			ARE.getLog().error("清理资源失败");
		}
	}

	
	public boolean checkDataExists(Connection conn, String tableName,
			String keyStr, String value) {
		StringBuilder buff = new StringBuilder();
		String[] keyArr = keyStr.split("#");
		String[] valueArr = value.split("#");
		buff.append("select 1 from " + tableName + " where ");
		for (int i = 0; i < keyArr.length; i++) {
			if (i != 0) {
				buff.append(" and ");
			}
			buff.append(keyArr[i] + "='" + valueArr[i] + "'");
		}
		
		ARE.getLog().info("拼接的select SQL语句:" + buff.toString());
		try(PreparedStatement pstmt = conn.prepareStatement(buff.toString())){
			rs = pstmt.executeQuery();

			if (rs.next()) {
				return true;
			}
		} catch (SQLException e) {
			ARE.getLog().error("清理资源失败");
		}
		return false;
	}

	
	public boolean initDB() {
		try {
			this.conn = ARE.getDBConnection(PIDRConstants.DATASOURCE_PIDR);
			return true;
		} catch (SQLException e) {
			ARE.getLog().debug("数据库连接异常!");
			return false;
		}
	}

	
	public void clearResource(Connection conn, PreparedStatement pstmt) {
		try {
		    if (rs !=null) {
                rs.close();
            }
		    
			if (pstmt != null) {
				pstmt.close();
			}
			if (conn != null) {
				conn.close();
			}
		} catch (SQLException e) {
			ARE.getLog().error("关闭资源失败");
		}
	}
}