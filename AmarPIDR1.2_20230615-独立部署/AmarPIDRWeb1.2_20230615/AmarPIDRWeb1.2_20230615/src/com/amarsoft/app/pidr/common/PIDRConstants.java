package com.amarsoft.app.pidr.common;

import java.util.Collections;
import java.util.HashMap;
import java.util.Map;

/**
 * 常量类
 * @author yyzang
 *
 */
public class PIDRConstants {

	/**
	 * 数据库源
	 */
	public static final String DATASOURCE_PIDR = "als";
	/**
	 * 期次号为14个0
	 */
	public static final String SESSIONID_14 = "00000000000000";
	/**
	 * 期次号为14个9
	 */
	public static final String SESSIONID_14_9 = "99999999999999";
	/**
	 * 期次号为16个0
	 */
	public static final String SESSIONID_16 = "0000000000000000";
	/**
	 * 期次号为14个7
	 */
	public static final String SESSIONID_14_7 = "77777777777777";
	/**
	 * 期次号为16个7
	 */
	public static final String SESSIONID_16_7 = "7777777777777777";	
	/**
	 * 期次号为16个9
	 */
	public static final String SESSIONID_16_9 = "9999999999999999";
	
	public static final String DATEFORMAT_1 = "yyyy-MM-dd";
	public static final String DATEFORMAT_2 = "yyyy/MM/dd";
	public static final String DATEFORMAT_3 = "yyyy-MM-dd HH:mm:ss";
	/**
	 * 企业评级记录类型代码
	 */
	public static final String NORMALREPORT_RATE = "310";
	/**
	 * 企业信贷资产记录类型代码
	 */
	public static final String NORMALREPORT_CREASS = "410";
	/**
	 * 评级标识变更记录类型代码
	 */
	public static final String IDCHANGE_RATE = "311";
	/**
	 * 评级按段更正记录类型代码
	 */
	public static final String MDFCINFO_RATE = "312";
	/**
	 * 评级整笔删除记录类型代码
	 */
	public static final String ALLDELETE_RATE = "313";
	/**
	 * 信贷资产标识变更记录类型代码
	 */
	public static final String IDCHANGE_CREASS = "411";
	/**
	 * 信贷资产整笔删除记录类型代码
	 */
	public static final String ALLDELETE_CREASS = "412";

	/**
	 * 批量任务各模块描述
	 */
	public static final String[] DESC = {"央行内评数据文件加载","导入央行内评客户评级信息任务","执行央行内评批量评级任务","导入央行内评企业信贷资产信息任务","央行内评信息段校验任务","央行内评数据迁移任务","央行内评数据报文生成任务"};
	
	/**
	 * 标志：是
	 */
	public static final String FLAG_TRUE = "1";
	
	/**
	 * 标志：否
	 */
	public static final String FLAG_FALSE = "2";
	/**
	 * 评级页面标志：新增
	 */
	public static final String EVALUATE_FLAG_ADD = "1";
	
	/**
	 * 评级页面标志：更新
	 */
	public static final String EVALUATE_FLAG_EDITE = "2";
	
	/**
     * 记录标识 A-新增
     */
    public static final String RECORDFLAG_A = "A";
    /**
     * 记录标识 U-更新
     */
    public static final String RECORDFLAG_U = "U";
    /**
     * 记录标识 R-已上报
     */
    public static final String RECORDFLAG_R = "R";
    /**
     * 记录标识 X-不再报送
     */
    public static final String RECORDFLAG_X = "X";

	/**
	 * 表名：企业评级基础信息
	 */
	public static final String TABLE_PIDR_RATE_BS = "PIDR_RATE_BS";

	/**
	 * 表名：企业评级基本概况信息
	 */
	public static final String TABLE_PIDR_RATE_FSINF = "PIDR_RATE_FSINF";
	
	/**
	 * 表名：企业评级主要负责人信息
	 */
	public static final String TABLE_PIDR_RATE_LEGREPINF = "PIDR_RATE_LEGREPINF";
	
	/**
	 * 表名：企业评级注册资本表
	 */
	public static final String TABLE_PIDR_RATE_REGCAP = "PIDR_RATE_REGCAP";
	
	/**
	 * 表名：企业评级主要出资人信息
	 */
	public static final String TABLE_PIDR_RATE_MNSHAHODINF = "PIDR_RATE_MNSHAHODINF";
	
	/**
	 * 表名：企业评级对外投资信息
	 */
	public static final String TABLE_PIDR_RATE_INVABROINF = "PIDR_RATE_INVABROINF";
	
	/**
	 * 表名：企业评级负面信息段信息
	 */
	public static final String TABLE_PIDR_RATE_NEGINF = "PIDR_RATE_NEGINF";
	
	/**
	 * 表名：企业评级资产负债表段信息
	 */
	public static final String TABLE_PIDR_RATE_BALANCESSHEET = "PIDR_RATE_BALANCESSHEET";
	
	/**
	 * 表名：企业评级利润表段信息
	 */
	public static final String TABLE_PIDR_RATE_INCOME = "PIDR_RATE_INCOME";
	
	/**
	 * 表名：企业评级现金流量表段信息
	 */
	public static final String TABLE_PIDR_RATE_CASHFLOW = "PIDR_RATE_CASHFLOW";
	
	/**
	 * 表名：企业评级补充报表段信息
	 */
	public static final String PIDR_FINANCE_STATEMENT = "PIDR_FINANCE_STATEMENT";
	/**
	 * 表名：企业信贷资产基础段信息
	 */
	public static final String TABLE_PIDR_CREASS_BS = "PIDR_CREASS_BS";
	
	/**
	 * 表名：企业信贷资产基本段信息
	 */
	public static final String TABLE_PIDR_CREASS_FSINF = "PIDR_CREASS_FSINF";
	
	/**
	 * 表名：企业基本信息接口表
	 */
	public static final String TABLE_PIDR_INT_ENTINFO = "PIDR_INT_ENTINFO";
	
	/**
	 * 表名：企业信贷资产信息接口表
	 */
	public static final String TABLE_PIDR_INT_BUSIINFO = "PIDR_INT_BUSIINFO";
	
	/**
	 * 表名：企业注册资本及主要出资人接口表
	 */
	public static final String TABLE_PIDR_INT_MNSHAHODINFO = "PIDR_INT_MNSHAHODINFO";
	
	/**
	 * 表名：企业对外投资接口表
	 */
	public static final String TABLE_PIDR_INT_INVABROINFO = "PIDR_INT_INVABROINFO";
	
	/**
	 * 表名：企业负面信息接口表
	 */
	public static final String TABLE_PIDR_INT_NEGINFO = "PIDR_INT_NEGINFO";
	
	/**
	 * 表名：企业资产负债信息接口表
	 */
	public static final String TABLE_PIDR_INT_BALANCESHEET = "PIDR_INT_BALANCESHEET";
	
	/**
	 * 表名：企业利润信息接口表
	 */
	public static final String TABLE_PIDR_INT_INCOME = "PIDR_INT_INCOME";
	
	/**
	 * 表名：企业现金流量信息接口表
	 */
	public static final String TABLE_PIDR_INT_CASHFLOW = "PIDR_INT_CASHFLOW";
	
	/**
	 * 表名：补充报表接口表
	 */
	public static final String TABLE_PIDR_INT_FINSTATEMENT = "PIDR_INT_FINSTATEMENT";
	
	
	
	
	
	/**
	 * 文件上传标志：1
	 */
	public static final int IMPORTRESULT_1 = 1;
	/**
	 * 文件上传标志：2
	 */
	public static final int IMPORTRESULT_2 = 2;
	/**
	 * 文件上传标志：3-获取的文件为非excel正确格式
	 */
	public static final int IMPORTRESULT_3 = 3;
	/**
	 * 文件上传标志：4-解析出现异常,请核对Excel文件中的数据
	 */
	public static final int IMPORTRESULT_4 = 4;
	/**
	 * 文件上传标志：5-I/O输出流异常
	 */
	public static final int IMPORTRESULT_5 = 5;
	/**
	 * 文件上传标志：6-导入失败
	 */
	public static final int IMPORTRESULT_6 = 6;
	/**
	 * 文件上传标志：7-不是multipart/form-data方式提交!
	 */
	public static final int IMPORTRESULT_7 =7;
	/**
	 * 文件上传标志：8-记录文件信息失败
	 */
	public static final int IMPORTRESULT_8 =8;
	/**
	 * 文件上传标志：0-存在主键冲突数据
	 */
	public static final int IMPORTRESULT_0 =0;
	/**
	 * 无效标志：0
	 */
	public static final String EFFSTATUS_0 = "0";
	/**
	 * 有效标志：1
	 */
	public static final String EFFSTATUS_1 = "1";
	/**
	 * 页面复用标志:1-全信息
	 */
	public static final String ALLMSG_FLAG = "1";
	/**
	 * 页面复用标志:2-查看历史
	 */	
	public static final String CHECKHIS_FLAG = "2";
	/**
	 * 页面复用标志:3-校验错误
	 */	
	public static final String VALIDATEERROR_FLAG = "3";
	/**
	 * 页面复用标志:4-反馈错误
	 */
	public static final String FEEDBACK_FLAG = "4";
	/**
	 * 页面复用标志:5-按段更正详情
	 */
	public static final String MDFC_FLAG = "5";
	
	/**
     * 企业评级信息按段更正
     */
    public static final Map<String,String> PIDRRATE_SGMTCODE_TABLE_HIS = Collections.unmodifiableMap(new HashMap<String,String>(){
        private static final long serialVersionUID = 1L;
        {
            put("A","HPIDR_RATE_BS");//基础段
            put("B","HPIDR_RATE_FSINF");//基本概况段
            put("C","HPIDR_RATE_LEGREPINF");//主要负责人段
            put("D","HPIDR_RATE_REGCAP@HPIDR_RATE_MNSHAHODINF");//注册资本及主要出资人段
            put("E","HPIDR_RATE_INVABROINF");//对外投资信息段
            put("F","HPIDR_RATE_NEGINF");//负面信息段
            put("G","HPIDR_RATE_BALANCESSHEET");//资产负债表段
            put("H","HPIDR_RATE_INCOME");//利润表段
            put("I","HPIDR_RATE_CASHFLOW");//现金流量表段
        }
    });
    
    /**
     * 企业评级信息段标：A-基础段
     */
    public static final String PIDR_RATE_A = "A";
    /**
     * 企业评级信息段标：B-基本概况段
     */
    public static final String PIDR_RATE_B = "B";
    /**
     * 企业评级信息段标：C-主要负责人段
     */
    public static final String PIDR_RATE_C = "C";
    /**
     * 企业评级信息段标：D-注册资本及主要出资人段
     */
    public static final String PIDR_RATE_D = "D";
    /**
     * 企业评级信息段标：E-对外投资信息段
     */
    public static final String PIDR_RATE_E = "E";
    /**
     * 企业评级信息段标：F-负面信息段
     */
    public static final String PIDR_RATE_F = "F";
    /**
     * 企业评级信息段标：G-资产负债表段
     */
    public static final String PIDR_RATE_G = "G";
    /**
     * 企业评级信息段标：H-利润表段
     */
    public static final String PIDR_RATE_H = "H";
    /**
     * 企业评级信息段标：I-现金流量表段
     */
    public static final String PIDR_RATE_I = "I";
    /**
     * 标识变更操作标志：Add-标识变更管理-新增按钮
     */
    public static final String IDCHANGE_OPERATE_ADD = "Add";
    /**
     * 标识变更操作标志：Info-标识变更管理-详情按钮
     */
    public static final String IDCHANGE_OPERATE_INFO = "Info";
    /**
     * 标识变更操作标志：Comp-综合查询-标识变更按钮
     */
    public static final String IDCHANGE_OPERATE_COMP = "Comp";
    /**
     * 标识变更保存前处理返回标志：notExist：不存在该标识
     */
    public static final String IDCHANGE_SAVE_NOTEXIST = "notExist";
    /**
     * 标识变更保存前处理返回标志：idChanged：已存在标识变更记录
     */
    public static final String IDCHANGE_SAVE_IDCHANGED = "idChanged";
    /**
     * 企业身份标识类型：20-统一社会信用代码
     */
    public static final String ENT_CERTTYPE_20 = "20";
    /**
     * 空值N/A
     */
    public static final String VALUE_NULL = "N/A";
    /**
     * 页面只读控制：ReadOnly
     */
    public static final String RIGHTTYPE_READONLY = "ReadOnly";
    /**
     * 段级校验：1
     */
    public static final String VALIDATEFLAG_1 = "1";
    /**
     * 数据项校验：2
     */
    public static final String VALIDATEFLAG_2 = "2";
    /**
     * 数据库类型：mysql
     */
    public static final String  DBKIND_MYSQL= "mysql";
    /**
     * 数据库类型：db2
     */
    public static final String  DBKIND_DB2= "db2";
    /**
     * 列表新增操作标志
     */
    public static final String  OPERATIONTYPE_ADD= "Add";
    /**
     * 列表详情操作标志
     */
    public static final String  OPERATIONTYPE_INFO= "Info";
    /**
     * 左右框架选择页面：AreaCode-行政区划
     */
    public static final String  SELECT_ITEM_AREACODE= "AreaCode";
    /**
     * 左右框架选择页面：EcoIndusCate-行业分类
     */
    public static final String  SELECT_ITEM_ECOINDUSCATE= "EcoIndusCate";
    /**
     * 财报：1-本期信息
     */
    public static final String  FINANCIAL_STAGE_1= "1";
    /**
     * 财报：2-上期信息
     */
    public static final String  FINANCIAL_STAGE_2= "2";
    /**
     * 预评级管理：合格分数界限
     */
    public static final String  QUALIFIED_EVALUATE_SCORE= "70";
    /**
     * 预评级管理：页面标志：1-查看历年评级结果
     */
    public static final String  VIEW_HIS_FLAG= "1";
    /**
     * 预评级管理：评估对象类型
     */
    public static final String  EVALUATE_OBJECT_TYPE = "PIDRCreditGrade";
    /**
     * 预评级管理：报送状态：0-暂缓上报
     */
    public static final String  REPORT_STATUS_0 = "0";
    /**
     * 预评级管理：报送状态：1-正常上报
     */
    public static final String  REPORT_STATUS_1 = "1";
    /**
     * 使用了虚字段的字段，在反馈错误提示标红框时，需要标出虚字段
     */
    public static final String XFiled = "ADMDIVOFREG@ECOINDUSCATE";
}
