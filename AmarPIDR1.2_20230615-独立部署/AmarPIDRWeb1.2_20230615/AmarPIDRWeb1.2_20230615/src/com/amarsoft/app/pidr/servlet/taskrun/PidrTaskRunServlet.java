package com.amarsoft.app.pidr.servlet.taskrun;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.alibaba.fastjson.JSON;
import com.amarsoft.app.pidr.common.CheckDBKind;
import com.amarsoft.app.pidr.common.DBManager;
import com.amarsoft.app.pidr.common.PIDRConstants;
import com.amarsoft.are.ARE;
import com.amarsoft.are.lang.StringX;
/**
 * 主页查询各个批量任务执行情况
 * @author kwwu
 */
public class PidrTaskRunServlet extends HttpServlet  {
	private static final long serialVersionUID = 1L;
	
    private String dbKind="";//当前使用的数据库类型
    public static final String TASK_PROGRESSING="0";//任务状态：进行中
	public static final String TASK_SUCCESS="1";//任务状态：成功
	public static final String TASK_FAILED="2";//任务状态：失败
    
	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException {
		if(StringX.isEmpty(ARE.getProperty("DBKind"))) {
			new CheckDBKind().initDBKind();//判断数据库类型
		}
		dbKind = ARE.getProperty("DBKind");
		String date = request.getParameter("Date")!=null ? request.getParameter("Date") : "";
		if(PIDRConstants.DBKIND_MYSQL.equals(dbKind)) {
			date = date + "%";
        }
        String status = "";//任务执行状态
		String[] desc = PIDRConstants.DESC;
		String[][] result = new String[PIDRConstants.DESC.length][3];
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		try {
			conn = DBManager.getConnection();
			String sql = "";
			if(PIDRConstants.DBKIND_MYSQL.equals(dbKind)|| PIDRConstants.DBKIND_DB2.equals(dbKind)) {//mysql、db2
				sql = "SELECT * from task_run_history where serialno=(SELECT max(serialno) FROM task_run_history where statustype = 'task' and inputdate like ? and taskdescribe = ?) ";
			}else {//oracle、db2
				sql =  "SELECT * from task_run_history where serialno=(SELECT max(serialno) FROM task_run_history where statustype = 'task' and to_char(inputdate,'yyyy-MM-dd') = ? and taskdescribe =?)";
			}
			for(int i = 0; i < desc.length;i++) {
				ps = conn.prepareStatement(sql);
				ps.setString(1, date);
				ps.setString(2, desc[i]);
				rs = ps.executeQuery();
				if(rs.next()) {
					status = rs.getString("status");
					if(TASK_SUCCESS.equals(status)){
						result[i][0]="执行成功";//任务状态描述
						result[i][1]="#06C1A0";//描述字体颜色
						result[i][2]="#CBF1EC";//步骤圆圈背景色
			        }else if(TASK_PROGRESSING.equals(status)){
			        	result[i][0]="执行中";
			        	result[i][1]="#3B94F6";
			        	result[i][2]="#CFE6FD";
			        }else if(TASK_FAILED.equals(status)){
			        	result[i][0]="执行失败";
			        	result[i][1]="#FD6464";
			        	result[i][2]="#FED8D8";
			        } 
				}else {
					result[i][0]="未执行";
					result[i][1]="#FEB322";
					result[i][2]="#FFECC8";
				}
			}
			String taskStatus = JSON.toJSONString(result);
			response.setCharacterEncoding("utf-8");
			response.setContentType("application/json");
	        PrintWriter respWriter = response.getWriter();
	        respWriter.append(taskStatus);
		}catch (Exception e){
			ARE.getLog().error("查询跑批任务记录失败",e);
		}finally {
			DBManager.close(rs);
			DBManager.close(ps);
			DBManager.close(conn);
		}
	}

	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request, response);
	}
}
