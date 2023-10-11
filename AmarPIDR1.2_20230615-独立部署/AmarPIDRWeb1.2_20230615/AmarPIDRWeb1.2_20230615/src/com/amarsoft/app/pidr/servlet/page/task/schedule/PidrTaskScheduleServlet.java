package com.amarsoft.app.pidr.servlet.page.task.schedule;

import java.io.IOException;
import java.io.UnsupportedEncodingException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.amarsoft.app.pidr.util.RunTask;
import com.amarsoft.are.ARE;

/**
 * 后台调用批量
 * Servlet implementation class TaskScheduleServlet
 * @author yjkang
 * @date 2018-10-11
 */
public class PidrTaskScheduleServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response){
		try{
		try {
			request.setCharacterEncoding("UTF-8");
		} catch (UnsupportedEncodingException e) {
			ARE.getLog().error("设置编码失败");
		}
		callScriptPattern(request,response);
		}catch(Throwable t){
			ARE.getLog().error("caught throwable at top level");
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

	/**
	 * 直接调用脚本的方式(此方式为调用主程序class执行task)
	 * @param request
	 * @param response
	 */
	public void callScriptPattern(HttpServletRequest request, HttpServletResponse response) {
		// 传入脚本名称；；因为该类用于统一管理调度执行通常的批量任务(校验，迁移，报文生成，反馈解析)和自动上传下载功能，所以需要传入相应的脚本名称
		String vScriptName = request.getParameter("ScriptName");
		// 传入要执行的任务名称
		String vTaskName = request.getParameter("TaskName");
		if(vTaskName != null) vTaskName = vTaskName.toLowerCase();//确保任务名称小写，以用于调用批量脚本
		// 获取操作系统类别，便于选择执行相应脚本
		String vOS_Class = System.getProperty("os.name") == null ? "" : System.getProperty("os.name").toLowerCase();

		ARE.getLog().info("【脚本名称】-" + vScriptName + " 【执行任务名称】-" + vTaskName + " 【操作系统类别】-" + vOS_Class);
		RunTask rt = new RunTask();
		if (vOS_Class.indexOf("linux") >= 0) {
			rt.callSh(vScriptName, vTaskName, ARE.getProperty("PIDR_HOME"));
		} else if (vOS_Class.indexOf("windows") >= 0) {
			rt.callCmd(vScriptName, vTaskName, ARE.getProperty("PIDR_HOME"));
		}
	}
	
}