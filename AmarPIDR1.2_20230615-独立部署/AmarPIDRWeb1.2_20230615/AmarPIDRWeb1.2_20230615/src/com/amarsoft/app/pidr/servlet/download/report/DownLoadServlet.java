package com.amarsoft.app.pidr.servlet.download.report;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.UnsupportedEncodingException;
import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.amarsoft.are.ARE;
import com.amarsoft.are.util.SpecialTools;
import com.amarsoft.awe.RuntimeContext;
/** 
 * 	@author hcliu
* 	@Description: 实现报文下载
*  	@date: 2023-02-22
*/
public class DownLoadServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public void doGet(HttpServletRequest request, HttpServletResponse response){
		//设置编码格式，否则获取中文值时会乱码
			try {
				request.setCharacterEncoding("UTF-8");
				HttpSession session = request.getSession();
				
			    RuntimeContext CurARC = (RuntimeContext)session.getAttribute("CurARC");
		//	    String sNowDate=new SimpleDateFormat("yyyyMMdd").format(new Date()).toString();
				//已对该参数进行处理
			    String file = SpecialTools.amarsoft2Real(request.getParameter("fileName")); 
			    String pathFlag ="";
			    if(file == null){
			    	file = "";
			    }else{
			    	String [] fileNameArray = file.split("/");
			    	pathFlag = fileNameArray[fileNameArray.length-2];
			    }
				
				ARE.getLog().info("报文文件下载pathFlag为"+pathFlag);
				
				if(file==null){
					throw new IOException("没有传递要下载的文件！");
				}
				file = java.net.URLDecoder.decode(file,"UTF-8");
				File f = new File(file);
					
				String fileName = new String(f.getName().getBytes("GBK"),"ISO-8859-1");
				
				ARE.getLog().info("用户"+CurARC.getUser().getUserID()+"正在下载"+file);
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
					if(is!=null&&os!=null){
					   while((l=is.read(buffer))>0) os.write(buffer,0,l);
					}
				}catch (UnsupportedEncodingException e) {
					try{
						response.reset();
						response.setHeader("Content-Disposition", "");
						response.setContentType("text/html;charset=GBk");
						String errorInfo = "文件不存在，请联系系统管理员！";
						errorInfo = new String(errorInfo.getBytes("GBK"),"ISO-8859-1");
				        ServletOutputStream outStream = response.getOutputStream();
				        outStream.println("<script>alert('"+errorInfo+"');</script>");
				        outStream.flush();
				        outStream.close();
					}catch(Exception e2){
					    ARE.getLog().error(e2);
					}
				}finally{
					if(is!=null) {
					    try{
					        is.close();
					    }catch(IOException e) {
		                    ARE.getLog().error("关闭流出现错误"+e);
		                }
					}
					if(os!=null) {
					    try{
					        os.flush();
					        os.close();
					    }catch(IOException e) {
                            ARE.getLog().error("关闭流出现错误"+e);
                        }
					}
				}
					
			}catch(Throwable t){
				ARE.getLog().error("caught throwable at top level");
			}
	}

	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request, response);
	}
	
	public static void safeClose(InputStream is) {
		  if (is != null) {
		    try {
		      is.close();
		    } catch (IOException e) {
		    	ARE.getLog().error(e);
		    }
		  }
		}
}