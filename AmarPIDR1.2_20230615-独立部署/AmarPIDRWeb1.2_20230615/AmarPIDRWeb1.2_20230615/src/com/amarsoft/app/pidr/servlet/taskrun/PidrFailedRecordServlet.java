package com.amarsoft.app.pidr.servlet.taskrun;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.alibaba.fastjson.JSON;
import com.amarsoft.app.pidr.common.CheckDBKind;
import com.amarsoft.app.pidr.common.PIDRConstants;
import com.amarsoft.app.pidr.index.TaskInfo;
import com.amarsoft.are.ARE;
import com.amarsoft.are.jbo.BizObject;
import com.amarsoft.are.jbo.JBOFactory;
import com.amarsoft.are.jbo.QueryResult.Limit;
import com.amarsoft.are.lang.StringX;

/**
 * 主页查询失败任务记录
 * 1.日历切换月份，失败任务记录展示该月份前十条失败记录
 * 2.日历点击日期，失败任务记录展示该日期前十条失败记录
 * @author kwwu
 */
public class PidrFailedRecordServlet extends HttpServlet  {
	private static final long serialVersionUID = 1L;
	
    private String dbKind="";//当前使用的数据库类型
    
	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException {
		try{
			if(StringX.isEmpty(ARE.getProperty("DBKind"))) {
				new CheckDBKind().initDBKind();//判断数据库类型
			}
			dbKind = ARE.getProperty("DBKind");
			ArrayList<TaskInfo> list = new ArrayList<TaskInfo>();
            request.setCharacterEncoding("UTF-8");
            String date = request.getParameter("Date")!=null ? request.getParameter("Date") : "";
        	String sql="";
            if(date.length() == 7) {//日历切换月份，失败任务记录展示该月份前十条失败记录
	   			if(PIDRConstants.DBKIND_MYSQL.equals(dbKind) || PIDRConstants.DBKIND_DB2.equals(dbKind)) {//mysql、db2
	   				sql = "select count(1) as v.Num, substr(InputDate,1,10) as v.InputDate from O where Status = '2' and substr(INPUTDATE,1,7) = :CurDate " 
	   						 + " group by substr(InputDate,1,10) order by substr(InputDate,1,10) desc ";
	   			}else {
	   				sql="select count(1) as v.Num, v.to_char(INPUTDATE,'yyyy-mm-dd') as v.InputDate from O where Status = '2' and v.to_char(INPUTDATE,'yyyy-mm') = :CurDate " 
	   						 + " group by v.to_char(INPUTDATE,'yyyy-mm-dd') order by v.to_char(INPUTDATE,'yyyy-mm-dd') desc ";
	   			}
            }else {//日历点击日期，失败任务记录展示该日期前十条失败记录
            	if(PIDRConstants.DBKIND_MYSQL.equals(dbKind) || PIDRConstants.DBKIND_DB2.equals(dbKind)) {//mysql、db2
	   				sql = "select count(1) as v.Num, substr(InputDate,1,10) as v.InputDate from O where Status = '2' and substr(INPUTDATE,1,10) = :CurDate " 
	   						 + " group by substr(InputDate,1,10) order by substr(InputDate,1,10) desc ";
	   			}else {
	   				sql="select count(1) as v.Num, v.to_char(INPUTDATE,'yyyy-mm-dd') as v.InputDate from O where Status = '2' and v.to_char(INPUTDATE,'yyyy-mm-dd') = :CurDate " 
	   						 + " group by v.to_char(INPUTDATE,'yyyy-mm-dd') order by v.to_char(INPUTDATE,'yyyy-mm-dd') desc ";
	   			}
            }
   			List<BizObject> bizList = JBOFactory.createBizObjectQuery("jbo.pidr.TASK_RUN_HISTORY", sql).setParameter("CurDate",date).setResultLimit(new Limit(0, 0, 10, "")).getResultList(false);
   			for (BizObject bizObject : bizList) {
   				TaskInfo taskInfo = new TaskInfo();
   				taskInfo.setInputDate(bizObject.getString("InputDate"));
   				taskInfo.setCount(bizObject.getInt("Num"));
   				list.add(taskInfo);
   			}
			String pidrRuntaskList = JSON.toJSONString(list);
			response.setCharacterEncoding("utf-8");
			response.setContentType("application/json");
	        PrintWriter respWriter = response.getWriter();
	        respWriter.append(pidrRuntaskList);
		}catch (Exception e){
			ARE.getLog().error("查询跑批失败任务记录失败",e);
		}
	}

	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request, response);
	}
}
