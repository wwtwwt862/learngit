package com.amarsoft.app.pidr.index;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import com.amarsoft.app.pidr.common.DBManager;
import com.amarsoft.app.pidr.common.PIDRConstants;
import com.amarsoft.are.ARE;

/**
 * 公告处理类
 * @author yyzang
 * @Date 2023-02-15
 *
 */
public class NoticeHandler {

	
	/**
	 * 获取公告信息
	 * @param request
	 */
	 public void getNotices(HttpServletRequest request,String userId) {
		 	Connection conn = null;
		 	PreparedStatement ps = null;
		 	ResultSet rs = null;
		 	SimpleDateFormat dft = new SimpleDateFormat(PIDRConstants.DATEFORMAT_1);
		   Date date = new Date(); 
		   String bizDate= dft.format(date);//当前日期
		   List<Notice> list = new ArrayList<Notice>();
		  
		 	try {
				conn = DBManager.getConnection();
				String sql = "select O.BoardNo, O.BoardName, O.BoardTitle, O.IsNew, O.IsEject, O.DocNo "
						+ "         from BOARD_LIST O where O.IsPublish = '1' and (O.ShowToRoles is null or O.ShowToRoles in (select UR.RoleID from USER_ROLE UR where UR.UserID= ?))  "
						+ "         and O.EndTime >= ?  order by O.BoardNo desc";
				ps = conn.prepareStatement(sql);
				ps.setString(1, "userId");
				ps.setString(2, bizDate);
				rs = ps.executeQuery();
				while(rs.next()) {
					Notice notice = new Notice();
					notice.setBoardNo(rs.getString("BoardNo"));
					String name = rs.getString("BoardName");
					if(name == null) name = "";
					name = name.replaceAll("&","&amp;").replaceAll("<","&lt;").replaceAll(">","&gt;")
							.replaceAll(" ","&nbsp;").replaceAll("'","&acute;").replaceAll("\"","&quot;");
					String title = rs.getString("BoardTitle");
					if(title == null) title = "";
					title = title.replaceAll("&","&amp;").replaceAll("<","&lt;").replaceAll(">","&gt;")
							.replaceAll(" ","&nbsp;").replaceAll("'","&acute;").replaceAll("\"","&quot;");
					notice.setBoardName(name);
					notice.setBoardTitle(title);
					notice.setIsNew(rs.getString("IsNew"));
					notice.setIsEject(rs.getString("IsEject"));
					notice.setDocNo(rs.getString("DocNo"));
					list.add(notice);
				}
			} catch (SQLException e) {
				ARE.getLog().error("首页获取公告信息出错",e);
			}finally {
				DBManager.close(rs);
				DBManager.close(ps);
				DBManager.close(conn);

			}
		 	request.setAttribute("fileList", list);
	 }
}
