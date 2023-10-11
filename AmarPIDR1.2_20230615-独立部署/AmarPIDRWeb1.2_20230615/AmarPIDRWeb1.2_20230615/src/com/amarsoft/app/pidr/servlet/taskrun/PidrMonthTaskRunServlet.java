package com.amarsoft.app.pidr.servlet.taskrun;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

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
 * 主页查询某月任务执行情况，便于日历中用小蓝点标出有跑批记录的日期
 * @author kwwu
 */
public class PidrMonthTaskRunServlet extends HttpServlet  {
	private static final long serialVersionUID = 1L;
	
    private String dbKind="";//当前使用的数据库类型
    public static final String TASK_PROGRESSING="0";//任务状态：进行中
	public static final String TASK_SUCCESS="1";//任务状态：成功
	public static final String TASK_FAILED="2";//任务状态：失败
    
	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException {
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		List<String> list = new ArrayList<String>();
		try {
			if(StringX.isEmpty(ARE.getProperty("DBKind"))) {
				new CheckDBKind().initDBKind();//判断数据库类型
			}
			dbKind = ARE.getProperty("DBKind");
			String date = request.getParameter("Date")!=null ? request.getParameter("Date") : "";//日历展示的起始日期
			Date startDate = new SimpleDateFormat("yyyy-M-d").parse(date);
			Calendar c = Calendar.getInstance();
			c.setTime(startDate);
			int day = c.get(Calendar.DATE);
			c.set(Calendar.DATE, day + 34);
			String endDate = new SimpleDateFormat("yyyy-MM-dd").format(c.getTime());//日历展示的结束日期
			date = new SimpleDateFormat("yyyy-MM-dd").format(startDate);//修改日期格式为yyyy-MM-dd
			if(PIDRConstants.DBKIND_MYSQL.equals(dbKind)) {
				date = date + "%";
	        }
		
			conn = DBManager.getConnection();
			String sql = "";
			if(PIDRConstants.DBKIND_MYSQL.equals(dbKind) || PIDRConstants.DBKIND_DB2.equals(dbKind)) {//mysql、db2
				sql = "select substr(inputdate,1,10) from task_run_history where substr(inputdate,1,10) >= ? and substr(inputdate,1,10) <= ? group by substr(inputdate,1,10) ";
			}else {//oracle
				sql = "select to_char(inputdate,'yyyy-MM-dd') from task_run_history trh where to_char(inputdate,'yyyy-MM-dd') >= ? and to_char(inputdate,'yyyy-MM-dd') <= ? group by to_char(inputdate,'yyyy-MM-dd')";
			}
			ps = conn.prepareStatement(sql);
			ps.setString(1, date);
			ps.setString(2, endDate);
			rs = ps.executeQuery();
			while(rs.next()) {
				list.add(rs.getString(1));//有跑批记录的日期
			}
			String taskStatus = JSON.toJSONString(list);
			response.setCharacterEncoding("utf-8");
			response.setContentType("application/json");
	        PrintWriter respWriter = response.getWriter();
	        respWriter.append(taskStatus);
		}catch (Exception e){
			ARE.getLog().error("查询整月跑批任务记录失败",e);
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
