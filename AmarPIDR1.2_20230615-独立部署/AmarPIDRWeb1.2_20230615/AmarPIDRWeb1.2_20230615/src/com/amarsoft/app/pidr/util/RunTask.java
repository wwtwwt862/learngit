package com.amarsoft.app.pidr.util;

import java.io.BufferedReader;
import java.io.File;
import java.io.IOException;
import java.io.InputStreamReader;

import com.amarsoft.are.ARE;

/**
 * 描述：java调用windows中bat和linux中shell功能类</br>
 * 功能：实现web平台应用自动上传报文时通过调用批处理文件和shell脚本执行相应上传unit</br>
 * 
 * @author mxmo
 *
 */
public class RunTask {
	private static final int EXPECTED_BUFFER_DATA = 1024;

	/**
	 * 描述：java调用bat批处理文件</br> 功能：调用bat,调用该方法即可在windows中运行上传unit</br>
	 * 
	 * @param:batName为传入的bat脚本名;taskName为传入的任务名；pidr_home为传入的主程序的home目录
	 * @throws Exception 
	 */
	public String callCmd(String batName, String taskName, String pidr_home){
		String vBatName = "";
		vBatName = "cmd.exe /C start " + pidr_home + ARE.getProperty("PIDR_BAT") + "/" + batName + ".bat";

		BufferedReader br = null;
		Process proc = null;
		try {
			ARE.getLog().info("执行bat开始-----------------------------");
			// 执行bat字符串，为bat名字+参数
			String execStr = vBatName + " " + taskName;
			proc = Runtime.getRuntime().exec(execStr, null,new File(pidr_home + ARE.getProperty("PIDR_BAT")));
			String lineStr = "";
			StringBuffer sbuf = new StringBuffer(EXPECTED_BUFFER_DATA);
			if (proc != null) {
				br = new BufferedReader(new InputStreamReader(proc.getInputStream(),"utf-8"), 4096);
				int streamlength = proc.getInputStream().available();
				int size = 0;
				if (br !=null){
				    while(streamlength>size){
					     lineStr = br.readLine();
					     if (lineStr !=null){
					         streamlength -= lineStr.getBytes("utf-8").length;
					     }
					     if (size != 0){
				             sbuf.append("\r\n");
			            }  
					    sbuf.append(lineStr);
					    size++;
				   }
				}
			     // 由于程序中存在多条命令执行，所以使用waitFor;注：若打印出0表示正常，非0异常
				try {
					ARE.getLog().info(proc.waitFor() + "-[注：若打印出0表示正常，非0异常]");
				} catch (InterruptedException e) {					
					ARE.getLog().error(e);
				}
			}
			ARE.getLog().info("执行bat完成------------------------");
			return "1";
		} catch (IOException e) {
			ARE.getLog().debug(e);
			return "2";
		}finally{
			if (br != null){
			    try {
					br.close();
				} catch (IOException e) {
					ARE.getLog().error("关闭资源失败");
				}
		    }
		}
	}

	/**
	 * 描述：java调用shell脚本</br> 功能：调用shell,调用该方法即可在linux运行上传unit</br>
	 * 
	 * @param:shellName为传入的shell脚本名;taskName为传入的任务名；pidr_home为传入的主程序的home目录
	 */
	public String callSh(String shellName, String taskName, String pidr_home) {
		String vShellName = "";		
		vShellName = pidr_home + ARE.getProperty("PIDR_SH") + "/" + shellName + ".sh";
		// 因为在web平台调用任务，所以shell中的路径不能为相对路径，即：var1为主程序home,var2为taskName,为shell两个参数
		String var1 = taskName;
		String var2 = pidr_home;
		BufferedReader br = null;
		Process proc = null;
		try {
			ARE.getLog().info("执行shell开始-----------------------------");
			// 有些系统并未授予当前登陆用户shell的执行权限，该语句为授予shell执行权限
			String chmodStr = "chmod a+x " + vShellName;
			proc = Runtime.getRuntime().exec(chmodStr);
			// 由于程序中存在多条命令执行，所以使用waitFor;注：若打印出0表示正常，非0异常
			ARE.getLog().info(proc.waitFor() + "-[注：若打印出0表示正常，非0异常]");

			// 执行shell字符串，为shell名字+参数
			String execStr = vShellName + " " + var1 + " " + var2;
			ARE.getLog().info(execStr);
			proc = Runtime.getRuntime().exec("/bin/bash " + execStr);

			int i = 0;
			String lineStr = "";
			StringBuffer sbuf = new StringBuffer(EXPECTED_BUFFER_DATA);
			if (proc != null) {
				br = new BufferedReader(new InputStreamReader(proc.getInputStream(),"utf-8"), 4096);
				if (br != null) {
					while ((lineStr = br.readLine()) != null) {
						if (i != 0)
							sbuf.append("\r\n");
						sbuf.append(lineStr);
						i++;
					}
					br.close();
				}
				// 由于程序中存在多条命令执行，所以使用waitFor;注：若打印出0表示正常，非0异常
				ARE.getLog().info(proc.waitFor() + "-[注：若打印出0表示正常，非0异常]");
			}
			ARE.getLog().info("执行shell完成------------------------");
			return "1";
		} catch (IOException | InterruptedException e) {
			return "2";
		}finally{
			if (br != null){
			    try {
					br.close();
				} catch (IOException e) {
					ARE.getLog().error("关闭资源失败");
				}
		    }
		}
	}
}