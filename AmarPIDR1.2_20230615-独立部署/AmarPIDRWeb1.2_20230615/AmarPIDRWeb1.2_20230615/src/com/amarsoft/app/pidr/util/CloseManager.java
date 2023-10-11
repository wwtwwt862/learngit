package com.amarsoft.app.pidr.util;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.FileInputStream;
import java.io.FileWriter;
import java.io.IOException;
import java.io.InputStreamReader;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import com.amarsoft.are.ARE;
import com.amarsoft.are.sql.Query;
/**
 * 关闭资源
 * @author yyzang
 *
 */
public class CloseManager {	
	public static void closeResource(Connection conn) {
		try {
			if(conn != null) {
				conn.close();
			}
			conn = null;
		} catch (SQLException e) {
			ARE.getLog().error("关闭数据库连接失败!",e);
		}
	}
	
	public static void closeResource(PreparedStatement ps) {
		try {
			if(ps != null) {
				ps.close();
			}
			ps = null;
		} catch (SQLException e) {
			ARE.getLog().error("关闭preparedstatement失败!", e);
		}
	}
	
	public static void closeResource(ResultSet rs) {
		try {
			if(rs != null) {
				rs.close();
			}
			rs = null;
		} catch (SQLException e) {
			ARE.getLog().error("关闭结果集失败!",e);
		}
	}
	public static void closeResource(Query q) {
		if (q != null) {
			q.close();
		}
		q = null;
	}
	
	public static void closeResource(InputStreamReader isr) {
		try {
			if (isr != null) {
				isr.close();
			}
			isr = null;
		} catch (IOException e) {
			ARE.getLog().error("关闭InputStreamReader出现问题" + e);
		}
	}
	
	public static void closeResource(BufferedReader br) {
		try {
			if (br != null) {
				br.close();
			}
			br = null;
		} catch (IOException e) {
			ARE.getLog().error("关闭BufferedReader出现问题" + e);
		}
	}
	
	public static void closeResource(FileInputStream fis) {
		try {
			if (fis != null) {
				fis.close();
			}
			fis = null;
		} catch (IOException e) {
			ARE.getLog().error("关闭FileInputStream出现问题" + e);
		}
	}

	public static void closeResource(FileWriter fw) {
		try {
			if (fw != null) {
				fw.flush();
				fw.close();
			}
			fw = null;
		} catch (IOException e) {
			ARE.getLog().error("关闭FileWriter出现问题" + e);
		}
	}
	
	public static void closeResource(BufferedWriter bw) {
		try {
			if (bw != null) {
				bw.flush();
				bw.close();
			}
			bw = null;
		} catch (IOException e) {
			ARE.getLog().error("关闭FileWriter出现问题" + e);
		}
	}

	public static void closeResource(Statement pstatement) {
		try {
			if (pstatement != null) {
				pstatement.close();
			}
			pstatement = null;
		}catch (SQLException e) {
			ARE.getLog().error("关闭pstatement出现问题" + e);
		}
		
	}
}
