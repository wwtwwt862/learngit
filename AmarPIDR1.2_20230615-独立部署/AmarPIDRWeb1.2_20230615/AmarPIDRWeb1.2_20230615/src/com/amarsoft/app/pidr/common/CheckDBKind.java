package com.amarsoft.app.pidr.common;

import java.sql.Connection;
import java.sql.DatabaseMetaData;
import java.sql.SQLException;
import java.util.Locale;

import com.amarsoft.are.ARE;
import com.amarsoft.are.lang.StringX;


public class CheckDBKind {
    /**
     * 数据库种类
     * @throws SQLException 
     */
    public void initDBKind() {
      Connection conn = null;
        try {
            conn = DBManager.getConnection();
            DatabaseMetaData metaData = conn.getMetaData();
            if(metaData != null){
                String url = metaData.getURL();
                if(!StringX.isEmpty(url)){
                    url = url.toLowerCase(Locale.ENGLISH);
                    String dbKind = "oracle";
                    if(url.indexOf("mysql") > -1){
                        dbKind = "mysql";
                    } else if(url.indexOf("db2") > -1){
                        dbKind = "db2";
                    }
                    ARE.setProperty("DBKind", dbKind);
                }
            }
        } catch (Exception e) {
            ARE.getLog().error("获取数据库连接异常", e);
        } finally{
           DBManager.close(conn);
        }
    }

}
