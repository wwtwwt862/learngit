package com.amarsoft.app.pidr.servlet.download.report;

import java.io.BufferedInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.UnsupportedEncodingException;
import java.util.zip.CRC32;
import java.util.zip.CheckedOutputStream;
import java.util.zip.ZipEntry;
import java.util.zip.ZipOutputStream;

import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.amarsoft.app.pidr.util.PathCharWhiteUtil;
import com.amarsoft.are.ARE;
import com.amarsoft.are.util.SpecialTools;
import com.amarsoft.awe.RuntimeContext;
import com.amarsoft.awe.control.model.ParameterUtil;
/** 
 * 	@author hcliu
* 	@Description: 实现同期报文批量下载
*  	@date: 2023-02-22
*/
public class DownLoadBatchServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private static final int BUFFER = 1024; 
	
	public void doGet(HttpServletRequest request, HttpServletResponse response) {
		try{
		//设置编码格式，否则获取中文值时会乱码
		if(compressBatchReportSelected(request,response)) {
			try {
				request.setCharacterEncoding("UTF-8");
				HttpSession session = request.getSession();
			    RuntimeContext CurARC = (RuntimeContext)session.getAttribute("CurARC");
				//已对该参数进行处理
			    String sFileName = SpecialTools.amarsoft2Real(request.getParameter("fileName"));
			    String pathFlag ="";
			    if(sFileName == null){
			    	 sFileName = "";
			     }else{
			    	 String [] fileNameArray = sFileName.split("/");
			    	 pathFlag = fileNameArray[fileNameArray.length-2];
			     }
				
				ARE.getLog().info("报文文件下载pathFlag为"+pathFlag);
				
				if(sFileName==null){
					throw new IOException("没有传递要下载的文件！");
				}
				sFileName = java.net.URLDecoder.decode(sFileName,"UTF-8");
				File f = new File(sFileName);
					
				String fileName = new String(f.getName().getBytes("GBK"),"ISO-8859-1");
				
				ARE.getLog().info("用户"+CurARC.getUser().getUserID()+"正在下载"+sFileName);
				//下载
				response.reset();
				//response.setContentType("application/octet-stream");
				//解决https下载问题

				response.setContentType("application/octet-stream;charset=gbk");
				response.setHeader("Content-Disposition", "attachment; filename="+fileName);
				response.addHeader("Pragma","public");
				response.addHeader("Cache-Control","max-age=0");
				response.setContentLength((int)f.length());
					
				//设置输出流
				OutputStream os = null;
				InputStream is = null;
				try{
					os = response.getOutputStream();
					is = new FileInputStream(f);
					byte buffer[] = new byte[1024];
					int l = 0;
					//写出
					while((l=is.read(buffer))>0) os.write(buffer,0,l);
				}finally{						
					if(is!=null) {
					    try {
					        is.close();			
					    }catch(IOException e) {
					        ARE.getLog().error("关闭流出现错误"+e);
					    }
					}
					if(os!=null) {
					    try {
					        os.flush();
					        os.close();
					    }catch(IOException e) {
                            ARE.getLog().error("关闭流出现错误"+e);
                        }
					}
				}
			} catch (UnsupportedEncodingException e) {
				try{
					response.reset();
					response.setHeader("Content-Disposition", "");
					response.setContentType("text/html;charset=GBK");
					String errorInfo = "文件不存在，请联系系统管理员！";
					errorInfo = new String(errorInfo.getBytes("GBK"),"ISO-8859-1");
			        ServletOutputStream outStream = response.getOutputStream();
			        outStream.println("<script>alert('"+errorInfo+"');</script>");
			        outStream.flush();
			        outStream.close();
				}catch(Exception e2){
				    ARE.getLog().error(e2);
				}
			} catch (Exception e) {
			    ARE.getLog().error(e);
			}
		}else {
			ARE.getLog().debug("文件打包压缩出现异常!");
			return ;
		}
		}catch (Throwable t){
			ARE.getLog().error("caught throwable at top level");
		}
	}

	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request, response);
	}
	
	/**
	 * 描述：java压缩文件</br>
	 * 功能：java实现循环读取并压缩文件</br>
	 * @param:zipOS为传入ZipOutputStream对象;srcPath为传入的要压缩文件所在路径；BatchFileName为传入的要批量压缩下载的文件名
	 
	 */
	public boolean zipBatchReportSelected(ZipOutputStream zipOS,String srcPath,String BatchFileName) {

		String[] vBatchFileNameArr = BatchFileName.split("@");
		File file = null;
		BufferedInputStream bis = null;
		ZipEntry zipEntry = null;
		try {
			
			for (int i = 0; i < vBatchFileNameArr.length; i++) {
				String srcPathName = srcPath + File.separator + vBatchFileNameArr[i]; // 目录拼接被选中下载的文件名
				ARE.getLog().info("批量下载的文件为：" +srcPathName);
				file = new File(PathCharWhiteUtil.pathCharWhite(ParameterUtil.filterPath(srcPathName)));
				if (!file.exists()) { // 如果被选中下载的文件在相应目录中不存在，则跳过本次循环
					continue;
				}

				bis = new BufferedInputStream(new FileInputStream(file)); // 根据被下载文件实例化FileInputStream,准备把原始文件读入输入流中
				zipEntry = new ZipEntry(file.getName());
				zipOS.putNextEntry(zipEntry);

				int count;
				byte[] data = new byte[BUFFER];
				while ((count = bis.read(data)) != -1) {
					zipOS.write(data, 0, count);
				}
			}
			return true;
		} catch (IOException e) {
			ARE.getLog().error("批量打包压缩文件出现问题!");
			return false;
		} finally {
			if(bis!=null) {
			    try{
			        bis.close();
			    }catch(IOException e) {
                    ARE.getLog().error("关闭流出现错误"+e);
                }
			}
			if (zipOS != null) {
			    try {
		             zipOS.flush();
		             zipOS.closeEntry();
			    }catch(IOException e) {
                    ARE.getLog().error("关闭流出现错误"+e);
                }

			}
		}
	}
	
	/**
	 * 描述：java压缩文件，压缩预准备，调用zipBatchReportSelected方法实现</br>
	 * 功能：java实现打包压缩文件入口方法，定义压缩文件路径及名</br>
	 * @param:request为传入HttpServletRequest对象;response为传入的HttpServletResponse对象
	 
	 */
	public boolean compressBatchReportSelected(HttpServletRequest request, HttpServletResponse response) {   //批量压缩被选中报文，调用zipBatchReportSelected方法实现
		File file = null;
		String zipPathName = "";
		FileOutputStream fos = null;
		ZipOutputStream zipOS = null;
		try {
			request.setCharacterEncoding("UTF-8");
			if(request.getParameter("fileName")!=null){
			zipPathName = SpecialTools.amarsoft2Real(request.getParameter("fileName"));
			}
			file = new  File(zipPathName);
            if (file.exists()) {  //如果在压缩前目录中已存在压缩文件名，则先把之前文件删除
            	if(!file.delete()){
            		return false;
            	}
            }
            String zipPath = file.getParent(); // 取出报文路径

			String vBatchFileName = request.getParameter("batchFileName"); // 从jsp页面获取批量下载文件名，多个文件使用@拼接
            ARE.getLog().info("报文存放路径为："+zipPath);
		    fos = new FileOutputStream(zipPathName);   //根据要写入压缩包的文件名实例化FileOutputStream对象
			CheckedOutputStream cos = new CheckedOutputStream(fos, new CRC32());
			zipOS = new ZipOutputStream(cos);
			if (vBatchFileName !=null){
			    if (zipBatchReportSelected(zipOS,zipPath,vBatchFileName)) {
				   return true;
			    } 
			}
		} catch (Exception e) {
			ARE.getLog().error("批量打包压缩文件出现问题!");
			return false;
		} finally {
			try {
				if (zipOS != null) {
					zipOS.close();
				}
				if (fos != null) {
					fos.close();
				}
			} catch (IOException e) {
			    ARE.getLog().error(e);
			}
		}
		return false;
	}
}