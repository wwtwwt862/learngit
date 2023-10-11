package com.amarsoft.app.pidr.feedback.servlet.upload;

import java.io.File;
import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.amarsoft.app.pidr.common.PIDRConstants;
import com.amarsoft.app.pidr.feedback.servlet.upload.FileUpload;
import com.amarsoft.are.ARE;
import com.amarsoft.awe.Configure;
import com.amarsoft.awe.RuntimeContext;
import com.amarsoft.awe.control.model.ParameterUtil;
/**
 * 上传反馈文件处理 
 * @author kwwu
 * @date 2023-02-24
 */
public class PidrFeedbackFileUploadServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		String compClientID = (String)request.getParameter("CompClientID");
		compClientID=ParameterUtil.getSafeParamter(compClientID);//解决安全扫描问题：进行参数验证,合并版可屏蔽此行代码
		String sFileName = (String)request.getParameter("FileName");//上传的文件名
		if(sFileName == null) sFileName = "";
    	int a = PIDRConstants.IMPORTRESULT_1;
		HttpSession session = request.getSession(false);
		if (session == null || session.getAttributeNames() == null) {
			throw new ServletException("------Timeout------"); 
		}	
		RuntimeContext curARC = (RuntimeContext)session.getAttribute("CurARC");
		if (curARC == null) {
			throw new ServletException("------Timeout------"); 
		}
		Configure curConfig = Configure.getInstance(session.getServletContext());
		if (curConfig == null) {
			throw new ServletException("读取配置文件错误！请检查配置文件");
		}
		
		String savePath = ARE.getProperty("PIDRUploadFeedbackFilePath");//反馈报文存储路径
        
        // 上传时生成的临时文件保存目录
        String tempPath = request.getSession().getServletContext().getResource("/").getFile() + "/WEB-INF/temp";
        File tempFile = new File(tempPath);
        // 判断上传文件的保存目录是否存在
        if (!tempFile.exists()) {
            // 创建目录
            tempFile.mkdir();
        }
        // 上传消息提示
        FileUpload fileUpLoad = new FileUpload();
    	fileUpLoad.init(session.getServletContext(), request, curConfig, curARC.getUser(),a,compClientID,savePath,tempFile);
    	try {
    		a = fileUpLoad.uploadFile();
    	}catch (Exception e) {
    		ARE.getLog().debug("上传出现问题!");
			a =  PIDRConstants.IMPORTRESULT_2;
			request.getRequestDispatcher("/PIDR/FileManage/FeedbackReportFile/FeedbackReportUpload.jsp?CloseFlag="+a+"&CompClientID=" + compClientID).forward(request, response);
			return;
		}
        request.getRequestDispatcher("/PIDR/FileManage/FeedbackReportFile/FeedbackReportUpload.jsp?CloseFlag="+a+"&CompClientID=" + compClientID).forward(request, response);//上传成功
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}