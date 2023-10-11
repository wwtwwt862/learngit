package com.amarsoft.app.pidr.common;



import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import com.amarsoft.are.ARE;
import com.amarsoft.are.sql.Query;
/**
 * 
 * @author yyzang
 * 数据库连接资源获取和关闭
 *
 */
public class DBManager {

	public static Connection getConnection() throws SQLException {
		String datasource = PIDRConstants.DATASOURCE_PIDR;
		return ARE.getDBConnection(datasource);
	}

	public static void close(ResultSet rs) {
		try {
			if (rs != null) {
				rs.close();
			}
		} catch (SQLException e) {
			ARE.getLog().error("关闭ResultSet出现问题，不过对象已经销毁" + e);
		}
		rs = null;
	}
	
	public static void close(Statement ps) {
		try {
			if (ps != null) {
				ps.close();
			}
		} catch (SQLException e) {
			ARE.getLog().error("关闭Statement出现问题，不过对象已经销毁" + e);
		}
		ps = null;
	}

	public static void close(PreparedStatement ps) {
		try {
			if (ps != null) {
				ps.close();
			}
		} catch (SQLException e) {
			ARE.getLog().error("关闭PreparedStatement出现问题，不过对象已经销毁" + e);
		}
		ps = null;
	}

	public static void close(Connection connection) {
		try {
			if (connection != null) {
				connection.close();
			}
		} catch (SQLException e) {
			ARE.getLog().error("关闭Connection出现问题，不过对象已经销毁" + e);
		}
		connection = null;
	}

	public static void close(Query q) {
		if (q != null) {
			q.close();
		}
		q = null;
	}

}
