package com.amarsoft.app.pidr.util;

import java.io.File;

import com.amarsoft.are.ARE;

/** 
 * @author hcliu
* 	@Description: 判断文件是否存在
*  	@date: 2023-02-22
*/
public class FileIsExists {
	//文件名称
	public String file;

	public String getFile() {
		return file;
	}

	public void setFile(String file) {
		this.file = file;
	}

	/** 
	* @Title: fileIsExists 
	* @Description: 判断文件是否存在
	* @param @return    文件的绝对路径 
	* @return Boolean    返回类型 
	* @throws 
	*/
	public String fileIsExists(){
		file = file.replace("%2B", "+");
		boolean Return = new File(file).exists();
		if(Return){
			ARE.getLog().info("===文件："+file+"存在===");
			return "true";
		}else{
			ARE.getLog().info("===文件："+file+"不存在，路径有误或已被删除===");
			return "false";
		}
	}
}