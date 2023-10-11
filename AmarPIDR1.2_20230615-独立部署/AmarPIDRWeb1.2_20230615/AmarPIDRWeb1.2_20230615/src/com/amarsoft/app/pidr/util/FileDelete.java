package com.amarsoft.app.pidr.util;

import java.io.File;
import java.sql.SQLException;
/**
 * 
 * @author hcliu
 * @Description: 刪除文件工具类
 * @date 2023-02-22 
 */
public class FileDelete {
	private String fileName;

	public String getFileName() {
		return fileName;
	}

	public void setFileName(String fileName) {
		this.fileName = fileName;
	}
	
	/**
	 * 删除文件
	 * @param 
	 * @return boolean
	 * @throws
	 */
	public String deleteFile() {
		String flag = "false";
		File file = new File(fileName);
		if(file.exists()&&file.isFile()){
			boolean deleteFlag = file.delete();
			if(deleteFlag){
				flag = "true";
			}
		}
		return flag;
	}
}