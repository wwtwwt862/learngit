package com.amarsoft.app.pidr.whitelist;

import java.io.File;
import java.io.IOException;
import java.net.MalformedURLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.amarsoft.app.pidr.codemanage.servlet.batchImp.FileUpload;
import com.amarsoft.app.pidr.codemanage.servlet.batchImp.ItemFile;
import com.amarsoft.app.pidr.common.PIDRConstants;
import com.amarsoft.are.ARE;
import com.amarsoft.awe.Configure;
import com.amarsoft.awe.RuntimeContext;
import com.amarsoft.osf.server.ParameterUtil;
/**
 * 白名单文件的上传解析
 */
@WebServlet(name="WhiteUpLoad" ,urlPatterns="/WhiteUpLoad")
public class WhiteUpLoadServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException{
		   this.doPost(request, response);
	}
	public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException{
		ARE.getLog().info("当前为白名单上传文件解析的入口开始");
		String compClientID = (String)request.getParameter("CompClientID");
    	compClientID=ParameterUtil.getSafeParamter(compClientID);//解决安全扫描问题：进行参数验证,合并版可屏蔽此行代码
    	int a = 1;

		HttpSession session = request.getSession(false);
		if (session == null || session.getAttributeNames() == null) {
			throw new ServletException("------Timeout------"); 
		}	
		RuntimeContext curARC = (RuntimeContext)session.getAttribute("CurARC");
		String userID=curARC.getUser().getUserID();// 用户ID
		String orgID=curARC.getUser().getOrgID();//用户机构
		if (curARC == null) {
			throw new ServletException("------Timeout------"); 
		}
		Configure curConfig = Configure.getInstance(session.getServletContext());
		if (curConfig == null) {
			throw new ServletException("读取配置文件错误！请检查配置文件");
		}
        String savePath = "";
		try {
			savePath = curConfig.getFileSavePath();
		} catch (Exception e1) {
			ARE.getLog().debug("文件路径不存在");
			ARE.getLog().error(e1);
		}
        // 上传时生成的临时文件保存目录
		String path = "";
		try {
			path = request.getSession().getServletContext().getResource("/").getFile();
		} catch (MalformedURLException e2) {
			ARE.getLog().debug("获取项目真实路径失败");
			ARE.getLog().error(e2);
		}
        String tempPath = path+"/WEB-INF/temp";
        File tempFile = new File(tempPath);
        // 判断上传文件的保存目录是否存在
        if (!tempFile.exists()) {
            // 创建目录
            tempFile.mkdir();
        }
        // 上传消息提示
        try {
        	FileUpload fileUpLoad = new FileUpload();
        	fileUpLoad.init(session.getServletContext(), request, curConfig, curARC.getUser(),a,compClientID,savePath,tempFile);
        	try {
        		a = fileUpLoad.uploadFile();
        	}catch (Exception e) {
        		ARE.getLog().debug("上传出现问题!");
				a =  PIDRConstants.IMPORTRESULT_2;
				request.getRequestDispatcher("/PIDR/IntegatedQueryManage/WhiteListDataManage/WhiteImportExcel.jsp?CloseFlag="+a+"&CompClientID=" + compClientID).forward(request, response);
				return;
			}
        	if(PIDRConstants.IMPORTRESULT_1 == a) {
        		ItemFile itemFile= fileUpLoad.getFiles().get(0);
				//存在服务器的文件地址、文件名’
				String excelServerPath = "",saveFilename ="";
				excelServerPath = itemFile.getFileFullPath();
				saveFilename = itemFile.getFileName();
				ReadExcelWhiteList reWL = new ReadExcelWhiteList(excelServerPath);
				if (saveFilename.indexOf(".xls") < 0) {
					ARE.getLog().debug("获取的文件非要求的excel正确格式");
					a =  PIDRConstants.IMPORTRESULT_3;
					request.getRequestDispatcher("/PIDR/IntegatedQueryManage/WhiteListDataManage/WhiteImportExcel.jsp?CloseFlag="+a+"&CompClientID=" + compClientID).forward(request, response);
					return;
				} 
				reWL.readExcel();
				// 处理数据
				int result=4;
				if(reWL.isSuccess())result=1;
				if (result==PIDRConstants.IMPORTRESULT_4) {
					ARE.getLog().debug("解析出现异常!");
					a =  PIDRConstants.IMPORTRESULT_4;
					request.getRequestDispatcher("/PIDR/IntegatedQueryManage/WhiteListDataManage/WhiteImportExcel.jsp?CloseFlag="+a+"&CompClientID=" + compClientID).forward(request, response);
					return;
				}
				request.getRequestDispatcher("/PIDR/IntegatedQueryManage/WhiteListDataManage/WhiteImportExcel.jsp?CloseFlag="+a+"&CompClientID=" + compClientID).forward(request, response);
			}
        } catch (Throwable e) {
        	 ARE.getLog().error("caught throwable at top level");
            a = PIDRConstants.IMPORTRESULT_6;
			try {
				request.getRequestDispatcher("/PIDR/IntegatedQueryManage/WhiteListDataManage/WhiteImportExcel.jsp?CloseFlag="+a+"&CompClientID=" + compClientID).forward(request, response);
			} catch (ServletException e1) {
				ARE.getLog().error(e1);
			} catch (IOException e1) {
				ARE.getLog().error(e1);
			}
			return;
        }
	}
}
