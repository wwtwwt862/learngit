package com.amarsoft.app.pidr.whitelist;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.UnsupportedEncodingException;

import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.amarsoft.are.ARE;
import com.amarsoft.awe.RuntimeContext;
/**
 * 白名单模板文件的下载
 */
@WebServlet(name="WhiteDownLoad" ,urlPatterns="/WhiteDownLoad")
public class WhiteDownLoadServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	public void doGet(HttpServletRequest request, HttpServletResponse response){
		ARE.getLog().info("当前为白名单模板下载文件入口");
		//设置编码格式，否则获取中文值时会乱码
		try {
			String homePath=request.getSession().getServletContext().getResource("/").getFile();
			request.setCharacterEncoding("UTF-8");
			String fileType=request.getParameter("fileType");
			String tableName=request.getParameter("tableName");
			boolean isTempFlag=Boolean.parseBoolean(request.getParameter("isTemp"));
			String filePath="";
			HttpSession session = request.getSession();
			// 公司框架获取用户信息的
		    RuntimeContext CurARC = (RuntimeContext)session.getAttribute("CurARC");
			//已对该参数进行处理
		    filePath=homePath+"/WEB-INF/etc/batchImp/TemplateFile/WhiteList.xls";
			if(filePath==""){
				throw new IOException("没有传递要下载的文件！");
			}
			File f = new File(filePath);
			String fileName = new String(f.getName().getBytes("GBK"),"ISO-8859-1");
			ARE.getLog().info("用户"+CurARC.getUser().getUserID()+"正在下载"+filePath);
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
	                    ARE.getLog().error("关闭输出流出现错误"+e);
	                }
				}
				if(os!=null) {
				    try{
				        os.flush();
				        os.close();
				    }catch(IOException e) {
                        ARE.getLog().error("关闭输入流出现错误"+e);
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
}
