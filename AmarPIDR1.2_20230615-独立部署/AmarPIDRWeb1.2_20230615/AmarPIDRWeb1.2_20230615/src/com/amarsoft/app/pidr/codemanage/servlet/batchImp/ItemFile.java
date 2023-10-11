package com.amarsoft.app.pidr.codemanage.servlet.batchImp;
/**
 *单个文件
 * @author jyshen
 *
 */
public class ItemFile {

	private String fileName;//文件名
	private String fileExtName;//文件扩展名
	private String fileFullPath;//文件全路径
	public String getFileName() {
		return fileName;
	}
	public void setFileName(String fileName) {
		this.fileName = fileName;
	}
	public String getFileExtName() {
		return fileExtName;
	}
	public void setFileExtName(String fileExtName) {
		this.fileExtName = fileExtName;
	}
	
	public String getFileFullPath() {
		return fileFullPath;
	}
	public void setFileFullPath(String fileFullPath) {
		this.fileFullPath = fileFullPath;
	}
	@Override
	public String toString() {
		return "ItemFile [fileName=" + fileName + ", fileExtName=" + fileExtName + ", fileFullPath=" + fileFullPath + "]";
	}
	
}
