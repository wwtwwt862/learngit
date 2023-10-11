-- MySQL dump 10.13  Distrib 5.7.12, for linux-glibc2.5 (x86_64)
--
-- Host: localhost    Database: pidr_dev
-- ------------------------------------------------------
-- Server version	5.7.12

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `audit_info`
--

DROP TABLE IF EXISTS `audit_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `audit_info` (
  `SERIALNO` varchar(32) NOT NULL COMMENT '流水号',
  `OPERATOR` varchar(80) DEFAULT NULL COMMENT '操作人',
  `SERVERADDRESS` varchar(80) DEFAULT NULL COMMENT '服务器地址',
  `CLIENTADDRESS` varchar(80) DEFAULT NULL COMMENT '客户端地址',
  `APPLICATION` varchar(80) DEFAULT NULL COMMENT '应用',
  `ADDITIONALINFO` varchar(200) DEFAULT NULL COMMENT '附加信息',
  `RECORDTYPE` varchar(32) DEFAULT NULL COMMENT '记录类型',
  `RECORDACTION` varchar(32) DEFAULT NULL COMMENT '记录动作',
  `RECORDTARGET` varchar(32) DEFAULT NULL COMMENT '记录目标',
  `AUDITTIME` varchar(40) DEFAULT NULL COMMENT '修改时间',
  `AUDITDATA` varchar(4000) DEFAULT NULL COMMENT '审计数据',
  PRIMARY KEY (`SERIALNO`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='记录基于ARE的审计信息， AWE中的审计数据落地参考实现';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `awe_bizfile_info`
--

DROP TABLE IF EXISTS `awe_bizfile_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `awe_bizfile_info` (
  `FILENO` varchar(32) NOT NULL COMMENT '文件编号',
  `FILEPATH` varchar(200) DEFAULT NULL COMMENT '文件路径',
  `FILEDESC` varchar(200) DEFAULT NULL COMMENT '文件描述',
  `CATALOGINFO` varchar(800) DEFAULT NULL COMMENT '概要信息',
  `ISTEMPORARY` varchar(10) DEFAULT NULL COMMENT '是否临时文件',
  `LATESTDOUSERID` varchar(32) DEFAULT NULL COMMENT '最近操作人',
  `DOWNLOADCOUNT` int(11) DEFAULT NULL COMMENT '下载次数',
  `CREATETIME` varchar(40) DEFAULT NULL COMMENT '创建时间',
  `CREATEUSER` varchar(32) DEFAULT NULL COMMENT '创建人员',
  PRIMARY KEY (`FILENO`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='业务文件下载信息';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `awe_dict_errmsg`
--

DROP TABLE IF EXISTS `awe_dict_errmsg`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `awe_dict_errmsg` (
  `MSGNO` varchar(8) NOT NULL COMMENT '错误编号',
  `MSGTYPE` varchar(8) DEFAULT NULL COMMENT '错误类型',
  `MSGTEXT` varchar(200) DEFAULT NULL COMMENT '错误中文显示',
  `ENTEXT` varchar(200) DEFAULT NULL COMMENT '错误英文显示',
  `INPUTUSER` varchar(32) DEFAULT NULL COMMENT '登记人员',
  `INPUTORG` varchar(32) DEFAULT NULL COMMENT '登记机构',
  `INPUTTIME` varchar(20) DEFAULT NULL COMMENT '登记时间',
  `UPDATEUSER` varchar(32) DEFAULT NULL COMMENT '更新人员',
  `UPDATETIME` varchar(20) DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`MSGNO`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='错误消息字典';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `awe_do_catalog`
--

DROP TABLE IF EXISTS `awe_do_catalog`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `awe_do_catalog` (
  `DONO` varchar(32) NOT NULL COMMENT '显示模板编号',
  `DONAME` varchar(80) DEFAULT NULL COMMENT '名称',
  `DODESCRIBE` varchar(250) DEFAULT NULL COMMENT '描述',
  `DOTYPE` varchar(18) DEFAULT NULL COMMENT '用途',
  `DOCLASS` varchar(18) DEFAULT NULL COMMENT '分类',
  `ISINUSE` varchar(18) DEFAULT NULL COMMENT '是否有效',
  `COLCOUNT` char(1) DEFAULT NULL COMMENT '分栏数',
  `MODEID` varchar(32) DEFAULT NULL COMMENT '风格编号',
  `JBOCLASS` varchar(200) DEFAULT NULL COMMENT 'JBO定义名',
  `JBOFROM` varchar(1000) DEFAULT NULL COMMENT 'from子句',
  `JBOWHERE` varchar(1000) DEFAULT NULL COMMENT '查询条件',
  `JBOGROUP` varchar(500) DEFAULT NULL COMMENT '分组',
  `JBOORDER` varchar(500) DEFAULT NULL COMMENT '排序',
  `BUSINESSPROCESS` varchar(200) DEFAULT NULL COMMENT '业务模型',
  `EXPORTFLAG` char(1) DEFAULT NULL COMMENT '导出标志',
  `INPUTUSER` varchar(32) DEFAULT NULL COMMENT '登记人',
  `INPUTTIME` varchar(20) DEFAULT NULL COMMENT '登记时间',
  `UPDATEUSER` varchar(32) DEFAULT NULL COMMENT '更新人',
  `UPDATETIME` varchar(20) DEFAULT NULL COMMENT '更新时间',
  `REMARK` varchar(250) DEFAULT NULL COMMENT '备注',
  `ISVALIDATE` char(1) DEFAULT NULL COMMENT '是否启用校验',
  `PARENT` varchar(32) DEFAULT NULL COMMENT '父模板',
  `ISOSFSERVICE` varchar(1) DEFAULT NULL,
  PRIMARY KEY (`DONO`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='OW显示模板目录';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `awe_do_col_validate`
--

DROP TABLE IF EXISTS `awe_do_col_validate`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `awe_do_col_validate` (
  `SERIALNO` varchar(32) NOT NULL COMMENT '验证名',
  `DONO` varchar(32) DEFAULT NULL COMMENT 'DO编号',
  `COLNAME` varchar(32) DEFAULT NULL COMMENT 'JBO属性名',
  `VALIDATORNAME` varchar(32) DEFAULT NULL COMMENT '对应验证规则',
  `PARAM1` varchar(2000) DEFAULT NULL COMMENT '参数1',
  `PARAM2` varchar(200) DEFAULT NULL COMMENT '参数2',
  `PARAM3` varchar(400) DEFAULT NULL COMMENT '参数3',
  `PARAM4` varchar(400) DEFAULT NULL COMMENT '参数4',
  `PARAM5` varchar(32) DEFAULT NULL COMMENT '参数5',
  `PARAM6` varchar(32) DEFAULT NULL COMMENT '参数6',
  `PARAM7` varchar(32) DEFAULT NULL COMMENT '参数7',
  `PARAM8` varchar(32) DEFAULT NULL COMMENT '参数8',
  `PARAM9` varchar(32) DEFAULT NULL COMMENT '参数9',
  `PARAM10` varchar(32) DEFAULT NULL COMMENT '参数10',
  `USESTATUS` varchar(32) DEFAULT NULL COMMENT '编辑状态',
  `ISINUSE` char(1) DEFAULT NULL COMMENT '是否使用',
  PRIMARY KEY (`SERIALNO`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='OW字段验证规则';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `awe_do_event`
--

DROP TABLE IF EXISTS `awe_do_event`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `awe_do_event` (
  `DONO` varchar(32) NOT NULL COMMENT '显示模板编号',
  `COLNAME` varchar(32) NOT NULL COMMENT 'jbo属性名',
  `EVENT` varchar(32) NOT NULL COMMENT '事件名',
  `SCRIPT` varchar(200) DEFAULT NULL COMMENT '事件执行方法',
  `EVENTPARAMS` varchar(400) DEFAULT NULL COMMENT '方法执行参数',
  `ISINUSE` char(1) DEFAULT NULL COMMENT '是否使用',
  `INPUTUSER` varchar(32) DEFAULT NULL COMMENT '登记人员',
  `INPUTTIME` varchar(20) DEFAULT NULL COMMENT '登记时间',
  `UPDATEUSER` varchar(32) DEFAULT NULL COMMENT '更新人员',
  `UPDATETIME` varchar(20) DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`DONO`,`COLNAME`,`EVENT`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='OW字段事件';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `awe_do_function`
--

DROP TABLE IF EXISTS `awe_do_function`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `awe_do_function` (
  `FUNCTIONNAME` varchar(80) NOT NULL COMMENT '方法名',
  `DONO` varchar(32) NOT NULL COMMENT 'OW显示模板编号',
  `FUNCTIONPARAMS` varchar(400) DEFAULT NULL COMMENT '方法参数',
  `FUNCTIONBODY` varchar(4000) DEFAULT NULL COMMENT '方法体',
  `FUNCTIONDESC` varchar(255) DEFAULT NULL COMMENT '方法描述',
  `ISINUSE` char(1) DEFAULT NULL COMMENT '是否使用',
  `INPUTUSER` varchar(32) DEFAULT NULL COMMENT '输入人',
  `INPUTTIME` varchar(20) DEFAULT NULL COMMENT '输入时间',
  `UPDATEUSER` varchar(32) DEFAULT NULL COMMENT '更新人',
  `UPDATETIME` varchar(20) DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`FUNCTIONNAME`,`DONO`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='OW脚本方法';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `awe_do_group`
--

DROP TABLE IF EXISTS `awe_do_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `awe_do_group` (
  `DONO` varchar(32) NOT NULL COMMENT '显示模板编号',
  `DOCKID` varchar(32) NOT NULL COMMENT '分组编号',
  `DOCKNAME` varchar(80) DEFAULT NULL COMMENT '分组名称',
  `SORTNO` varchar(32) DEFAULT NULL COMMENT '排序号',
  `GROUPHEAD` varchar(3000) DEFAULT NULL COMMENT '分组头',
  `GROUPFOOT` varchar(3000) DEFAULT NULL COMMENT '分组尾',
  `GROUPBODY` varchar(3000) DEFAULT NULL COMMENT '分组体',
  `COLCOUNT` int(11) DEFAULT NULL COMMENT '每行列数',
  `STYLEID` varchar(32) DEFAULT NULL COMMENT '使用样式编号',
  `ISEXPAND` char(1) DEFAULT NULL COMMENT '分组是否展开',
  `GROUPBODY1` varchar(3000) DEFAULT NULL COMMENT '分组体1',
  `GROUPBODY2` varchar(3000) DEFAULT NULL COMMENT '分组体2',
  `INPUTUSER` varchar(32) DEFAULT NULL COMMENT '录入人',
  `INPUTTIME` varchar(20) DEFAULT NULL COMMENT '录入时间',
  `UPDATEUSER` varchar(32) DEFAULT NULL COMMENT '更新人',
  `UPDATETIME` varchar(20) DEFAULT NULL COMMENT '更新时间',
  `INPUTORG` varchar(32) DEFAULT NULL COMMENT '录入机构',
  PRIMARY KEY (`DONO`,`DOCKID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='OW分组信息';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `awe_do_js_function`
--

DROP TABLE IF EXISTS `awe_do_js_function`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `awe_do_js_function` (
  `FUNCTIONNAME` varchar(32) NOT NULL,
  `FUNCTIONPARAMS` varchar(200) DEFAULT NULL,
  `INVOKEEXAMPLE` varchar(200) DEFAULT NULL,
  `FUNCTIONTYPE` varchar(32) DEFAULT NULL,
  `ISINUSE` char(1) DEFAULT NULL,
  `FUNCTIONDESC` varchar(250) DEFAULT NULL,
  `INPUTUSER` varchar(32) DEFAULT NULL,
  `INPUTTIME` varchar(20) DEFAULT NULL,
  `UPDATEUSER` varchar(32) DEFAULT NULL,
  `UPDATETIME` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`FUNCTIONNAME`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='OW通用JS方法';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `awe_do_keyfilter`
--

DROP TABLE IF EXISTS `awe_do_keyfilter`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `awe_do_keyfilter` (
  `SERIALNO` varchar(32) NOT NULL COMMENT '自动编号',
  `DONO` varchar(32) DEFAULT NULL COMMENT '验证类型',
  `COLNAME` varchar(32) DEFAULT NULL COMMENT '字段名',
  `TRADEKEY` varchar(32) DEFAULT NULL COMMENT '关键字',
  `TRADEVALUE` varchar(80) DEFAULT NULL COMMENT '值',
  `INPUTTIME` varchar(32) DEFAULT NULL COMMENT '录入时间',
  `UPDATETIME` varchar(32) DEFAULT NULL COMMENT '更新时间',
  `INPUTUSER` varchar(32) DEFAULT NULL COMMENT '录入人',
  `UPDATEUSER` varchar(32) DEFAULT NULL COMMENT '更新人',
  `TITLE` varchar(32) DEFAULT NULL COMMENT '标题',
  `HIT` int(11) DEFAULT '0' COMMENT '点击次数',
  PRIMARY KEY (`SERIALNO`),
  KEY `KEY_DO_KEYFILTER` (`TRADEKEY`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='OW关键字查询';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `awe_do_library`
--

DROP TABLE IF EXISTS `awe_do_library`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `awe_do_library` (
  `DONO` varchar(32) NOT NULL COMMENT '显示模板编号',
  `COLINDEX` varchar(32) NOT NULL COMMENT '序号',
  `SORTNO` varchar(18) DEFAULT NULL COMMENT '排序号',
  `ISINUSE` varchar(18) DEFAULT NULL COMMENT '有效',
  `COLTABLENAME` varchar(80) DEFAULT NULL COMMENT 'JBO类名',
  `COLACTUALNAME` varchar(200) DEFAULT NULL COMMENT '列名',
  `COLNAME` varchar(80) DEFAULT NULL COMMENT '使用名',
  `COLTYPE` varchar(32) DEFAULT NULL COMMENT '值类型',
  `COLDEFAULTVALUE` varchar(80) DEFAULT NULL COMMENT '缺省值',
  `COLHEADER` varchar(80) DEFAULT NULL COMMENT '中文显示',
  `COLUNIT` varchar(250) DEFAULT NULL COMMENT '显示后缀',
  `COLCOLUMNTYPE` varchar(18) DEFAULT NULL COMMENT '是否Sum',
  `COLEDITSTYLE` varchar(18) DEFAULT NULL COMMENT '编辑形式',
  `COLCHECKFORMAT` varchar(18) DEFAULT NULL COMMENT '特殊输入格式',
  `COLALIGN` varchar(18) DEFAULT NULL COMMENT '对齐',
  `COLEDITSOURCETYPE` varchar(18) DEFAULT NULL COMMENT '下拉框来源',
  `COLEDITSOURCE` varchar(250) DEFAULT NULL COMMENT '来源描述',
  `COLHTMLSTYLE` varchar(250) DEFAULT NULL COMMENT 'HTML格式',
  `COLLIMIT` varchar(18) DEFAULT NULL COMMENT '长度',
  `COLVISIBLE` char(1) DEFAULT NULL COMMENT '可见',
  `COLREADONLY` char(1) DEFAULT NULL COMMENT '只读',
  `COLREQUIRED` char(1) DEFAULT NULL COMMENT '必需',
  `COLSORTABLE` char(1) DEFAULT NULL COMMENT '可排序',
  `ISFILTER` char(1) DEFAULT NULL COMMENT '查询',
  `COLSPAN` int(11) DEFAULT NULL COMMENT '跨几栏',
  `ISAUTOCOMPLETE` char(1) DEFAULT NULL COMMENT '是否自动完成',
  `GROUPID` varchar(32) DEFAULT NULL COMMENT '所属组',
  `COLFILTERREFID` varchar(32) DEFAULT NULL COMMENT '关联的实际字段',
  `INPUTUSER` varchar(32) DEFAULT NULL COMMENT '输入人',
  `INPUTTIME` varchar(20) DEFAULT NULL COMMENT '输入时间',
  `UPDATEUSER` varchar(32) DEFAULT NULL COMMENT '更新人',
  `UPDATETIME` varchar(20) DEFAULT NULL COMMENT '更新时间',
  `ISAUDIT` char(1) DEFAULT NULL COMMENT '是否审计',
  `COLFILTERATTRS` varchar(255) DEFAULT NULL COMMENT '过滤属性',
  `ISUPDATE` varchar(2) DEFAULT NULL COMMENT '是否已更新',
  `PARENTCOLINDEX` varchar(32) DEFAULT NULL COMMENT '父序号',
  `TIPS` varchar(250) DEFAULT NULL COMMENT '提示',
  `COLINNERBTEVENT` varchar(250) DEFAULT NULL COMMENT '内置按钮事件',
  `COLFILTEROPTIONS` varchar(200) DEFAULT NULL COMMENT '查询操作符定义',
  `AUTOCOMPLETEFUN` varchar(64) DEFAULT NULL,
  PRIMARY KEY (`DONO`,`COLINDEX`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='OW显示模板属性库';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `awe_do_modes`
--

DROP TABLE IF EXISTS `awe_do_modes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `awe_do_modes` (
  `MODEID` varchar(32) NOT NULL COMMENT '编号',
  `GROUPHEAD` varchar(4000) DEFAULT NULL COMMENT '分组头信息',
  `GROUPFOOT` varchar(1000) DEFAULT NULL COMMENT '分组尾信息',
  `GROUPBODY1` varchar(4000) DEFAULT NULL COMMENT '分组体1',
  `COLCOUNT` int(11) DEFAULT NULL COMMENT '分栏数',
  `MODENAME` varchar(32) DEFAULT NULL COMMENT '样式名',
  `GROUPBODY2` varchar(4000) DEFAULT NULL COMMENT '分组体2',
  `MODEDESC` varchar(200) DEFAULT NULL COMMENT '样式描述',
  `HTMLHEAD` varchar(1000) DEFAULT NULL COMMENT 'HTML头',
  `HTMLFOOT` varchar(1000) DEFAULT NULL COMMENT 'HTML尾',
  `CONTROLHEAD` varchar(100) DEFAULT NULL COMMENT '控制头文件地址',
  `CONTROLFOOT` varchar(100) DEFAULT NULL COMMENT '控制尾文件地址',
  `GROUPBODYPARSER` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`MODEID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='OW显示模板样式';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `awe_do_validate`
--

DROP TABLE IF EXISTS `awe_do_validate`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `awe_do_validate` (
  `VALIDATORNAME` varchar(32) NOT NULL COMMENT '验证名',
  `VALIDATORTYPE` varchar(32) DEFAULT NULL COMMENT '验证类型',
  `ERRMSG` varchar(100) DEFAULT NULL COMMENT '出错信息',
  `CONTROLTO` varchar(32) DEFAULT NULL COMMENT '对应控件名',
  `REGULAR` varchar(200) DEFAULT NULL COMMENT '规则',
  `CUSFUNCTION` varchar(80) DEFAULT NULL COMMENT '方法',
  `COMPARETO` varchar(80) DEFAULT NULL COMMENT '比较控件',
  `MINVALUE` varchar(32) DEFAULT NULL COMMENT '最小值',
  `MAXVALUE` varchar(32) DEFAULT NULL COMMENT '最大值',
  `INPUTTIME` varchar(20) DEFAULT NULL COMMENT '输入时间',
  `ISSYSTEM` char(1) DEFAULT NULL COMMENT '系统保留',
  `COMPAREOBJ` varchar(80) DEFAULT NULL COMMENT '有条件比较对象',
  `VALIDATORTITLE` varchar(80) DEFAULT NULL COMMENT '验证类标题',
  `BUSINESSTYPE` varchar(32) DEFAULT NULL COMMENT '业务类型',
  PRIMARY KEY (`VALIDATORNAME`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='OW数据验证类';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `awe_do_validate_catalog`
--

DROP TABLE IF EXISTS `awe_do_validate_catalog`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `awe_do_validate_catalog` (
  `CATALOGNO` varchar(32) NOT NULL COMMENT '分类编号',
  `CATALOGTITLE` varchar(80) DEFAULT NULL COMMENT '分类标题',
  `SORTNO` varchar(32) DEFAULT NULL COMMENT '排序号',
  `ISINUSE` char(1) DEFAULT NULL COMMENT '是否使用',
  `ATTRIBUTE1` varchar(32) DEFAULT NULL COMMENT '参数1',
  `ATTRIBUTE2` varchar(32) DEFAULT NULL COMMENT '参数2',
  `ATTRIBUTE3` varchar(32) DEFAULT NULL COMMENT '参数3',
  `ATTRIBUTE4` varchar(32) DEFAULT NULL COMMENT '参数4',
  `ATTRIBUTE5` varchar(255) DEFAULT NULL COMMENT '参数5',
  `ATTRIBUTE6` varchar(255) DEFAULT NULL COMMENT '参数6',
  `ATTRIBUTE7` varchar(400) DEFAULT NULL COMMENT '参数7',
  `ATTRIBUTE8` varchar(400) DEFAULT NULL COMMENT '参数8',
  PRIMARY KEY (`CATALOGNO`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='OW数据验证业务分类';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `awe_dw_context`
--

DROP TABLE IF EXISTS `awe_dw_context`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `awe_dw_context` (
  `SERIALNO` varchar(32) NOT NULL COMMENT '自动编号',
  `OBJECTTYPE` varchar(32) DEFAULT NULL COMMENT '对象类型',
  `OBJECTNO` varchar(32) DEFAULT NULL COMMENT '对象名',
  `CONTENT` varchar(4000) DEFAULT NULL COMMENT '内容',
  PRIMARY KEY (`SERIALNO`),
  KEY `IDX_DW_CONTEXT_1` (`OBJECTTYPE`,`OBJECTNO`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='DataWindow、ObjectWindow通用，主要是校验使用';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `awe_erpt_catalog`
--

DROP TABLE IF EXISTS `awe_erpt_catalog`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `awe_erpt_catalog` (
  `DOCID` varchar(18) NOT NULL COMMENT '文档类型编号',
  `DOCNAME` varchar(200) DEFAULT NULL COMMENT '文档类型名称',
  `DOCTYPE` varchar(18) DEFAULT NULL COMMENT '文档类型',
  `ATTRIBUTE1` varchar(200) DEFAULT NULL COMMENT '属性1',
  `ATTRIBUTE2` varchar(200) DEFAULT NULL COMMENT '属性2',
  `ATTRIBUTE3` varchar(200) DEFAULT NULL COMMENT '属性3',
  `ATTRIBUTE4` varchar(200) DEFAULT NULL COMMENT '属性4',
  `ORGID` varchar(32) DEFAULT NULL COMMENT '机构',
  `USERID` varchar(32) DEFAULT NULL COMMENT '登记人',
  `INPUTDATE` varchar(10) DEFAULT NULL COMMENT '登记日期',
  `UPDATEDATE` varchar(10) DEFAULT NULL COMMENT '更新日期',
  `TOOLCLASSNAME` varchar(200) DEFAULT NULL COMMENT '报告工具类名',
  `DEFAULTMODELPACKAGENAME` varchar(255) DEFAULT NULL COMMENT '模板默认使用包名',
  `VERTIONNUMBER` varchar(32) DEFAULT NULL,
  `ENDDATE` varchar(10) DEFAULT NULL COMMENT '结束日期',
  `STARTDATE` varchar(10) DEFAULT NULL COMMENT '开始日期',
  `ISINUSE` varchar(32) DEFAULT NULL COMMENT '有效状态',
  `SCOREHANDLER` varchar(255) DEFAULT NULL COMMENT '打分处理类',
  PRIMARY KEY (`DOCID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='电子报告目录';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `awe_erpt_data`
--

DROP TABLE IF EXISTS `awe_erpt_data`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `awe_erpt_data` (
  `SERIALNO` varchar(40) NOT NULL COMMENT '流水号',
  `RELATIVESERIALNO` varchar(32) NOT NULL COMMENT '相应的记录号',
  `TREENO` varchar(18) DEFAULT NULL COMMENT '排序号',
  `DOCID` varchar(18) DEFAULT NULL COMMENT '文档类型编号',
  `DIRID` varchar(18) DEFAULT NULL COMMENT '目录编号',
  `DIRNAME` varchar(200) DEFAULT NULL COMMENT '目录名称',
  `GUARANTYNO` varchar(40) DEFAULT NULL COMMENT '关联担保号',
  `HTMLDATA` longblob COMMENT '内容',
  `CONTENTLENGTH` int(11) DEFAULT NULL COMMENT '长度',
  `SCORE` varchar(32) DEFAULT NULL COMMENT '评分',
  `SCOREDESC` varchar(1000) DEFAULT NULL COMMENT '评分描述',
  `SAVED` char(1) DEFAULT NULL COMMENT '是否保存',
  `ORGID` varchar(32) DEFAULT NULL COMMENT '机构',
  `USERID` varchar(32) DEFAULT NULL COMMENT '登记人',
  `INPUTDATE` varchar(10) DEFAULT NULL COMMENT '登记日期',
  `UPDATEDATE` varchar(10) DEFAULT NULL COMMENT '更新日期',
  PRIMARY KEY (`SERIALNO`),
  KEY `IX_AWE_ERPT_DATA` (`RELATIVESERIALNO`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='电子报告文档内容';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `awe_erpt_def`
--

DROP TABLE IF EXISTS `awe_erpt_def`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `awe_erpt_def` (
  `DOCID` varchar(18) NOT NULL COMMENT '文档类型编号',
  `DIRID` varchar(18) NOT NULL COMMENT '目录编号',
  `DIRNAME` varchar(200) DEFAULT NULL COMMENT '目录名称',
  `JSPFILENAME` varchar(200) DEFAULT NULL COMMENT 'JSP文件名',
  `HTMLFILENAME` varchar(200) DEFAULT NULL COMMENT '模板文件名',
  `DEFAULTMODELPACKAGENAME` varchar(255) DEFAULT NULL COMMENT '模板使用包名',
  `EDITSTATUS` varchar(32) DEFAULT NULL COMMENT '编辑属性',
  `ARRANGEATTR` varchar(18) DEFAULT NULL COMMENT '展现属性',
  `CIRCLEATTR` varchar(18) DEFAULT NULL COMMENT '循环属性',
  `ATTRIBUTE1` varchar(200) DEFAULT NULL COMMENT '属性1',
  `ATTRIBUTE2` varchar(200) DEFAULT NULL COMMENT '属性2',
  `ORGID` varchar(32) DEFAULT NULL COMMENT '机构',
  `USERID` varchar(32) DEFAULT NULL COMMENT '登记人',
  `INPUTDATE` varchar(10) DEFAULT NULL COMMENT '登记日期',
  `UPDATEDATE` varchar(10) DEFAULT NULL COMMENT '更新日期',
  PRIMARY KEY (`DIRID`,`DOCID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='电子报告定义';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `awe_erpt_map`
--

DROP TABLE IF EXISTS `awe_erpt_map`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `awe_erpt_map` (
  `SERIALNO` varchar(32) NOT NULL COMMENT '流水号',
  `DOCID` varchar(18) DEFAULT NULL COMMENT '文档类型编号',
  `DIRID` varchar(18) DEFAULT NULL COMMENT '目录编号',
  `ENNAME` varchar(32) DEFAULT NULL COMMENT '英文名',
  `CNNAME` varchar(80) DEFAULT NULL COMMENT '中文名',
  `ATTRIBUTE1` varchar(200) DEFAULT NULL COMMENT '属性1',
  `ATTRIBUTE2` varchar(200) DEFAULT NULL COMMENT '属性2',
  `ORGID` varchar(32) DEFAULT NULL COMMENT '机构',
  `USERID` varchar(32) DEFAULT NULL COMMENT '登记人',
  `INPUTDATE` varchar(10) DEFAULT NULL COMMENT '登记日期',
  `UPDATEDATE` varchar(10) DEFAULT NULL COMMENT '更新日期',
  PRIMARY KEY (`SERIALNO`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='电子报告字段中文应映射表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `awe_erpt_offline`
--

DROP TABLE IF EXISTS `awe_erpt_offline`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `awe_erpt_offline` (
  `SERIALNO` varchar(32) NOT NULL COMMENT '记录号',
  `OBJECTTYPE` varchar(32) DEFAULT NULL COMMENT '对象类型',
  `OBJECTNO` varchar(32) DEFAULT NULL COMMENT '对象编号',
  `DOCID` varchar(32) DEFAULT NULL COMMENT '格式化报告编号',
  `SAVEPATH` varchar(120) DEFAULT NULL COMMENT '格式化报告路径',
  `ATTRIBUTE1` varchar(40) DEFAULT NULL COMMENT '属性1',
  `ATTRIBUTE2` varchar(40) DEFAULT NULL COMMENT '属性2',
  `ATTRIBUTE3` varchar(40) DEFAULT NULL COMMENT '属性3',
  `ATTRIBUTE4` varchar(40) DEFAULT NULL COMMENT '属性4',
  `ATTRIBUTE5` varchar(40) DEFAULT NULL COMMENT '属性5',
  `ORGID` varchar(32) DEFAULT NULL COMMENT '机构',
  `USERID` varchar(32) DEFAULT NULL COMMENT '登记人',
  `INPUTDATE` varchar(10) DEFAULT NULL COMMENT '登记日期',
  `DIRECTION` varchar(10) DEFAULT NULL COMMENT '更新方向',
  PRIMARY KEY (`SERIALNO`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='电子报告离线上传下载记录';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `awe_erpt_para`
--

DROP TABLE IF EXISTS `awe_erpt_para`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `awe_erpt_para` (
  `ORGID` varchar(32) NOT NULL COMMENT '机构号',
  `DOCID` varchar(32) NOT NULL COMMENT '报告模板编号',
  `DEFAULTVALUE` varchar(400) DEFAULT NULL COMMENT '默认打印节点',
  `DOCNAME` varchar(80) DEFAULT NULL COMMENT '模板名称',
  `ATTRIBUTE1` varchar(80) DEFAULT NULL COMMENT '属性1',
  `ATTRIBUTE2` varchar(80) DEFAULT NULL COMMENT '属性2',
  `INPUTUSER` varchar(32) DEFAULT NULL COMMENT '录入用户编号',
  `INPUTTIME` varchar(32) DEFAULT NULL COMMENT '录入时间',
  `UPDATEUSER` varchar(32) DEFAULT NULL COMMENT '更新用户编号',
  `UPDATEDATE` varchar(32) DEFAULT NULL COMMENT '更新时间',
  `REMARK` varchar(200) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`DOCID`,`ORGID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='电子报告参数表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `awe_erpt_record`
--

DROP TABLE IF EXISTS `awe_erpt_record`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `awe_erpt_record` (
  `SERIALNO` varchar(32) NOT NULL COMMENT '记录号',
  `OBJECTTYPE` varchar(18) NOT NULL COMMENT '对象类型',
  `OBJECTNO` varchar(32) NOT NULL COMMENT '对象编号',
  `DOCID` varchar(18) NOT NULL COMMENT '格式化报告编号',
  `SAVEDATE` varchar(10) DEFAULT NULL COMMENT '生成报告日期',
  `SAVEPATH` varchar(256) DEFAULT NULL COMMENT '保存路径',
  `ATTRIBUTE1` varchar(40) DEFAULT NULL COMMENT '属性1',
  `ATTRIBUTE2` varchar(40) DEFAULT NULL COMMENT '属性2',
  `ATTRIBUTE3` varchar(40) DEFAULT NULL COMMENT '属性3',
  `ATTRIBUTE4` varchar(40) DEFAULT NULL COMMENT '属性4',
  `ATTRIBUTE5` varchar(40) DEFAULT NULL COMMENT '属性5',
  `ORGID` varchar(32) DEFAULT NULL COMMENT '机构',
  `USERID` varchar(32) DEFAULT NULL COMMENT '登记人',
  `INPUTDATE` varchar(10) DEFAULT NULL COMMENT '登记日期',
  `UPDATEDATE` varchar(10) DEFAULT NULL COMMENT '更新日期',
  `OFFLINEVERSION` int(11) DEFAULT NULL COMMENT '离线报告最新版本号',
  PRIMARY KEY (`SERIALNO`),
  KEY `IX_ERPT_RECORD_1` (`OBJECTTYPE`,`OBJECTNO`,`DOCID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='电子报告文档记录';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `awe_erpt_type`
--

DROP TABLE IF EXISTS `awe_erpt_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `awe_erpt_type` (
  `TYPENO` varchar(32) NOT NULL COMMENT '分类编号',
  `TYPETITLE` varchar(80) DEFAULT NULL COMMENT '分类标题',
  `SORTNO` varchar(32) DEFAULT NULL COMMENT '排序号',
  `ISINUSE` varchar(1) DEFAULT NULL COMMENT '是否使用',
  `ATTRIBUTE1` varchar(32) DEFAULT NULL COMMENT '属性1',
  `ATTRIBUTE2` varchar(32) DEFAULT NULL COMMENT '属性2',
  `ATTRIBUTE3` varchar(32) DEFAULT NULL COMMENT '属性3',
  `ATTRIBUTE4` varchar(32) DEFAULT NULL COMMENT '属性4',
  `ATTRIBUTE5` varchar(255) DEFAULT NULL COMMENT '属性5',
  `ATTRIBUTE6` varchar(255) DEFAULT NULL COMMENT '属性6',
  `ATTRIBUTE7` varchar(400) DEFAULT NULL COMMENT '属性7',
  `ATTRIBUTE8` varchar(400) DEFAULT NULL COMMENT '属性8',
  PRIMARY KEY (`TYPENO`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='电子报告分类管理';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `awe_erpt_version`
--

DROP TABLE IF EXISTS `awe_erpt_version`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `awe_erpt_version` (
  `VERSIONNO` varchar(32) NOT NULL COMMENT '版本编号',
  `CURDOCID` varchar(32) NOT NULL COMMENT '当前报告编号',
  `ORIGDOCID` varchar(32) DEFAULT NULL COMMENT '原始报告编号',
  `INPUTUSER` varchar(32) DEFAULT NULL COMMENT '录入用户编号',
  `INPUTTIME` varchar(20) DEFAULT NULL COMMENT '录入时间',
  `UPDATEUSER` varchar(32) DEFAULT NULL COMMENT '更新用户编号',
  `UPATETIME` varchar(20) DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`VERSIONNO`,`CURDOCID`),
  KEY `IX_ERPT_VERSION_1` (`ORIGDOCID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='电子报告版本';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `awe_function_url`
--

DROP TABLE IF EXISTS `awe_function_url`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `awe_function_url` (
  `SERIALNO` varchar(32) NOT NULL COMMENT '流水号',
  `FUNCTIONID` varchar(32) DEFAULT NULL COMMENT '功能点编号',
  `RIGHTPOINTTYPE` varchar(32) NOT NULL COMMENT '权限点类型',
  `RIGHTPOINTNAME` varchar(80) NOT NULL COMMENT '权限点名称',
  `URL` varchar(200) NOT NULL COMMENT 'URL路径',
  `REMARK` varchar(250) DEFAULT NULL COMMENT '备注',
  `INPUTORGID` varchar(32) DEFAULT NULL COMMENT '录入机构',
  `INPUTUSERID` varchar(32) DEFAULT NULL COMMENT '录入人',
  `INPUTTIME` varchar(20) DEFAULT NULL COMMENT '录入时间',
  `UPDATEORGID` varchar(32) DEFAULT NULL COMMENT '更新机构',
  `UPDATEUSERID` varchar(32) DEFAULT NULL COMMENT '更新人',
  `UPDATETIME` varchar(20) DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`SERIALNO`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='功能点与页面URL的关系表。一个功能点可以对应多个URL';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `awe_group_catalog`
--

DROP TABLE IF EXISTS `awe_group_catalog`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `awe_group_catalog` (
  `GROUPID` varchar(32) NOT NULL COMMENT '组合编号',
  `GROUPNAME` varchar(64) DEFAULT NULL COMMENT '组合名称',
  `GROUPDESCRIBE` varchar(80) DEFAULT NULL COMMENT '描述',
  `CLASSIFYID` varchar(32) DEFAULT NULL COMMENT '分类编号',
  `DISPLAYTYPE` varchar(18) DEFAULT NULL COMMENT '展现类型',
  `DEFAULTPAGE` varchar(400) DEFAULT NULL COMMENT '默认页面',
  `ISINUSE` varchar(1) DEFAULT NULL COMMENT '是否使用',
  `ATTRIBUTE1` varchar(80) DEFAULT NULL COMMENT '属性1',
  `ATTRIBUTE2` varchar(80) DEFAULT NULL COMMENT '属性2',
  `ATTRIBUTE3` varchar(80) DEFAULT NULL COMMENT '属性3',
  `ATTRIBUTE4` varchar(80) DEFAULT NULL COMMENT '属性4',
  `ATTRIBUTE5` varchar(80) DEFAULT NULL COMMENT '属性5',
  `INPUTORG` varchar(32) DEFAULT NULL COMMENT '创建机构',
  `INPUTUSER` varchar(32) DEFAULT NULL COMMENT '创建人员',
  `INPUTTIME` varchar(20) DEFAULT NULL COMMENT '创建日期',
  `UPDATEUSER` varchar(32) DEFAULT NULL COMMENT '更新人',
  `UPDATETIME` varchar(20) DEFAULT NULL COMMENT '更新日期',
  `REMARK` varchar(250) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`GROUPID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='组合页面目录信息';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `awe_group_classify`
--

DROP TABLE IF EXISTS `awe_group_classify`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `awe_group_classify` (
  `CLASSIFYID` varchar(32) NOT NULL COMMENT '分类编号',
  `CLASSIFYNAME` varchar(80) DEFAULT NULL COMMENT '分类名称',
  `SORTNO` varchar(20) DEFAULT NULL COMMENT '排序号',
  `ISINUSE` varchar(1) DEFAULT NULL COMMENT '是否使用',
  `INPUTORG` varchar(32) DEFAULT NULL COMMENT '创建机构',
  `INPUTUSER` varchar(32) DEFAULT NULL COMMENT '创建人员',
  `INPUTTIME` varchar(20) DEFAULT NULL COMMENT '创建日期',
  `UPDATEORG` varchar(32) DEFAULT NULL COMMENT '更新机构',
  `UPDATEUSER` varchar(32) DEFAULT NULL COMMENT '更新人',
  `UPDATETIME` varchar(20) DEFAULT NULL COMMENT '更新日期',
  PRIMARY KEY (`CLASSIFYID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='组合页面分类信息';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `awe_group_item`
--

DROP TABLE IF EXISTS `awe_group_item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `awe_group_item` (
  `GROUPID` varchar(32) NOT NULL COMMENT '组合编号',
  `ITEMNO` varchar(32) NOT NULL COMMENT '项目编号',
  `ITEMNAME` varchar(64) DEFAULT NULL COMMENT '项目名称',
  `ITEMDESCRIBE` varchar(80) DEFAULT NULL COMMENT '描述',
  `SORTNO` varchar(16) DEFAULT NULL COMMENT '排序号',
  `URL` varchar(320) DEFAULT NULL COMMENT '页面路径',
  `PARAMS` varchar(240) DEFAULT NULL COMMENT '参数',
  `CHECKMETHOD` varchar(320) DEFAULT NULL COMMENT '检验方法',
  `ISINUSE` varchar(1) DEFAULT NULL COMMENT '是否使用',
  `ATTRIBUTE1` varchar(80) DEFAULT NULL COMMENT '属性1',
  `ATTRIBUTE2` varchar(80) DEFAULT NULL COMMENT '属性2',
  `ATTRIBUTE3` varchar(80) DEFAULT NULL COMMENT '属性3',
  `ATTRIBUTE4` varchar(80) DEFAULT NULL COMMENT '属性4',
  `ATTRIBUTE5` varchar(80) DEFAULT NULL COMMENT '属性5',
  `INPUTORG` varchar(32) DEFAULT NULL COMMENT '创建机构',
  `INPUTUSER` varchar(32) DEFAULT NULL COMMENT '创建人员',
  `INPUTTIME` varchar(20) DEFAULT NULL COMMENT '创建日期',
  `UPDATEUSER` varchar(32) DEFAULT NULL COMMENT '更新人',
  `UPDATETIME` varchar(20) DEFAULT NULL COMMENT '更新日期',
  `REMARK` varchar(250) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`GROUPID`,`ITEMNO`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='组合页面详细信息';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `awe_href_info`
--

DROP TABLE IF EXISTS `awe_href_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `awe_href_info` (
  `HREF` varchar(200) NOT NULL,
  `HREFTYPE` varchar(200) NOT NULL,
  `HREFDESCRIBE` varchar(250) DEFAULT NULL,
  `INPUTORGID` varchar(32) DEFAULT NULL,
  `INPUTUSERID` varchar(32) DEFAULT NULL,
  `INPUTTIME` varchar(20) DEFAULT NULL,
  `UPDATEORGID` varchar(32) DEFAULT NULL,
  `UPDATEUSERID` varchar(32) DEFAULT NULL,
  `UPDATETIME` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`HREF`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='全局URL信息，需控制权限HREF的全集。';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `awe_jsp_runtime`
--

DROP TABLE IF EXISTS `awe_jsp_runtime`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `awe_jsp_runtime` (
  `JRTYPE` varchar(1) NOT NULL COMMENT '统计类型（H小时、D天）',
  `JRTERM` varchar(16) NOT NULL COMMENT '统计周期',
  `SERVERID` varchar(120) NOT NULL COMMENT '服务标识',
  `JRCOUNT` int(11) DEFAULT NULL COMMENT '运行次数',
  `JRTIME` decimal(24,2) DEFAULT NULL COMMENT '耗时',
  PRIMARY KEY (`JRTYPE`,`JRTERM`,`SERVERID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='统计JSP运行信息';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `awe_menu_info`
--

DROP TABLE IF EXISTS `awe_menu_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `awe_menu_info` (
  `MENUID` varchar(32) NOT NULL COMMENT '菜单编号',
  `MENUNAME` varchar(250) DEFAULT NULL COMMENT '菜单名称',
  `DISPLAYNAME` varchar(32) DEFAULT NULL COMMENT '显示名称',
  `SORTNO` varchar(32) DEFAULT NULL COMMENT '排序号',
  `URL` varchar(200) DEFAULT NULL COMMENT 'URL路径',
  `URLPARAM` varchar(150) DEFAULT NULL COMMENT 'URL参数',
  `TARGET` varchar(20) DEFAULT NULL COMMENT '目标窗口',
  `STYLE` varchar(20) DEFAULT NULL COMMENT '样式',
  `ISINUSE` varchar(1) DEFAULT NULL COMMENT '是否使用',
  `REMARK` varchar(250) DEFAULT NULL COMMENT '备注',
  `INPUTORGID` varchar(32) DEFAULT NULL COMMENT '录入机构',
  `INPUTUSERID` varchar(32) DEFAULT NULL COMMENT '录入人',
  `INPUTTIME` varchar(20) DEFAULT NULL COMMENT '录入时间',
  `UPDATEORGID` varchar(32) DEFAULT NULL COMMENT '更新机构',
  `UPDATEUSERID` varchar(32) DEFAULT NULL COMMENT '更新人',
  `UPDATETIME` varchar(20) DEFAULT NULL COMMENT '更新时间',
  `ACCESSTYPE` varchar(20) DEFAULT NULL COMMENT '打开方式',
  `ICON` varchar(80) DEFAULT NULL COMMENT '菜单图标',
  `APPICON` varchar(80) DEFAULT NULL COMMENT '子系统图标',
  PRIMARY KEY (`MENUID`),
  KEY `IDX1_MENU_INFO` (`SORTNO`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='系统菜单表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `awe_query_info`
--

DROP TABLE IF EXISTS `awe_query_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `awe_query_info` (
  `QUERYSCHEMENO` varchar(32) NOT NULL COMMENT '查询方案编号',
  `QUERYSCHEMENAME` varchar(100) DEFAULT NULL COMMENT '查询方案名称',
  `BIZOBJCLASS` varchar(80) NOT NULL COMMENT '主对象',
  `RELATEDCLASS` varchar(200) DEFAULT NULL COMMENT '关联对象串（JSON格式）',
  `RELATION` varchar(1000) DEFAULT NULL COMMENT '对象间关系',
  `QUERYCLAUSE` blob COMMENT '查询条件',
  `DISPLAYITEMS` blob COMMENT '输出信息项',
  `ORDERITEMS` blob COMMENT '排序信息项',
  `GROUPITEMS` varchar(200) DEFAULT NULL COMMENT '汇总信息项',
  `SUMMARYITEMS` varchar(200) DEFAULT NULL COMMENT '合计信息项',
  `FILTERCOLS` blob COMMENT '查询条件列',
  `QUERYPARAMS` blob COMMENT '参数变量串',
  `QUERYSQL` blob COMMENT '查询脚本',
  `ISPRIVATE` varchar(2) DEFAULT NULL COMMENT '是否私有',
  `FREQUENCY` int(11) DEFAULT NULL COMMENT '查询频率',
  `USERID` varchar(32) DEFAULT NULL COMMENT '录入人',
  `ORGID` varchar(32) DEFAULT NULL COMMENT '录入机构',
  `UPDATEDATE` varchar(20) DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`QUERYSCHEMENO`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='查询方案基本信息';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `awe_query_user`
--

DROP TABLE IF EXISTS `awe_query_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `awe_query_user` (
  `SERIALNO` varchar(32) NOT NULL COMMENT '流水号',
  `USERID` varchar(32) NOT NULL COMMENT '用户编号',
  `QUERYID` varchar(32) DEFAULT NULL COMMENT '查询id',
  `STATUS` varchar(16) NOT NULL COMMENT '状态',
  `FILEPATH` varchar(200) DEFAULT NULL COMMENT '文件目录',
  `FILENAME` varchar(300) DEFAULT NULL COMMENT '文件名',
  `STARTTIME` varchar(20) DEFAULT NULL COMMENT '开始时间',
  `REMARK` varchar(100) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`SERIALNO`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='查询异步下载';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `awe_quick_href`
--

DROP TABLE IF EXISTS `awe_quick_href`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `awe_quick_href` (
  `QUICKID` varchar(32) NOT NULL COMMENT '快捷链接编号',
  `QUICKNAME` varchar(80) NOT NULL COMMENT '快捷链接名称',
  `QUICKTYPE` varchar(32) NOT NULL COMMENT '快捷链接类型，代码CODE_LIBRARY.CodeNo=QuickType',
  `QUICKPARAMS` varchar(200) DEFAULT NULL COMMENT '快捷链接参数',
  `REMARK` varchar(250) DEFAULT NULL COMMENT '备注',
  `FORUSER` varchar(32) NOT NULL COMMENT '服务用户',
  `ISINUSE` varchar(1) NOT NULL COMMENT '有效标记，代码CODE_LIBRARY.CodeNo=IsInUse',
  `SORTNO` varchar(25) DEFAULT NULL COMMENT '排序号',
  `INPUTORG` varchar(32) DEFAULT NULL COMMENT '录入机构',
  `INPUTUSER` varchar(32) DEFAULT NULL COMMENT '录入人',
  `INPUTTIME` varchar(20) DEFAULT NULL COMMENT '录入时间',
  `UPDATEORG` varchar(32) DEFAULT NULL COMMENT '更新机构',
  `UPDATEUSER` varchar(32) DEFAULT NULL COMMENT '更新人',
  `UPDATETIME` varchar(20) DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`QUICKID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='快捷链接';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `awe_record_info`
--

DROP TABLE IF EXISTS `awe_record_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `awe_record_info` (
  `SERIALNO` varchar(32) NOT NULL COMMENT '流水号',
  `RECORDUSER` varchar(32) DEFAULT NULL COMMENT '记录用户',
  `RECORDTIME` varchar(20) DEFAULT NULL COMMENT '记录时间',
  `RECORDREASON` varchar(200) DEFAULT NULL COMMENT '记录原因',
  `RECORDCONTENT` varchar(2000) DEFAULT NULL COMMENT '记录内容',
  PRIMARY KEY (`SERIALNO`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='操作记录信息';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `awe_role_menu`
--

DROP TABLE IF EXISTS `awe_role_menu`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `awe_role_menu` (
  `ROLEID` varchar(32) NOT NULL COMMENT '角色编号',
  `MENUID` varchar(32) NOT NULL COMMENT '菜单编号',
  PRIMARY KEY (`MENUID`,`ROLEID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='角色、菜单关联表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `awe_role_url`
--

DROP TABLE IF EXISTS `awe_role_url`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `awe_role_url` (
  `ROLEID` varchar(32) NOT NULL COMMENT '角色编号',
  `URL` varchar(200) NOT NULL COMMENT 'URL路径',
  PRIMARY KEY (`ROLEID`,`URL`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='根据角色子系统关联表，取得对应URL； 根据角色菜单关联表，取得对应URL； 根据角色功能点关联表，取得对应URL； 这';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `awe_sso_login_info`
--

DROP TABLE IF EXISTS `awe_sso_login_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `awe_sso_login_info` (
  `ACCOUNT` varchar(80) NOT NULL COMMENT '登录账号',
  `SSOINFO` varchar(2000) DEFAULT NULL COMMENT 'SSO信息',
  PRIMARY KEY (`ACCOUNT`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='SSO账号信息';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `awe_task_info`
--

DROP TABLE IF EXISTS `awe_task_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `awe_task_info` (
  `SERIALNO` varchar(32) NOT NULL COMMENT '任务编号',
  `TASKTITLE` varchar(80) DEFAULT NULL COMMENT '任务名',
  `TASKDESC` varchar(400) DEFAULT NULL COMMENT '任务描述',
  `STARTUSERID` varchar(32) DEFAULT NULL COMMENT '发起人',
  `DOUSERID` varchar(32) DEFAULT NULL COMMENT '执行人',
  `STARTTIME` varchar(20) DEFAULT NULL COMMENT '发起时间',
  `PREENDTIME` varchar(20) DEFAULT NULL COMMENT '预计完成时间',
  `TRUEENDTIME` varchar(20) DEFAULT NULL COMMENT '实际完成时间',
  `FINISHFLAG` char(1) DEFAULT NULL COMMENT '完成状态',
  `ACTIONTYPE` varchar(80) DEFAULT NULL COMMENT '操作分类',
  `ACTIONPARAM` varchar(200) DEFAULT NULL COMMENT '操作参数',
  `CATALOGID` varchar(32) DEFAULT NULL COMMENT '任务分类编号',
  `CATALOGTITLE` varchar(80) DEFAULT NULL COMMENT '任务分类名',
  `EXPORTEDCOUNT` int(11) DEFAULT NULL COMMENT '导出计数',
  `INPUTDATE` varchar(20) DEFAULT NULL COMMENT '创建日期',
  `INPUTUSER` varchar(32) DEFAULT NULL COMMENT '创建人员',
  `UPDATEDATE` varchar(20) DEFAULT NULL COMMENT '更新日期',
  `UPDATEUSER` varchar(32) DEFAULT NULL COMMENT '更新人',
  PRIMARY KEY (`SERIALNO`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='导出任务信息';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `awe_task_process`
--

DROP TABLE IF EXISTS `awe_task_process`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `awe_task_process` (
  `TASKID` varchar(32) NOT NULL COMMENT '任务编号',
  `USERID` varchar(32) DEFAULT NULL COMMENT '执行人',
  `TOTALCOUNT` int(11) DEFAULT NULL COMMENT '总数',
  `EXPORTEDCOUNT` int(11) DEFAULT NULL COMMENT '已导出数',
  `THREADID` int(11) DEFAULT NULL COMMENT '线程号',
  `CANRUN` char(1) DEFAULT NULL COMMENT '运行状态',
  `UPDATETIME` decimal(22,0) DEFAULT NULL COMMENT '更新时间（精确到妙）',
  PRIMARY KEY (`TASKID`),
  KEY `IX_ATAPR_001` (`UPDATETIME`),
  KEY `IX_ATAPR_002` (`UPDATETIME`,`USERID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='导出任务进度信息';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `awe_wizard_catalog`
--

DROP TABLE IF EXISTS `awe_wizard_catalog`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `awe_wizard_catalog` (
  `WIZARDID` varchar(32) NOT NULL COMMENT '向导编号',
  `WIZARDNAME` varchar(80) DEFAULT NULL COMMENT '向导名称',
  `REMARK` varchar(200) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`WIZARDID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='向导目录';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `awe_wizard_library`
--

DROP TABLE IF EXISTS `awe_wizard_library`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `awe_wizard_library` (
  `WIZARDID` varchar(32) NOT NULL COMMENT '向导编号',
  `ITEMNO` varchar(32) NOT NULL COMMENT '步骤编号',
  `ITEMNAME` varchar(80) DEFAULT NULL COMMENT '步骤名称',
  `SORTNO` varchar(32) DEFAULT NULL COMMENT '步骤排序',
  `URL` varchar(200) DEFAULT NULL COMMENT '步骤地址',
  `PARAMS` varchar(500) DEFAULT NULL COMMENT '步骤定义参数',
  PRIMARY KEY (`WIZARDID`,`ITEMNO`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='向导步骤定义';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `awe_wizard_runner`
--

DROP TABLE IF EXISTS `awe_wizard_runner`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `awe_wizard_runner` (
  `WIZARDID` varchar(32) NOT NULL COMMENT '向导编号',
  `OBJECTNO` varchar(32) NOT NULL COMMENT '向导运行对象',
  `WIZARDINFO` varchar(4000) NOT NULL COMMENT '向导运行记录',
  PRIMARY KEY (`WIZARDID`,`OBJECTNO`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='向导运行记录';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `board_list`
--

DROP TABLE IF EXISTS `board_list`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `board_list` (
  `BOARDNO` varchar(32) NOT NULL COMMENT '公告编号',
  `BOARDNAME` varchar(100) DEFAULT NULL COMMENT '公告名称',
  `BOARDTITLE` varchar(100) DEFAULT NULL COMMENT '公告标题',
  `BOARDDESC` varchar(200) DEFAULT NULL COMMENT '公告描述',
  `ISPUBLISH` varchar(18) DEFAULT NULL COMMENT '是否发布',
  `ISNEW` varchar(18) DEFAULT NULL COMMENT '是否新',
  `ISEJECT` varchar(18) DEFAULT NULL COMMENT '是否弹出',
  `FILENAME` varchar(200) DEFAULT NULL COMMENT '公告文件名',
  `CONTENTTYPE` varchar(50) DEFAULT NULL COMMENT '内容类型',
  `CONTENTLENGTH` varchar(32) DEFAULT NULL COMMENT '内容长度',
  `UPLOADTIME` varchar(20) DEFAULT NULL COMMENT '上传时间',
  `DOCCONTENT` varchar(20) DEFAULT NULL COMMENT '文档内容',
  `SHOWTOROLES` varchar(80) DEFAULT NULL COMMENT '可查看角色列表',
  `SHOWTOORG` varchar(32) DEFAULT NULL COMMENT '可查看机构(含下属)',
  `SHOWTOORGS` varchar(32) DEFAULT NULL COMMENT '可查看机构清单(不含下属)',
  `FILEPATH` varchar(120) DEFAULT NULL COMMENT '文档路径',
  `FULLPATH` varchar(200) DEFAULT NULL COMMENT '文档全路径',
  `FILESAVEMODE` varchar(18) DEFAULT NULL COMMENT '文档保存方式',
  `ENDTIME` varchar(20) DEFAULT NULL COMMENT '结束时间',
  `DOCNO` varchar(32) DEFAULT NULL,
  PRIMARY KEY (`BOARDNO`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='通告信息';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `business_contract`
--

DROP TABLE IF EXISTS `business_contract`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `business_contract` (
  `SERIALNO` varchar(32) NOT NULL,
  `RELATIVESERIALNO` varchar(32) DEFAULT NULL,
  `ARTIFICIALNO` varchar(32) DEFAULT NULL,
  `OCCURDATE` varchar(10) DEFAULT NULL,
  `CUSTOMERID` varchar(32) DEFAULT NULL,
  `CUSTOMERNAME` varchar(80) DEFAULT NULL,
  `BUSINESSTYPE` varchar(18) DEFAULT NULL,
  `OLDBUSINESSTYPE` varchar(18) DEFAULT NULL,
  `BUSINESSSUBTYPE` varchar(18) DEFAULT NULL,
  `OCCURTYPE` varchar(18) DEFAULT NULL,
  `CREDITDIGEST` varchar(18) DEFAULT NULL,
  `CREDITCYCLE` varchar(18) DEFAULT NULL,
  `CREDITTYPE` varchar(18) DEFAULT NULL,
  `CURRENYLIST` varchar(18) DEFAULT NULL,
  `CURRENCYMODE` varchar(18) DEFAULT NULL,
  `BUSINESSTYPELIST` varchar(18) DEFAULT NULL,
  `CALCULATEMODE` varchar(18) DEFAULT NULL,
  `USEORGLIST` varchar(18) DEFAULT NULL,
  `FLOWREDUCEFLAG` varchar(18) DEFAULT NULL,
  `CONTRACTFLAG` varchar(18) DEFAULT NULL,
  `SUBCONTRACTFLAG` varchar(18) DEFAULT NULL,
  `SELFUSEFLAG` varchar(18) DEFAULT NULL,
  `CREDITINDEX` decimal(10,6) DEFAULT NULL,
  `CREDITREDUCESUM` decimal(24,6) DEFAULT NULL,
  `LIMITATIONTERM` varchar(10) DEFAULT NULL,
  `USETERM` varchar(10) DEFAULT NULL,
  `CREDITAGGREEMENT` varchar(32) DEFAULT NULL,
  `RELATIVEAGREEMENT` varchar(32) DEFAULT NULL,
  `LOANFLAG` varchar(18) DEFAULT NULL,
  `TOTALSUM` decimal(24,6) DEFAULT NULL,
  `OURROLE` varchar(18) DEFAULT NULL,
  `REVERSIBILITY` varchar(18) DEFAULT NULL,
  `BILLNUM` decimal(22,0) DEFAULT NULL,
  `HOUSETYPE` varchar(18) DEFAULT NULL,
  `LCTERMTYPE` varchar(18) DEFAULT NULL,
  `RISKATTRIBUTE` varchar(18) DEFAULT NULL,
  `SURETYPE` varchar(18) DEFAULT NULL,
  `SAFEGUARDTYPE` varchar(18) DEFAULT NULL,
  `CREDITBUSINESS` varchar(18) DEFAULT NULL,
  `BUSINESSCURRENCY` varchar(18) DEFAULT NULL,
  `BUSINESSSUM` decimal(24,6) DEFAULT NULL,
  `BUSINESSPROP` decimal(10,6) DEFAULT NULL,
  `TERMYEAR` decimal(22,0) DEFAULT NULL,
  `TERMMONTH` decimal(22,0) DEFAULT NULL,
  `TERMDAY` decimal(22,0) DEFAULT NULL,
  `LGTERM` decimal(22,0) DEFAULT NULL,
  `BASERATETYPE` varchar(18) DEFAULT NULL,
  `BASERATE` decimal(10,6) DEFAULT NULL,
  `RATEFLOATTYPE` varchar(18) DEFAULT NULL,
  `RATEFLOAT` decimal(10,6) DEFAULT NULL,
  `BUSINESSRATE` decimal(10,6) DEFAULT NULL,
  `ICTYPE` varchar(18) DEFAULT NULL,
  `ICCYC` varchar(18) DEFAULT NULL,
  `PDGRATIO` decimal(10,6) DEFAULT NULL,
  `PDGSUM` decimal(24,6) DEFAULT NULL,
  `PDGPAYMETHOD` varchar(18) DEFAULT NULL,
  `PDGPAYPERIOD` varchar(18) DEFAULT NULL,
  `PROMISESFEERATIO` decimal(10,6) DEFAULT NULL,
  `PROMISESFEESUM` decimal(24,6) DEFAULT NULL,
  `PROMISESFEEPERIOD` decimal(22,0) DEFAULT NULL,
  `PROMISESFEEBEGIN` varchar(10) DEFAULT NULL,
  `MFEERATIO` decimal(10,6) DEFAULT NULL,
  `MFEESUM` decimal(24,6) DEFAULT NULL,
  `MFEEPAYMETHOD` varchar(18) DEFAULT NULL,
  `AGENTFEE` decimal(24,6) DEFAULT NULL,
  `DEALFEE` decimal(24,6) DEFAULT NULL,
  `TOTALCAST` decimal(24,6) DEFAULT NULL,
  `DISCOUNTINTEREST` decimal(24,6) DEFAULT NULL,
  `PURCHASERINTEREST` decimal(24,6) DEFAULT NULL,
  `BARGAINORINTEREST` decimal(24,6) DEFAULT NULL,
  `DISCOUNTSUM` decimal(24,6) DEFAULT NULL,
  `BAILRATIO` decimal(10,6) DEFAULT NULL,
  `BAILCURRENCY` varchar(18) DEFAULT NULL,
  `BAILSUM` decimal(24,6) DEFAULT NULL,
  `BAILACCOUNT` varchar(32) DEFAULT NULL,
  `FINERATETYPE` varchar(18) DEFAULT NULL,
  `FINERATE` decimal(10,6) DEFAULT NULL,
  `DRAWINGTYPE` varchar(18) DEFAULT NULL,
  `FIRSTDRAWINGDATE` varchar(10) DEFAULT NULL,
  `DRAWINGPERIOD` decimal(22,0) DEFAULT NULL,
  `PAYTIMES` decimal(22,0) DEFAULT NULL,
  `PAYCYC` varchar(18) DEFAULT NULL,
  `GRACEPERIOD` decimal(22,0) DEFAULT NULL,
  `OVERDRAFTPERIOD` decimal(22,0) DEFAULT NULL,
  `OLDLCNO` varchar(32) DEFAULT NULL,
  `OLDLCTERMTYPE` varchar(18) DEFAULT NULL,
  `OLDLCCURRENCY` varchar(18) DEFAULT NULL,
  `OLDLCSUM` decimal(24,6) DEFAULT NULL,
  `OLDLCLOADINGDATE` varchar(10) DEFAULT NULL,
  `OLDLCVALIDDATE` varchar(10) DEFAULT NULL,
  `DIRECTION` varchar(18) DEFAULT NULL,
  `PURPOSE` varchar(200) DEFAULT NULL,
  `PLANALLOCATION` varchar(200) DEFAULT NULL,
  `IMMEDIACYPAYSOURCE` varchar(200) DEFAULT NULL,
  `PAYSOURCE` varchar(200) DEFAULT NULL,
  `CORPUSPAYMETHOD` varchar(18) DEFAULT NULL,
  `INTERESTPAYMETHOD` varchar(18) DEFAULT NULL,
  `PUTOUTDATE` varchar(10) DEFAULT NULL,
  `MATURITY` varchar(10) DEFAULT NULL,
  `THIRDPARTY1` varchar(200) DEFAULT NULL,
  `THIRDPARTYID1` varchar(32) DEFAULT NULL,
  `THIRDPARTY2` varchar(200) DEFAULT NULL,
  `THIRDPARTYID2` varchar(32) DEFAULT NULL,
  `THIRDPARTY3` varchar(200) DEFAULT NULL,
  `THIRDPARTYID3` varchar(32) DEFAULT NULL,
  `THIRDPARTYREGION` varchar(18) DEFAULT NULL,
  `THIRDPARTYACCOUNTS` varchar(32) DEFAULT NULL,
  `CARGOINFO` varchar(80) DEFAULT NULL,
  `PROJECTNAME` varchar(80) DEFAULT NULL,
  `OPERATIONINFO` varchar(400) DEFAULT NULL,
  `CONTEXTINFO` varchar(200) DEFAULT NULL,
  `SECURITIESTYPE` varchar(18) DEFAULT NULL,
  `SECURITIESREGION` varchar(18) DEFAULT NULL,
  `CONSTRUCTIONAREA` decimal(24,6) DEFAULT NULL,
  `USEAREA` decimal(24,6) DEFAULT NULL,
  `FLAG1` varchar(18) DEFAULT NULL,
  `FLAG2` varchar(18) DEFAULT NULL,
  `FLAG3` varchar(18) DEFAULT NULL,
  `TRADECONTRACTNO` varchar(32) DEFAULT NULL,
  `INVOICENO` varchar(32) DEFAULT NULL,
  `TRADECURRENCY` varchar(18) DEFAULT NULL,
  `TRADESUM` decimal(24,6) DEFAULT NULL,
  `LCNO` varchar(32) DEFAULT NULL,
  `PAYMENTDATE` varchar(10) DEFAULT NULL,
  `OPERATIONMODE` varchar(18) DEFAULT NULL,
  `BEGINDATE` varchar(10) DEFAULT NULL,
  `ENDDATE` varchar(10) DEFAULT NULL,
  `VOUCHCLASS` varchar(18) DEFAULT NULL,
  `VOUCHTYPE` varchar(18) DEFAULT NULL,
  `VOUCHTYPE1` varchar(18) DEFAULT NULL,
  `VOUCHTYPE2` varchar(18) DEFAULT NULL,
  `VOUCHFLAG` varchar(18) DEFAULT NULL,
  `WARRANTOR` varchar(80) DEFAULT NULL,
  `WARRANTORID` varchar(32) DEFAULT NULL,
  `OTHERCONDITION` varchar(400) DEFAULT NULL,
  `GUARANTYVALUE` decimal(24,6) DEFAULT NULL,
  `GUARANTYRATE` decimal(10,6) DEFAULT NULL,
  `BASEEVALUATERESULT` varchar(18) DEFAULT NULL,
  `RISKRATE` decimal(24,6) DEFAULT NULL,
  `LOWRISK` varchar(18) DEFAULT NULL,
  `OTHERAREALOAN` varchar(18) DEFAULT NULL,
  `LOWRISKBAILSUM` decimal(24,6) DEFAULT NULL,
  `APPLYTYPE` varchar(18) DEFAULT NULL,
  `ORIGINALPUTOUTDATE` varchar(10) DEFAULT NULL,
  `EXTENDTIMES` decimal(22,0) DEFAULT NULL,
  `LNGOTIMES` decimal(22,0) DEFAULT NULL,
  `GOLNTIMES` decimal(22,0) DEFAULT NULL,
  `DRTIMES` decimal(22,0) DEFAULT NULL,
  `GUARANTYNO` varchar(32) DEFAULT NULL,
  `PUTOUTSUM` decimal(24,6) DEFAULT NULL,
  `ACTUALPUTOUTSUM` decimal(24,6) DEFAULT NULL,
  `BALANCE` decimal(24,6) DEFAULT NULL,
  `NORMALBALANCE` decimal(24,6) DEFAULT NULL,
  `OVERDUEBALANCE` decimal(24,6) DEFAULT NULL,
  `DULLBALANCE` decimal(24,6) DEFAULT NULL,
  `BADBALANCE` decimal(24,6) DEFAULT NULL,
  `INTERESTBALANCE1` decimal(24,6) DEFAULT NULL,
  `INTERESTBALANCE2` decimal(24,6) DEFAULT NULL,
  `FINEBALANCE1` decimal(24,6) DEFAULT NULL,
  `FINEBALANCE2` decimal(24,6) DEFAULT NULL,
  `OVERDUEDAYS` decimal(22,0) DEFAULT NULL,
  `OWEINTERESTDAYS` decimal(22,0) DEFAULT NULL,
  `TABALANCE` decimal(24,6) DEFAULT NULL,
  `TAINTERESTBALANCE` decimal(24,6) DEFAULT NULL,
  `TATIMES` decimal(22,0) DEFAULT NULL,
  `LCATIMES` decimal(24,6) DEFAULT NULL,
  `PBINTERESTSUM` decimal(24,6) DEFAULT NULL,
  `PBMFEESUM` decimal(24,6) DEFAULT NULL,
  `PBPDGSUM` decimal(24,6) DEFAULT NULL,
  `PBLEGALCOSTSUM` decimal(24,6) DEFAULT NULL,
  `POLEGALCOSTSUM` decimal(24,6) DEFAULT NULL,
  `ORIGINALBADDATE` varchar(10) DEFAULT NULL,
  `BASECLASSIFYRESULT` varchar(18) DEFAULT NULL,
  `CLASSIFYRESULT` varchar(80) DEFAULT NULL,
  `CLASSIFYTYPE` varchar(18) DEFAULT NULL,
  `CLASSIFYDATE` varchar(10) DEFAULT NULL,
  `CLASSIFYORGID` varchar(32) DEFAULT NULL,
  `RESERVESUM` decimal(24,6) DEFAULT NULL,
  `EXPECTLOSSSUM` decimal(24,6) DEFAULT NULL,
  `BAILRATE` decimal(24,6) DEFAULT NULL,
  `FINISHORG` varchar(18) DEFAULT NULL,
  `FINISHTYPE` varchar(18) DEFAULT NULL,
  `FINISHDATE` varchar(10) DEFAULT NULL,
  `DESCRIBE1` varchar(100) DEFAULT NULL,
  `REINFORCEFLAG` varchar(18) DEFAULT NULL,
  `MANAGEORGID` varchar(32) DEFAULT NULL,
  `MANAGEUSERID` varchar(32) DEFAULT NULL,
  `RECOVERYORGID` varchar(32) DEFAULT NULL,
  `RECOVERYUSERID` varchar(32) DEFAULT NULL,
  `STATORGID` varchar(32) DEFAULT NULL,
  `STATUSERID` varchar(32) DEFAULT NULL,
  `OPERATEORGID` varchar(32) DEFAULT NULL,
  `OPERATEUSERID` varchar(32) DEFAULT NULL,
  `OPERATEDATE` varchar(10) DEFAULT NULL,
  `INPUTORGID` varchar(32) DEFAULT NULL,
  `INPUTUSERID` varchar(32) DEFAULT NULL,
  `INPUTDATE` varchar(10) DEFAULT NULL,
  `UPDATEDATE` varchar(10) DEFAULT NULL,
  `PIGEONHOLEDATE` varchar(10) DEFAULT NULL,
  `REMARK` varchar(200) DEFAULT NULL,
  `FLAG4` varchar(18) DEFAULT NULL,
  `PAYCURRENCY` varchar(18) DEFAULT NULL,
  `PAYDATE` varchar(10) DEFAULT NULL,
  `FLAG5` varchar(18) DEFAULT NULL,
  `CLASSIFYSUM1` decimal(24,6) DEFAULT NULL,
  `CLASSIFYSUM2` decimal(24,6) DEFAULT NULL,
  `CLASSIFYSUM3` decimal(24,6) DEFAULT NULL,
  `CLASSIFYSUM4` decimal(24,6) DEFAULT NULL,
  `CLASSIFYSUM5` decimal(24,6) DEFAULT NULL,
  `SHIFTTYPE` varchar(18) DEFAULT NULL,
  `OPERATETYPE` varchar(18) DEFAULT NULL,
  `FUNDSOURCE` varchar(18) DEFAULT NULL,
  `CYCLEFLAG` varchar(18) DEFAULT NULL,
  `CREDITFREEZEFLAG` varchar(18) DEFAULT NULL,
  `SHIFTBALANCE` decimal(24,6) DEFAULT NULL,
  `CLASSIFYFREQUENCY` decimal(22,0) DEFAULT NULL,
  `CLASSIFYLEVEL` varchar(18) DEFAULT NULL,
  `VOUCHNEWFLAG` varchar(18) DEFAULT NULL,
  `ACTUALARTIFICIALNO` varchar(32) DEFAULT NULL,
  `DELETEFLAG` varchar(18) DEFAULT NULL,
  `ACCOUNTNO` varchar(32) DEFAULT NULL,
  `LOANACCOUNTNO` varchar(32) DEFAULT NULL,
  `SECONDPAYACCOUNT` varchar(32) DEFAULT NULL,
  `ADJUSTRATETYPE` varchar(18) DEFAULT NULL,
  `ADJUSTRATETERM` varchar(18) DEFAULT NULL,
  `OVERINTTYPE` varchar(18) DEFAULT NULL,
  `RATEADJUSTCYC` varchar(18) DEFAULT NULL,
  `PDGACCOUNTNO` varchar(32) DEFAULT NULL,
  `DEDUCTDATE` varchar(10) DEFAULT NULL,
  `FZANBALANCE` decimal(24,6) DEFAULT NULL,
  `ACCEPTINTTYPE` varchar(18) DEFAULT NULL,
  `RATIO` decimal(24,6) DEFAULT NULL,
  `THIRDPARTYADD1` varchar(80) DEFAULT NULL,
  `THIRDPARTYZIP1` varchar(32) DEFAULT NULL,
  `THIRDPARTYADD2` varchar(80) DEFAULT NULL,
  `THIRDPARTYZIP2` varchar(32) DEFAULT NULL,
  `THIRDPARTYADD3` varchar(80) DEFAULT NULL,
  `THIRDPARTYZIP3` varchar(32) DEFAULT NULL,
  `EFFECTAREA` varchar(18) DEFAULT NULL,
  `TERMDATE1` varchar(10) DEFAULT NULL,
  `TERMDATE2` varchar(10) DEFAULT NULL,
  `TERMDATE3` varchar(10) DEFAULT NULL,
  `FIXCYC` decimal(22,0) DEFAULT NULL,
  `DESCRIBE2` varchar(100) DEFAULT NULL,
  `CANCELSUM` decimal(24,6) DEFAULT NULL,
  `CANCELINTEREST` decimal(24,6) DEFAULT NULL,
  `LOANTERM` varchar(18) DEFAULT NULL,
  `PUTOUTORGID` varchar(32) DEFAULT NULL,
  `TEMPSAVEFLAG` varchar(18) DEFAULT NULL,
  `OVERDUEDATE` varchar(10) DEFAULT NULL,
  `OWEINTERESTDATE` varchar(10) DEFAULT NULL,
  `FREEZEFLAG` varchar(1) DEFAULT NULL,
  `APPROVEDATE` varchar(10) DEFAULT NULL,
  `SHIFTSTATUS` varchar(18) DEFAULT NULL,
  `RECOVERYCOGNORGID` varchar(32) DEFAULT NULL,
  `RECOVERYCOGNUSERID` varchar(32) DEFAULT NULL,
  `SHIFTDOCDESCRIBE` varchar(800) DEFAULT NULL,
  `GUARANTYFLAG` varchar(18) DEFAULT NULL,
  `TOTALBALANCE` decimal(24,6) DEFAULT NULL,
  `GROUPLINEID` varchar(40) DEFAULT NULL,
  `TRANSFORMTIMES` decimal(22,0) DEFAULT NULL,
  `TRANSFORMFLAG` varchar(1) DEFAULT NULL,
  `FUNDBACKACCOUNT` varchar(20) DEFAULT NULL,
  `REQUITALACCOUNT` varchar(20) DEFAULT NULL,
  `PAYMENTMODE` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`SERIALNO`),
  KEY `IDX1_BUSINESS_CONTRACT` (`CUSTOMERID`),
  KEY `IDX2_BUSINESS_CONTRACT` (`ARTIFICIALNO`),
  KEY `IDX3_BUSINESS_CONTRACT` (`RELATIVESERIALNO`),
  KEY `IDX4_BUSINESS_CONTRACT` (`BUSINESSTYPE`),
  KEY `IDX5_BUSINESS_CONTRACT` (`MANAGEORGID`,`REINFORCEFLAG`),
  KEY `IDX6_BUSINESS_CONTRACT` (`MANAGEORGID`,`MANAGEUSERID`,`BUSINESSTYPE`),
  KEY `IDX7_BUSINESS_CONTRACT` (`CREDITAGGREEMENT`),
  KEY `IDX8_BUSINESS_CONTRACT` (`OPERATEUSERID`,`OPERATEORGID`),
  KEY `IDX9_BUSINESS_CONTRACT` (`RECOVERYORGID`,`RECOVERYUSERID`),
  KEY `IDX10_BUSINESS_CONTRACT` (`MANAGEUSERID`,`REINFORCEFLAG`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `business_duebill`
--

DROP TABLE IF EXISTS `business_duebill`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `business_duebill` (
  `SERIALNO` varchar(40) NOT NULL,
  `RELATIVESERIALNO1` varchar(40) DEFAULT NULL,
  `RELATIVESERIALNO2` varchar(40) DEFAULT NULL,
  `SUBJECTNO` varchar(20) DEFAULT NULL,
  `MFCUSTOMERID` varchar(40) DEFAULT NULL,
  `CUSTOMERID` varchar(40) DEFAULT NULL,
  `CUSTOMERNAME` varchar(80) DEFAULT NULL,
  `BUSINESSTYPE` varchar(18) DEFAULT NULL,
  `BUSINESSSUBTYPE` varchar(20) DEFAULT NULL,
  `BUSINESSSTATUS` varchar(20) DEFAULT NULL,
  `BUSINESSCURRENCY` varchar(20) DEFAULT NULL,
  `BUSINESSSUM` decimal(24,6) DEFAULT NULL,
  `PUTOUTDATE` varchar(10) DEFAULT NULL,
  `MATURITY` varchar(10) DEFAULT NULL,
  `ACTUALMATURITY` varchar(10) DEFAULT NULL,
  `BUSINESSRATE` decimal(24,10) DEFAULT NULL,
  `ACTUALBUSINESSRATE` decimal(10,6) DEFAULT NULL,
  `ICTYPE` varchar(20) DEFAULT NULL,
  `ICCYC` varchar(20) DEFAULT NULL,
  `PAYTIMES` decimal(22,0) DEFAULT NULL,
  `PAYCYC` varchar(20) DEFAULT NULL,
  `CORPUSPAYMETHOD` varchar(20) DEFAULT NULL,
  `EXTENDTIMES` decimal(22,0) DEFAULT NULL,
  `REORGTIMES` decimal(22,0) DEFAULT NULL,
  `RENEWTIMES` decimal(22,0) DEFAULT NULL,
  `GOLNTIMES` decimal(22,0) DEFAULT NULL,
  `BALANCE` decimal(24,6) DEFAULT NULL,
  `NORMALBALANCE` decimal(24,6) DEFAULT NULL,
  `OVERDUEBALANCE` decimal(24,6) DEFAULT NULL,
  `DULLBALANCE` decimal(24,6) DEFAULT NULL,
  `BADBALANCE` decimal(24,6) DEFAULT NULL,
  `INTERESTBALANCE1` decimal(24,6) DEFAULT NULL,
  `INTERESTBALANCE2` decimal(24,6) DEFAULT NULL,
  `FINEBALANCE1` decimal(24,6) DEFAULT NULL,
  `FINEBALANCE2` decimal(24,6) DEFAULT NULL,
  `RECEIVEBALANCE` decimal(24,6) DEFAULT NULL,
  `PAYEDBALANCE` decimal(24,6) DEFAULT NULL,
  `OVERDUEDAYS` decimal(22,0) DEFAULT NULL,
  `PAYACCOUNT` varchar(40) DEFAULT NULL,
  `PUTOUTACCOUNT` varchar(40) DEFAULT NULL,
  `PAYBACKACCOUNT` varchar(40) DEFAULT NULL,
  `PAYINTERESTACCOUNT` varchar(40) DEFAULT NULL,
  `OWEINTERESTDAYS` decimal(22,0) DEFAULT NULL,
  `TABALANCE` decimal(24,6) DEFAULT NULL,
  `TAINTERESTBALANCE` decimal(24,6) DEFAULT NULL,
  `TATIMES` decimal(24,6) DEFAULT NULL,
  `LCATIMES` decimal(24,6) DEFAULT NULL,
  `SALEDATE` varchar(10) DEFAULT NULL,
  `FINISHTYPE` varchar(20) DEFAULT NULL,
  `FINISHDATE` varchar(10) DEFAULT NULL,
  `MFAREAID` varchar(20) DEFAULT NULL,
  `MFORGID` varchar(20) DEFAULT NULL,
  `MFUSERID` varchar(20) DEFAULT NULL,
  `OPERATEORGID` varchar(20) DEFAULT NULL,
  `OPERATEUSERID` varchar(20) DEFAULT NULL,
  `INPUTORGID` varchar(20) DEFAULT NULL,
  `INPUTUSERID` varchar(20) DEFAULT NULL,
  `INPUTDATE` varchar(10) DEFAULT NULL,
  `UPDATEDATE` varchar(10) DEFAULT NULL,
  `INOUTFLAG` varchar(40) DEFAULT NULL,
  `DEALFLAG` varchar(1) DEFAULT NULL,
  `OCCURDATE` varchar(10) DEFAULT NULL,
  `BUSINESSPROP` decimal(10,6) DEFAULT NULL,
  `BENEFITCORP` varchar(40) DEFAULT NULL,
  `ACTUALTERMMONTH` decimal(22,0) DEFAULT NULL,
  `ACTUALTERMDAY` decimal(22,0) DEFAULT NULL,
  `BASERATETYPE` varchar(20) DEFAULT NULL,
  `BASERATE` decimal(24,6) DEFAULT NULL,
  `RATEFLOATTYPE` varchar(20) DEFAULT NULL,
  `RATEFLOAT` decimal(24,6) DEFAULT NULL,
  `TIMSFLAG` varchar(40) DEFAULT NULL,
  `BAILRATIO` decimal(10,6) DEFAULT NULL,
  `LOGOUTDATE` varchar(10) DEFAULT NULL,
  `CANCELLOGOUTDATE` varchar(10) DEFAULT NULL,
  `BAILSUM` decimal(24,6) DEFAULT NULL,
  `BAILACCOUNT` varchar(40) DEFAULT NULL,
  `PURPOSE` varchar(200) DEFAULT NULL,
  `ADVANCEFLAG` varchar(20) DEFAULT NULL,
  `RELATIVEDUEBILLNO` varchar(40) DEFAULT NULL,
  `ACTUALARTIFICIALNO` varchar(40) DEFAULT NULL,
  `ACCOUNTNO` varchar(40) DEFAULT NULL,
  `LOANACCOUNTNO` varchar(40) DEFAULT NULL,
  `SECONDPAYACCOUNT` varchar(40) DEFAULT NULL,
  `ADJUSTRATETYPE` varchar(20) DEFAULT NULL,
  `ADJUSTRATETERM` varchar(20) DEFAULT NULL,
  `OVERINTTYPE` varchar(20) DEFAULT NULL,
  `RATEADJUSTCYC` varchar(20) DEFAULT NULL,
  `PDGACCOUNTNO` varchar(40) DEFAULT NULL,
  `DEDUCTDATE` varchar(10) DEFAULT NULL,
  `FZANBALANCE` decimal(24,6) DEFAULT NULL,
  `ACCEPTINTTYPE` varchar(20) DEFAULT NULL,
  `RATIO` decimal(24,6) DEFAULT NULL,
  `THIRDPARTYADD1` varchar(80) DEFAULT NULL,
  `THIRDPARTYZIP1` varchar(40) DEFAULT NULL,
  `THIRDPARTYADD2` varchar(80) DEFAULT NULL,
  `THIRDPARTYZIP2` varchar(40) DEFAULT NULL,
  `TERMDATE1` varchar(10) DEFAULT NULL,
  `TERMDATE2` varchar(10) DEFAULT NULL,
  `TERMDATE3` varchar(10) DEFAULT NULL,
  `DESCRIBE2` varchar(200) DEFAULT NULL,
  `FIXCYC` decimal(22,0) DEFAULT NULL,
  `THIRDPARTY1` varchar(200) DEFAULT NULL,
  `THIRDPARTYID1` varchar(40) DEFAULT NULL,
  `THIRDPARTY2` varchar(200) DEFAULT NULL,
  `THIRDPARTY3` varchar(200) DEFAULT NULL,
  `TYPE1` varchar(20) DEFAULT NULL,
  `TYPE2` varchar(20) DEFAULT NULL,
  `TYPE3` varchar(20) DEFAULT NULL,
  `BILLNO` varchar(40) DEFAULT NULL,
  `FLAG1` varchar(20) DEFAULT NULL,
  `FLAG2` varchar(20) DEFAULT NULL,
  `FLAG3` varchar(20) DEFAULT NULL,
  `THIRDPARTYREGION` varchar(20) DEFAULT NULL,
  `THIRDPARTYACCOUNTS` varchar(40) DEFAULT NULL,
  `CARGOINFO` varchar(80) DEFAULT NULL,
  `SECURITIESTYPE` varchar(20) DEFAULT NULL,
  `SECURITIESREGION` varchar(20) DEFAULT NULL,
  `ABOUTBANKID2` varchar(40) DEFAULT NULL,
  `ABOUTBANKNAME2` varchar(80) DEFAULT NULL,
  `ABOUTBANKID3` varchar(40) DEFAULT NULL,
  `ABOUTBANKNAME` varchar(80) DEFAULT NULL,
  `ABOUTBANKID` varchar(40) DEFAULT NULL,
  `OLDLCTERMTYPE` varchar(20) DEFAULT NULL,
  `NEGOTIATENO` varchar(40) DEFAULT NULL,
  `CREDITKIND` varchar(20) DEFAULT NULL,
  `GATHERINGNAME` varchar(80) DEFAULT NULL,
  `PREINTTYPE` varchar(20) DEFAULT NULL,
  `RESUMEINTTYPE` varchar(20) DEFAULT NULL,
  `GUARANTYNO` varchar(40) DEFAULT NULL,
  `PZTYPE` varchar(20) DEFAULT NULL,
  `GRACEPERIOD` decimal(22,0) DEFAULT NULL,
  `OLDLCVALIDDATE` varchar(10) DEFAULT NULL,
  `MFEEPAYMETHOD` varchar(20) DEFAULT NULL,
  `DESCRIBE1` varchar(200) DEFAULT NULL,
  `TRADECONTRACTNO` varchar(40) DEFAULT NULL,
  `LOANTYPE` varchar(20) DEFAULT NULL,
  `FIXTERM` decimal(24,6) DEFAULT NULL,
  `CANCELSUM` decimal(24,6) DEFAULT NULL,
  `CANCELINTEREST` decimal(24,6) DEFAULT NULL,
  `BAILACOUNT` varchar(40) DEFAULT NULL,
  `CLASSIFY4` varchar(18) DEFAULT NULL,
  `CLASSIFYRESULT` varchar(18) DEFAULT NULL,
  `RETURNTYPE` varchar(18) DEFAULT NULL,
  `BAILPERCENT` decimal(10,6) DEFAULT NULL,
  `PAYMENTTYPE` varchar(18) DEFAULT NULL,
  `TERMSFREQ` varchar(18) DEFAULT NULL,
  `OVERDUEDATE` varchar(10) DEFAULT NULL,
  `OWEINTERESTDATE` varchar(10) DEFAULT NULL,
  `LCSTATUS` varchar(18) DEFAULT NULL,
  `ICHANGEDATE` varchar(10) DEFAULT NULL,
  `VOUCHTYPE` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`SERIALNO`),
  KEY `IDX1_BUSINESS_DUEBILL` (`RELATIVESERIALNO2`),
  KEY `IDX2_BUSINESS_DUEBILL` (`CUSTOMERID`),
  KEY `IDX3_BUSINESS_DUEBILL` (`RELATIVESERIALNO1`),
  KEY `IDX4_BUSINESS_DUEBILL` (`SUBJECTNO`,`MFORGID`,`BUSINESSCURRENCY`),
  KEY `IDX5_BUSINESS_DUEBILL` (`ACTUALMATURITY`,`FINISHDATE`,`BALANCE`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `business_type`
--

DROP TABLE IF EXISTS `business_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `business_type` (
  `TYPENO` varchar(32) NOT NULL,
  `SORTNO` varchar(32) DEFAULT NULL,
  `TYPENAME` varchar(80) DEFAULT NULL,
  `TYPESORTNO` varchar(32) DEFAULT NULL,
  `SUBTYPECODE` varchar(32) DEFAULT NULL,
  `INFOSET` varchar(200) DEFAULT NULL,
  `DISPLAYTEMPLET` varchar(32) DEFAULT NULL,
  `ATTRIBUTE1` varchar(200) DEFAULT NULL,
  `ATTRIBUTE2` varchar(200) DEFAULT NULL,
  `ATTRIBUTE3` varchar(200) DEFAULT NULL,
  `ATTRIBUTE4` varchar(200) DEFAULT NULL,
  `ATTRIBUTE5` varchar(200) DEFAULT NULL,
  `ATTRIBUTE6` varchar(200) DEFAULT NULL,
  `ATTRIBUTE7` varchar(200) DEFAULT NULL,
  `ATTRIBUTE8` varchar(200) DEFAULT NULL,
  `ATTRIBUTE9` varchar(200) DEFAULT NULL,
  `ATTRIBUTE10` varchar(200) DEFAULT NULL,
  `REMARK` varchar(200) DEFAULT NULL,
  `APPLYDETAILNO` varchar(18) DEFAULT NULL,
  `APPROVEDETAILNO` varchar(18) DEFAULT NULL,
  `CONTRACTDETAILNO` varchar(18) DEFAULT NULL,
  `INPUTUSER` varchar(32) DEFAULT NULL,
  `INPUTORG` varchar(32) DEFAULT NULL,
  `INPUTTIME` varchar(20) DEFAULT NULL,
  `UPDATEUSER` varchar(32) DEFAULT NULL,
  `UPDATETIME` varchar(20) DEFAULT NULL,
  `ATTRIBUTE11` varchar(80) DEFAULT NULL,
  `ATTRIBUTE12` varchar(80) DEFAULT NULL,
  `ATTRIBUTE13` varchar(80) DEFAULT NULL,
  `ATTRIBUTE14` varchar(80) DEFAULT NULL,
  `ATTRIBUTE15` varchar(80) DEFAULT NULL,
  `ATTRIBUTE16` varchar(80) DEFAULT NULL,
  `ATTRIBUTE17` varchar(80) DEFAULT NULL,
  `ATTRIBUTE18` varchar(80) DEFAULT NULL,
  `ATTRIBUTE19` varchar(80) DEFAULT NULL,
  `ATTRIBUTE20` varchar(80) DEFAULT NULL,
  `ATTRIBUTE21` varchar(80) DEFAULT NULL,
  `ATTRIBUTE22` varchar(80) DEFAULT NULL,
  `ATTRIBUTE23` varchar(80) DEFAULT NULL,
  `ATTRIBUTE24` varchar(80) DEFAULT NULL,
  `ATTRIBUTE25` varchar(80) DEFAULT NULL,
  `ISINUSE` varchar(18) DEFAULT NULL,
  `OFFSHEETFLAG` varchar(32) DEFAULT NULL,
  PRIMARY KEY (`TYPENO`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `class_attribute`
--

DROP TABLE IF EXISTS `class_attribute`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `class_attribute` (
  `CLASSNAME` varchar(80) NOT NULL COMMENT '类名称',
  `ATTRIBUTENAME` varchar(80) NOT NULL COMMENT '属性名称',
  `ATTRIBUTETYPE` varchar(18) DEFAULT NULL COMMENT '属性类型',
  `ATTRIBUTEDESCRIBE` varchar(80) DEFAULT NULL COMMENT '属性描述',
  `INPUTUSER` varchar(32) DEFAULT NULL COMMENT '登记人',
  `INPUTORG` varchar(32) DEFAULT NULL COMMENT '登记机构',
  `INPUTTIME` varchar(20) DEFAULT NULL COMMENT '登记时间',
  `UPDATEUSER` varchar(32) DEFAULT NULL COMMENT '更新人',
  `UPDATETIME` varchar(20) DEFAULT NULL COMMENT '更新时间',
  `REMARK` varchar(250) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`CLASSNAME`,`ATTRIBUTENAME`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='方法属性库';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `class_catalog`
--

DROP TABLE IF EXISTS `class_catalog`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `class_catalog` (
  `CLASSNAME` varchar(80) NOT NULL COMMENT '方法集名称',
  `CLASSTYPE` varchar(18) DEFAULT NULL COMMENT '类分类',
  `CLASSDESCRIBE` varchar(250) DEFAULT NULL COMMENT '方法集描述',
  `PARENTCLASS` varchar(80) DEFAULT NULL COMMENT '父类名称',
  `INPUTUSER` varchar(32) DEFAULT NULL COMMENT '登记人',
  `INPUTORG` varchar(32) DEFAULT NULL COMMENT '登记机构',
  `INPUTTIME` varchar(20) DEFAULT NULL COMMENT '登记时间',
  `UPDATEUSER` varchar(32) DEFAULT NULL COMMENT '更新人',
  `UPDATETIME` varchar(20) DEFAULT NULL COMMENT '更新时间',
  `REMARK` varchar(250) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`CLASSNAME`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='方法集';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `class_method`
--

DROP TABLE IF EXISTS `class_method`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `class_method` (
  `CLASSNAME` varchar(80) NOT NULL COMMENT '方法集名称',
  `METHODNAME` varchar(80) NOT NULL COMMENT '方法名称',
  `METHODTYPE` varchar(18) DEFAULT NULL COMMENT '方法类型',
  `METHODDESCRIBE` varchar(250) DEFAULT NULL COMMENT '方法描述',
  `RETURNTYPE` varchar(18) DEFAULT NULL COMMENT '返回值类型',
  `METHODARGS` varchar(250) DEFAULT NULL COMMENT '方法参数',
  `METHODCODE` varchar(1600) DEFAULT NULL COMMENT '方法实现代码',
  `INPUTUSER` varchar(32) DEFAULT NULL COMMENT '登记人',
  `INPUTORG` varchar(32) DEFAULT NULL COMMENT '登记机构',
  `INPUTTIME` varchar(20) DEFAULT NULL COMMENT '登记时间',
  `UPDATEUSER` varchar(32) DEFAULT NULL COMMENT '更新人',
  `UPDATETIME` varchar(20) DEFAULT NULL COMMENT '更新时间',
  `REMARK` varchar(250) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`CLASSNAME`,`METHODNAME`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='方法库明细';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `classify_catalog`
--

DROP TABLE IF EXISTS `classify_catalog`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `classify_catalog` (
  `MODELNO` varchar(32) NOT NULL COMMENT '模型编号',
  `MODELNAME` varchar(80) DEFAULT NULL COMMENT '模型名称',
  `MODELDESCRIBE` varchar(80) DEFAULT NULL COMMENT '模型描述',
  `MODELATTRIBUTE` varchar(32) DEFAULT NULL COMMENT '模型属性',
  PRIMARY KEY (`MODELNO`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='风险分类模板目录';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `classify_data`
--

DROP TABLE IF EXISTS `classify_data`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `classify_data` (
  `SERIALNO` varchar(32) NOT NULL COMMENT '分类记录流水号',
  `OBJECTTYPE` varchar(18) NOT NULL COMMENT '对象类型',
  `OBJECTNO` varchar(32) NOT NULL COMMENT '对象编号',
  `ITEMNO` varchar(32) NOT NULL COMMENT '项目编号',
  `ITEMVALUE` varchar(80) DEFAULT NULL COMMENT '项目值',
  `EVALUATESCORE` decimal(24,6) DEFAULT NULL COMMENT '评估值',
  PRIMARY KEY (`OBJECTTYPE`,`OBJECTNO`,`SERIALNO`,`ITEMNO`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='风险分类数据';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `classify_model`
--

DROP TABLE IF EXISTS `classify_model`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `classify_model` (
  `MODELNO` varchar(32) NOT NULL COMMENT '模型编号',
  `GROUPNO` varchar(32) NOT NULL COMMENT '组编号',
  `CONDITIONNO` varchar(32) NOT NULL COMMENT '条件编号',
  `STATUS` varchar(80) NOT NULL COMMENT '状态',
  `NEXTSTATUS` varchar(80) DEFAULT NULL COMMENT '后续状态',
  `NEXTACTION` varchar(250) DEFAULT NULL COMMENT '后续动作',
  PRIMARY KEY (`MODELNO`,`GROUPNO`,`CONDITIONNO`,`STATUS`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='风险分类模型';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `classify_record`
--

DROP TABLE IF EXISTS `classify_record`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `classify_record` (
  `SERIALNO` varchar(32) NOT NULL COMMENT '流水号',
  `OBJECTTYPE` varchar(18) NOT NULL COMMENT '对象类型',
  `OBJECTNO` varchar(32) NOT NULL COMMENT '对象编号',
  `MODELNO` varchar(32) DEFAULT NULL COMMENT '分类模型编号',
  `CUSTOMERID` varchar(40) DEFAULT NULL COMMENT '客户编号',
  `FIRSTRESULT` varchar(18) DEFAULT NULL COMMENT '第一次分类结果',
  `SECONDRESULT` varchar(18) DEFAULT NULL COMMENT '第二次分类结果',
  `RESULT1` varchar(18) DEFAULT NULL COMMENT '客户经理分类认定结果',
  `RESULTOPINION1` varchar(200) DEFAULT NULL COMMENT '客户经理认定分类原因',
  `RESULT2` varchar(18) DEFAULT NULL COMMENT '支行分类认定结果',
  `RESULTOPINION2` varchar(200) DEFAULT NULL COMMENT '支行认定签署意见',
  `RESULT3` varchar(18) DEFAULT NULL COMMENT '分行风险管理分类认定结果',
  `RESULTOPINION3` varchar(200) DEFAULT NULL COMMENT '分行风险管理认定签署意见',
  `RESULT4` varchar(18) DEFAULT NULL COMMENT '分行领导分类认定结果',
  `RESULTOPINION4` varchar(200) DEFAULT NULL COMMENT '分行领导认定签署意见',
  `FINALLYRESULT` varchar(18) DEFAULT NULL COMMENT '最终认定结果',
  `SUM1` decimal(24,6) DEFAULT NULL COMMENT '人工拆分正常金额',
  `SUM2` decimal(24,6) DEFAULT NULL COMMENT '人工拆分关注金额',
  `SUM3` decimal(24,6) DEFAULT NULL COMMENT '人工拆分次级金额',
  `SUM4` decimal(24,6) DEFAULT NULL COMMENT '人工拆分可疑金额',
  `SUM5` decimal(24,6) DEFAULT NULL COMMENT '人工拆分损失金额',
  `EXPECTLOSSSUM` decimal(24,6) DEFAULT NULL COMMENT '预测损失金额',
  `RESERVESUM` decimal(24,6) DEFAULT NULL COMMENT '计提准备金额',
  `CLASSIFYUSERID` varchar(32) DEFAULT NULL COMMENT '评估人',
  `CLASSIFYORGID` varchar(32) DEFAULT NULL COMMENT '评估单位',
  `CLASSIFYDATE` varchar(10) DEFAULT NULL COMMENT '分类日期',
  `FINISHDATE` varchar(10) DEFAULT NULL COMMENT '分类完成日期',
  `INPUTDATE` varchar(10) DEFAULT NULL COMMENT '登记日期',
  `UPDATEDATE` varchar(10) DEFAULT NULL COMMENT '更新日期',
  `REMARK` varchar(200) DEFAULT NULL COMMENT '备注',
  `BUSINESSBALANCE` decimal(24,6) DEFAULT NULL COMMENT '分类时合同余额',
  `ORGID` varchar(32) DEFAULT NULL COMMENT '登记机构',
  `USERID` varchar(32) DEFAULT NULL COMMENT '登记人',
  `ACCOUNTMONTH` varchar(10) DEFAULT NULL COMMENT '分类截止日期',
  `RESULT5` varchar(18) DEFAULT NULL COMMENT '总行风险管理分类认定结果',
  `RESULTOPINION5` varchar(200) DEFAULT NULL COMMENT '总行风险管理认定签署意见',
  `RESULTUSERNAME5` varchar(80) DEFAULT NULL COMMENT '总行风险管理认定人',
  `RESULTUSERNAME4` varchar(80) DEFAULT NULL COMMENT '分行领导认定人',
  `RESULTUSERNAME3` varchar(80) DEFAULT NULL COMMENT '分行风险管理认定人',
  `RESULTUSERNAME2` varchar(80) DEFAULT NULL COMMENT '支行认定人',
  `RESULTUSERNAME1` varchar(80) DEFAULT NULL,
  `CLASSIFYLEVEL` varchar(18) DEFAULT NULL COMMENT '认定级别',
  `RESULTUSERID2` varchar(32) DEFAULT NULL COMMENT '支行认定人代码',
  `RESULTUSERID3` varchar(32) DEFAULT NULL COMMENT '分行认定人代码',
  `RESULTUSERID4` varchar(32) DEFAULT NULL COMMENT '分行领导认定人代码',
  `RESULTUSERID5` varchar(32) DEFAULT NULL COMMENT '总行风险管理认定人代码',
  `FINISHDATE2` varchar(10) DEFAULT NULL COMMENT '支行认定人完成时间',
  `FINISHDATE3` varchar(10) DEFAULT NULL COMMENT '分行认定人完成时间',
  `FINISHDATE4` varchar(10) DEFAULT NULL COMMENT '分行领导认定完成时间',
  `FINISHDATE5` varchar(10) DEFAULT NULL COMMENT '总行风管认定人完成时间',
  `ORIGINALPUTOUTDATE` varchar(10) DEFAULT NULL COMMENT '首次发放日',
  `LASTRESULT` varchar(18) DEFAULT NULL COMMENT '上次分类结果',
  PRIMARY KEY (`SERIALNO`,`OBJECTTYPE`,`OBJECTNO`),
  KEY `IDX1_CLASSIFY_REC` (`OBJECTTYPE`,`OBJECTNO`),
  KEY `IDX2_CLASSIFY_REC` (`USERID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='风险分类记录';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `code_catalog`
--

DROP TABLE IF EXISTS `code_catalog`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `code_catalog` (
  `CODENO` varchar(32) NOT NULL COMMENT '代码编号',
  `SORTNO` varchar(32) DEFAULT NULL COMMENT '排序号',
  `CODETYPEONE` varchar(80) DEFAULT NULL COMMENT '大类',
  `CODETYPETWO` varchar(80) DEFAULT NULL COMMENT '小类',
  `CODENAME` varchar(80) DEFAULT NULL COMMENT '代码名称',
  `CODEDESCRIBE` varchar(250) DEFAULT NULL COMMENT '代码描述',
  `CODEATTRIBUTE` varchar(250) DEFAULT NULL COMMENT '代码属性',
  `INPUTUSER` varchar(32) DEFAULT NULL COMMENT '登记人',
  `INPUTORG` varchar(32) DEFAULT NULL COMMENT '登记机构',
  `INPUTTIME` varchar(20) DEFAULT NULL COMMENT '登记时间',
  `UPDATEUSER` varchar(32) DEFAULT NULL COMMENT '更新人',
  `UPDATETIME` varchar(20) DEFAULT NULL COMMENT '更新时间',
  `REMARK` varchar(250) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`CODENO`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='代码目录';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `code_library`
--

DROP TABLE IF EXISTS `code_library`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `code_library` (
  `CODENO` varchar(32) NOT NULL COMMENT '代码编号',
  `ITEMNO` varchar(32) NOT NULL COMMENT '项目编号',
  `ITEMNAME` varchar(250) DEFAULT NULL COMMENT '项目名',
  `BANKNO` varchar(32) DEFAULT NULL COMMENT '征信代码',
  `SORTNO` varchar(32) DEFAULT NULL COMMENT '排序号',
  `ISINUSE` varchar(18) DEFAULT NULL COMMENT '是否使用',
  `ITEMDESCRIBE` varchar(800) DEFAULT NULL COMMENT '项目描述',
  `ITEMATTRIBUTE` varchar(800) DEFAULT NULL COMMENT '项目属性',
  `RELATIVECODE` varchar(1600) DEFAULT NULL COMMENT '关联代码',
  `ATTRIBUTE1` varchar(800) DEFAULT NULL COMMENT '属性1',
  `ATTRIBUTE2` varchar(250) DEFAULT NULL COMMENT '属性2',
  `ATTRIBUTE3` varchar(250) DEFAULT NULL COMMENT '属性3',
  `ATTRIBUTE4` varchar(250) DEFAULT NULL COMMENT '属性4',
  `ATTRIBUTE5` varchar(250) DEFAULT NULL COMMENT '属性5',
  `ATTRIBUTE6` varchar(250) DEFAULT NULL COMMENT '属性6',
  `ATTRIBUTE7` varchar(250) DEFAULT NULL COMMENT '属性7',
  `ATTRIBUTE8` varchar(250) DEFAULT NULL COMMENT '属性8',
  `INPUTUSER` varchar(32) DEFAULT NULL COMMENT '登记人员',
  `INPUTORG` varchar(32) DEFAULT NULL COMMENT '登记机构',
  `INPUTTIME` varchar(20) DEFAULT NULL COMMENT '登记时间',
  `UPDATEUSER` varchar(32) DEFAULT NULL COMMENT '更新人员',
  `UPDATETIME` varchar(20) DEFAULT NULL COMMENT '更新时间',
  `REMARK` varchar(250) DEFAULT NULL COMMENT '备注',
  `HELPTEXT` varchar(250) DEFAULT NULL COMMENT '帮助文本',
  PRIMARY KEY (`CODENO`,`ITEMNO`),
  KEY `IDX1_CODE_LIBRAY` (`CODENO`,`SORTNO`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='代码库';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `contract_relative`
--

DROP TABLE IF EXISTS `contract_relative`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `contract_relative` (
  `SERIALNO` varchar(40) NOT NULL,
  `OBJECTTYPE` varchar(18) NOT NULL,
  `OBJECTNO` varchar(40) NOT NULL,
  `RELATIVESUM` decimal(24,6) DEFAULT NULL,
  `RELATIONSTATUS` varchar(3) DEFAULT NULL,
  PRIMARY KEY (`SERIALNO`,`OBJECTTYPE`,`OBJECTNO`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `corporation_info`
--

DROP TABLE IF EXISTS `corporation_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `corporation_info` (
  `CORPORGID` varchar(40) NOT NULL COMMENT '法人编号',
  `CORPORGNAME` varchar(80) DEFAULT NULL COMMENT '法人名称',
  `DEFAULTLANG` varchar(10) DEFAULT NULL COMMENT '默认语言',
  `DEFAULTCURRENCY` varchar(10) DEFAULT NULL COMMENT '默认币种',
  `TIMEDIFFID` varchar(40) DEFAULT NULL COMMENT '默认时区',
  `STATUS` varchar(1) DEFAULT NULL COMMENT '状态',
  `INPUTUSER` varchar(32) DEFAULT NULL COMMENT '创建人员',
  `INPUTTIME` varchar(20) DEFAULT NULL COMMENT '创建时间',
  `UPDATEUSER` varchar(32) DEFAULT NULL COMMENT '更新人',
  `UPDATETIME` varchar(20) DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`CORPORGID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='法人信息表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `customer_belong`
--

DROP TABLE IF EXISTS `customer_belong`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `customer_belong` (
  `CUSTOMERID` varchar(32) NOT NULL,
  `ORGID` varchar(40) NOT NULL,
  `USERID` varchar(40) NOT NULL,
  `BELONGATTRIBUTE` varchar(80) DEFAULT NULL,
  `BELONGATTRIBUTE1` varchar(80) DEFAULT NULL,
  `BELONGATTRIBUTE2` varchar(80) DEFAULT NULL,
  `BELONGATTRIBUTE3` varchar(80) DEFAULT NULL,
  `BELONGATTRIBUTE4` varchar(80) DEFAULT NULL,
  `INPUTUSERID` varchar(80) DEFAULT NULL,
  `INPUTORGID` varchar(40) DEFAULT NULL,
  `INPUTDATE` varchar(10) DEFAULT NULL,
  `UPDATEDATE` varchar(10) DEFAULT NULL,
  `APPLYATTRIBUTE` varchar(80) DEFAULT NULL,
  `APPLYATTRIBUTE1` varchar(80) DEFAULT NULL,
  `APPLYATTRIBUTE2` varchar(80) DEFAULT NULL,
  `APPLYATTRIBUTE3` varchar(80) DEFAULT NULL,
  `APPLYATTRIBUTE4` varchar(80) DEFAULT NULL,
  `REMARK` varchar(250) DEFAULT NULL,
  `APPLYSTATUS` varchar(20) DEFAULT NULL,
  `APPLYREASON` varchar(500) DEFAULT NULL,
  `APPLYRIGHT` varchar(20) DEFAULT NULL,
  `APPLYTYPE` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`CUSTOMERID`,`ORGID`,`USERID`),
  KEY `IDX_CUSTOMER_BELONG` (`USERID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `customer_fsrecord`
--

DROP TABLE IF EXISTS `customer_fsrecord`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `customer_fsrecord` (
  `CUSTOMERID` varchar(32) NOT NULL COMMENT '客户编号',
  `RECORDNO` varchar(32) NOT NULL COMMENT '记录编号',
  `REPORTDATE` varchar(10) DEFAULT NULL COMMENT '报表截至日期',
  `REPORTSCOPE` varchar(18) DEFAULT NULL COMMENT '报表口径',
  `REPORTPERIOD` varchar(18) DEFAULT NULL COMMENT '报表周期',
  `REPORTCURRENCY` varchar(18) DEFAULT NULL COMMENT '报表币种',
  `REPORTUNIT` varchar(18) DEFAULT NULL COMMENT '报表单位',
  `REPORTSTATUS` varchar(18) DEFAULT NULL COMMENT '报表状态',
  `REPORTFLAG` varchar(1) DEFAULT NULL COMMENT '报表检查标志',
  `REPORTOPINION` varchar(200) DEFAULT NULL COMMENT '报表注释',
  `AUDITFLAG` varchar(1) DEFAULT NULL COMMENT '审计标志',
  `AUDITOFFICE` varchar(80) DEFAULT NULL COMMENT '审计单位',
  `AUDITOPINION` varchar(80) DEFAULT NULL COMMENT '审计意见',
  `INPUTDATE` varchar(20) DEFAULT NULL COMMENT '登记日期',
  `ORGID` varchar(32) DEFAULT NULL COMMENT '登记机构',
  `USERID` varchar(32) DEFAULT NULL COMMENT '登记人编号',
  `UPDATEDATE` varchar(10) DEFAULT NULL COMMENT '修改日期',
  `REMARK` varchar(250) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`RECORDNO`),
  KEY `IDX_CUST_FSRECORD` (`CUSTOMERID`,`RECORDNO`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='客户财务报表记录';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `customer_info`
--

DROP TABLE IF EXISTS `customer_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `customer_info` (
  `CUSTOMERID` varchar(40) NOT NULL,
  `CUSTOMERNAME` varchar(80) DEFAULT NULL,
  `CUSTOMERTYPE` varchar(20) DEFAULT NULL,
  `CERTTYPE` varchar(20) DEFAULT NULL,
  `CERTID` varchar(40) DEFAULT NULL,
  `CUSTOMERPASSWORD` varchar(20) DEFAULT NULL,
  `INPUTORGID` varchar(32) DEFAULT NULL,
  `INPUTUSERID` varchar(32) DEFAULT NULL,
  `INPUTDATE` varchar(10) DEFAULT NULL,
  `REMARK` varchar(250) DEFAULT NULL,
  `MFCUSTOMERID` varchar(40) DEFAULT NULL,
  `STATUS` varchar(20) DEFAULT NULL,
  `BELONGGROUPID` varchar(40) DEFAULT NULL,
  `CHANNEL` varchar(18) DEFAULT NULL,
  `LOANCARDNO` varchar(32) DEFAULT NULL,
  `CUSTOMERSCALE` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`CUSTOMERID`),
  KEY `IDX1_CUSTOMER_INFO` (`CERTID`,`CERTTYPE`),
  KEY `IDX2_CUSTOMER_INFO` (`LOANCARDNO`),
  KEY `IDX3_CUSTOMER_INFO` (`CUSTOMERTYPE`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `customer_relative`
--

DROP TABLE IF EXISTS `customer_relative`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `customer_relative` (
  `CUSTOMERID` varchar(32) NOT NULL,
  `RELATIVEID` varchar(32) NOT NULL,
  `RELATIONSHIP` varchar(18) NOT NULL,
  `CUSTOMERNAME` varchar(80) DEFAULT NULL,
  `CERTTYPE` varchar(18) DEFAULT NULL,
  `CERTID` varchar(32) DEFAULT NULL,
  `FICTITIOUSPERSON` varchar(80) DEFAULT NULL,
  `CURRENCYTYPE` varchar(18) DEFAULT NULL,
  `INVESTMENTSUM` decimal(24,6) DEFAULT NULL,
  `OUGHTSUM` decimal(24,6) DEFAULT NULL,
  `INVESTMENTPROP` decimal(10,6) DEFAULT NULL,
  `INVESTDATE` varchar(10) DEFAULT NULL,
  `STOCKCERTNO` varchar(32) DEFAULT NULL,
  `DUTY` varchar(18) DEFAULT NULL,
  `TELEPHONE` varchar(32) DEFAULT NULL,
  `EFFECT` varchar(18) DEFAULT NULL,
  `WHETHEN1` varchar(18) DEFAULT NULL,
  `WHETHEN2` varchar(18) DEFAULT NULL,
  `WHETHEN3` varchar(18) DEFAULT NULL,
  `WHETHEN4` varchar(18) DEFAULT NULL,
  `WHETHEN5` varchar(18) DEFAULT NULL,
  `INPUTORGID` varchar(80) DEFAULT NULL,
  `INPUTUSERID` varchar(80) DEFAULT NULL,
  `INPUTDATE` varchar(10) DEFAULT NULL,
  `UPDATEDATE` varchar(10) DEFAULT NULL,
  `REMARK` varchar(200) DEFAULT NULL,
  `SEX` varchar(18) DEFAULT NULL,
  `BIRTHDAY` varchar(10) DEFAULT NULL,
  `SINO` varchar(32) DEFAULT NULL,
  `FAMILYADD` varchar(200) DEFAULT NULL,
  `FAMILYZIP` varchar(32) DEFAULT NULL,
  `EDUEXPERIENCE` varchar(18) DEFAULT NULL,
  `INVESTYIELD` decimal(24,6) DEFAULT NULL,
  `HOLDDATE` varchar(10) DEFAULT NULL,
  `ENGAGETERM` decimal(22,0) DEFAULT NULL,
  `HOLDSTOCK` varchar(200) DEFAULT NULL,
  `LOANCARDNO` varchar(32) DEFAULT NULL,
  `EFFSTATUS` varchar(1) DEFAULT NULL,
  `CUSTOMERTYPE` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`CUSTOMERID`,`RELATIVEID`,`RELATIONSHIP`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `dataobject_catalog`
--

DROP TABLE IF EXISTS `dataobject_catalog`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dataobject_catalog` (
  `DONO` varchar(32) NOT NULL COMMENT 'DO编号',
  `DONAME` varchar(80) DEFAULT NULL COMMENT 'DO名称',
  `DODESCRIBE` varchar(250) DEFAULT NULL COMMENT 'DO描述',
  `DOTYPE` varchar(18) DEFAULT NULL COMMENT 'DO用途',
  `DOARGUMENTS` varchar(250) DEFAULT NULL COMMENT 'DO参数',
  `DOATTRIBUTE` varchar(80) DEFAULT NULL COMMENT 'DO属性',
  `DOUPDATETABLE` varchar(80) DEFAULT NULL COMMENT '更新目标表',
  `DOUPDATEWHERE` varchar(18) DEFAULT NULL COMMENT '更新方式',
  `DOFROMCLAUSE` varchar(800) DEFAULT NULL COMMENT 'DOFrom子句',
  `DOWHERECLAUSE` varchar(800) DEFAULT NULL COMMENT 'DOWhere子句',
  `DOGROUPCLAUSE` varchar(800) DEFAULT NULL COMMENT 'DOGroup子句',
  `DOORDERCLAUSE` varchar(800) DEFAULT NULL COMMENT 'DOOrder子句',
  `REMARK` varchar(250) DEFAULT NULL COMMENT '备注',
  `DOCLASS` varchar(18) DEFAULT NULL COMMENT 'Do类型',
  `MODIFYAUDITTABLE` varchar(32) DEFAULT NULL COMMENT '修改审计表',
  `MODIFYMODECRITERIA` varchar(800) DEFAULT NULL COMMENT '修改审计模式条件',
  `DELETEAUDITTABLE` varchar(32) DEFAULT NULL COMMENT '删除审计表',
  `DELETEMODECRITERIA` varchar(800) DEFAULT NULL COMMENT '删除审计模式',
  `ISINUSE` varchar(18) DEFAULT NULL COMMENT '失效标志',
  `INPUTUSER` varchar(32) DEFAULT NULL COMMENT '登记人',
  `INPUTTIME` varchar(20) DEFAULT NULL COMMENT '登记时间',
  `UPDATEUSER` varchar(32) DEFAULT NULL COMMENT '更新人',
  `UPDATETIME` varchar(20) DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`DONO`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='DW数据对象目录';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `dataobject_col_valid`
--

DROP TABLE IF EXISTS `dataobject_col_valid`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dataobject_col_valid` (
  `SERIALNO` varchar(32) NOT NULL COMMENT '流水号',
  `DONO` varchar(32) DEFAULT NULL COMMENT '显示模板编号',
  `COLNAME` varchar(32) DEFAULT NULL COMMENT 'jbo属性名',
  `VALIDATORNAME` varchar(32) DEFAULT NULL COMMENT '对应验证规则',
  `PARAM1` varchar(2000) DEFAULT NULL COMMENT '参数1',
  `PARAM2` varchar(200) DEFAULT NULL COMMENT '参数2',
  `PARAM3` varchar(400) DEFAULT NULL COMMENT '参数3',
  `PARAM4` varchar(400) DEFAULT NULL COMMENT '参数4',
  `PARAM5` varchar(32) DEFAULT NULL COMMENT '参数5',
  `PARAM6` varchar(32) DEFAULT NULL COMMENT '参数6',
  `PARAM7` varchar(32) DEFAULT NULL COMMENT '参数7',
  `PARAM8` varchar(32) DEFAULT NULL COMMENT '参数8',
  `PARAM9` varchar(32) DEFAULT NULL COMMENT '参数9',
  `PARAM10` varchar(32) DEFAULT NULL COMMENT '参数10',
  `USESTATUS` varchar(32) DEFAULT NULL COMMENT '编辑状态',
  `ISINUSE` char(1) DEFAULT NULL COMMENT '是否使用',
  PRIMARY KEY (`SERIALNO`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='DW字段验证规则';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `dataobject_filter`
--

DROP TABLE IF EXISTS `dataobject_filter`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dataobject_filter` (
  `DONO` varchar(32) NOT NULL,
  PRIMARY KEY (`DONO`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='DW数据对象过滤器';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `dataobject_group`
--

DROP TABLE IF EXISTS `dataobject_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dataobject_group` (
  `DONO` varchar(32) NOT NULL COMMENT '显示模板编号',
  `DOCKID` varchar(32) NOT NULL COMMENT '分组编号',
  `DOCKNAME` varchar(80) DEFAULT NULL COMMENT '分组名称',
  `INPUTUSER` varchar(32) DEFAULT NULL COMMENT '录入人',
  `INPUTTIME` varchar(20) DEFAULT NULL COMMENT '录入时间',
  `UPDATEUSER` varchar(32) DEFAULT NULL COMMENT '更新人',
  `UPDATETIME` varchar(20) DEFAULT NULL COMMENT '更新时间',
  `INPUTORG` varchar(32) DEFAULT NULL COMMENT '录入机构',
  `SORTNO` varchar(32) DEFAULT NULL COMMENT '排序号',
  `GROUPHEAD` varchar(3000) DEFAULT NULL COMMENT '分组头',
  `GROUPFOOT` varchar(3000) DEFAULT NULL COMMENT '分组尾',
  `GROUPBODY` varchar(3000) DEFAULT NULL COMMENT '分组体',
  `COLCOUNT` int(11) DEFAULT NULL COMMENT '每行列数',
  `STYLEID` varchar(32) DEFAULT NULL COMMENT '使用样式编号',
  `ISEXPAND` char(1) DEFAULT NULL COMMENT '分组是否展开',
  `GROUPBODY1` varchar(3000) DEFAULT NULL COMMENT '分组体1',
  `GROUPBODY2` varchar(3000) DEFAULT NULL COMMENT '分组体2',
  PRIMARY KEY (`DONO`,`DOCKID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='DW分组信息';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `dataobject_library`
--

DROP TABLE IF EXISTS `dataobject_library`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dataobject_library` (
  `DONO` varchar(32) NOT NULL COMMENT 'DO编号',
  `COLINDEX` varchar(32) NOT NULL COMMENT '显示序号',
  `COLATTRIBUTE` varchar(80) DEFAULT NULL COMMENT '属性',
  `COLTABLENAME` varchar(80) DEFAULT NULL COMMENT '数据表名',
  `COLACTUALNAME` varchar(80) DEFAULT NULL COMMENT '数据库源名',
  `COLNAME` varchar(80) DEFAULT NULL COMMENT '使用名称',
  `COLTYPE` varchar(18) DEFAULT NULL COMMENT '值类型',
  `COLDEFAULTVALUE` varchar(80) DEFAULT NULL COMMENT '缺省值',
  `COLHEADER` varchar(80) DEFAULT NULL COMMENT '中文名称',
  `COLUNIT` varchar(250) DEFAULT NULL COMMENT '显示后缀',
  `COLCOLUMNTYPE` varchar(18) DEFAULT NULL COMMENT '字段类型',
  `COLCHECKFORMAT` varchar(18) DEFAULT NULL COMMENT '检查格式',
  `COLALIGN` varchar(18) DEFAULT NULL COMMENT '对齐方式',
  `COLEDITSTYLE` varchar(18) DEFAULT NULL COMMENT '编辑形式',
  `COLEDITSOURCETYPE` varchar(18) DEFAULT NULL COMMENT '显示来源类型',
  `COLEDITSOURCE` varchar(250) DEFAULT NULL COMMENT '显示来源',
  `COLHTMLSTYLE` varchar(250) DEFAULT NULL COMMENT 'HTML显示格式',
  `COLLIMIT` varchar(18) DEFAULT NULL COMMENT '长度限制',
  `COLKEY` varchar(18) DEFAULT NULL COMMENT '是否关键字',
  `COLUPDATEABLE` varchar(18) DEFAULT NULL COMMENT '是否可更新',
  `COLVISIBLE` varchar(18) DEFAULT NULL COMMENT '是否可见',
  `COLREADONLY` varchar(18) DEFAULT NULL COMMENT '是否只读',
  `COLREQUIRED` varchar(18) DEFAULT NULL COMMENT '是否必须',
  `COLSORTABLE` varchar(18) DEFAULT NULL COMMENT '是否需要排序',
  `COLCHECKITEM` varchar(18) DEFAULT NULL COMMENT '是否进行完备性检查',
  `COLTRANSFERBACK` varchar(18) DEFAULT NULL COMMENT '是否回传值',
  `DATAITEMID` varchar(32) DEFAULT NULL COMMENT '数据项ID',
  `ISFOREIGNKEY` varchar(18) DEFAULT NULL COMMENT '是否外键',
  `SORTNO` varchar(18) DEFAULT NULL COMMENT '排序号',
  `ISINUSE` varchar(18) DEFAULT NULL COMMENT '有效标志',
  `DATAPRECISION` decimal(24,6) DEFAULT NULL COMMENT '有效位数',
  `DATASCALE` decimal(24,6) DEFAULT NULL COMMENT '小数点后位数',
  `ATTRIBUTE1` varchar(250) DEFAULT NULL COMMENT '属性1',
  `ATTRIBUTE2` varchar(250) DEFAULT NULL COMMENT '属性2',
  `ATTRIBUTE3` varchar(250) DEFAULT NULL COMMENT '属性3',
  `ISFILTER` varchar(18) DEFAULT NULL COMMENT '是否需要查询',
  `FILTEROPTIONS` varchar(1600) DEFAULT NULL COMMENT '过滤条件',
  `INPUTUSER` varchar(32) DEFAULT NULL COMMENT '登记人',
  `INPUTTIME` varchar(20) DEFAULT NULL COMMENT '登记时间',
  `UPDATEUSER` varchar(32) DEFAULT NULL COMMENT '更新人',
  `UPDATETIME` varchar(20) DEFAULT NULL COMMENT '更新时间',
  `DOCKID` varchar(32) DEFAULT NULL COMMENT '分组编号',
  `COLSPAN` int(11) DEFAULT NULL COMMENT '列跨度',
  `POSITIONTYPE` varchar(32) DEFAULT NULL COMMENT '位置类型',
  `BLANKCOLSAHEAD` int(11) DEFAULT NULL COMMENT '列前空格',
  `BLANKCOLSAFTER` int(11) DEFAULT NULL COMMENT '列后空格',
  `AUDITCOLUMN` varchar(80) DEFAULT NULL COMMENT '审计列',
  `AUDITTABLE` varchar(80) DEFAULT NULL COMMENT '审计表',
  `AUDITABLE` varchar(80) DEFAULT NULL COMMENT '是否审计',
  `COLTIPS` varchar(250) DEFAULT NULL COMMENT 'tips说明',
  `COLINNERBTEVENT` varchar(250) DEFAULT NULL COMMENT '内置按钮事件',
  PRIMARY KEY (`DONO`,`COLINDEX`),
  KEY `IDX_DO_LIBRARY` (`DONO`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='DW数据对象属性库';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `demo_employee`
--

DROP TABLE IF EXISTS `demo_employee`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `demo_employee` (
  `EmployeeId` varchar(10) NOT NULL,
  `PID` varchar(18) DEFAULT NULL,
  `Name` varchar(20) DEFAULT NULL,
  `Sex` char(1) DEFAULT NULL,
  `Birthday` date DEFAULT NULL,
  `Education` char(1) DEFAULT NULL,
  `WorkYear` decimal(4,0) DEFAULT NULL,
  `Salary` decimal(16,2) DEFAULT NULL,
  `Department` varchar(50) DEFAULT NULL,
  `Email` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`EmployeeId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `doc_attachment`
--

DROP TABLE IF EXISTS `doc_attachment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `doc_attachment` (
  `DOCNO` varchar(32) NOT NULL COMMENT '文档编号',
  `ATTACHMENTNO` varchar(32) NOT NULL COMMENT '附件编号',
  `FILENAME` varchar(100) DEFAULT NULL COMMENT '文档全路径文件名',
  `FILEPATH` varchar(120) DEFAULT NULL COMMENT '文档路径',
  `FULLPATH` varchar(200) DEFAULT NULL COMMENT '文档全路径',
  `FILESAVEMODE` varchar(18) DEFAULT NULL COMMENT '文档保存模式',
  `CONTENTTYPE` varchar(80) DEFAULT NULL COMMENT '内容类型',
  `CONTENTLENGTH` varchar(32) DEFAULT NULL COMMENT '内容长度',
  `CONTENTSTATUS` varchar(18) DEFAULT NULL COMMENT '内容状态',
  `DOCCONTENT` longblob COMMENT '文档内容',
  `BEGINTIME` varchar(20) DEFAULT NULL COMMENT '发送开始时间',
  `ENDTIME` varchar(20) DEFAULT NULL COMMENT '发送完成时间',
  `INPUTUSER` varchar(32) DEFAULT NULL COMMENT '登记人',
  `INPUTORG` varchar(32) DEFAULT NULL COMMENT '登记单位',
  `INPUTTIME` varchar(20) DEFAULT NULL COMMENT '登记时间',
  `UPDATETIME` varchar(20) DEFAULT NULL COMMENT '更新时间',
  `UPDATEUSER` varchar(32) DEFAULT NULL COMMENT '更新人',
  `REMARK` varchar(250) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`DOCNO`,`ATTACHMENTNO`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='文档附件库';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `doc_library`
--

DROP TABLE IF EXISTS `doc_library`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `doc_library` (
  `DOCNO` varchar(32) NOT NULL COMMENT '文档编号',
  `DOCTYPE` varchar(18) DEFAULT NULL COMMENT '文档类型',
  `DOCTITLE` varchar(80) DEFAULT NULL COMMENT '文档名称',
  `DOCLENGTH` varchar(32) DEFAULT NULL COMMENT '文档长度',
  `DOCIMPORTANCE` varchar(18) DEFAULT NULL COMMENT '文档重要性',
  `DOCSECRET` varchar(18) DEFAULT NULL COMMENT '文档密级',
  `DOCSTAGE` varchar(18) DEFAULT NULL COMMENT '所属阶段',
  `DOCSOURCE` varchar(80) DEFAULT NULL COMMENT '文档来源',
  `DOCUNIT` varchar(80) DEFAULT NULL COMMENT '编制单位',
  `DOCDATE` varchar(10) DEFAULT NULL COMMENT '编制日期',
  `DOCORGANIZER` varchar(80) DEFAULT NULL COMMENT '编制人',
  `DOCKEYWORD` varchar(250) DEFAULT NULL COMMENT '文档主题词',
  `DOCABSTRACT` varchar(250) DEFAULT NULL COMMENT '文档摘要',
  `DOCLOCATION` varchar(250) DEFAULT NULL COMMENT '文档保存位置',
  `DOCATTRIBUTE` varchar(18) DEFAULT NULL COMMENT '文档性质',
  `USERID` varchar(32) DEFAULT NULL COMMENT '操作员',
  `USERNAME` varchar(32) DEFAULT NULL COMMENT '操作员姓名',
  `ORGID` varchar(32) DEFAULT NULL COMMENT '所属行编号',
  `ORGNAME` varchar(80) DEFAULT NULL COMMENT '所属行名称',
  `TRANSFORMTIME` varchar(20) DEFAULT NULL COMMENT '计划发送时间',
  `INPUTUSER` varchar(32) DEFAULT NULL COMMENT '登记人',
  `INPUTORG` varchar(80) DEFAULT NULL COMMENT '登记单位',
  `INPUTTIME` varchar(20) DEFAULT NULL COMMENT '登记时间',
  `UPDATEUSER` varchar(32) DEFAULT NULL COMMENT '更新人',
  `UPDATETIME` varchar(20) DEFAULT NULL COMMENT '更新时间',
  `DOCFLAG` varchar(18) DEFAULT NULL COMMENT '文档标志',
  `SORTNO` varchar(32) DEFAULT NULL COMMENT '排序号',
  `REMARK` varchar(250) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`DOCNO`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='文档资料库';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `doc_relative`
--

DROP TABLE IF EXISTS `doc_relative`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `doc_relative` (
  `DOCNO` varchar(32) NOT NULL COMMENT '文档编号',
  `OBJECTTYPE` varchar(18) NOT NULL COMMENT '对象类别',
  `OBJECTNO` varchar(32) NOT NULL COMMENT '对象标识',
  `OBJECTNAME` varchar(80) DEFAULT NULL COMMENT '对象名称',
  PRIMARY KEY (`DOCNO`,`OBJECTTYPE`,`OBJECTNO`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='文档关联对象表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `edoc_define`
--

DROP TABLE IF EXISTS `edoc_define`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `edoc_define` (
  `EDOCNO` varchar(32) NOT NULL COMMENT '文档编号',
  `EDOCNAME` varchar(80) DEFAULT NULL COMMENT '文档名称',
  `ISINUSE` varchar(18) DEFAULT NULL COMMENT '是否有效',
  `EDOCTYPE` varchar(18) DEFAULT NULL COMMENT '文档类型',
  `STAMPERTYPE` varchar(18) DEFAULT NULL COMMENT '签章页类型',
  `VOUCHNO` varchar(18) DEFAULT NULL COMMENT 'VOUCHNO',
  `FULLPATHFMT` varchar(200) DEFAULT NULL COMMENT '格式文件路径',
  `CONTENTTYPEFMT` varchar(32) DEFAULT NULL COMMENT '格式文件类型',
  `CONTENTLENGTHFMT` varchar(32) DEFAULT NULL COMMENT '格式文件大小',
  `FILENAMEDEF` varchar(100) DEFAULT NULL COMMENT '数据定义文件',
  `FULLPATHDEF` varchar(200) DEFAULT NULL COMMENT '数据定义文件路径',
  `CONTENTTYPEDEF` varchar(32) DEFAULT NULL COMMENT '数据定义文件类型',
  `FILENAMEFMT` varchar(100) DEFAULT NULL COMMENT '格式文件',
  `CONTENTLENGTHDEF` varchar(32) DEFAULT NULL COMMENT '数据定义文件大小',
  `INPUTORG` varchar(32) DEFAULT NULL COMMENT '登记机构',
  `INPUTUSER` varchar(32) DEFAULT NULL COMMENT '登记人',
  `INPUTTIME` varchar(20) DEFAULT NULL COMMENT '登记时间',
  `UPDATEORG` varchar(32) DEFAULT NULL COMMENT '更新机构',
  `UPDATEUSER` varchar(32) DEFAULT NULL COMMENT '更新人',
  `UPDATETIME` varchar(20) DEFAULT NULL COMMENT '更新日期',
  PRIMARY KEY (`EDOCNO`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='电子合同文档模板定义';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `edoc_print`
--

DROP TABLE IF EXISTS `edoc_print`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `edoc_print` (
  `SERIALNO` varchar(32) NOT NULL COMMENT '流水号',
  `OBJECTNO` varchar(32) NOT NULL COMMENT '对象编号',
  `OBJECTTYPE` varchar(32) NOT NULL COMMENT '对象类型',
  `EDOCNO` varchar(32) NOT NULL COMMENT '电子合同模板编号',
  `FILENAME` varchar(100) DEFAULT NULL COMMENT '文件名',
  `FULLPATH` varchar(200) DEFAULT NULL COMMENT '文件路径',
  `CONTENTTYPE` varchar(32) DEFAULT NULL COMMENT '内容类型',
  `CONTENTLENGTH` varchar(32) DEFAULT NULL COMMENT '文件大小',
  `INPUTTIME` varchar(20) DEFAULT NULL COMMENT '登记时间',
  `INPUTORG` varchar(32) DEFAULT NULL COMMENT '登记机构',
  `INPUTUSER` varchar(32) DEFAULT NULL COMMENT '登记人',
  PRIMARY KEY (`SERIALNO`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='电子合同打印信息';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `edoc_relative`
--

DROP TABLE IF EXISTS `edoc_relative`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `edoc_relative` (
  `TYPENO` varchar(20) NOT NULL COMMENT '业务类型编号',
  `TYPENAME` varchar(100) DEFAULT NULL COMMENT '业务类型',
  `EDOCNO` varchar(18) DEFAULT NULL COMMENT '电子合同模板编号',
  `ISINUSE` varchar(1) DEFAULT NULL COMMENT '是否使用',
  PRIMARY KEY (`TYPENO`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='电子合同关联类型信息';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ent_info`
--

DROP TABLE IF EXISTS `ent_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ent_info` (
  `CUSTOMERID` varchar(32) NOT NULL,
  `CORPID` varchar(32) DEFAULT NULL,
  `ENTERPRISENAME` varchar(80) DEFAULT NULL,
  `ENGLISHNAME` varchar(80) DEFAULT NULL,
  `FICTITIOUSPERSON` varchar(80) DEFAULT NULL,
  `ORGNATURE` varchar(18) DEFAULT NULL,
  `FINANCETYPE` varchar(18) DEFAULT NULL,
  `ENTERPRISEBELONG` varchar(18) DEFAULT NULL,
  `INDUSTRYTYPE` varchar(18) DEFAULT NULL,
  `INDUSTRYTYPE1` varchar(18) DEFAULT NULL,
  `INDUSTRYTYPE2` varchar(18) DEFAULT NULL,
  `PRIVATE` varchar(18) DEFAULT NULL,
  `ECONOMYTYPE` varchar(18) DEFAULT NULL,
  `ORGTYPE` varchar(18) DEFAULT NULL,
  `MOSTBUSINESS` varchar(800) DEFAULT NULL,
  `BUDGETTYPE` varchar(18) DEFAULT NULL,
  `RCCURRENCY` varchar(18) DEFAULT NULL,
  `REGISTERCAPITAL` decimal(24,6) DEFAULT NULL,
  `PCCURRENCY` varchar(18) DEFAULT NULL,
  `PAICLUPCAPITAL` decimal(24,6) DEFAULT NULL,
  `FUNDSOURCE` varchar(200) DEFAULT NULL,
  `TOTALASSETS` decimal(24,6) DEFAULT NULL,
  `NETASSETS` decimal(24,6) DEFAULT NULL,
  `ANNUALINCOME` decimal(24,6) DEFAULT NULL,
  `SCOPE` varchar(18) DEFAULT NULL,
  `CREDITDATE` varchar(10) DEFAULT NULL,
  `LICENSENO` varchar(32) DEFAULT NULL,
  `LICENSEDATE` varchar(10) DEFAULT NULL,
  `LICENSEMATURITY` varchar(10) DEFAULT NULL,
  `SETUPDATE` varchar(10) DEFAULT NULL,
  `INSPECTIONYEAR` varchar(10) DEFAULT NULL,
  `LOCKSITUATION` varchar(200) DEFAULT NULL,
  `TAXNO` varchar(32) DEFAULT NULL,
  `BANKLICENSE` varchar(32) DEFAULT NULL,
  `BANKID` varchar(32) DEFAULT NULL,
  `MANAGEAREA` varchar(200) DEFAULT NULL,
  `BANCHAMOUNT` decimal(22,0) DEFAULT NULL,
  `EXCHANGEID` varchar(32) DEFAULT NULL,
  `REGISTERADD` varchar(80) DEFAULT NULL,
  `CHARGEDEPARTMENT` varchar(80) DEFAULT NULL,
  `OFFICEADD` varchar(80) DEFAULT NULL,
  `OFFICEZIP` varchar(32) DEFAULT NULL,
  `COUNTRYCODE` varchar(18) DEFAULT NULL,
  `REGIONCODE` varchar(18) DEFAULT NULL,
  `VILLAGECODE` varchar(18) DEFAULT NULL,
  `VILLAGENAME` varchar(80) DEFAULT NULL,
  `RELATIVETYPE` varchar(200) DEFAULT NULL,
  `OFFICETEL` varchar(32) DEFAULT NULL,
  `OFFICEFAX` varchar(32) DEFAULT NULL,
  `WEBADD` varchar(80) DEFAULT NULL,
  `EMAILADD` varchar(80) DEFAULT NULL,
  `EMPLOYEENUMBER` decimal(22,0) DEFAULT NULL,
  `MAINPRODUCTION` varchar(200) DEFAULT NULL,
  `NEWTECHCORPORNOT` varchar(18) DEFAULT NULL,
  `LISTINGCORPORNOT` varchar(18) DEFAULT NULL,
  `HASIERIGHT` varchar(18) DEFAULT NULL,
  `HASDIRECTORATE` varchar(18) DEFAULT NULL,
  `BASICBANK` varchar(80) DEFAULT NULL,
  `BASICACCOUNT` varchar(32) DEFAULT NULL,
  `MANAGEINFO` varchar(800) DEFAULT NULL,
  `CUSTOMERHISTORY` varchar(800) DEFAULT NULL,
  `PROJECTFLAG` varchar(18) DEFAULT NULL,
  `REALTYFLAG` varchar(18) DEFAULT NULL,
  `WORKFIELDAREA` decimal(22,0) DEFAULT NULL,
  `WORKFIELDFEE` varchar(18) DEFAULT NULL,
  `ACCOUNTDATE` varchar(10) DEFAULT NULL,
  `LOANCARDNO` varchar(32) DEFAULT NULL,
  `LOANCARDPASSWORD` varchar(32) DEFAULT NULL,
  `LOANCARDINSYEAR` varchar(10) DEFAULT NULL,
  `LOANCARDINSRESULT` varchar(200) DEFAULT NULL,
  `LOANFLAG` varchar(18) DEFAULT NULL,
  `FINANCEORNOT` varchar(18) DEFAULT NULL,
  `FINANCEBELONG` varchar(18) DEFAULT NULL,
  `CREDITBELONG` varchar(18) DEFAULT NULL,
  `CREDITLEVEL` varchar(80) DEFAULT NULL,
  `EVALUATEDATE` varchar(20) DEFAULT NULL,
  `OTHERCREDITLEVEL` varchar(80) DEFAULT NULL,
  `OTHEREVALUATEDATE` varchar(10) DEFAULT NULL,
  `OTHERORGNAME` varchar(80) DEFAULT NULL,
  `INPUTORGID` varchar(32) DEFAULT NULL,
  `INPUTUSERID` varchar(32) DEFAULT NULL,
  `INPUTDATE` varchar(10) DEFAULT NULL,
  `UPDATEORGID` varchar(32) DEFAULT NULL,
  `UPDATEUSERID` varchar(32) DEFAULT NULL,
  `UPDATEDATE` varchar(10) DEFAULT NULL,
  `REMARK` varchar(200) DEFAULT NULL,
  `TAXNO1` varchar(32) DEFAULT NULL,
  `FICTITIOUSPERSONID` varchar(32) DEFAULT NULL,
  `GROUPFLAG` varchar(18) DEFAULT NULL,
  `EVALUATELEVEL` varchar(18) DEFAULT NULL,
  `MYBANK` varchar(80) DEFAULT NULL,
  `MYBANKACCOUNT` varchar(32) DEFAULT NULL,
  `OTHERBANK` varchar(80) DEFAULT NULL,
  `OTHERBANKACCOUNT` varchar(32) DEFAULT NULL,
  `TEMPSAVEFLAG` varchar(18) DEFAULT NULL,
  `FINANCEDEPTTEL` varchar(32) DEFAULT NULL,
  `ECGROUPFLAG` varchar(18) DEFAULT NULL,
  `SUPERCORPNAME` varchar(80) DEFAULT NULL,
  `SUPERLOANCARDNO` varchar(32) DEFAULT NULL,
  `SUPERCERTTYPE` varchar(18) DEFAULT NULL,
  `SMEINDUSTRYTYPE` varchar(10) DEFAULT NULL,
  `SELLSUM` decimal(24,6) DEFAULT NULL,
  `SUPERCERTID` varchar(32) DEFAULT NULL,
  PRIMARY KEY (`CUSTOMERID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `evaluate_catalog`
--

DROP TABLE IF EXISTS `evaluate_catalog`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `evaluate_catalog` (
  `MODELNO` varchar(32) NOT NULL COMMENT '评估表编号',
  `MODELNAME` varchar(80) DEFAULT NULL COMMENT '评估表名称',
  `MODELTYPE` varchar(18) DEFAULT NULL COMMENT '评估表类别',
  `MODELDESCRIBE` varchar(250) DEFAULT NULL COMMENT '评估表描述',
  `TRANSFORMMETHOD` varchar(1600) DEFAULT NULL COMMENT '转换方法',
  `REMARK` varchar(250) DEFAULT NULL COMMENT '备注',
  `CATEGORY` varchar(80) DEFAULT NULL COMMENT '种类',
  `EVALUATECONTEXT` varchar(2000) DEFAULT NULL COMMENT '评估上下文',
  PRIMARY KEY (`MODELNO`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='评估模型目录';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `evaluate_data`
--

DROP TABLE IF EXISTS `evaluate_data`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `evaluate_data` (
  `OBJECTTYPE` varchar(18) NOT NULL COMMENT '对象类型',
  `OBJECTNO` varchar(32) NOT NULL COMMENT '对象编号',
  `SERIALNO` varchar(32) NOT NULL COMMENT '流水号',
  `ITEMNO` varchar(32) NOT NULL COMMENT '项目编号',
  `ITEMVALUE` varchar(80) DEFAULT NULL COMMENT '项目值',
  `EVALUATESCORE` decimal(24,6) DEFAULT NULL COMMENT '评估值',
  PRIMARY KEY (`OBJECTTYPE`,`OBJECTNO`,`SERIALNO`,`ITEMNO`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='评估数据';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `evaluate_model`
--

DROP TABLE IF EXISTS `evaluate_model`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `evaluate_model` (
  `MODELNO` varchar(32) NOT NULL COMMENT '评估表编号',
  `ITEMNO` varchar(32) NOT NULL COMMENT '项目编号',
  `DISPLAYNO` varchar(32) DEFAULT NULL COMMENT '显示序号',
  `ITEMNAME` varchar(80) DEFAULT NULL COMMENT '项目名称',
  `ITEMATTRIBUTE` varchar(80) DEFAULT NULL COMMENT '项目属性',
  `VALUEMETHOD` varchar(2100) DEFAULT NULL COMMENT '取值方法',
  `VALUECODE` varchar(250) DEFAULT NULL COMMENT '取值代码',
  `VALUETYPE` varchar(18) DEFAULT NULL COMMENT '值类型',
  `EVALUATEMETHOD` varchar(1600) DEFAULT NULL COMMENT '评估方法',
  `COEFFICIENT` decimal(24,6) DEFAULT NULL COMMENT '系数',
  `REMARK` varchar(250) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`MODELNO`,`ITEMNO`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='评估模型';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `evaluate_record`
--

DROP TABLE IF EXISTS `evaluate_record`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `evaluate_record` (
  `OBJECTTYPE` varchar(18) NOT NULL COMMENT '对象类型',
  `OBJECTNO` varchar(32) NOT NULL COMMENT '对象编号',
  `SERIALNO` varchar(32) NOT NULL COMMENT '流水号',
  `ACCOUNTMONTH` varchar(10) DEFAULT NULL COMMENT '会计月份',
  `MODELNO` varchar(32) DEFAULT NULL COMMENT '模型编号',
  `REPORTSCOPE` varchar(8) DEFAULT NULL COMMENT '报表口径',
  `EVALUATEDATE` varchar(20) DEFAULT NULL COMMENT '评估日期',
  `EVALUATESCORE` decimal(24,6) DEFAULT NULL COMMENT '评估得分',
  `EVALUATERESULT` varchar(80) DEFAULT NULL COMMENT '评估结果',
  `ORGID` varchar(32) DEFAULT NULL COMMENT '评估单位',
  `USERID` varchar(32) DEFAULT NULL COMMENT '评估人',
  `COGNDATE` varchar(20) DEFAULT NULL COMMENT '认定日期',
  `COGNSCORE` decimal(24,6) DEFAULT NULL COMMENT '认定得分',
  `COGNRESULT` varchar(80) DEFAULT NULL COMMENT '认定结果',
  `COGNORGID` varchar(32) DEFAULT NULL COMMENT '认定单位',
  `COGNUSERID` varchar(32) DEFAULT NULL COMMENT '认定人',
  `REMARK` varchar(250) DEFAULT NULL COMMENT '备注',
  `COGNREASON` varchar(250) DEFAULT NULL COMMENT '认定理由',
  `COGNRESULT2` varchar(80) DEFAULT NULL COMMENT '分行认定结果',
  `COGNUSERNAME2` varchar(80) DEFAULT NULL COMMENT '分行认定人',
  `COGNREASON2` varchar(250) DEFAULT NULL COMMENT '分行认定理由',
  `COGNRESULT3` varchar(80) DEFAULT NULL COMMENT '总行认定结果',
  `COGNUSERNAME3` varchar(80) DEFAULT NULL COMMENT '总行认定人',
  `COGNREASON3` varchar(250) DEFAULT NULL COMMENT '总行认定理由',
  `COGNUSERID3` varchar(32) DEFAULT NULL COMMENT '总行认定人代码',
  `COGNUSERID2` varchar(32) DEFAULT NULL COMMENT '分行认定人代码',
  `EVALUATELEVEL` varchar(18) DEFAULT NULL COMMENT '认定级别',
  `FINISHDATE2` varchar(20) DEFAULT NULL COMMENT '分行认定时间',
  `FINISHDATE3` varchar(20) DEFAULT NULL COMMENT '总行认定时间',
  `FINISHDATE` varchar(20) DEFAULT NULL COMMENT '认定时间',
  `COGNRESULT4` varchar(80) DEFAULT NULL COMMENT '支行认定结果',
  `COGNUSERNAME4` varchar(80) DEFAULT NULL COMMENT '支行认定人',
  `COGNREASON4` varchar(250) DEFAULT NULL COMMENT '支行认定理由',
  `FINISHDATE4` varchar(20) DEFAULT NULL COMMENT '支行认定时间',
  `COGNUSERID4` varchar(32) DEFAULT NULL COMMENT '支行认定人代码',
  PRIMARY KEY (`OBJECTTYPE`,`OBJECTNO`,`SERIALNO`),
  KEY `IDX1_EVALUATE_REC` (`OBJECTNO`,`OBJECTTYPE`,`MODELNO`,`ACCOUNTMONTH`,`COGNRESULT`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='评估记录';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `example_datawindow`
--

DROP TABLE IF EXISTS `example_datawindow`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `example_datawindow` (
  `SERIALNO` varchar(32) NOT NULL COMMENT '编号',
  `CUSTOMERNAME` varchar(32) DEFAULT NULL COMMENT '姓名',
  `TELEPHONE` varchar(32) DEFAULT NULL COMMENT '电话',
  `ADDRESS` varchar(32) DEFAULT NULL COMMENT '所在地区',
  `ADDRESS2` varchar(32) DEFAULT NULL COMMENT '所在地区2',
  `SORTNO` varchar(32) DEFAULT NULL COMMENT '排序号',
  `PARENTNO` varchar(32) DEFAULT NULL COMMENT '所属父类',
  `ISINUSE` char(1) DEFAULT NULL COMMENT '是否使用',
  `ATTR1` varchar(32) DEFAULT NULL COMMENT '属性1',
  `ATTR2` varchar(32) DEFAULT NULL COMMENT '属性1',
  `ATTR3` varchar(32) DEFAULT NULL COMMENT '属性1',
  `ATTR4` varchar(32) DEFAULT NULL COMMENT '属性1',
  `ATTR5` varchar(32) DEFAULT NULL COMMENT '属性1',
  `STAR` varchar(32) DEFAULT NULL COMMENT '五星评分',
  `NUMBER1` decimal(24,6) DEFAULT NULL COMMENT '测试数字',
  `TESTDATE` datetime DEFAULT NULL COMMENT '测试日期',
  PRIMARY KEY (`SERIALNO`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='OW案例数据表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `example_info`
--

DROP TABLE IF EXISTS `example_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `example_info` (
  `EXAMPLEID` varchar(32) NOT NULL COMMENT '示例ID',
  `EXAMPLENAME` varchar(80) DEFAULT NULL COMMENT '示例名称',
  `SORTNO` varchar(32) DEFAULT NULL COMMENT '排序号',
  `INDUSTRYTYPE` varchar(18) DEFAULT NULL COMMENT '行业类型',
  `BEGINDATE` varchar(10) DEFAULT NULL COMMENT '开始日期',
  `APPLYSUM` decimal(24,6) DEFAULT NULL COMMENT '申请金额',
  `ATTRIBUTE1` varchar(80) DEFAULT NULL COMMENT '属性1',
  `ATTRIBUTE2` varchar(80) DEFAULT NULL COMMENT '属性2',
  `ATTRIBUTE3` varchar(80) DEFAULT NULL COMMENT '属性3',
  `INPUTORG` varchar(32) DEFAULT NULL COMMENT '登记单位',
  `INPUTUSER` varchar(32) DEFAULT NULL COMMENT '登记人',
  `INPUTTIME` varchar(20) DEFAULT NULL COMMENT '登记时间',
  `UPDATEUSER` varchar(32) DEFAULT NULL COMMENT '更新人',
  `UPDATETIME` varchar(20) DEFAULT NULL COMMENT '更新时间',
  `REMARK` varchar(250) DEFAULT NULL COMMENT '备注',
  `AUDITUSER` varchar(32) DEFAULT NULL COMMENT '审计人',
  `AUDITORG` varchar(32) DEFAULT NULL COMMENT '审计单位',
  `PARENTEXAMPLEID` varchar(32) DEFAULT NULL COMMENT '父示例ID',
  `CUSTOMERTYPE` varchar(32) DEFAULT NULL COMMENT '客户类型',
  `PASSWORD` varchar(20) DEFAULT NULL COMMENT '密码',
  `CUSTOMERNAME` varchar(32) DEFAULT NULL COMMENT '客户名称',
  `CUSTOMERID` varchar(32) DEFAULT NULL COMMENT '客户编号',
  `MYCLOB1` text,
  `MYCLOB2` text,
  PRIMARY KEY (`EXAMPLEID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `example_number`
--

DROP TABLE IF EXISTS `example_number`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `example_number` (
  `SERIALNO` varchar(32) NOT NULL COMMENT '编号',
  `NUMBER1` decimal(24,6) DEFAULT NULL COMMENT '测试数字',
  `NUMBER2` decimal(10,2) DEFAULT NULL COMMENT '测试数字',
  `NUMBER3` int(11) DEFAULT NULL COMMENT '测试整数',
  PRIMARY KEY (`SERIALNO`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='测试数字表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `example_wizard_info`
--

DROP TABLE IF EXISTS `example_wizard_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `example_wizard_info` (
  `SERIALNO` varchar(32) NOT NULL COMMENT '编号',
  `FLAG` varchar(1) DEFAULT NULL COMMENT '向导完结标识',
  `OPINION` varchar(800) DEFAULT NULL COMMENT '意见信息',
  PRIMARY KEY (`SERIALNO`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='向导运行案例表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Temporary view structure for view `finance_catalog`
--

DROP TABLE IF EXISTS `finance_catalog`;
/*!50001 DROP VIEW IF EXISTS `finance_catalog`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `finance_catalog` AS SELECT 
 1 AS `REPORTTYPE`,
 1 AS `REPORTNO`,
 1 AS `REPORTNAME`,
 1 AS `REPORTDESCRIBE`,
 1 AS `BELONGINDUSTRY`,
 1 AS `REPORTABBR`,
 1 AS `HEADERMETHOD`,
 1 AS `DISPLAYMETHOD`,
 1 AS `DELETEFLAG`,
 1 AS `ATTRIBUTE2`,
 1 AS `ATTRIBUTE1`,
 1 AS `REMARK`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `finance_data`
--

DROP TABLE IF EXISTS `finance_data`;
/*!50001 DROP VIEW IF EXISTS `finance_data`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `finance_data` AS SELECT 
 1 AS `CUSTOMERID`,
 1 AS `ACCOUNTMONTH`,
 1 AS `MODELNO`,
 1 AS `REPORTNO`,
 1 AS `SCOPE`,
 1 AS `FINANCEITEMNO`,
 1 AS `ITEM1VALUE`,
 1 AS `ITEM2VALUE`,
 1 AS `ITEM1BASEVALUE`,
 1 AS `ITEM2BASEVALUE`,
 1 AS `STANDARDVALUE`,
 1 AS `DISPLAYORDER`,
 1 AS `ITEMATTRIBUTE`,
 1 AS `DISPLAYNAME`,
 1 AS `DISPLAYNO`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `finance_item`
--

DROP TABLE IF EXISTS `finance_item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `finance_item` (
  `ITEMNO` varchar(32) NOT NULL COMMENT '科目编号',
  `ITEMNAME` varchar(80) DEFAULT NULL COMMENT '科目名称',
  `ITEMATTRIBUTE` varchar(250) DEFAULT NULL COMMENT '科目属性',
  `ITEMDESCRIBE` varchar(250) DEFAULT NULL COMMENT '科目描述',
  `DELETEFLAG` varchar(1) DEFAULT NULL COMMENT '删除标志',
  `REMARK` varchar(250) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`ITEMNO`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='财务报表科目表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Temporary view structure for view `finance_model`
--

DROP TABLE IF EXISTS `finance_model`;
/*!50001 DROP VIEW IF EXISTS `finance_model`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `finance_model` AS SELECT 
 1 AS `ITEM1DEF`,
 1 AS `ITEM1BASEDEF`,
 1 AS `ITEM2DEF`,
 1 AS `ITEM2BASEDEF`,
 1 AS `DELETEFLAG`,
 1 AS `LISTNO`,
 1 AS `REPORTNO`,
 1 AS `ITEMATTRIBUTE`,
 1 AS `DISPLAYNAME`,
 1 AS `DISPLAYNO`,
 1 AS `FINANCEITEMNO`,
 1 AS `STANDARDVALUE`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `finance_record`
--

DROP TABLE IF EXISTS `finance_record`;
/*!50001 DROP VIEW IF EXISTS `finance_record`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `finance_record` AS SELECT 
 1 AS `REPORTPERIOD`,
 1 AS `ATTRIBUTE1`,
 1 AS `ATTRIBUTE2`,
 1 AS `CUSTOMERID`,
 1 AS `INPUTDATE`,
 1 AS `INPUTTIME`,
 1 AS `LASTUPDATEDATE`,
 1 AS `OBJECTNO`,
 1 AS `OBJECTTYPE`,
 1 AS `ORGID`,
 1 AS `RECORDNO`,
 1 AS `REMARK`,
 1 AS `REMARK1`,
 1 AS `REPORT_ORGID`,
 1 AS `REPORT_USERID`,
 1 AS `REPORTCURRENCY`,
 1 AS `ACCOUNTMONTH`,
 1 AS `REPORTDATE`,
 1 AS `REPORTFLAG`,
 1 AS `REPORTNAME`,
 1 AS `REPORTNO`,
 1 AS `REPORT_REPORTNO`,
 1 AS `REPORTOPINION`,
 1 AS `REPORTSCOPE`,
 1 AS `REPORTSTATUS`,
 1 AS `REPORTUNIT`,
 1 AS `UPDATETIME`,
 1 AS `USERID`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `flow_catalog`
--

DROP TABLE IF EXISTS `flow_catalog`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `flow_catalog` (
  `FLOWNO` varchar(32) NOT NULL COMMENT '流程编号',
  `FLOWNAME` varchar(80) DEFAULT NULL COMMENT '流程名称',
  `FLOWTYPE` varchar(18) DEFAULT NULL COMMENT '流程类型',
  `FLOWDESCRIBE` varchar(250) DEFAULT NULL COMMENT '流程描述',
  `INITPHASE` varchar(250) DEFAULT NULL COMMENT '开始阶段',
  `AAENABLED` varchar(1) DEFAULT NULL COMMENT '授权是否可用',
  `AAPOLICY` varchar(32) DEFAULT NULL COMMENT '授权方案',
  `VIEWFILE` longblob COMMENT '流程图描述',
  `VIEWFILELENGTH` decimal(22,0) DEFAULT NULL COMMENT '流程图描述长度',
  `GROUPTITLES` varchar(1000) DEFAULT NULL COMMENT '流程图分组标题',
  `METAFLOWNO` varchar(32) DEFAULT NULL,
  `ISINUSE` varchar(18) DEFAULT NULL COMMENT '是否使用',
  `VERSION` varchar(10) NOT NULL DEFAULT '1' COMMENT '版本',
  `BASEFLOWNO` varchar(32) DEFAULT NULL COMMENT '基础流程编号',
  `BASEFLOWNAME` varchar(80) DEFAULT NULL COMMENT '基础流程名称',
  `FLOWBUTTONSET` varchar(40) DEFAULT NULL COMMENT '流程按钮组，若流程没有关联的申请或审批类型，则使用此按钮组编号',
  PRIMARY KEY (`FLOWNO`,`VERSION`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='流程模型目录表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `flow_model`
--

DROP TABLE IF EXISTS `flow_model`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `flow_model` (
  `FLOWNO` varchar(32) NOT NULL COMMENT '流程编号',
  `PHASENO` varchar(32) NOT NULL COMMENT '阶段编号',
  `PHASETYPE` varchar(18) DEFAULT NULL COMMENT '阶段类型',
  `PHASENAME` varchar(80) DEFAULT NULL COMMENT '阶段名称',
  `PHASEDESCRIBE` varchar(250) DEFAULT NULL COMMENT '阶段描述',
  `PHASEATTRIBUTE` varchar(80) DEFAULT NULL COMMENT '阶段属性',
  `PRESCRIPT` varchar(250) DEFAULT NULL COMMENT '前沿检查Script',
  `INITSCRIPT` varchar(800) DEFAULT NULL COMMENT '承办人初始化Script',
  `CHOICEDESCRIBE` varchar(250) DEFAULT NULL COMMENT '意见提示文字',
  `CHOICESCRIPT` varchar(250) DEFAULT NULL COMMENT '意见生成Script',
  `ACTIONDESCRIBE` varchar(800) DEFAULT NULL COMMENT '动作提示文字',
  `ACTIONSCRIPT` varchar(800) DEFAULT NULL COMMENT '动作生成Script',
  `POSTSCRIPT` varchar(800) DEFAULT NULL COMMENT '后继判断Script',
  `ATTRIBUTE1` varchar(250) DEFAULT NULL COMMENT '当前工作功能按钮',
  `ATTRIBUTE2` varchar(250) DEFAULT NULL COMMENT '已完成工作功能按钮',
  `ATTRIBUTE3` varchar(250) DEFAULT NULL COMMENT '意见查看权限方式',
  `ATTRIBUTE4` varchar(250) DEFAULT NULL COMMENT '意见权限阶段',
  `ATTRIBUTE5` varchar(250) DEFAULT NULL COMMENT '意见查看特权角色',
  `ATTRIBUTE6` varchar(250) DEFAULT NULL COMMENT '仅查看自己签署意见所对应的阶段',
  `ATTRIBUTE7` varchar(250) DEFAULT NULL COMMENT '视图',
  `ATTRIBUTE8` varchar(250) DEFAULT NULL COMMENT '签署意见组件ID',
  `ATTRIBUTE9` varchar(250) DEFAULT NULL COMMENT '本阶段对应的角色',
  `ATTRIBUTE10` varchar(250) DEFAULT NULL COMMENT '属性10',
  `AAENABLED` varchar(1) DEFAULT NULL COMMENT '是否为授权点',
  `AAPOINTINITSCRIPT` varchar(1600) DEFAULT NULL COMMENT '授权点初始化',
  `AAPOINTCOMP` varchar(250) DEFAULT NULL COMMENT '授权点编辑组件',
  `AAPOINTCOMPURL` varchar(250) DEFAULT NULL COMMENT '授权点编辑组件地址',
  `STANDARDTIME1` int(11) DEFAULT NULL COMMENT '标准审批用时(分钟)',
  `STANDARDTIME2` int(11) DEFAULT NULL COMMENT '最长审批用时(分钟)',
  `COSTLOB` varchar(32) DEFAULT NULL COMMENT '审批成本归属',
  `STRIPS` varchar(400) DEFAULT NULL COMMENT '显示的Strips',
  `CHECKLIST` varchar(32) DEFAULT NULL COMMENT '执行的Checklist',
  `DECISIONSCRIPT` varchar(800) DEFAULT NULL COMMENT '执行的规则组',
  `RISKSCANRULE` varchar(32) DEFAULT NULL COMMENT '风险点扫描',
  `BUTTONSET2` varchar(400) DEFAULT NULL COMMENT 'Strips上方按钮',
  `INPUTUSER` varchar(32) DEFAULT NULL COMMENT '登记人员',
  `INPUTTIME` varchar(20) DEFAULT NULL COMMENT '登记时间',
  `UPDATEUSER` varchar(32) DEFAULT NULL COMMENT '更新人员',
  `UPDATETIME` varchar(20) DEFAULT NULL COMMENT '更新时间',
  `DISTRIBUTERULE` varchar(32) DEFAULT NULL COMMENT '分发方式',
  `ID` varchar(32) DEFAULT NULL,
  `TYPE` varchar(32) DEFAULT NULL,
  `NAME` varchar(400) DEFAULT NULL,
  `XCOORDINATE` varchar(10) DEFAULT NULL,
  `YCOORDINATE` varchar(10) DEFAULT NULL,
  `WIDTH` varchar(10) DEFAULT NULL,
  `HEIGHT` varchar(10) DEFAULT NULL,
  `VERSION` varchar(10) NOT NULL DEFAULT '1' COMMENT '版本',
  `SWIMLANE` varchar(32) DEFAULT NULL COMMENT '泳道',
  `NODETYPE` varchar(32) DEFAULT NULL COMMENT '流程节点类型',
  `FLOWPHASECONTEXT` varchar(1500) DEFAULT NULL COMMENT '流程阶段上下文',
  `CONTINUECONDITION` varchar(200) DEFAULT NULL COMMENT '多批时流程继续的判断',
  PRIMARY KEY (`FLOWNO`,`PHASENO`,`VERSION`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='流程模型信息表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `flow_object`
--

DROP TABLE IF EXISTS `flow_object`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `flow_object` (
  `OBJECTTYPE` varchar(18) NOT NULL COMMENT '对象类型',
  `OBJECTNO` varchar(32) NOT NULL COMMENT '对象编号',
  `PHASETYPE` varchar(18) DEFAULT NULL COMMENT '阶段类型',
  `APPLYTYPE` varchar(18) DEFAULT NULL COMMENT '申请类型',
  `FLOWNO` varchar(32) DEFAULT NULL COMMENT '当前流程号',
  `FLOWNAME` varchar(80) DEFAULT NULL COMMENT '当前流程名称',
  `PHASENO` varchar(32) DEFAULT NULL COMMENT '当前阶段号',
  `PHASENAME` varchar(80) DEFAULT NULL COMMENT '当前阶段名称',
  `OBJDESCRIBE` varchar(250) DEFAULT NULL COMMENT '对象描述',
  `OBJATTRIBUTE1` varchar(80) DEFAULT NULL COMMENT '对象属性1',
  `OBJATTRIBUTE2` varchar(80) DEFAULT NULL COMMENT '对象属性2',
  `OBJATTRIBUTE3` varchar(80) DEFAULT NULL COMMENT '对象属性3',
  `OBJATTRIBUTE4` varchar(80) DEFAULT NULL COMMENT '对象属性4',
  `OBJATTRIBUTE5` varchar(80) DEFAULT NULL COMMENT '对象属性5',
  `ORGID` varchar(32) DEFAULT NULL COMMENT '创建机构',
  `ORGNAME` varchar(80) DEFAULT NULL COMMENT '创建机构名称',
  `USERID` varchar(32) DEFAULT NULL COMMENT '创建人',
  `USERNAME` varchar(80) DEFAULT NULL COMMENT '创建人姓名',
  `INPUTDATE` varchar(20) DEFAULT NULL COMMENT '创建日期',
  `ARCHIVE` char(1) DEFAULT NULL COMMENT '是否归档',
  `ARCHIVETIME` varchar(20) DEFAULT NULL COMMENT '归档时间',
  `APPLYNO` varchar(32) DEFAULT NULL COMMENT '申请编号',
  `FLOWSTATE` varchar(80) DEFAULT NULL COMMENT '流程状态',
  `PROCESSINSTNO` varchar(32) DEFAULT NULL COMMENT '流程实例',
  `PROCESSTASKNO` varchar(32) DEFAULT NULL COMMENT '流程实例任务号',
  `RELATIVETASKNO` varchar(32) DEFAULT NULL COMMENT '关联任务号',
  `VERSION` varchar(10) DEFAULT NULL COMMENT '版本',
  `BASEFLOWNO` varchar(32) DEFAULT NULL COMMENT '流程号',
  `TASKTYPE` varchar(32) DEFAULT NULL COMMENT '任务类型',
  `SERIALNO` varchar(32) DEFAULT NULL COMMENT '编号',
  PRIMARY KEY (`OBJECTNO`,`OBJECTTYPE`),
  KEY `IDX1_FLOW_OBJECT` (`OBJECTTYPE`,`OBJECTNO`,`PHASENO`),
  KEY `IDX2_FLOW_OBJECT` (`USERID`,`APPLYTYPE`,`OBJECTTYPE`,`OBJECTNO`),
  KEY `IDX3_FLOW_OBJECT` (`FLOWNO`,`PHASENO`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='流程对象表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `flow_opinion`
--

DROP TABLE IF EXISTS `flow_opinion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `flow_opinion` (
  `SERIALNO` varchar(32) NOT NULL COMMENT '流程任务流水号',
  `OPINIONNO` varchar(32) NOT NULL COMMENT '意见序号',
  `OBJECTTYPE` varchar(18) DEFAULT NULL COMMENT '对象类型',
  `OBJECTNO` varchar(32) DEFAULT NULL COMMENT '对象编号',
  `CUSTOMERID` varchar(32) DEFAULT NULL COMMENT '客户编号',
  `CUSTOMERNAME` varchar(80) DEFAULT NULL COMMENT '客户名称',
  `BUSINESSCURRENCY` varchar(18) DEFAULT NULL COMMENT '币种',
  `BUSINESSSUM` decimal(24,6) DEFAULT NULL COMMENT '金额',
  `TERMYEAR` int(11) DEFAULT NULL COMMENT '期限(年)',
  `TERMMONTH` int(11) DEFAULT NULL COMMENT '期限(月)',
  `TERMDAY` int(11) DEFAULT NULL COMMENT '期限(日)',
  `BASERATETYPE` varchar(18) DEFAULT NULL COMMENT '基准利率类型',
  `RATEFLOATTYPE` varchar(18) DEFAULT NULL COMMENT '利率浮动方式',
  `RATEFLOAT` decimal(10,6) DEFAULT NULL COMMENT '利率浮动',
  `BAILCURRENCY` varchar(18) DEFAULT NULL COMMENT '保证金币种',
  `BUSINESSRATE` decimal(10,6) DEFAULT NULL COMMENT '执行利率',
  `BAILRATIO` decimal(10,6) DEFAULT NULL COMMENT '保证金比率',
  `BAILSUM` decimal(24,6) DEFAULT NULL COMMENT '保证金金额',
  `PDGRATIO` decimal(10,6) DEFAULT NULL COMMENT '手续费比率',
  `PDGSUM` decimal(24,6) DEFAULT NULL COMMENT '手续费金额',
  `BASERATE` decimal(10,6) DEFAULT NULL COMMENT '基准利率',
  `PHASECHOICE` varchar(800) DEFAULT NULL COMMENT '阶段意见',
  `PHASEOPINION` varchar(400) DEFAULT NULL COMMENT '意见详情',
  `PHASEOPINION1` varchar(400) DEFAULT NULL COMMENT '意见详情1',
  `PHASEOPINION2` varchar(400) DEFAULT NULL COMMENT '意见详情2',
  `PHASEOPINION3` varchar(400) DEFAULT NULL COMMENT '意见详情3',
  `INPUTORG` varchar(32) DEFAULT NULL COMMENT '登记机构',
  `INPUTUSER` varchar(32) DEFAULT NULL COMMENT '登记人员',
  `INPUTTIME` varchar(20) DEFAULT NULL COMMENT '登记时间',
  `UPDATEUSER` varchar(32) DEFAULT NULL COMMENT '变更人员',
  `UPDATETIME` varchar(20) DEFAULT NULL COMMENT '变更时间',
  PRIMARY KEY (`SERIALNO`,`OPINIONNO`),
  KEY `IDX1_FLOW_OPINION` (`INPUTUSER`,`OPINIONNO`,`SERIALNO`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='流程意见记录';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `flow_swimlane`
--

DROP TABLE IF EXISTS `flow_swimlane`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `flow_swimlane` (
  `LANENO` varchar(32) NOT NULL COMMENT '编号',
  `LANENAME` varchar(80) DEFAULT NULL COMMENT '名称',
  `SORTNO` varchar(18) DEFAULT NULL COMMENT '排序号',
  `LANECONSTRAINT` varchar(60) DEFAULT NULL COMMENT '坐标',
  PRIMARY KEY (`LANENO`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='流程泳道';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `flow_task`
--

DROP TABLE IF EXISTS `flow_task`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `flow_task` (
  `SERIALNO` varchar(32) NOT NULL COMMENT '流水号',
  `OBJECTNO` varchar(32) DEFAULT NULL COMMENT '对象编号',
  `OBJECTTYPE` varchar(18) DEFAULT NULL COMMENT '对象类型',
  `RELATIVESERIALNO` varchar(32) DEFAULT NULL COMMENT '上一流水号',
  `FLOWNO` varchar(32) DEFAULT NULL COMMENT '流程编号',
  `FLOWNAME` varchar(80) DEFAULT NULL COMMENT '流程名称',
  `PHASENO` varchar(32) DEFAULT NULL COMMENT '阶段编号',
  `PHASENAME` varchar(80) DEFAULT NULL COMMENT '阶段名称',
  `PHASETYPE` varchar(18) DEFAULT NULL COMMENT '阶段类型',
  `APPLYTYPE` varchar(18) DEFAULT NULL COMMENT '申请类型',
  `USERID` varchar(32) DEFAULT NULL COMMENT '承办人编号',
  `USERNAME` varchar(80) DEFAULT NULL COMMENT '承办人姓名',
  `ORGID` varchar(32) DEFAULT NULL COMMENT '承办机构编号',
  `ORGNAME` varchar(80) DEFAULT NULL COMMENT '承办机构名称',
  `BEGINTIME` varchar(20) DEFAULT NULL COMMENT '开始执行时间',
  `ENDTIME` varchar(20) DEFAULT NULL COMMENT '完成执行时间',
  `PHASECHOICE` varchar(80) DEFAULT NULL COMMENT '阶段意见',
  `PHASEACTION` varchar(500) DEFAULT NULL COMMENT '阶段动作',
  `PHASEOPINION` varchar(1600) DEFAULT NULL COMMENT '意见详情',
  `PHASEOPINION1` varchar(250) DEFAULT NULL COMMENT '意见详情1',
  `PHASEOPINION2` varchar(250) DEFAULT NULL COMMENT '意见详情2',
  `PHASEOPINION3` varchar(250) DEFAULT NULL COMMENT '意见详情3',
  `PHASEOPINION4` varchar(250) DEFAULT NULL COMMENT '意见详情4',
  `CHECKLISTRESULT` varchar(80) DEFAULT NULL COMMENT '检查清单结果',
  `AUTODECISION` varchar(80) DEFAULT NULL COMMENT '自动审批判断结果',
  `RISKSCANRESULT` varchar(80) DEFAULT NULL COMMENT '风险探测结果',
  `STANDARDTIME1` varchar(32) DEFAULT NULL COMMENT '标准审批用时',
  `STANDARDTIME2` varchar(32) DEFAULT NULL COMMENT '最长审批用时',
  `COSTLOB` varchar(32) DEFAULT NULL COMMENT '审批成本归属',
  `CLIENTX` int(11) DEFAULT NULL COMMENT '图元X坐标',
  `CLIENTY` int(11) DEFAULT NULL COMMENT '图元Y坐标',
  `WIDTH` int(11) DEFAULT NULL COMMENT '图元宽度',
  `HEIGTH` int(11) DEFAULT NULL COMMENT '图元高度',
  `GROUPINFO` varchar(1000) DEFAULT NULL COMMENT '分组信息',
  `PROCESSINSTNO` varchar(32) DEFAULT NULL COMMENT '流程实例编号',
  `PROCESSTASKNO` varchar(32) DEFAULT NULL COMMENT '任务流程编号',
  `FLOWSTATE` varchar(80) DEFAULT NULL,
  `RELATIVEOBJECTNO` varchar(32) DEFAULT NULL,
  `FORKSTATE` varchar(6) DEFAULT NULL COMMENT '并行状态',
  `VERSION` varchar(10) DEFAULT NULL COMMENT '版本',
  `BASEFLOWNO` varchar(32) DEFAULT NULL COMMENT '流程号',
  `TASKSTATE` varchar(6) DEFAULT NULL COMMENT '任务状态',
  `FORKNO` varchar(32) DEFAULT NULL COMMENT '并行分支编号',
  `ALLFORKNO` varchar(250) DEFAULT NULL COMMENT '所有的并行分支编号',
  `PARENTFLOWNO` varchar(64) DEFAULT NULL COMMENT '父流程编号',
  `ASSIGNEDTASKNO` varchar(320) DEFAULT NULL COMMENT '指定任务编号',
  `RELANOTICENO` varchar(40) DEFAULT NULL COMMENT '关联提醒编号',
  PRIMARY KEY (`SERIALNO`),
  KEY `IDX1_FLOW_TASK` (`USERID`,`OBJECTNO`,`OBJECTTYPE`,`FLOWNO`,`PHASENO`),
  KEY `IDX_FLOW_TASK` (`OBJECTNO`,`OBJECTTYPE`,`FLOWNO`,`PHASENO`),
  KEY `IDX2_FLOW_TASK` (`USERID`,`ENDTIME`),
  KEY `IDX3_FLOW_TASK` (`RELATIVESERIALNO`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='流程任务';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `flow_task_closed`
--

DROP TABLE IF EXISTS `flow_task_closed`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `flow_task_closed` (
  `SERIALNO` varchar(32) NOT NULL COMMENT '流水号',
  `OBJECTNO` varchar(32) DEFAULT NULL COMMENT '对象编号',
  `OBJECTTYPE` varchar(18) DEFAULT NULL COMMENT '对象类型',
  `RELATIVESERIALNO` varchar(32) DEFAULT NULL COMMENT '上一流水号',
  `FLOWNO` varchar(32) DEFAULT NULL COMMENT '流程编号',
  `FLOWNAME` varchar(80) DEFAULT NULL COMMENT '流程名称',
  `PHASENO` varchar(32) DEFAULT NULL COMMENT '阶段编号',
  `PHASENAME` varchar(80) DEFAULT NULL COMMENT '阶段名称',
  `PHASETYPE` varchar(18) DEFAULT NULL COMMENT '阶段类型',
  `APPLYTYPE` varchar(18) DEFAULT NULL COMMENT '申请类型',
  `USERID` varchar(32) DEFAULT NULL COMMENT '承办人编号',
  `USERNAME` varchar(80) DEFAULT NULL COMMENT '承办人姓名',
  `ORGID` varchar(32) DEFAULT NULL COMMENT '承办机构编号',
  `ORGNAME` varchar(80) DEFAULT NULL COMMENT '承办机构名称',
  `BEGINTIME` varchar(20) DEFAULT NULL COMMENT '开始执行时间',
  `ENDTIME` varchar(20) DEFAULT NULL COMMENT '完成执行时间',
  `PHASECHOICE` varchar(80) DEFAULT NULL COMMENT '阶段意见',
  `PHASEACTION` varchar(250) DEFAULT NULL COMMENT '阶段动作',
  `PHASEOPINION` varchar(1600) DEFAULT NULL COMMENT '意见详情',
  `PHASEOPINION1` varchar(18) DEFAULT NULL COMMENT '意见详情1',
  `PHASEOPINION2` varchar(250) DEFAULT NULL COMMENT '意见详情2',
  `PHASEOPINION3` varchar(250) DEFAULT NULL COMMENT '意见详情3',
  `PHASEOPINION4` varchar(250) DEFAULT NULL COMMENT '意见详情4',
  PRIMARY KEY (`SERIALNO`),
  KEY `IDX_FT_CLOSED` (`FLOWNO`,`PHASENO`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='已结束流程任务';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `flow_user_rela`
--

DROP TABLE IF EXISTS `flow_user_rela`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `flow_user_rela` (
  `SERIALNO` varchar(32) NOT NULL COMMENT '流水号',
  `OBJECTTYPE` varchar(40) DEFAULT NULL COMMENT '对象类型',
  `OBJECTNO` varchar(40) DEFAULT NULL COMMENT '对象编号',
  `TASKID` varchar(32) DEFAULT NULL COMMENT '任务编号',
  `FLOWNO` varchar(32) DEFAULT NULL COMMENT '流程编号',
  `USERID` varchar(32) DEFAULT NULL COMMENT '用户号',
  `ORGID` varchar(32) DEFAULT NULL COMMENT '机构',
  `ROLEID` varchar(32) DEFAULT NULL COMMENT '角色号(任务池)',
  `RELATYPE` varchar(32) DEFAULT NULL COMMENT '关联类型(ASSIST-协助,POOL2任务池角色)',
  `INPUTTIME` varchar(20) DEFAULT NULL COMMENT '建立时间',
  `UPDATETIME` varchar(20) DEFAULT NULL COMMENT '更新时间',
  `STATUS` char(1) DEFAULT NULL COMMENT '协助状态(1-未处理,2-已处理)',
  PRIMARY KEY (`SERIALNO`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用于候选角色POOL2任务池模式，保存流程任务与角色的关联';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `formatdoc_catalog`
--

DROP TABLE IF EXISTS `formatdoc_catalog`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `formatdoc_catalog` (
  `DOCID` varchar(18) NOT NULL COMMENT '文档类型编号',
  `DOCNAME` varchar(200) DEFAULT NULL COMMENT '文档类型名称',
  `DOCTYPE` varchar(18) DEFAULT NULL COMMENT '文档类型',
  `ATTRIBUTE1` varchar(200) DEFAULT NULL COMMENT '属性1',
  `ATTRIBUTE2` varchar(200) DEFAULT NULL COMMENT '属性2',
  `ATTRIBUTE3` varchar(200) DEFAULT NULL COMMENT '属性3',
  `ATTRIBUTE4` varchar(200) DEFAULT NULL COMMENT '属性4',
  `ORGID` varchar(32) DEFAULT NULL COMMENT '机构',
  `USERID` varchar(32) DEFAULT NULL COMMENT '登记人',
  `INPUTDATE` varchar(10) DEFAULT NULL COMMENT '登记日期',
  `UPDATEDATE` varchar(10) DEFAULT NULL COMMENT '更新日期',
  PRIMARY KEY (`DOCID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='格式化报告模型目录';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `formatdoc_data`
--

DROP TABLE IF EXISTS `formatdoc_data`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `formatdoc_data` (
  `SERIALNO` varchar(40) NOT NULL COMMENT '一般情况下为docid+treeno',
  `OBJECTNO` varchar(40) NOT NULL COMMENT '相应的业务号',
  `TREENO` varchar(18) DEFAULT NULL COMMENT '一般情况下为dirid',
  `DOCID` varchar(18) DEFAULT NULL COMMENT '文档类型编号',
  `DIRID` varchar(18) DEFAULT NULL COMMENT '目录编号',
  `DIRNAME` varchar(200) DEFAULT NULL COMMENT '目录名称',
  `GUARANTYNO` varchar(40) DEFAULT NULL COMMENT '关联担保号',
  `HTMLDATA` longblob COMMENT '内容',
  `CONTENTLENGTH` int(11) DEFAULT NULL COMMENT '长度',
  `ORGID` varchar(32) DEFAULT NULL COMMENT '机构',
  `USERID` varchar(32) DEFAULT NULL COMMENT '登记人',
  `INPUTDATE` varchar(10) DEFAULT NULL COMMENT '登记日期',
  `UPDATEDATE` varchar(10) DEFAULT NULL COMMENT '更新日期',
  `OBJECTTYPE` varchar(18) DEFAULT NULL COMMENT '对象类型',
  PRIMARY KEY (`SERIALNO`,`OBJECTNO`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='格式化报告内容';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `formatdoc_def`
--

DROP TABLE IF EXISTS `formatdoc_def`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `formatdoc_def` (
  `DOCID` varchar(18) NOT NULL COMMENT '文档类型编号',
  `DIRID` varchar(18) NOT NULL COMMENT '目录编号',
  `DIRNAME` varchar(200) DEFAULT NULL COMMENT '目录名称',
  `JSPFILENAME` varchar(200) DEFAULT NULL COMMENT 'JSP文件名',
  `HTMLFILENAME` varchar(200) DEFAULT NULL COMMENT '模版文件名',
  `ARRANGEATTR` varchar(18) DEFAULT NULL COMMENT '展现属性',
  `CIRCLEATTR` varchar(18) DEFAULT NULL COMMENT '循环属性',
  `ATTRIBUTE1` varchar(200) DEFAULT NULL COMMENT '属性1',
  `ATTRIBUTE2` varchar(200) DEFAULT NULL COMMENT '属性2',
  `ORGID` varchar(32) DEFAULT NULL COMMENT '机构',
  `USERID` varchar(32) DEFAULT NULL COMMENT '登记人',
  `INPUTDATE` varchar(10) DEFAULT NULL COMMENT '登记日期',
  `UPDATEDATE` varchar(10) DEFAULT NULL COMMENT '更新日期',
  PRIMARY KEY (`DOCID`,`DIRID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='格式化报告模型定义';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `formatdoc_para`
--

DROP TABLE IF EXISTS `formatdoc_para`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `formatdoc_para` (
  `ORGID` varchar(32) NOT NULL COMMENT '机构号',
  `DOCID` varchar(32) NOT NULL COMMENT '调查报告模板编号',
  `DEFAULTVALUE` varchar(400) DEFAULT NULL COMMENT '默认打印节点',
  `DOCNAME` varchar(80) DEFAULT NULL COMMENT '模板名称',
  `ATTRIBUTE1` varchar(80) DEFAULT NULL COMMENT '属性1',
  `ATTRIBUTE2` varchar(80) DEFAULT NULL COMMENT '属性2',
  `INPUTUSER` varchar(32) DEFAULT NULL COMMENT '录入用户编号',
  `INPUTTIME` varchar(32) DEFAULT NULL COMMENT '录入时间',
  `UPDATEUSER` varchar(32) DEFAULT NULL COMMENT '更新用户编号',
  `UPDATEDATE` varchar(32) DEFAULT NULL COMMENT '更新时间',
  `REMARK` varchar(200) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`DOCID`,`ORGID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='格式化报告模型参数表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `formatdoc_record`
--

DROP TABLE IF EXISTS `formatdoc_record`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `formatdoc_record` (
  `SERIALNO` varchar(32) NOT NULL COMMENT '流水号',
  `OBJECTTYPE` varchar(18) DEFAULT NULL COMMENT '对象类型',
  `OBJECTNO` varchar(32) DEFAULT NULL COMMENT '对象编号',
  `DOCID` varchar(18) DEFAULT NULL COMMENT '格式化报告编号',
  `SAVEPATH` varchar(120) DEFAULT NULL COMMENT '保存路径',
  `ATTRIBUTE1` varchar(40) DEFAULT NULL COMMENT '属性1',
  `ATTRIBUTE2` varchar(40) DEFAULT NULL COMMENT '属性2',
  `ATTRIBUTE3` varchar(40) DEFAULT NULL COMMENT '属性3',
  `ATTRIBUTE4` varchar(40) DEFAULT NULL COMMENT '属性4',
  `ATTRIBUTE5` varchar(40) DEFAULT NULL COMMENT '属性5',
  PRIMARY KEY (`SERIALNO`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='格式化报告记录';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `guaranty_contract`
--

DROP TABLE IF EXISTS `guaranty_contract`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `guaranty_contract` (
  `SERIALNO` varchar(40) NOT NULL,
  `CONTRACTTYPE` varchar(20) DEFAULT NULL,
  `GUARANTYTYPE` varchar(20) DEFAULT NULL,
  `CONTRACTSTATUS` varchar(20) DEFAULT NULL,
  `CONTRACTNO` varchar(80) DEFAULT NULL,
  `SIGNDATE` varchar(10) DEFAULT NULL,
  `BEGINDATE` varchar(10) DEFAULT NULL,
  `ENDDATE` varchar(10) DEFAULT NULL,
  `CUSTOMERID` varchar(40) DEFAULT NULL,
  `GUARANTORID` varchar(40) DEFAULT NULL,
  `GUARANTORNAME` varchar(80) DEFAULT NULL,
  `CREDITORGID` varchar(40) DEFAULT NULL,
  `CREDITORGNAME` varchar(80) DEFAULT NULL,
  `GUARANTYCURRENCY` varchar(20) DEFAULT NULL,
  `GUARANTYVALUE` decimal(24,6) DEFAULT NULL,
  `GUARANTYINFO` varchar(200) DEFAULT NULL,
  `OTHERDESCRIBE` varchar(500) DEFAULT NULL,
  `CHECKGUARANTY` varchar(20) DEFAULT NULL,
  `RECEPTION` varchar(80) DEFAULT NULL,
  `RECEPTIONDUTY` varchar(80) DEFAULT NULL,
  `GUARANRYOPINION` varchar(200) DEFAULT NULL,
  `CHECKGUARANTYMAN1` varchar(80) DEFAULT NULL,
  `CHECKGUARANTYMAN2` varchar(80) DEFAULT NULL,
  `INPUTORGID` varchar(40) DEFAULT NULL,
  `INPUTUSERID` varchar(40) DEFAULT NULL,
  `INPUTDATE` varchar(10) DEFAULT NULL,
  `UPDATEUSERID` varchar(40) DEFAULT NULL,
  `UPDATEDATE` varchar(10) DEFAULT NULL,
  `REMARK` varchar(250) DEFAULT NULL,
  `CERTTYPE` varchar(20) DEFAULT NULL,
  `CERTID` varchar(40) DEFAULT NULL,
  `OTHERNAME` varchar(80) DEFAULT NULL,
  `LOANCARDNO` varchar(32) DEFAULT NULL,
  `GUARANTEEFORM` varchar(18) DEFAULT NULL,
  `COMMONDATE` varchar(10) DEFAULT NULL,
  `BAILRATIO` decimal(24,6) DEFAULT NULL,
  PRIMARY KEY (`SERIALNO`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `hpidr_creass_alldlt`
--

DROP TABLE IF EXISTS `hpidr_creass_alldlt`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hpidr_creass_alldlt` (
  `SessionID` varchar(16) NOT NULL COMMENT '上报期次',
  `InfRecType` varchar(3) DEFAULT NULL COMMENT '信息记录类型',
  `DelDueCode` varchar(80) NOT NULL COMMENT '待删除借据号',
  `DelContractCode` varchar(80) NOT NULL COMMENT '待删除贷款合同编号',
  `DelMngmtOrgCode` varchar(14) DEFAULT NULL COMMENT '待删除业务管理金融机构',
  `FbCode` varchar(300) DEFAULT NULL COMMENT '反馈错误码[数据级]',
  `ManagerOrgID` varchar(32) DEFAULT NULL COMMENT '管户机构编号',
  `InputOrgID` varchar(32) DEFAULT NULL COMMENT '录入机构',
  `InputUserID` varchar(32) DEFAULT NULL COMMENT '录入用户',
  `InputTime` varchar(19) DEFAULT NULL COMMENT '录入时间',
  `OccurDate` varchar(10) DEFAULT NULL COMMENT '数据日期',
  `Extend1` varchar(30) DEFAULT NULL COMMENT '扩展字段1',
  `Extend2` varchar(30) DEFAULT NULL COMMENT '扩展字段2',
  `Extend3` varchar(30) DEFAULT NULL COMMENT '扩展字段3',
  `RowNo` int(11) DEFAULT NULL COMMENT '报文行号',
  PRIMARY KEY (`SessionID`,`DelDueCode`,`DelContractCode`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='企业信贷资产信息整笔删除请求记录表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `hpidr_creass_bs`
--

DROP TABLE IF EXISTS `hpidr_creass_bs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hpidr_creass_bs` (
  `SessionId` varchar(16) NOT NULL COMMENT '期次号',
  `DueCode` varchar(80) NOT NULL COMMENT '借据号',
  `InfRecType` varchar(3) DEFAULT NULL COMMENT '信息记录类型',
  `ContractCode` varchar(80) DEFAULT NULL COMMENT '贷款合同编号',
  `CustomerId` varchar(60) DEFAULT NULL COMMENT '客户编号',
  `EntName` varchar(160) DEFAULT NULL COMMENT '企业名称',
  `EntCertType` varchar(2) DEFAULT NULL COMMENT '企业身份标识类型;20-统一社会信用代码',
  `EntCertNum` varchar(18) DEFAULT NULL COMMENT '企业身份标识号码',
  `MngmtOrgCode` varchar(14) DEFAULT NULL COMMENT '业务管理金融机构代码',
  `RptDate` varchar(10) DEFAULT NULL COMMENT '信息报告日期',
  `RecordFlag` varchar(1) DEFAULT NULL COMMENT '记录标志',
  `OccurDate` varchar(10) DEFAULT NULL COMMENT '数据日期',
  `ManagerOrgID` varchar(32) DEFAULT NULL COMMENT '管户机构编号',
  `ManagerUserID` varchar(32) DEFAULT NULL COMMENT '管户用户编号',
  `OperOrgID` varchar(32) DEFAULT NULL COMMENT '操作机构编号',
  `OperUserID` varchar(32) DEFAULT NULL COMMENT '操作用户编号',
  `OperTime` varchar(19) DEFAULT NULL COMMENT '操作时间',
  `Extend1` varchar(30) DEFAULT NULL COMMENT '扩展字段1',
  `Extend2` varchar(30) DEFAULT NULL COMMENT '扩展字段2',
  `Extend3` varchar(30) DEFAULT NULL COMMENT '扩展字段3',
  `RowNo` int(11) DEFAULT NULL COMMENT '报文行号',
  PRIMARY KEY (`SessionId`,`DueCode`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='资产信息基础段历史表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `hpidr_creass_fsinf`
--

DROP TABLE IF EXISTS `hpidr_creass_fsinf`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hpidr_creass_fsinf` (
  `SessionId` varchar(16) NOT NULL COMMENT '期次号',
  `DueCode` varchar(80) NOT NULL COMMENT '借据号',
  `BusiDtlLines` varchar(2) DEFAULT NULL COMMENT '贷款业务种类细分',
  `AccPrinc` decimal(17,2) DEFAULT NULL COMMENT '贷款本金',
  `GuarMode` varchar(2) DEFAULT NULL COMMENT '担保方式',
  `AnnualRate` decimal(4,2) DEFAULT NULL COMMENT '年利率',
  `OpenDate` varchar(10) DEFAULT NULL COMMENT '贷款发放日',
  `DueDate` varchar(10) DEFAULT NULL COMMENT '贷款到期日',
  `LatRpyDate` varchar(10) DEFAULT NULL COMMENT '最近一次还款日期',
  `AcctBal` decimal(17,2) DEFAULT NULL COMMENT '贷款剩余本金',
  `AcctStatus` varchar(2) DEFAULT NULL COMMENT '贷款状态',
  `IsGreen` varchar(2) DEFAULT NULL COMMENT '是否符合绿色信贷',
  `FiveCate` varchar(2) DEFAULT NULL COMMENT '五级分类',
  `RecordFlag` varchar(1) DEFAULT NULL COMMENT '记录标志',
  `OccurDate` varchar(10) DEFAULT NULL COMMENT '数据日期',
  `ManagerOrgID` varchar(32) DEFAULT NULL COMMENT '管户机构编号',
  `ManagerUserID` varchar(32) DEFAULT NULL COMMENT '管户用户编号',
  `OperOrgID` varchar(32) DEFAULT NULL COMMENT '操作机构编号',
  `OperUserID` varchar(32) DEFAULT NULL COMMENT '操作用户编号',
  `OperTime` varchar(19) DEFAULT NULL COMMENT '操作时间',
  `Extend1` varchar(30) DEFAULT NULL COMMENT '扩展字段1',
  `Extend2` varchar(30) DEFAULT NULL COMMENT '扩展字段2',
  `Extend3` varchar(30) DEFAULT NULL COMMENT '扩展字段3',
  PRIMARY KEY (`SessionId`,`DueCode`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='资产信息基本段历史表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `hpidr_creass_idchange`
--

DROP TABLE IF EXISTS `hpidr_creass_idchange`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hpidr_creass_idchange` (
  `SessionID` varchar(16) NOT NULL COMMENT '上报期次',
  `InfRecType` varchar(3) DEFAULT NULL COMMENT '信息记录类型',
  `OldDueCode` varchar(80) NOT NULL COMMENT '旧借据号',
  `OldContractCode` varchar(80) NOT NULL COMMENT '旧贷款合同编号',
  `NewDueCode` varchar(80) DEFAULT NULL COMMENT '新借据号',
  `NewContractCode` varchar(80) DEFAULT NULL COMMENT '新贷款合同编号',
  `MngmtOrgCode` varchar(14) DEFAULT NULL COMMENT '业务管理机构代码',
  `ManagerOrgID` varchar(32) DEFAULT NULL COMMENT '管户机构编号',
  `InputOrgID` varchar(32) DEFAULT NULL COMMENT '录入机构',
  `InputUserID` varchar(32) DEFAULT NULL COMMENT '录入用户',
  `InputTime` varchar(19) DEFAULT NULL COMMENT '录入时间',
  `OccurDate` varchar(10) DEFAULT NULL COMMENT '数据日期',
  `Extend1` varchar(30) DEFAULT NULL COMMENT '扩展字段1',
  `Extend2` varchar(30) DEFAULT NULL COMMENT '扩展字段2',
  `Extend3` varchar(30) DEFAULT NULL COMMENT '扩展字段3',
  `RowNo` int(11) DEFAULT NULL COMMENT '报文行号',
  PRIMARY KEY (`SessionID`,`OldDueCode`,`OldContractCode`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='企业信贷资产标识变更信息表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `hpidr_rate_alldlt`
--

DROP TABLE IF EXISTS `hpidr_rate_alldlt`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hpidr_rate_alldlt` (
  `SessionID` varchar(16) NOT NULL COMMENT '上报期次',
  `InfRecType` varchar(3) DEFAULT NULL COMMENT '信息记录类型',
  `EntCertType` varchar(2) NOT NULL COMMENT '企业身份标识类型',
  `EntCertNum` varchar(20) NOT NULL COMMENT '企业身份标识号码',
  `RptDate` varchar(10) DEFAULT NULL COMMENT '信息报告日期',
  `FinStaYear` varchar(4) DEFAULT NULL COMMENT '报表年份',
  `MngmtOrgCode` varchar(14) DEFAULT NULL COMMENT '业务管理机构代码',
  `FbCode` varchar(300) DEFAULT NULL COMMENT '反馈错误码[数据级]',
  `ManagerOrgID` varchar(32) DEFAULT NULL COMMENT '管户机构编号',
  `InputOrgID` varchar(32) DEFAULT NULL COMMENT '录入机构',
  `InputUserID` varchar(32) DEFAULT NULL COMMENT '录入用户',
  `InputTime` varchar(19) DEFAULT NULL COMMENT '录入时间',
  `OccurDate` varchar(10) DEFAULT NULL COMMENT '数据日期',
  `Extend1` varchar(30) DEFAULT NULL COMMENT '扩展字段1',
  `Extend2` varchar(30) DEFAULT NULL COMMENT '扩展字段2',
  `Extend3` varchar(30) DEFAULT NULL COMMENT '扩展字段3',
  `RowNo` int(11) DEFAULT NULL COMMENT '报文行号',
  PRIMARY KEY (`SessionID`,`EntCertType`,`EntCertNum`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='企业评级信息整笔删除请求记录表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `hpidr_rate_balancessheet`
--

DROP TABLE IF EXISTS `hpidr_rate_balancessheet`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hpidr_rate_balancessheet` (
  `SessionId` varchar(16) NOT NULL COMMENT '期次号',
  `CustomerID` varchar(60) NOT NULL COMMENT '客户编号',
  `Stage` varchar(1) NOT NULL COMMENT '期次',
  `FinStaYear` varchar(4) NOT NULL COMMENT '报表年份',
  `SheetType` varchar(2) NOT NULL COMMENT '报表类型',
  `SheetTypeDivide` varchar(1) NOT NULL COMMENT '报表类型细分',
  `CurrencyFunds` decimal(17,2) DEFAULT NULL COMMENT '货币资金',
  `FinancialAssetsHeldForTrading` decimal(17,2) DEFAULT NULL COMMENT '交易性金融资产',
  `DerivativeFinancialAssets` decimal(17,2) DEFAULT NULL COMMENT '衍生金融资产',
  `NotesReceivable` decimal(17,2) DEFAULT NULL COMMENT '应收票据',
  `AccountsReceivable` decimal(17,2) DEFAULT NULL COMMENT '应收账款',
  `AccountsReceivableFinancing` decimal(17,2) DEFAULT NULL COMMENT '应收款项融资',
  `Prepayments` decimal(17,2) DEFAULT NULL COMMENT '预付款项',
  `OtherReceivables` decimal(17,2) DEFAULT NULL COMMENT '其他应收款',
  `Inventories` decimal(17,2) DEFAULT NULL COMMENT '存货',
  `ContractAssets` decimal(17,2) DEFAULT NULL COMMENT '合同资产',
  `AssetsAvailableForSale` decimal(17,2) DEFAULT NULL COMMENT '持有待售资产',
  `CurPortionOfNonCurrentAssets` decimal(17,2) DEFAULT NULL COMMENT '一年内到期的非流动资产;CurrentPortionOfNonCurrentAssets',
  `OtherCurrentAssets` decimal(17,2) DEFAULT NULL COMMENT '其他流动资产',
  `TotalCurrentAssets` decimal(17,2) DEFAULT NULL COMMENT '流动资产合计',
  `DebtInvestment` decimal(17,2) DEFAULT NULL COMMENT '债权投资',
  `OtherDebtInvestment` decimal(17,2) DEFAULT NULL COMMENT '其他债权投资',
  `LongTermReceivables` decimal(17,2) DEFAULT NULL COMMENT '长期应收款',
  `LongTermEquityInvestment` decimal(17,2) DEFAULT NULL COMMENT '长期股权投资',
  `OthEquityInstrumentsInvestment` decimal(17,2) DEFAULT NULL COMMENT '其他权益工具投资;OtherEquityInstrumentsInvestment',
  `OtherNonCurrentFinancialAssets` decimal(17,2) DEFAULT NULL COMMENT '其他非流动金融资产',
  `InvestmentProperties` decimal(17,2) DEFAULT NULL COMMENT '投资性房地产',
  `FixedAssets` decimal(17,2) DEFAULT NULL COMMENT '固定资产',
  `ConstructionInProgress` decimal(17,2) DEFAULT NULL COMMENT '在建工程',
  `NonCurrentBiologicalAssets` decimal(17,2) DEFAULT NULL COMMENT '生产性生物资产',
  `OilAndGasAssets` decimal(17,2) DEFAULT NULL COMMENT '油气资产',
  `UseRightAssets` decimal(17,2) DEFAULT NULL COMMENT '使用权资产',
  `IntangibleAssets` decimal(17,2) DEFAULT NULL COMMENT '无形资产',
  `DevelopmentDisbursements` decimal(17,2) DEFAULT NULL COMMENT '开发支出',
  `Goodwill` decimal(17,2) DEFAULT NULL COMMENT '商誉',
  `LongTermDeferredExpenses` decimal(17,2) DEFAULT NULL COMMENT '长期待摊费用',
  `DeferredTaxAssets` decimal(17,2) DEFAULT NULL COMMENT '递延所得税资产',
  `OtherNonCurrentAssets` decimal(17,2) DEFAULT NULL COMMENT '其他非流动资产',
  `TotalNonCurrentAssets` decimal(17,2) DEFAULT NULL COMMENT '非流动资产合计',
  `TotalAssets` decimal(17,2) DEFAULT NULL COMMENT '资产总计',
  `ShortTermBorrowings` decimal(17,2) DEFAULT NULL COMMENT '短期借款',
  `FinLiabilitiesHeldForTrading` decimal(17,2) DEFAULT NULL COMMENT '交易性金融负债;FinancialLiabilitiesHeldForTrading',
  `DerivativeFinancialLiabilities` decimal(17,2) DEFAULT NULL COMMENT '衍生金融负债',
  `NotesPayable` decimal(17,2) DEFAULT NULL COMMENT '应付票据',
  `AccountsPayable` decimal(17,2) DEFAULT NULL COMMENT '应付账款',
  `ReceiptsInAdvance` decimal(17,2) DEFAULT NULL COMMENT '预收款项',
  `ContractualLiabilities` decimal(17,2) DEFAULT NULL COMMENT '合同负债',
  `EmployeeBenefitsPayable` decimal(17,2) DEFAULT NULL COMMENT '应付职工薪酬',
  `TaxesPayable` decimal(17,2) DEFAULT NULL COMMENT '应交税费',
  `OtherPayables` decimal(17,2) DEFAULT NULL COMMENT '其他应付款',
  `LiabilitiesHeldForSale` decimal(17,2) DEFAULT NULL COMMENT '持有待售负债',
  `CurPorOfLongTermLiabilities` decimal(17,2) DEFAULT NULL COMMENT '一年内到期的非流动负债CurrentPortionOfLongTermLiabilities',
  `OtherCurrentLiabilities` decimal(17,2) DEFAULT NULL COMMENT '其他流动负债',
  `TotalCurrentLiabilities` decimal(17,2) DEFAULT NULL COMMENT '流动负债合计',
  `LongTermBorrowings` decimal(17,2) DEFAULT NULL COMMENT '长期借款',
  `BondsPayables` decimal(17,2) DEFAULT NULL COMMENT '应付债券',
  `PreferredStockInBondsPayables` decimal(17,2) DEFAULT NULL COMMENT '其中:优先股',
  `PerpetualBondsInBondsPayables` decimal(17,2) DEFAULT NULL COMMENT '永续债',
  `LeaseLiabilities` decimal(17,2) DEFAULT NULL COMMENT '租赁负债',
  `LongTermPayables` decimal(17,2) DEFAULT NULL COMMENT '长期应付款',
  `Provisions` decimal(17,2) DEFAULT NULL COMMENT '预计负债',
  `DeferredIncome` decimal(17,2) DEFAULT NULL COMMENT '递延收益',
  `DeferredTaxLiabilities` decimal(17,2) DEFAULT NULL COMMENT '递延所得税负债',
  `OtherNonCurrentLiabilities` decimal(17,2) DEFAULT NULL COMMENT '其他非流动负债',
  `TotalNonCurrentLiabilities` decimal(17,2) DEFAULT NULL COMMENT '非流动负债合计',
  `TotalLiabilities` decimal(17,2) DEFAULT NULL COMMENT '负债合计',
  `PaidInCapitalOrShareCapital` decimal(17,2) DEFAULT NULL COMMENT '实收资本(或股本)',
  `OtherEquityInstruments` decimal(17,2) DEFAULT NULL COMMENT '其他权益工具投资',
  `PreStockInOthEquityInstruments` decimal(17,2) DEFAULT NULL COMMENT '其中:优先股;PreferredStockInOtherEquityInstruments',
  `PerBondsInOthEquityInstruments` decimal(17,2) DEFAULT NULL COMMENT '永续债;PerpetualBondsInOtherEquityInstruments',
  `CapitalrRserve` decimal(17,2) DEFAULT NULL COMMENT '资本公积',
  `LessTreasuryStocks` decimal(17,2) DEFAULT NULL COMMENT '减:库存股',
  `OtherComprehensiveIncome` decimal(17,2) DEFAULT NULL COMMENT '其他综合收益',
  `SpecialReserve` decimal(17,2) DEFAULT NULL COMMENT '专项储备',
  `SurplusReserve` decimal(17,2) DEFAULT NULL COMMENT '盈余公积',
  `UnappropriatedProfit` decimal(17,2) DEFAULT NULL COMMENT '未分配利润',
  `TotalEquity` decimal(17,2) DEFAULT NULL COMMENT '所有者权益(或股东权益)合计',
  `TotalEquityAndLiabilities` decimal(17,2) DEFAULT NULL COMMENT '负债和所有者权益(或股东权益)总计',
  `ManagerOrgID` varchar(32) DEFAULT NULL COMMENT '管户机构编号',
  `ManagerUserID` varchar(32) DEFAULT NULL COMMENT '管户用户编号',
  `OperOrgID` varchar(32) DEFAULT NULL COMMENT '操作机构编号',
  `OperUserID` varchar(32) DEFAULT NULL COMMENT '操作用户编号',
  `RecordFlag` varchar(1) DEFAULT NULL COMMENT '记录标志',
  `OccurDate` varchar(10) DEFAULT NULL COMMENT '数据日期',
  `Extend1` varchar(30) DEFAULT NULL COMMENT '扩展字段1',
  `Extend2` varchar(30) DEFAULT NULL COMMENT '扩展字段2',
  `Extend3` varchar(30) DEFAULT NULL COMMENT '扩展字段3',
  PRIMARY KEY (`SessionId`,`CustomerID`,`Stage`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='企业资产负债表段历史表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `hpidr_rate_bs`
--

DROP TABLE IF EXISTS `hpidr_rate_bs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hpidr_rate_bs` (
  `SessionId` varchar(16) NOT NULL COMMENT '期次号',
  `CustomerId` varchar(60) NOT NULL COMMENT '客户编号',
  `InfRecType` varchar(3) DEFAULT NULL COMMENT '信息记录类型',
  `EntName` varchar(160) DEFAULT NULL COMMENT '企业名称',
  `EntCertType` varchar(2) DEFAULT NULL COMMENT '企业身份标识类型;20-统一社会信用代码',
  `EntCertNum` varchar(18) DEFAULT NULL COMMENT '企业身份标识号码',
  `FinStaYear` varchar(4) DEFAULT NULL COMMENT '报表年份',
  `SheetType` varchar(2) DEFAULT NULL COMMENT '报表类型',
  `SheetTypeDivide` varchar(1) DEFAULT NULL COMMENT '报表类型细分',
  `MngmtOrgCode` varchar(14) DEFAULT NULL COMMENT '业务管理金融机构代码',
  `RptDate` varchar(10) DEFAULT NULL COMMENT '信息报告日期',
  `RecordFlag` varchar(1) DEFAULT NULL COMMENT '记录标志',
  `OccurDate` varchar(10) DEFAULT NULL COMMENT '数据日期',
  `ManagerOrgID` varchar(32) DEFAULT NULL COMMENT '管户机构编号',
  `ManagerUserID` varchar(32) DEFAULT NULL COMMENT '管户用户编号',
  `OperOrgID` varchar(32) DEFAULT NULL COMMENT '操作机构编号',
  `OperUserID` varchar(32) DEFAULT NULL COMMENT '操作用户编号',
  `OperTime` varchar(19) DEFAULT NULL COMMENT '操作时间',
  `Extend1` varchar(30) DEFAULT NULL COMMENT '扩展字段1',
  `Extend2` varchar(30) DEFAULT NULL COMMENT '扩展字段2',
  `Extend3` varchar(30) DEFAULT NULL COMMENT '扩展字段3',
  `RowNo` int(11) DEFAULT NULL COMMENT '报文行号',
  PRIMARY KEY (`SessionId`,`CustomerId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='评级基础段历史表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `hpidr_rate_cashflow`
--

DROP TABLE IF EXISTS `hpidr_rate_cashflow`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hpidr_rate_cashflow` (
  `SessionId` varchar(16) NOT NULL COMMENT '期次号',
  `CustomerId` varchar(60) NOT NULL COMMENT '客户编号',
  `Stage` varchar(1) NOT NULL COMMENT '期次',
  `FinStaYear` varchar(4) NOT NULL COMMENT '报表年份',
  `SheetType` varchar(2) NOT NULL COMMENT '报表类型',
  `SheetTypeDivide` varchar(1) NOT NULL COMMENT '报表类型细分',
  `CashReceivedFromSalesOGOROS` decimal(17,2) DEFAULT NULL COMMENT '销售商品、提供劳务收到的现金;CashReceivedFromSalesOfGoodsOrRendingOfServices',
  `TaxRefunds` decimal(17,2) DEFAULT NULL COMMENT '收到的税费返还',
  `OtherCashReceivedRTOA` decimal(17,2) DEFAULT NULL COMMENT '收到其他与经营活动有关的现金;OtherCashReceivedRelatingToOperatingActivities',
  `TotalCashInflowsFromOA` decimal(17,2) DEFAULT NULL COMMENT '经营活动现金流入小计;TotalCashInflowsFromOperatingActivities',
  `CashPaidForGoodsAndServices` decimal(17,2) DEFAULT NULL COMMENT '购买商品、接受劳务支付的现金',
  `CashPaidToAndOnBOE` decimal(17,2) DEFAULT NULL COMMENT '支付给职工以及为职工支付的现金;CashPaidToAndOnBehalfOfEmployees',
  `PaymentsOfAllTypesOfTaxes` decimal(17,2) DEFAULT NULL COMMENT '支付的各项税费',
  `OtherCashPaymentsFromOA` decimal(17,2) DEFAULT NULL COMMENT '支付其他与经营活动有关的现金;OtherCashPaymentsFromOperatingActivities',
  `TotalCashOutflowsFromOA` decimal(17,2) DEFAULT NULL COMMENT '经营活动现金流出小计;TotalCashOutflowsFromOperatingActivities',
  `NetCashFlowsFromOA` decimal(17,2) DEFAULT NULL COMMENT '经营活动产生的现金流量净额;NetCashFlowsFromOperatingActivities',
  `CashReceivedFromROI` decimal(17,2) DEFAULT NULL COMMENT '收回投资收到的现金;CashReceivedFromReturnOfInvestment',
  `CashReceivedFromOnvestments` decimal(17,2) DEFAULT NULL COMMENT '取得投资收益收到的现金',
  `NetCashAndOtherLongTermAssets` decimal(17,2) DEFAULT NULL COMMENT '处置固定资产、无形资产和其他长期资产收回的现金净额;NetCashReceivedFromDisposalOfFixedAssetsIntangibleAssetsAndOtherLongTermAssets',
  `NetCashReceivedFromDSAOB` decimal(17,2) DEFAULT NULL COMMENT '处置子公司及其他营业单位收到的现金净额;NetCashReceivedFromDisposalSubsidiariesAndOtherBusiness',
  `CashReceivedRelatingToOIA` decimal(17,2) DEFAULT NULL COMMENT '收到其他与投资活动有关的现金;CashReceivedRelatingToOtherInvestingActivities',
  `TotalCashInflowsFromIA` decimal(17,2) DEFAULT NULL COMMENT '投资活动现金流入小计;TotalCashInflowsFromInvestingActivities',
  `CashPaidToAcquire` decimal(17,2) DEFAULT NULL COMMENT '购建固定资产、无形资产和其他长期资产支付的现金;CashPaidToAcquireFixedAssetsIntangibleAssetsAndOtherLongTermAssents',
  `CashPaymentsForInvestments` decimal(17,2) DEFAULT NULL COMMENT '投资支付的现金',
  `NetCashPaidToASAOB` decimal(17,2) DEFAULT NULL COMMENT '取得子公司及其他营业单位支付的现金净额;NetCashPaidToAcquireSubsidiariesAndOtherBusiness',
  `CashPaymentsRelatedToTA` decimal(17,2) DEFAULT NULL COMMENT '支付其他与投资活动有关的现金;CashPaymentsRelatedToOtherInvestingActivities',
  `SubTotalOfCashOutflows` decimal(17,2) DEFAULT NULL COMMENT '投资活动现金流出小计',
  `NetCashFlowsFromIA` decimal(17,2) DEFAULT NULL COMMENT '投资活动产生的现金流量净额;NetCashFlowsFromInvestingActivities',
  `CashReceivedFromInvestors` decimal(17,2) DEFAULT NULL COMMENT '吸收投资收到的现金',
  `CashFromBorrowings` decimal(17,2) DEFAULT NULL COMMENT '取得借款收到的现金',
  `OtherCashReceivedRelatingTFA` decimal(17,2) DEFAULT NULL COMMENT '收到其他与筹资活动有关的现金;OtherCashReceivedRelatingToFinancingActivities',
  `TotalCashInflowsFromFA` decimal(17,2) DEFAULT NULL COMMENT '筹资活动现金流入小计TotalCashInflowsFromFinancingActivities',
  `CashRepaymentsForDebts` decimal(17,2) DEFAULT NULL COMMENT '偿还债务支付的现金',
  `CashPaymentsForDist` decimal(17,2) DEFAULT NULL COMMENT '分配股利、利润或偿付利息支付的现金',
  `CashPaymentsRelatedToOFA` decimal(17,2) DEFAULT NULL COMMENT '支付其他与筹资活动有关的现金;CashPaymentsRelatedToOtherFinancingActivities',
  `TotalCashOutflowsFromFA` decimal(17,2) DEFAULT NULL COMMENT '筹资活动现金流出小计;TotalCashOutflowsFromFinancingActivities',
  `NetCashFlowsFromFA` decimal(17,2) DEFAULT NULL COMMENT '筹资活动产生的现金流量净额;NetCashFlowsFromFinancingActivities',
  `EffectOfExchangRateCOC` decimal(17,2) DEFAULT NULL COMMENT '四、汇率变动对现金及现金等价物的影响;EffectOfExchangRateChangesOnCash',
  `NetIncreaseInCashAndCE` decimal(17,2) DEFAULT NULL COMMENT '五、现金及现金等价物净增加额;NetIncreaseInCashAndCashEquivalents',
  `InitialCashAndCashEB` decimal(17,2) DEFAULT NULL COMMENT '加:期初现金及现金等价物余额;InitialCashAndCashEquivalentsBalance',
  `TheFinalCashAndCashEB` decimal(17,2) DEFAULT NULL COMMENT '六、期末现金及现金等价物余额;TheFinalCashAndCashEquivalentsBalance',
  `RecordFlag` varchar(1) DEFAULT NULL COMMENT '记录标志',
  `OccurDate` varchar(10) DEFAULT NULL COMMENT '数据日期',
  `ManagerOrgID` varchar(32) DEFAULT NULL COMMENT '管户机构编号',
  `ManagerUserID` varchar(32) DEFAULT NULL COMMENT '管户用户编号',
  `OperOrgID` varchar(32) DEFAULT NULL COMMENT '操作机构编号',
  `OperUserID` varchar(32) DEFAULT NULL COMMENT '操作用户编号',
  `OperTime` varchar(19) DEFAULT NULL COMMENT '操作时间',
  `Extend1` varchar(30) DEFAULT NULL COMMENT '扩展字段1',
  `Extend2` varchar(30) DEFAULT NULL COMMENT '扩展字段2',
  `Extend3` varchar(30) DEFAULT NULL COMMENT '扩展字段3',
  PRIMARY KEY (`SessionId`,`CustomerId`,`Stage`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='评级现金流量表段历史表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `hpidr_rate_fsinf`
--

DROP TABLE IF EXISTS `hpidr_rate_fsinf`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hpidr_rate_fsinf` (
  `SessionId` varchar(16) NOT NULL COMMENT '期次号',
  `CustomerId` varchar(60) NOT NULL COMMENT '客户编号',
  `RegAdd` varchar(200) DEFAULT NULL COMMENT '登记注册地址',
  `AdmDivOfReg` varchar(6) DEFAULT NULL COMMENT '登记地行政区划代码',
  `EstablishDate` varchar(10) DEFAULT NULL COMMENT '成立日期',
  `BizRange` varchar(800) DEFAULT NULL COMMENT '业务范围',
  `MainBusSou` varchar(200) DEFAULT NULL COMMENT '主营业务收入来源',
  `EcoIndusCate` varchar(4) DEFAULT NULL COMMENT '行业分类代码',
  `EcoType` varchar(3) DEFAULT NULL COMMENT '经济类型代码',
  `InterRatingRes` varchar(3) DEFAULT NULL COMMENT '金融机构内部评级结果',
  `InterRatinDes` varchar(2000) DEFAULT NULL COMMENT '金融机构内评体系描述',
  `MainBusChan` varchar(1) DEFAULT NULL COMMENT '主营业务变更情况',
  `CreAssSup` varchar(1) DEFAULT NULL COMMENT '信贷资产支持',
  `PerChaSit` varchar(1) DEFAULT NULL COMMENT '近一年主要人员是否发生变动',
  `DefaTaxAmount` int(11) DEFAULT NULL COMMENT '近三年的欠税条数',
  `HousEquities` varchar(1) DEFAULT NULL COMMENT '经营地产权情况',
  `NumOfEmployees` int(11) DEFAULT NULL COMMENT '从业人员数量',
  `DirecortNum` int(11) DEFAULT NULL COMMENT '董事会成员(执行董事)数量',
  `SupervisorNum` int(11) DEFAULT NULL COMMENT '监事会成员(监事)数量',
  `IsInCounty` varchar(1) DEFAULT NULL COMMENT '是否县域企业',
  `HasIncFromAgri` varchar(1) DEFAULT NULL COMMENT '是否涉农企业',
  `RecordFlag` varchar(1) DEFAULT NULL COMMENT '记录标志',
  `OccurDate` varchar(10) DEFAULT NULL COMMENT '数据日期',
  `ManagerOrgID` varchar(32) DEFAULT NULL COMMENT '管户机构编号',
  `ManagerUserID` varchar(32) DEFAULT NULL COMMENT '管户用户编号',
  `OperOrgID` varchar(32) DEFAULT NULL COMMENT '操作机构编号',
  `OperUserID` varchar(32) DEFAULT NULL COMMENT '操作用户编号',
  `OperTime` varchar(19) DEFAULT NULL COMMENT '操作时间',
  `Extend1` varchar(30) DEFAULT NULL COMMENT '扩展字段1',
  `Extend2` varchar(30) DEFAULT NULL COMMENT '扩展字段2',
  `Extend3` varchar(30) DEFAULT NULL COMMENT '扩展字段3',
  PRIMARY KEY (`SessionId`,`CustomerId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='评级基本概况段历史表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `hpidr_rate_idchange`
--

DROP TABLE IF EXISTS `hpidr_rate_idchange`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hpidr_rate_idchange` (
  `SessionID` varchar(16) NOT NULL COMMENT '上报期次',
  `InfRecType` varchar(3) DEFAULT NULL COMMENT '信息记录类型',
  `OldEntCertType` varchar(2) NOT NULL COMMENT '原企业身份标识类型',
  `OldEntCertNum` varchar(20) NOT NULL COMMENT '原企业身份标识号码',
  `FinStaYear` varchar(4) DEFAULT NULL COMMENT '报表年份',
  `MngmtOrgCode` varchar(14) DEFAULT NULL COMMENT '业务管理金融机构代码',
  `NewEntCertType` varchar(2) DEFAULT NULL COMMENT '新企业身份标识类型',
  `NewEntCertNum` varchar(20) DEFAULT NULL COMMENT '新企业身份标识号码',
  `ManagerOrgID` varchar(32) DEFAULT NULL COMMENT '管户机构编号',
  `InputOrgID` varchar(32) DEFAULT NULL COMMENT '录入机构',
  `InputUserID` varchar(32) DEFAULT NULL COMMENT '录入用户',
  `InputTime` varchar(20) DEFAULT NULL COMMENT '录入时间',
  `OccurDate` varchar(10) DEFAULT NULL COMMENT '数据日期',
  `Extend1` varchar(30) DEFAULT NULL COMMENT '扩展字段1',
  `Extend2` varchar(30) DEFAULT NULL COMMENT '扩展字段2',
  `Extend3` varchar(30) DEFAULT NULL COMMENT '扩展字段3',
  `RowNo` int(11) DEFAULT NULL COMMENT '报文行号',
  PRIMARY KEY (`SessionID`,`OldEntCertType`,`OldEntCertNum`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='企业评级标识变更信息表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `hpidr_rate_income`
--

DROP TABLE IF EXISTS `hpidr_rate_income`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hpidr_rate_income` (
  `SessionId` varchar(16) NOT NULL COMMENT '期次号',
  `CustomerID` varchar(60) NOT NULL COMMENT '客户编号',
  `Stage` varchar(1) NOT NULL COMMENT '期次',
  `FinStaYear` varchar(4) NOT NULL COMMENT '报表年份',
  `SheetType` varchar(2) NOT NULL COMMENT '报表类型',
  `SheetTypeDivide` varchar(1) NOT NULL COMMENT '报表类型细分',
  `RevenueOfSales` decimal(17,2) DEFAULT NULL COMMENT '一、营业收入',
  `CostOfSales` decimal(17,2) DEFAULT NULL COMMENT '减:营业成本',
  `BusinessAndOtherTaxes` decimal(17,2) DEFAULT NULL COMMENT '税金及附加',
  `SellingExpenses` decimal(17,2) DEFAULT NULL COMMENT '销售费用',
  `GenAndAdministrativeExpenses` decimal(17,2) DEFAULT NULL COMMENT '管理费用;GeneralAndAdministrativeExpenses',
  `RDExpenses` decimal(17,2) DEFAULT NULL COMMENT '研发费用',
  `FinancialExpense` decimal(17,2) DEFAULT NULL COMMENT '财务费用',
  `InterestFeeOfFinancialExpense` decimal(17,2) DEFAULT NULL COMMENT '其中:利息费用',
  `IntIncomeOfFinancialExpense` decimal(17,2) DEFAULT NULL COMMENT '利息收入;InterestIncomeOfFinancialExpense',
  `OtherIncome` decimal(17,2) DEFAULT NULL COMMENT '加:其他收益',
  `InvestmentIncome` decimal(17,2) DEFAULT NULL COMMENT '投资收益(损失以“-”号填列)',
  `AssociatesAndJointVenturesInc` decimal(17,2) DEFAULT NULL COMMENT '其中:对联营企业和合营企业的投资收益;AssociatesAndJointVenturesIncom',
  `FinancialAssetsEndIncome` decimal(17,2) DEFAULT NULL COMMENT '以摊余成本计量的金融资产终止确认收益(损失以“-”号填列)',
  `NetExposureHedgingIncome` decimal(17,2) DEFAULT NULL COMMENT '净敞口套期收益(损失以“-”号填列)',
  `IncomeFromChangesInFairValue` decimal(17,2) DEFAULT NULL COMMENT '公允价值变动收益(损失以“-”号填列)',
  `CreditImpairmentLoss` decimal(17,2) DEFAULT NULL COMMENT '信用减值损失(损失以“-”号填列)',
  `ImpairmentLossOfAssets` decimal(17,2) DEFAULT NULL COMMENT '资产减值损失(损失以“-”号填列)',
  `IncomeFromAssetDisposal` decimal(17,2) DEFAULT NULL COMMENT '资产处置收益(损失以“-”号填列)',
  `OperatingProfits` decimal(17,2) DEFAULT NULL COMMENT '二、营业利润(亏损以“-”号填列)',
  `NonOperatingIncome` decimal(17,2) DEFAULT NULL COMMENT '加:营业外收入',
  `NonOperatingExpenses` decimal(17,2) DEFAULT NULL COMMENT '减:营业外支出	',
  `ProfitBeforeTax` decimal(17,2) DEFAULT NULL COMMENT '三、利润总额(亏损总额以“-”号填列)',
  `IncomeTaxExpense` decimal(17,2) DEFAULT NULL COMMENT '减:所得税费用',
  `NetProfit` decimal(17,2) DEFAULT NULL COMMENT '四、净利润(净亏损以“-”号填列)',
  `OthComprehensiveIncomeAfterTax` decimal(17,2) DEFAULT NULL COMMENT '五、其他综合收益的税后净额;OtherComprehensiveIncomeAfterTax',
  `TotalComprehensiveIncome` decimal(17,2) DEFAULT NULL COMMENT '六、综合收益总额',
  `EarningsPerShare` decimal(17,2) DEFAULT NULL COMMENT '七、每股收益:',
  `BasicEarningsPerShare` decimal(17,2) DEFAULT NULL COMMENT '(一)基本每股收益',
  `DilutedEarningsPerShare` decimal(17,2) DEFAULT NULL COMMENT '(二)稀释每股收益',
  `ManagerOrgID` varchar(32) DEFAULT NULL COMMENT '管户机构编号',
  `ManagerUserID` varchar(32) DEFAULT NULL COMMENT '管户用户编号',
  `OperOrgID` varchar(32) DEFAULT NULL COMMENT '操作机构编号',
  `OperUserID` varchar(32) DEFAULT NULL COMMENT '操作用户编号',
  `OccurDate` varchar(10) DEFAULT NULL COMMENT '数据日期',
  `RecordFlag` varchar(1) DEFAULT NULL COMMENT '记录标志',
  `Extend1` varchar(30) DEFAULT NULL COMMENT '扩展字段1',
  `Extend2` varchar(30) DEFAULT NULL COMMENT '扩展字段2',
  `Extend3` varchar(30) DEFAULT NULL COMMENT '扩展字段3',
  PRIMARY KEY (`SessionId`,`CustomerID`,`Stage`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='企业利润信息表段历史表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `hpidr_rate_invabroinf`
--

DROP TABLE IF EXISTS `hpidr_rate_invabroinf`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hpidr_rate_invabroinf` (
  `SessionId` varchar(16) NOT NULL COMMENT '期次号',
  `RelaId` varchar(60) NOT NULL COMMENT '关联编号',
  `CustomerId` varchar(60) DEFAULT NULL COMMENT '客户编号',
  `InvEntName` varchar(160) DEFAULT NULL COMMENT '被投资企业名称',
  `InvEntIDType` varchar(2) DEFAULT NULL COMMENT '被投资企业身份标识类型',
  `InvEntIDNum` varchar(18) DEFAULT NULL COMMENT '被投资企业身份标识号码',
  `InvEntRegCap` decimal(17,2) DEFAULT NULL COMMENT '被投资企业注册资本',
  `InvEntEstablishDate` varchar(10) DEFAULT NULL COMMENT '被投资企业成立日期',
  `InvCurrency` varchar(3) DEFAULT NULL COMMENT '投资币种',
  `InvSubAmount` decimal(17,2) DEFAULT NULL COMMENT '投资认缴金额',
  `InvPaidAmount` decimal(17,2) DEFAULT NULL COMMENT '投资实缴金额',
  `ShareHoldRatio` decimal(5,2) DEFAULT NULL COMMENT '持股比例',
  `InvDate` varchar(10) DEFAULT NULL COMMENT '投资日期',
  `EffStatus` varchar(1) DEFAULT NULL COMMENT '有效标志',
  `RecordFlag` varchar(1) DEFAULT NULL COMMENT '记录标志',
  `OccurDate` varchar(10) DEFAULT NULL COMMENT '数据日期',
  `ManagerOrgID` varchar(32) DEFAULT NULL COMMENT '管户机构编号',
  `ManagerUserID` varchar(32) DEFAULT NULL COMMENT '管户用户编号',
  `OperOrgID` varchar(32) DEFAULT NULL COMMENT '操作机构编号',
  `OperUserID` varchar(32) DEFAULT NULL COMMENT '操作用户编号',
  `OperTime` varchar(19) DEFAULT NULL COMMENT '操作时间',
  `Extend1` varchar(30) DEFAULT NULL COMMENT '扩展字段1',
  `Extend2` varchar(30) DEFAULT NULL COMMENT '扩展字段2',
  `Extend3` varchar(30) DEFAULT NULL COMMENT '扩展字段3',
  PRIMARY KEY (`SessionId`,`RelaId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='评级对外投资段历史表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `hpidr_rate_legrepinf`
--

DROP TABLE IF EXISTS `hpidr_rate_legrepinf`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hpidr_rate_legrepinf` (
  `SessionId` varchar(16) NOT NULL COMMENT '期次号',
  `CustomerId` varchar(60) NOT NULL COMMENT '客户编号',
  `LegRepName` varchar(60) DEFAULT NULL COMMENT '主要负责人名称',
  `LegRepIDType` varchar(2) DEFAULT NULL COMMENT '主要负责人身份标识类型',
  `LegRepIDNum` varchar(40) DEFAULT NULL COMMENT '主要负责人证件号码',
  `LegRepHouseAddStat` varchar(1) DEFAULT NULL COMMENT '主要负责人户籍情况',
  `LegRepEduLevel` varchar(2) DEFAULT NULL COMMENT '主要负责人学历',
  `LegRepWorkingYears` int(11) DEFAULT NULL COMMENT '主要负责人在本单位从业年限',
  `RecordFlag` varchar(1) DEFAULT NULL COMMENT '记录标志',
  `OccurDate` varchar(10) DEFAULT NULL COMMENT '数据日期',
  `ManagerOrgID` varchar(32) DEFAULT NULL COMMENT '管户机构编号',
  `ManagerUserID` varchar(32) DEFAULT NULL COMMENT '管户用户编号',
  `OperOrgID` varchar(32) DEFAULT NULL COMMENT '操作机构编号',
  `OperUserID` varchar(32) DEFAULT NULL COMMENT '操作用户编号',
  `OperTime` varchar(19) DEFAULT NULL COMMENT '操作时间',
  `Extend1` varchar(30) DEFAULT NULL COMMENT '扩展字段1',
  `Extend2` varchar(30) DEFAULT NULL COMMENT '扩展字段2',
  `Extend3` varchar(30) DEFAULT NULL COMMENT '扩展字段3',
  PRIMARY KEY (`SessionId`,`CustomerId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='评级主要负责人段历史表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `hpidr_rate_mdfcinfo`
--

DROP TABLE IF EXISTS `hpidr_rate_mdfcinfo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hpidr_rate_mdfcinfo` (
  `SessionID` varchar(16) NOT NULL COMMENT '上报期次',
  `InfRecType` varchar(3) DEFAULT NULL COMMENT '信息记录类型',
  `CustomerId` varchar(60) NOT NULL COMMENT '待更正客户编号',
  `EntCertType` varchar(2) DEFAULT NULL COMMENT '企业身份标识类型',
  `EntCertNum` varchar(20) DEFAULT NULL COMMENT '企业身份标识号码',
  `RptDate` varchar(10) DEFAULT NULL COMMENT '信息报告日期',
  `FinStaYear` varchar(4) DEFAULT NULL COMMENT '报表年份',
  `MdfcSgmtCode` varchar(1) NOT NULL COMMENT '待更正段段标',
  `MngmtOrgCode` varchar(14) DEFAULT NULL COMMENT '业务管理机构代码',
  `FbCode` varchar(300) DEFAULT NULL COMMENT '反馈错误码[数据级]',
  `ManagerOrgID` varchar(32) DEFAULT NULL COMMENT '管户机构编号',
  `InputOrgID` varchar(32) DEFAULT NULL COMMENT '录入机构',
  `InputUserID` varchar(32) DEFAULT NULL COMMENT '录入用户',
  `InputTime` varchar(19) DEFAULT NULL COMMENT '录入时间',
  `OccurDate` varchar(10) DEFAULT NULL COMMENT '数据日期',
  `Extend1` varchar(30) DEFAULT NULL COMMENT '扩展字段1',
  `Extend2` varchar(30) DEFAULT NULL COMMENT '扩展字段2',
  `Extend3` varchar(30) DEFAULT NULL COMMENT '扩展字段3',
  `RowNo` int(11) DEFAULT NULL COMMENT '报文行号',
  PRIMARY KEY (`SessionID`,`CustomerId`,`MdfcSgmtCode`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='企业评级信息按段更正请求记录表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `hpidr_rate_mnshahodinf`
--

DROP TABLE IF EXISTS `hpidr_rate_mnshahodinf`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hpidr_rate_mnshahodinf` (
  `SessionId` varchar(16) NOT NULL COMMENT '期次号',
  `RelaId` varchar(60) NOT NULL COMMENT '关联编号',
  `CustomerId` varchar(60) NOT NULL COMMENT '客户编号',
  `SharHodType` varchar(2) DEFAULT NULL COMMENT '出资人类型',
  `SharHodCertType` varchar(1) DEFAULT NULL COMMENT '出资人身份类别',
  `SharHodName` varchar(160) DEFAULT NULL COMMENT '出资人名称',
  `SharHodIDType` varchar(2) DEFAULT NULL COMMENT '出资人身份标识类型',
  `SharHodIDNum` varchar(80) DEFAULT NULL COMMENT '出资人身份号码',
  `InvRatio` decimal(5,2) DEFAULT NULL COMMENT '出资比例',
  `EffStatus` varchar(1) DEFAULT NULL COMMENT '有效标志',
  `RecordFlag` varchar(1) DEFAULT NULL COMMENT '记录标志',
  `OccurDate` varchar(10) DEFAULT NULL COMMENT '数据日期',
  `ManagerOrgID` varchar(32) DEFAULT NULL COMMENT '管户机构编号',
  `ManagerUserID` varchar(32) DEFAULT NULL COMMENT '管户用户编号',
  `OperOrgID` varchar(32) DEFAULT NULL COMMENT '操作机构编号',
  `OperUserID` varchar(32) DEFAULT NULL COMMENT '操作用户编号',
  `OperTime` varchar(19) DEFAULT NULL COMMENT '操作时间',
  `Extend1` varchar(30) DEFAULT NULL COMMENT '扩展字段1',
  `Extend2` varchar(30) DEFAULT NULL COMMENT '扩展字段2',
  `Extend3` varchar(30) DEFAULT NULL COMMENT '扩展字段3',
  PRIMARY KEY (`SessionId`,`RelaId`,`CustomerId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='评级注册资本及主要出资人段历史表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `hpidr_rate_neginf`
--

DROP TABLE IF EXISTS `hpidr_rate_neginf`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hpidr_rate_neginf` (
  `SessionId` varchar(16) NOT NULL COMMENT '期次号',
  `RelaId` varchar(60) NOT NULL COMMENT '关联编号',
  `CustomerId` varchar(60) NOT NULL COMMENT '客户编号',
  `NegInfType` varchar(2) DEFAULT NULL COMMENT '负面信息类型',
  `NegInfContent` varchar(800) DEFAULT NULL COMMENT '信息内容',
  `InvolvedAmount` decimal(17,2) DEFAULT NULL COMMENT '涉案金额',
  `NegInfDate` varchar(10) DEFAULT NULL COMMENT '信息发生(公示)时间',
  `NegInfValidity` varchar(10) DEFAULT NULL COMMENT '有效期',
  `NegInfIssOrg` varchar(80) DEFAULT NULL COMMENT '信息发布机构',
  `EffStatus` varchar(1) DEFAULT NULL COMMENT '有效标志',
  `RecordFlag` varchar(1) DEFAULT NULL COMMENT '记录标志',
  `OccurDate` varchar(10) DEFAULT NULL COMMENT '数据日期',
  `ManagerOrgID` varchar(32) DEFAULT NULL COMMENT '管户机构编号',
  `ManagerUserID` varchar(32) DEFAULT NULL COMMENT '管户用户编号',
  `OperOrgID` varchar(32) DEFAULT NULL COMMENT '操作机构编号',
  `OperUserID` varchar(32) DEFAULT NULL COMMENT '操作用户编号',
  `OperTime` varchar(19) DEFAULT NULL COMMENT '操作时间',
  `Extend1` varchar(30) DEFAULT NULL COMMENT '扩展字段1',
  `Extend2` varchar(30) DEFAULT NULL COMMENT '扩展字段2',
  `Extend3` varchar(30) DEFAULT NULL COMMENT '扩展字段3',
  PRIMARY KEY (`SessionId`,`RelaId`,`CustomerId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='评级负面信息段历史表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `hpidr_rate_regcap`
--

DROP TABLE IF EXISTS `hpidr_rate_regcap`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hpidr_rate_regcap` (
  `SessionId` varchar(16) NOT NULL COMMENT '期次号',
  `CustomerId` varchar(60) NOT NULL COMMENT '客户编号',
  `RegCapCurrency` varchar(3) DEFAULT NULL COMMENT '注册资本币种',
  `RegCap` decimal(17,2) DEFAULT NULL COMMENT '注册资本',
  `RecordFlag` varchar(1) DEFAULT NULL COMMENT '记录标志',
  `OccurDate` varchar(10) DEFAULT NULL COMMENT '数据日期',
  `ManagerOrgID` varchar(32) DEFAULT NULL COMMENT '管户机构编号',
  `ManagerUserID` varchar(32) DEFAULT NULL COMMENT '管户用户编号',
  `OperOrgID` varchar(32) DEFAULT NULL COMMENT '操作机构编号',
  `OperUserID` varchar(32) DEFAULT NULL COMMENT '操作用户编号',
  `OperTime` varchar(19) DEFAULT NULL COMMENT '操作时间',
  `Extend1` varchar(30) DEFAULT NULL COMMENT '扩展字段1',
  `Extend2` varchar(30) DEFAULT NULL COMMENT '扩展字段2',
  `Extend3` varchar(30) DEFAULT NULL COMMENT '扩展字段3',
  PRIMARY KEY (`SessionId`,`CustomerId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='评级信息注册资本历史表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `log_auditinfo`
--

DROP TABLE IF EXISTS `log_auditinfo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `log_auditinfo` (
  `LOGID` varchar(20) NOT NULL COMMENT '日志编号',
  `AUDITTYPE` varchar(18) DEFAULT NULL COMMENT '审计类型',
  `USERID` varchar(32) DEFAULT NULL COMMENT '用户号',
  `USERNAME` varchar(80) DEFAULT NULL COMMENT '用户名',
  `CHANGEUSERID` varchar(32) DEFAULT NULL COMMENT '修改人用户号',
  `CHANGEUSERNAME` varchar(80) DEFAULT NULL COMMENT '修改人用户名',
  `BEGINTIME` varchar(20) DEFAULT NULL COMMENT '开始时间',
  `REMARK` varchar(200) DEFAULT NULL COMMENT '备注',
  `REMARK2` varchar(200) DEFAULT NULL COMMENT '备注2',
  `RUNSQL` varchar(255) DEFAULT NULL COMMENT '执行SQL脚本',
  PRIMARY KEY (`LOGID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='安全审计日志';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `log_runtime_history`
--

DROP TABLE IF EXISTS `log_runtime_history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `log_runtime_history` (
  `SERIALNO` varchar(32) NOT NULL COMMENT '流水号',
  `SESSIONID` varchar(100) NOT NULL COMMENT 'session编号',
  `BEGINTIME` varchar(20) NOT NULL COMMENT '开始时间',
  `USERID` varchar(32) NOT NULL COMMENT '用户号',
  `USERNAME` varchar(80) DEFAULT NULL COMMENT '用户名',
  `JSPNAME` varchar(200) NOT NULL COMMENT 'JSP名称',
  `ENDTIME` varchar(20) DEFAULT NULL COMMENT '结束时间',
  `TIMECONSUMING` decimal(10,6) DEFAULT NULL COMMENT '耗时',
  PRIMARY KEY (`SERIALNO`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `log_runtime_role`
--

DROP TABLE IF EXISTS `log_runtime_role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `log_runtime_role` (
  `SERIALNO` varchar(32) NOT NULL COMMENT '流水号',
  `SESSIONID` varchar(100) NOT NULL COMMENT 'session编号',
  `BEGINTIME` varchar(20) NOT NULL COMMENT '开始时间',
  `USERID` varchar(32) NOT NULL COMMENT '用户号',
  `USERNAME` varchar(80) DEFAULT NULL COMMENT '用户名',
  `JSPNAME` varchar(200) NOT NULL COMMENT 'JSP名称',
  `ENDTIME` varchar(20) DEFAULT NULL COMMENT '结束时间',
  `TIMECONSUMING` decimal(10,6) DEFAULT NULL COMMENT '耗时',
  PRIMARY KEY (`SERIALNO`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `object_attribute`
--

DROP TABLE IF EXISTS `object_attribute`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `object_attribute` (
  `OBJECTTYPE` varchar(32) NOT NULL COMMENT '对象类型号',
  `ATTRIBUTEID` varchar(32) NOT NULL COMMENT '属性ID',
  `SORTNO` varchar(18) DEFAULT NULL COMMENT '排序号',
  `ISINUSE` varchar(18) DEFAULT NULL COMMENT '是否可用',
  `ATTRIBUTENAME` varchar(80) DEFAULT NULL COMMENT '属性名称',
  `ATTRIBUTEDESCRIBE` varchar(80) DEFAULT NULL COMMENT '属性描述',
  `INPUTORG` varchar(32) DEFAULT NULL COMMENT '登记机构',
  `INPUTUSER` varchar(32) DEFAULT NULL COMMENT '登记人员',
  `INPUTTIME` varchar(20) DEFAULT NULL COMMENT '登记时间',
  `UPDATEUSER` varchar(32) DEFAULT NULL COMMENT '更新人员',
  `UPDATETIME` varchar(20) DEFAULT NULL COMMENT '更新时间',
  `REMARK` varchar(250) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`ATTRIBUTEID`,`OBJECTTYPE`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='对象属性信息表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `object_maxsn`
--

DROP TABLE IF EXISTS `object_maxsn`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `object_maxsn` (
  `TABLENAME` varchar(80) NOT NULL COMMENT '表名',
  `COLUMNNAME` varchar(80) NOT NULL COMMENT '列名',
  `MAXSERIALNO` varchar(80) NOT NULL COMMENT '最大数',
  `DATEFMT` varchar(20) NOT NULL COMMENT '日期模式',
  `NOFMT` varchar(20) NOT NULL COMMENT '流水号模式',
  PRIMARY KEY (`TABLENAME`,`COLUMNNAME`,`DATEFMT`,`NOFMT`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='系统流水号表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `objecttype_catalog`
--

DROP TABLE IF EXISTS `objecttype_catalog`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `objecttype_catalog` (
  `OBJECTTYPE` varchar(32) NOT NULL COMMENT '对象类型号',
  `OBJECTNAME` varchar(80) DEFAULT NULL COMMENT '对象类型名称',
  `SORTNO` varchar(32) DEFAULT NULL COMMENT '排序号',
  `TREECODE` varchar(80) DEFAULT NULL COMMENT '对象树图',
  `PAGEPATH` varchar(80) DEFAULT NULL COMMENT 'Web访问路径',
  `OBJECTATTRIBUTE` varchar(250) DEFAULT NULL COMMENT '属性集',
  `OBJECTTABLE` varchar(80) DEFAULT NULL COMMENT '主数据表',
  `KEYCOL` varchar(250) DEFAULT NULL COMMENT '关键字段',
  `KEYCOLNAME` varchar(80) DEFAULT NULL COMMENT '关键字段名称',
  `VIEWTYPE` varchar(32) DEFAULT NULL COMMENT '视图组',
  `DEFAULTVIEW` varchar(18) DEFAULT NULL COMMENT '默认视图',
  `RIGHTTYPE` varchar(250) DEFAULT NULL COMMENT '权限方法',
  `USAGEDESCRIBE` varchar(250) DEFAULT NULL COMMENT '描述',
  `ATTRIBUTE1` varchar(80) DEFAULT NULL COMMENT '属性1',
  `ATTRIBUTE2` varchar(80) DEFAULT NULL COMMENT '属性2',
  `ATTRIBUTE3` varchar(80) DEFAULT NULL COMMENT '属性3',
  `INPUTORG` varchar(32) DEFAULT NULL COMMENT '登记机构',
  `INPUTUSER` varchar(32) DEFAULT NULL COMMENT '登记人员',
  `INPUTTIME` varchar(32) DEFAULT NULL COMMENT '登记时间',
  `UPDATEUSER` varchar(32) DEFAULT NULL COMMENT '更新人员',
  `UPDATETIME` varchar(20) DEFAULT NULL COMMENT '更新时间',
  `REMARK` varchar(250) DEFAULT NULL COMMENT '备注',
  `RELATIVETABLE` varchar(80) DEFAULT NULL COMMENT '关联数据表',
  `OBJECTCOLATTRIBUTE` varchar(18) DEFAULT NULL COMMENT '对象列属性',
  `CATALOGSQL` varchar(250) DEFAULT NULL COMMENT 'sql语句',
  `CATALOGWHERE1` varchar(250) DEFAULT NULL COMMENT 'where条件1',
  `CATALOGWHERE2` varchar(250) DEFAULT NULL COMMENT 'where条件2',
  `CATALOGWHERE3` varchar(250) DEFAULT NULL COMMENT 'where条件3',
  PRIMARY KEY (`OBJECTTYPE`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='对象类型信息表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `objecttype_rela`
--

DROP TABLE IF EXISTS `objecttype_rela`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `objecttype_rela` (
  `OBJECTTYPE` varchar(32) NOT NULL COMMENT '对象类型号',
  `RELATIONSHIP` varchar(80) NOT NULL COMMENT '关联关系',
  `RELAOBJECTTYPE` varchar(32) DEFAULT NULL COMMENT '关联对象类型',
  `SORTNO` varchar(32) DEFAULT NULL COMMENT '排序号',
  `DISPLAYNAME` varchar(250) DEFAULT NULL COMMENT '显示名称',
  `SHOWONTABEXPR` varchar(250) DEFAULT NULL COMMENT '模板表述',
  `RELAEXPR` varchar(250) DEFAULT NULL COMMENT '关系表述',
  `VIEWEXPR` varchar(250) DEFAULT NULL COMMENT '视图表述',
  `ISINUSE` varchar(1) DEFAULT NULL COMMENT '是否可用',
  `ATTRIBUTE1` varchar(200) DEFAULT NULL COMMENT '属性1',
  `ATTRIBUTE2` varchar(200) DEFAULT NULL COMMENT '属性2',
  `ATTRIBUTE3` varchar(200) DEFAULT NULL COMMENT '属性3',
  `INPUTUSER` varchar(32) DEFAULT NULL COMMENT '登记人员',
  `INPUTORG` varchar(32) DEFAULT NULL COMMENT '登记机构',
  `INPUTTIME` varchar(20) DEFAULT NULL COMMENT '登记时间',
  `UPDATEUSER` varchar(32) DEFAULT NULL COMMENT '更新人员',
  `UPDATETIME` varchar(20) DEFAULT NULL COMMENT '更新时间',
  `REMARK` varchar(250) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`RELATIONSHIP`,`OBJECTTYPE`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='对象关联信息表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `org_info`
--

DROP TABLE IF EXISTS `org_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `org_info` (
  `ORGID` varchar(32) NOT NULL COMMENT '机构编号',
  `SORTNO` varchar(32) DEFAULT NULL COMMENT '排序号',
  `ORGNAME` varchar(80) DEFAULT NULL COMMENT '机构名称',
  `ORGLEVEL` varchar(32) DEFAULT NULL COMMENT '级别',
  `ORGPROPERTY` varchar(250) DEFAULT NULL COMMENT '属性',
  `RELATIVEORGID` varchar(32) DEFAULT NULL COMMENT '上级机构代码',
  `BANKID` varchar(32) DEFAULT NULL COMMENT '人行金融机构号',
  `BANKLICENSE` varchar(32) DEFAULT NULL COMMENT '金融机构许可证',
  `BUSINESSLICENSE` varchar(32) DEFAULT NULL COMMENT '营业执照',
  `BELONGAREA` varchar(18) DEFAULT NULL COMMENT '机构辖区',
  `ORGCLASS` varchar(18) DEFAULT NULL COMMENT '机构类别',
  `ZIPCODE` varchar(18) DEFAULT NULL COMMENT '邮政编码',
  `MAINFRAMEORGID` varchar(32) DEFAULT NULL COMMENT '网点号',
  `MAINFRAMEEXGID` varchar(32) DEFAULT NULL COMMENT '主机交换号',
  `ORGCODE` varchar(32) DEFAULT NULL COMMENT '机构缩写',
  `ORGSTATUS` varchar(80) DEFAULT NULL COMMENT '当前状态',
  `ORGOLDNAME` varchar(80) DEFAULT NULL COMMENT '机构曾用名',
  `SETUPDATE` varchar(10) DEFAULT NULL COMMENT '成立时间',
  `ORGADD` varchar(80) DEFAULT NULL COMMENT '机构地址',
  `PRINCIPAL` varchar(10) DEFAULT NULL COMMENT '负责人',
  `ORGTEL` varchar(80) DEFAULT NULL COMMENT '联系电话',
  `BRANCHNUM` int(11) DEFAULT NULL COMMENT '管辖网点数',
  `CMNUM` int(11) DEFAULT NULL COMMENT '客户经理数',
  `BUSINESSHOURS` varchar(80) DEFAULT NULL COMMENT '营业时间',
  `INPUTORG` varchar(32) DEFAULT NULL COMMENT '登记机构',
  `INPUTUSER` varchar(32) DEFAULT NULL COMMENT '登记人员',
  `INPUTDATE` varchar(20) DEFAULT NULL COMMENT '登记日期',
  `INPUTTIME` varchar(20) DEFAULT NULL COMMENT '登记时间',
  `UPDATEUSER` varchar(32) DEFAULT NULL COMMENT '更新人员',
  `UPDATETIME` varchar(20) DEFAULT NULL COMMENT '更新时间',
  `UPDATEDATE` varchar(20) DEFAULT NULL COMMENT '更新日期',
  `REMARK` varchar(250) DEFAULT NULL COMMENT '备注',
  `BELONGORGID` varchar(32) DEFAULT NULL COMMENT '权属机构',
  `HOSTNO` varchar(10) DEFAULT NULL COMMENT '主机号',
  `VITUALSERIALNO` int(11) DEFAULT NULL COMMENT '虚拟编号',
  `VITUALID` varchar(32) DEFAULT NULL COMMENT '虚拟ID',
  `CORPORGID` varchar(20) DEFAULT NULL COMMENT '法人机构编号',
  PRIMARY KEY (`ORGID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='机构信息';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `pidr_amount_record`
--

DROP TABLE IF EXISTS `pidr_amount_record`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pidr_amount_record` (
  `BSCODE` varchar(60) NOT NULL COMMENT '标识号',
  `SGMTNAME` varchar(40) NOT NULL COMMENT '段标签名',
  `AMOUNT` decimal(17,0) DEFAULT NULL COMMENT '数量',
  `RECORDFLAG` varchar(2) DEFAULT NULL COMMENT '记录标志',
  PRIMARY KEY (`BSCODE`,`SGMTNAME`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='特殊处理表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `pidr_code_catalog`
--

DROP TABLE IF EXISTS `pidr_code_catalog`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pidr_code_catalog` (
  `CODENO` varchar(32) NOT NULL COMMENT '代码编号',
  `SORTNO` varchar(32) DEFAULT NULL COMMENT '排序号',
  `CODETYPEONE` varchar(80) DEFAULT NULL COMMENT '大类',
  `CODETYPETWO` varchar(80) DEFAULT NULL COMMENT '小类',
  `CODENAME` varchar(80) DEFAULT NULL COMMENT '代码名称',
  `CODEDESCRIBE` varchar(250) DEFAULT NULL COMMENT '代码描述',
  `CODEATTRIBUTE` varchar(250) DEFAULT NULL COMMENT '代码属性',
  `INPUTUSER` varchar(32) DEFAULT NULL COMMENT '登记人',
  `INPUTORG` varchar(32) DEFAULT NULL COMMENT '登记机构',
  `INPUTTIME` varchar(20) DEFAULT NULL COMMENT '登记时间',
  `UPDATEUSER` varchar(32) DEFAULT NULL COMMENT '更新人',
  `UPDATETIME` varchar(20) DEFAULT NULL COMMENT '更新时间',
  `REMARK` varchar(250) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`CODENO`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='目录';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `pidr_code_library`
--

DROP TABLE IF EXISTS `pidr_code_library`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pidr_code_library` (
  `COLNAME` varchar(80) DEFAULT NULL COMMENT '标识名称',
  `CODENO` varchar(64) NOT NULL COMMENT '标识符',
  `SUBCODENO` varchar(64) NOT NULL COMMENT '子级标识符',
  `CBCODE` varchar(64) NOT NULL COMMENT '商行代码',
  `PBCODE` varchar(64) NOT NULL COMMENT '人行代码',
  `APPLICATIONCODE` varchar(2) DEFAULT NULL COMMENT '应用类别',
  `CBITEMNAME` varchar(500) DEFAULT NULL COMMENT '商行代码项中文名',
  `PBITEMNAME` varchar(500) DEFAULT NULL COMMENT '人行代码项中文名',
  `SORTNO` varchar(64) DEFAULT NULL COMMENT '排序号',
  `ISINUSE` varchar(36) DEFAULT NULL COMMENT '启用状态',
  `ITEMDESCRIBE` varchar(1600) DEFAULT NULL COMMENT '代码项描述',
  `ITEMATTRIBUTE` varchar(1600) DEFAULT NULL COMMENT '代码属性',
  `RELATIVECODE` varchar(3200) DEFAULT NULL COMMENT '关联代码',
  `INPUTUSER` varchar(64) DEFAULT NULL COMMENT '录入用户',
  `INPUTORG` varchar(64) DEFAULT NULL COMMENT '录入机构',
  `INPUTTIME` varchar(40) DEFAULT NULL COMMENT '录入时间',
  `UPDATEUSER` varchar(64) DEFAULT NULL COMMENT '更新用户',
  `UPDATETIME` varchar(40) DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`CODENO`,`SUBCODENO`,`PBCODE`,`CBCODE`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='代码映射表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `pidr_creass_bs`
--

DROP TABLE IF EXISTS `pidr_creass_bs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pidr_creass_bs` (
  `SessionId` varchar(16) DEFAULT NULL COMMENT '期次号',
  `DueCode` varchar(80) NOT NULL COMMENT '借据号',
  `InfRecType` varchar(3) DEFAULT NULL COMMENT '信息记录类型',
  `ContractCode` varchar(80) DEFAULT NULL COMMENT '贷款合同编号',
  `CustomerId` varchar(60) DEFAULT NULL COMMENT '客户编号',
  `EntName` varchar(160) DEFAULT NULL COMMENT '企业名称',
  `EntCertType` varchar(2) DEFAULT NULL COMMENT '企业身份标识类型;20-统一社会信用代码',
  `EntCertNum` varchar(18) DEFAULT NULL COMMENT '企业身份标识号码',
  `MngmtOrgCode` varchar(14) DEFAULT NULL COMMENT '业务管理金融机构代码',
  `RptDate` varchar(10) DEFAULT NULL COMMENT '信息报告日期',
  `RecordFlag` varchar(1) DEFAULT NULL COMMENT '记录标志',
  `OccurDate` varchar(10) DEFAULT NULL COMMENT '数据日期',
  `ManagerOrgID` varchar(32) DEFAULT NULL COMMENT '管户机构编号',
  `ManagerUserID` varchar(32) DEFAULT NULL COMMENT '管户用户编号',
  `OperOrgID` varchar(32) DEFAULT NULL COMMENT '操作机构编号',
  `OperUserID` varchar(32) DEFAULT NULL COMMENT '操作用户编号',
  `OperTime` varchar(19) DEFAULT NULL COMMENT '操作时间',
  `Extend1` varchar(30) DEFAULT NULL COMMENT '扩展字段1',
  `Extend2` varchar(30) DEFAULT NULL COMMENT '扩展字段2',
  `Extend3` varchar(30) DEFAULT NULL COMMENT '扩展字段3',
  PRIMARY KEY (`DueCode`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='资产信息基础段当期表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `pidr_creass_fsinf`
--

DROP TABLE IF EXISTS `pidr_creass_fsinf`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pidr_creass_fsinf` (
  `SessionId` varchar(16) DEFAULT NULL COMMENT '期次号',
  `DueCode` varchar(80) NOT NULL COMMENT '借据号',
  `BusiDtlLines` varchar(2) DEFAULT NULL COMMENT '贷款业务种类细分',
  `AccPrinc` decimal(17,2) DEFAULT NULL COMMENT '贷款本金',
  `GuarMode` varchar(2) DEFAULT NULL COMMENT '担保方式',
  `AnnualRate` decimal(4,2) DEFAULT NULL COMMENT '年利率',
  `OpenDate` varchar(10) DEFAULT NULL COMMENT '贷款发放日',
  `DueDate` varchar(10) DEFAULT NULL COMMENT '贷款到期日',
  `LatRpyDate` varchar(10) DEFAULT NULL COMMENT '最近一次还款日期',
  `AcctBal` decimal(17,2) DEFAULT NULL COMMENT '贷款剩余本金',
  `AcctStatus` varchar(2) DEFAULT NULL COMMENT '贷款状态',
  `IsGreen` varchar(2) DEFAULT NULL COMMENT '是否符合绿色信贷',
  `FiveCate` varchar(2) DEFAULT NULL COMMENT '五级分类',
  `RecordFlag` varchar(1) DEFAULT NULL COMMENT '记录标志',
  `OccurDate` varchar(10) DEFAULT NULL COMMENT '数据日期',
  `ManagerOrgID` varchar(32) DEFAULT NULL COMMENT '管户机构编号',
  `ManagerUserID` varchar(32) DEFAULT NULL COMMENT '管户用户编号',
  `OperOrgID` varchar(32) DEFAULT NULL COMMENT '操作机构编号',
  `OperUserID` varchar(32) DEFAULT NULL COMMENT '操作用户编号',
  `OperTime` varchar(19) DEFAULT NULL COMMENT '操作时间',
  `Extend1` varchar(30) DEFAULT NULL COMMENT '扩展字段1',
  `Extend2` varchar(30) DEFAULT NULL COMMENT '扩展字段2',
  `Extend3` varchar(30) DEFAULT NULL COMMENT '扩展字段3',
  PRIMARY KEY (`DueCode`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='资产信息基本段当期表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `pidr_ecoinduscate_library`
--

DROP TABLE IF EXISTS `pidr_ecoinduscate_library`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pidr_ecoinduscate_library` (
  `MODELNO` varchar(32) NOT NULL COMMENT '模型编号',
  `ecoinduscate` varchar(60) NOT NULL COMMENT '行业分类代码',
  `weightedValue01` varchar(10) DEFAULT NULL COMMENT '净资产与年末贷款比率-权重',
  `excellentValue01` varchar(10) DEFAULT NULL COMMENT '净资产与年末贷款比率-优秀值',
  `lowerValue01` varchar(10) DEFAULT NULL COMMENT '净资产与年末贷款比率-较低值',
  `weightedValue02` varchar(10) DEFAULT NULL COMMENT '资产负债率-权重',
  `excellentValue02` varchar(10) DEFAULT NULL COMMENT '资产负债率-优秀值',
  `lowerValue02` varchar(10) DEFAULT NULL COMMENT '资产负债率-较低值',
  `weightedValue03` varchar(10) DEFAULT NULL COMMENT '资本固定化比率-权重',
  `excellentValue03` varchar(10) DEFAULT NULL COMMENT '资本固定化比率-优秀值',
  `lowerValue03` varchar(10) DEFAULT NULL COMMENT '资本固定化比率-较低值',
  `weightedValue04` varchar(10) DEFAULT NULL COMMENT '流动比率-权重',
  `excellentValue04` varchar(10) DEFAULT NULL COMMENT '流动比率-优秀值',
  `lowerValue04` varchar(10) DEFAULT NULL COMMENT '流动比率-较低值',
  `weightedValue05` varchar(10) DEFAULT NULL COMMENT '速动比率-权重',
  `excellentValue05` varchar(10) DEFAULT NULL COMMENT '速动比率-优秀值',
  `lowerValue05` varchar(10) DEFAULT NULL COMMENT '速动比率-较低值',
  `weightedValue06` varchar(10) DEFAULT NULL COMMENT '现金流动负债比率-权重',
  `excellentValue06` varchar(10) DEFAULT NULL COMMENT '现金流动负债比率-优秀值',
  `lowerValue06` varchar(10) DEFAULT NULL COMMENT '现金流动负债比率-较低值',
  `weightedValue07` varchar(10) DEFAULT NULL COMMENT '利息保障倍数-权重',
  `excellentValue07` varchar(10) DEFAULT NULL COMMENT '利息保障倍数-优秀值',
  `lowerValue07` varchar(10) DEFAULT NULL COMMENT '利息保障倍数-较低值',
  `weightedValue08` varchar(10) DEFAULT NULL COMMENT '担保比率-权重',
  `excellentValue08` varchar(10) DEFAULT NULL COMMENT '担保比率-优秀值',
  `lowerValue08` varchar(10) DEFAULT NULL COMMENT '担保比率-较低值',
  `weightedValue09` varchar(10) DEFAULT NULL COMMENT '营业收入现金率-权重',
  `excellentValue09` varchar(10) DEFAULT NULL COMMENT '营业收入现金率-优秀值',
  `lowerValue09` varchar(10) DEFAULT NULL COMMENT '营业收入现金率-较低值',
  `weightedValue10` varchar(10) DEFAULT NULL COMMENT '现金比率-权重',
  `excellentValue10` varchar(10) DEFAULT NULL COMMENT '现金比率-优秀值',
  `lowerValue10` varchar(10) DEFAULT NULL COMMENT '现金比率-较低值',
  `weightedValue11` varchar(10) DEFAULT NULL COMMENT '应收账款周转率-权重',
  `excellentValue11` varchar(10) DEFAULT NULL COMMENT '应收账款周转率-优秀值',
  `lowerValue11` varchar(10) DEFAULT NULL COMMENT '应收账款周转率-较低值',
  `weightedValue12` varchar(10) DEFAULT NULL COMMENT '存货周转率-权重',
  `excellentValue12` varchar(10) DEFAULT NULL COMMENT '存货周转率-优秀值',
  `lowerValue12` varchar(10) DEFAULT NULL COMMENT '存货周转率-较低值',
  `weightedValue13` varchar(10) DEFAULT NULL COMMENT '总资产周转率-权重',
  `excellentValue13` varchar(10) DEFAULT NULL COMMENT '总资产周转率-优秀值',
  `lowerValue13` varchar(10) DEFAULT NULL COMMENT '总资产周转率-较低值',
  `weightedValue14` varchar(10) DEFAULT NULL COMMENT '固定资产周转率-权重',
  `excellentValue14` varchar(10) DEFAULT NULL COMMENT '固定资产周转率-优秀值',
  `lowerValue14` varchar(10) DEFAULT NULL COMMENT '固定资产周转率-较低值',
  `weightedValue15` varchar(10) DEFAULT NULL COMMENT '毛利率-权重',
  `excellentValue15` varchar(10) DEFAULT NULL COMMENT '毛利率-优秀值',
  `lowerValue15` varchar(10) DEFAULT NULL COMMENT '毛利率-较低值',
  `weightedValue16` varchar(10) DEFAULT NULL COMMENT '营业利润率-权重',
  `excellentValue16` varchar(10) DEFAULT NULL COMMENT '营业利润率-优秀值',
  `lowerValue16` varchar(10) DEFAULT NULL COMMENT '营业利润率-较低值',
  `weightedValue17` varchar(10) DEFAULT NULL COMMENT '总资产报酬率-权重',
  `excellentValue17` varchar(10) DEFAULT NULL COMMENT '总资产报酬率-优秀值',
  `lowerValue17` varchar(10) DEFAULT NULL COMMENT '总资产报酬率-较低值',
  PRIMARY KEY (`MODELNO`,`ecoinduscate`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='行业标准表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `pidr_error_table`
--

DROP TABLE IF EXISTS `pidr_error_table`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pidr_error_table` (
  `SESSIONID` varchar(200) DEFAULT NULL COMMENT '报文期次',
  `INFRECTYPE` varchar(3) DEFAULT NULL COMMENT '信息记录类型',
  `SERIALNO` varchar(60) DEFAULT NULL COMMENT '流水号',
  `RPTDATE` varchar(10) DEFAULT NULL COMMENT '信息报告日期',
  `OCCURDATE` varchar(10) DEFAULT NULL COMMENT '数据日期',
  `EXTEND1` varchar(30) DEFAULT NULL COMMENT '扩展字段1',
  `EXTEND2` varchar(30) DEFAULT NULL COMMENT '扩展字段2',
  `EXTEND3` varchar(30) DEFAULT NULL COMMENT '扩展字段3'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='生成报文错误提示表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `pidr_evaluate_data`
--

DROP TABLE IF EXISTS `pidr_evaluate_data`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pidr_evaluate_data` (
  `OBJECTTYPE` varchar(18) NOT NULL COMMENT '对象类型',
  `CUSTOMERID` varchar(32) NOT NULL COMMENT '对象客户号编号',
  `ITEMNO` varchar(32) NOT NULL COMMENT '项目编号',
  `ITEMVALUE` varchar(80) DEFAULT NULL COMMENT '机器测算-项目值',
  `EVALUATESCORE` decimal(24,6) DEFAULT NULL COMMENT '评估值',
  `ITEMVALUE2` varchar(80) DEFAULT NULL COMMENT '人工测算-项目值',
  `EVALUATESCORE2` decimal(24,6) DEFAULT NULL COMMENT '机器测算-评分值(未加权重折扣等)',
  PRIMARY KEY (`OBJECTTYPE`,`CUSTOMERID`,`ITEMNO`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='评估数据';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `pidr_evaluate_record`
--

DROP TABLE IF EXISTS `pidr_evaluate_record`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pidr_evaluate_record` (
  `OBJECTTYPE` varchar(18) NOT NULL COMMENT '对象类型',
  `CUSTOMERID` varchar(32) NOT NULL COMMENT '对象客户号',
  `EntName` varchar(160) DEFAULT NULL COMMENT '企业名称',
  `EntCertType` varchar(2) DEFAULT NULL COMMENT '企业身份标识类型;20-统一社会信用代码',
  `EntCertNum` varchar(18) DEFAULT NULL COMMENT '企业身份标识号码',
  `EcoIndusCate` varchar(4) DEFAULT NULL COMMENT '行业分类代码',
  `FinStaYear` varchar(10) NOT NULL COMMENT '报表年份',
  `MODELNO` varchar(32) DEFAULT NULL COMMENT '模型编号',
  `REPORTSCOPE` varchar(8) DEFAULT NULL COMMENT '报表口径',
  `EVALUATEDATE` varchar(20) DEFAULT NULL COMMENT '评估日期',
  `EVALUATESCORE` decimal(24,6) DEFAULT NULL COMMENT '评估得分',
  `EVALUATERESULT` varchar(80) DEFAULT NULL COMMENT '评估结果',
  `ORGID` varchar(32) DEFAULT NULL COMMENT '评估单位',
  `USERID` varchar(32) DEFAULT NULL COMMENT '评估人',
  `COGNDATE` varchar(20) DEFAULT NULL COMMENT '认定日期',
  `COGNSCORE` decimal(24,6) DEFAULT NULL COMMENT '认定得分',
  `COGNRESULT` varchar(80) DEFAULT NULL COMMENT '认定结果',
  `COGNORGID` varchar(32) DEFAULT NULL COMMENT '认定单位',
  `COGNUSERID` varchar(32) DEFAULT NULL COMMENT '认定人',
  `REMARK` varchar(250) DEFAULT NULL COMMENT '备注',
  `COGNREASON` varchar(250) DEFAULT NULL COMMENT '认定理由',
  `COGNRESULT2` varchar(80) DEFAULT NULL COMMENT '分行认定结果',
  `COGNUSERNAME2` varchar(80) DEFAULT NULL COMMENT '分行认定人',
  `COGNREASON2` varchar(250) DEFAULT NULL COMMENT '分行认定理由',
  `COGNRESULT3` varchar(80) DEFAULT NULL COMMENT '总行认定结果',
  `COGNUSERNAME3` varchar(80) DEFAULT NULL COMMENT '总行认定人',
  `COGNREASON3` varchar(250) DEFAULT NULL COMMENT '总行认定理由',
  `COGNUSERID3` varchar(32) DEFAULT NULL COMMENT '总行认定人代码',
  `COGNUSERID2` varchar(32) DEFAULT NULL COMMENT '分行认定人代码',
  `EVALUATELEVEL` varchar(18) DEFAULT NULL COMMENT '认定级别',
  `FINISHDATE2` varchar(20) DEFAULT NULL COMMENT '分行认定时间',
  `FINISHDATE3` varchar(20) DEFAULT NULL COMMENT '总行认定时间',
  `FINISHDATE` varchar(20) DEFAULT NULL COMMENT '认定时间',
  `COGNRESULT4` varchar(80) DEFAULT NULL COMMENT '支行认定结果',
  `COGNUSERNAME4` varchar(80) DEFAULT NULL COMMENT '支行认定人',
  `COGNREASON4` varchar(250) DEFAULT NULL COMMENT '支行认定理由',
  `FINISHDATE4` varchar(20) DEFAULT NULL COMMENT '支行认定时间',
  `COGNUSERID4` varchar(32) DEFAULT NULL COMMENT '支行认定人代码',
  `REPORTSTATUS` varchar(2) DEFAULT NULL COMMENT '报送状态',
  PRIMARY KEY (`OBJECTTYPE`,`CUSTOMERID`,`FinStaYear`),
  KEY `IDX1_EVALUATE_REC` (`OBJECTTYPE`,`CUSTOMERID`,`FinStaYear`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='央行评估记录表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `pidr_feedback`
--

DROP TABLE IF EXISTS `pidr_feedback`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pidr_feedback` (
  `FNO` varchar(128) NOT NULL COMMENT '反馈处理编号',
  `BUSIIDSERIALNO` varchar(200) DEFAULT NULL COMMENT '业务标识号',
  `BSBUSIIDSERIALNO` varchar(200) DEFAULT NULL COMMENT '基础段业务标识号',
  `SESSIONID` varchar(16) DEFAULT NULL COMMENT '报文期次',
  `MESSAGETYPE` varchar(6) DEFAULT NULL COMMENT '报文类型',
  `ERRPOSTION` varchar(12) DEFAULT NULL COMMENT '错误位置',
  `ERRCODE` varchar(20) DEFAULT NULL COMMENT '错误代码',
  `MNGMTORGCODE` varchar(14) DEFAULT NULL COMMENT '业务管理金融机构代码',
  `OCCURDATE` varchar(10) DEFAULT NULL COMMENT '数据日期',
  `MODIFYFLAG` varchar(2) DEFAULT NULL COMMENT '是否修改',
  `ERRMSG` varchar(800) DEFAULT NULL COMMENT '错误消息',
  `FILENAME` varchar(60) DEFAULT NULL COMMENT '反馈文件名',
  `ERRLEVEL` varchar(1) DEFAULT NULL COMMENT '错误级别',
  `DIGEST` varchar(256) DEFAULT NULL COMMENT '信息摘要',
  PRIMARY KEY (`FNO`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='反馈错误表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `pidr_feedbacklogs`
--

DROP TABLE IF EXISTS `pidr_feedbacklogs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pidr_feedbacklogs` (
  `FLOGNO` varchar(128) NOT NULL COMMENT '内部编号',
  `VCHANNEL` varchar(10) DEFAULT NULL COMMENT '反馈来源',
  `SESSIONID` varchar(16) DEFAULT NULL COMMENT '报文期次',
  `FEEDBACKTOTAL` decimal(5,0) DEFAULT NULL COMMENT '反馈错误数量',
  `STARTTIME` varchar(20) DEFAULT NULL COMMENT '反馈解析开始时间',
  `ENDTIME` varchar(20) DEFAULT NULL COMMENT '反馈解析结束时间',
  `OPERATOR` varchar(20) DEFAULT NULL COMMENT '操作用户',
  `OPERORGID` varchar(20) DEFAULT NULL COMMENT '操作机构',
  `OCCURDATE` varchar(10) DEFAULT NULL COMMENT '数据日期',
  PRIMARY KEY (`FLOGNO`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='反馈日志表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `pidr_finance_statement`
--

DROP TABLE IF EXISTS `pidr_finance_statement`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pidr_finance_statement` (
  `SessionId` varchar(16) DEFAULT NULL COMMENT '期次号',
  `CustomerID` varchar(60) NOT NULL COMMENT '客户编号',
  `Stage` varchar(1) NOT NULL COMMENT '期次',
  `FinStaYear` varchar(4) NOT NULL COMMENT '报表年份',
  `SheetType` varchar(2) NOT NULL COMMENT '报表类型',
  `SheetTypeDivide` varchar(1) NOT NULL COMMENT '报表类型细分',
  `InterestPayable` decimal(17,2) DEFAULT NULL COMMENT '资产负债,补充,应付利息',
  `DividendsReceivable` decimal(17,2) DEFAULT NULL COMMENT '资产负债,补充,应收股利',
  `UnclearedGuarBEndOfTheTerm` decimal(17,2) DEFAULT NULL COMMENT '补充报表,未清担保余额',
  `ManagerOrgID` varchar(32) DEFAULT NULL COMMENT '管户机构编号',
  `ManagerUserID` varchar(32) DEFAULT NULL COMMENT '管户用户编号',
  `OperOrgID` varchar(32) DEFAULT NULL COMMENT '操作机构编号',
  `OperUserID` varchar(32) DEFAULT NULL COMMENT '操作用户编号',
  `RecordFlag` varchar(1) DEFAULT NULL COMMENT '记录标志',
  `OccurDate` varchar(10) DEFAULT NULL COMMENT '数据日期',
  `Extend1` varchar(30) DEFAULT NULL COMMENT '扩展字段1',
  `Extend2` varchar(30) DEFAULT NULL COMMENT '扩展字段2',
  `Extend3` varchar(30) DEFAULT NULL COMMENT '扩展字段3',
  PRIMARY KEY (`CustomerID`,`Stage`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='作为评分记录使用的补充报表记录数据';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `pidr_int_balancesheet`
--

DROP TABLE IF EXISTS `pidr_int_balancesheet`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pidr_int_balancesheet` (
  `CustomerID` varchar(60) NOT NULL COMMENT '客户编号',
  `Stage` varchar(1) NOT NULL COMMENT '期次',
  `FinStaYear` varchar(4) NOT NULL COMMENT '报表年份',
  `SheetType` varchar(2) NOT NULL COMMENT '报表类型',
  `SheetTypeDivide` varchar(1) NOT NULL COMMENT '报表类型细分',
  `CurrencyFunds` decimal(17,2) DEFAULT NULL COMMENT '货币资金',
  `FinancialAssetsHeldForTrading` decimal(17,2) DEFAULT NULL COMMENT '交易性金融资产',
  `DerivativeFinancialAssets` decimal(17,2) DEFAULT NULL COMMENT '衍生金融资产',
  `NotesReceivable` decimal(17,2) DEFAULT NULL COMMENT '应收票据',
  `AccountsReceivable` decimal(17,2) DEFAULT NULL COMMENT '应收账款',
  `AccountsReceivableFinancing` decimal(17,2) DEFAULT NULL COMMENT '应收款项融资',
  `Prepayments` decimal(17,2) DEFAULT NULL COMMENT '预付款项',
  `OtherReceivables` decimal(17,2) DEFAULT NULL COMMENT '其他应收款',
  `Inventories` decimal(17,2) DEFAULT NULL COMMENT '存货',
  `ContractAssets` decimal(17,2) DEFAULT NULL COMMENT '合同资产',
  `AssetsAvailableForSale` decimal(17,2) DEFAULT NULL COMMENT '持有待售资产',
  `CurPortionOfNonCurrentAssets` decimal(17,2) DEFAULT NULL COMMENT '一年内到期的非流动资产;CurrentPortionOfNonCurrentAssets',
  `OtherCurrentAssets` decimal(17,2) DEFAULT NULL COMMENT '其他流动资产',
  `TotalCurrentAssets` decimal(17,2) DEFAULT NULL COMMENT '流动资产合计',
  `DebtInvestment` decimal(17,2) DEFAULT NULL COMMENT '债权投资',
  `OtherDebtInvestment` decimal(17,2) DEFAULT NULL COMMENT '其他债权投资',
  `LongTermReceivables` decimal(17,2) DEFAULT NULL COMMENT '长期应收款',
  `LongTermEquityInvestment` decimal(17,2) DEFAULT NULL COMMENT '长期股权投资',
  `OthEquityInstrumentsInvestment` decimal(17,2) DEFAULT NULL COMMENT '其他权益工具投资;OtherEquityInstrumentsInvestment',
  `OtherNonCurrentFinancialAssets` decimal(17,2) DEFAULT NULL COMMENT '其他非流动金融资产',
  `InvestmentProperties` decimal(17,2) DEFAULT NULL COMMENT '投资性房地产',
  `FixedAssets` decimal(17,2) DEFAULT NULL COMMENT '固定资产',
  `ConstructionInProgress` decimal(17,2) DEFAULT NULL COMMENT '在建工程',
  `NonCurrentBiologicalAssets` decimal(17,2) DEFAULT NULL COMMENT '生产性生物资产',
  `OilAndGasAssets` decimal(17,2) DEFAULT NULL COMMENT '油气资产',
  `UseRightAssets` decimal(17,2) DEFAULT NULL COMMENT '使用权资产',
  `IntangibleAssets` decimal(17,2) DEFAULT NULL COMMENT '无形资产',
  `DevelopmentDisbursements` decimal(17,2) DEFAULT NULL COMMENT '开发支出',
  `Goodwill` decimal(17,2) DEFAULT NULL COMMENT '商誉',
  `LongTermDeferredExpenses` decimal(17,2) DEFAULT NULL COMMENT '长期待摊费用',
  `DeferredTaxAssets` decimal(17,2) DEFAULT NULL COMMENT '递延所得税资产',
  `OtherNonCurrentAssets` decimal(17,2) DEFAULT NULL COMMENT '其他非流动资产',
  `TotalNonCurrentAssets` decimal(17,2) DEFAULT NULL COMMENT '非流动资产合计',
  `TotalAssets` decimal(17,2) DEFAULT NULL COMMENT '资产总计',
  `ShortTermBorrowings` decimal(17,2) DEFAULT NULL COMMENT '短期借款',
  `FinLiabilitiesHeldForTrading` decimal(17,2) DEFAULT NULL COMMENT '交易性金融负债;FinancialLiabilitiesHeldForTrading',
  `DerivativeFinancialLiabilities` decimal(17,2) DEFAULT NULL COMMENT '衍生金融负债',
  `NotesPayable` decimal(17,2) DEFAULT NULL COMMENT '应付票据',
  `AccountsPayable` decimal(17,2) DEFAULT NULL COMMENT '应付账款',
  `ReceiptsInAdvance` decimal(17,2) DEFAULT NULL COMMENT '预收款项',
  `ContractualLiabilities` decimal(17,2) DEFAULT NULL COMMENT '合同负债',
  `EmployeeBenefitsPayable` decimal(17,2) DEFAULT NULL COMMENT '应付职工薪酬',
  `TaxesPayable` decimal(17,2) DEFAULT NULL COMMENT '应交税费',
  `OtherPayables` decimal(17,2) DEFAULT NULL COMMENT '其他应付款',
  `LiabilitiesHeldForSale` decimal(17,2) DEFAULT NULL COMMENT '持有待售负债',
  `CurPorOfLongTermLiabilities` decimal(17,2) DEFAULT NULL COMMENT '一年内到期的非流动负债CurrentPortionOfLongTermLiabilities',
  `OtherCurrentLiabilities` decimal(17,2) DEFAULT NULL COMMENT '其他流动负债',
  `TotalCurrentLiabilities` decimal(17,2) DEFAULT NULL COMMENT '流动负债合计',
  `LongTermBorrowings` decimal(17,2) DEFAULT NULL COMMENT '长期借款',
  `BondsPayables` decimal(17,2) DEFAULT NULL COMMENT '应付债券',
  `PreferredStockInBondsPayables` decimal(17,2) DEFAULT NULL COMMENT '其中:优先股',
  `PerpetualBondsInBondsPayables` decimal(17,2) DEFAULT NULL COMMENT '永续债',
  `LeaseLiabilities` decimal(17,2) DEFAULT NULL COMMENT '租赁负债',
  `LongTermPayables` decimal(17,2) DEFAULT NULL COMMENT '长期应付款',
  `Provisions` decimal(17,2) DEFAULT NULL COMMENT '预计负债',
  `DeferredIncome` decimal(17,2) DEFAULT NULL COMMENT '递延收益',
  `DeferredTaxLiabilities` decimal(17,2) DEFAULT NULL COMMENT '递延所得税负债',
  `OtherNonCurrentLiabilities` decimal(17,2) DEFAULT NULL COMMENT '其他非流动负债',
  `TotalNonCurrentLiabilities` decimal(17,2) DEFAULT NULL COMMENT '非流动负债合计',
  `TotalLiabilities` decimal(17,2) DEFAULT NULL COMMENT '负债合计',
  `PaidInCapitalOrShareCapital` decimal(17,2) DEFAULT NULL COMMENT '实收资本(或股本)',
  `OtherEquityInstruments` decimal(17,2) DEFAULT NULL COMMENT '其他权益工具投资',
  `PreStockInOthEquityInstruments` decimal(17,2) DEFAULT NULL COMMENT '其中:优先股;PreferredStockInOtherEquityInstruments',
  `PerBondsInOthEquityInstruments` decimal(17,2) DEFAULT NULL COMMENT '永续债;PerpetualBondsInOtherEquityInstruments',
  `CapitalrRserve` decimal(17,2) DEFAULT NULL COMMENT '资本公积',
  `LessTreasuryStocks` decimal(17,2) DEFAULT NULL COMMENT '减:库存股',
  `OtherComprehensiveIncome` decimal(17,2) DEFAULT NULL COMMENT '其他综合收益',
  `SpecialReserve` decimal(17,2) DEFAULT NULL COMMENT '专项储备',
  `SurplusReserve` decimal(17,2) DEFAULT NULL COMMENT '盈余公积',
  `UnappropriatedProfit` decimal(17,2) DEFAULT NULL COMMENT '未分配利润',
  `TotalEquity` decimal(17,2) DEFAULT NULL COMMENT '所有者权益(或股东权益)合计',
  `TotalEquityAndLiabilities` decimal(17,2) DEFAULT NULL COMMENT '负债和所有者权益(或股东权益)总计',
  `ManagerOrgID` varchar(32) DEFAULT NULL COMMENT '管户机构编号',
  `ManagerUserID` varchar(32) DEFAULT NULL COMMENT '管户用户编号',
  `OperOrgID` varchar(32) DEFAULT NULL COMMENT '操作机构编号',
  `OperUserID` varchar(32) DEFAULT NULL COMMENT '操作用户编号',
  `OccurDate` varchar(10) DEFAULT NULL COMMENT '数据日期',
  `Extend1` varchar(30) DEFAULT NULL COMMENT '扩展字段1',
  `Extend2` varchar(30) DEFAULT NULL COMMENT '扩展字段2',
  `Extend3` varchar(30) DEFAULT NULL COMMENT '扩展字段3',
  `ImportType` varchar(10) DEFAULT NULL COMMENT '区分数据来源,分web和批量',
  PRIMARY KEY (`CustomerID`,`Stage`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='企业资产负债信息接口表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `pidr_int_busiinfo`
--

DROP TABLE IF EXISTS `pidr_int_busiinfo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pidr_int_busiinfo` (
  `DueCode` varchar(80) NOT NULL COMMENT '借据号',
  `CustomerID` varchar(80) DEFAULT NULL COMMENT '客户号',
  `ContractCode` varchar(80) DEFAULT NULL COMMENT '贷款合同编号',
  `EntName` varchar(160) DEFAULT NULL COMMENT '企业名称',
  `EntCertType` varchar(2) DEFAULT NULL COMMENT '企业身份标识类型',
  `EntCertNum` varchar(18) DEFAULT NULL COMMENT '企业身份标识号码',
  `BusiDtlLines` varchar(2) DEFAULT NULL COMMENT '贷款业务种类细分',
  `AccPrinc` decimal(17,2) DEFAULT NULL COMMENT '贷款本金',
  `GuarMode` varchar(2) DEFAULT NULL COMMENT '担保方式',
  `AnnualRate` decimal(4,2) DEFAULT NULL COMMENT '年利率',
  `OpenDate` varchar(10) DEFAULT NULL COMMENT '贷款发放日',
  `DueDate` varchar(10) DEFAULT NULL COMMENT '贷款到期日',
  `LatRpyDate` varchar(10) DEFAULT NULL COMMENT '最近一次还款日期',
  `AcctBal` decimal(17,2) DEFAULT NULL COMMENT '贷款剩余本金',
  `AcctStatus` varchar(2) DEFAULT NULL COMMENT '贷款状态',
  `IsGreen` varchar(2) DEFAULT NULL COMMENT '是否符合绿色信贷',
  `FiveCate` varchar(2) DEFAULT NULL COMMENT '五级分类',
  `ManagerOrgID` varchar(32) DEFAULT NULL COMMENT '管户机构编号',
  `ManagerUserID` varchar(32) DEFAULT NULL COMMENT '管户用户编号',
  `OperOrgID` varchar(32) DEFAULT NULL COMMENT '操作机构编号',
  `OperUserID` varchar(32) DEFAULT NULL COMMENT '操作用户编号',
  `OccurDate` varchar(10) DEFAULT NULL COMMENT '数据日期',
  `Extend1` varchar(30) DEFAULT NULL COMMENT '扩展字段1',
  `Extend2` varchar(30) DEFAULT NULL COMMENT '扩展字段2',
  `Extend3` varchar(30) DEFAULT NULL COMMENT '扩展字段3',
  `ImportType` varchar(10) DEFAULT NULL COMMENT '区分数据来源,分web和批量',
  PRIMARY KEY (`DueCode`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='企业信贷资产信息接口表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `pidr_int_cashflow`
--

DROP TABLE IF EXISTS `pidr_int_cashflow`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pidr_int_cashflow` (
  `CustomerID` varchar(60) NOT NULL COMMENT '客户编号',
  `Stage` varchar(1) NOT NULL COMMENT '期次',
  `FinStaYear` varchar(4) NOT NULL COMMENT '报表年份',
  `SheetType` varchar(2) NOT NULL COMMENT '报表类型',
  `SheetTypeDivide` varchar(1) NOT NULL COMMENT '报表类型细分',
  `CashReceivedFromSalesOGOROS` decimal(17,2) DEFAULT NULL COMMENT '销售商品、提供劳务收到的现金;CashReceivedFromSalesOfGoodsOrRendingOfServices',
  `TaxRefunds` decimal(17,2) DEFAULT NULL COMMENT '收到的税费返还',
  `OtherCashReceivedRTOA` decimal(17,2) DEFAULT NULL COMMENT '收到其他与经营活动有关的现金;OtherCashReceivedRelatingToOperatingActivities',
  `TotalCashInflowsFromOA` decimal(17,2) DEFAULT NULL COMMENT '经营活动现金流入小计;TotalCashInflowsFromOperatingActivities',
  `CashPaidForGoodsAndServices` decimal(17,2) DEFAULT NULL COMMENT '购买商品、接受劳务支付的现金',
  `CashPaidToAndOnBOE` decimal(17,2) DEFAULT NULL COMMENT '支付给职工以及为职工支付的现金;CashPaidToAndOnBehalfOfEmployees',
  `PaymentsOfAllTypesOfTaxes` decimal(17,2) DEFAULT NULL COMMENT '支付的各项税费',
  `OtherCashPaymentsFromOA` decimal(17,2) DEFAULT NULL COMMENT '支付其他与经营活动有关的现金;OtherCashPaymentsFromOperatingActivities',
  `TotalCashOutflowsFromOA` decimal(17,2) DEFAULT NULL COMMENT '经营活动现金流出小计;TotalCashOutflowsFromOperatingActivities',
  `NetCashFlowsFromOA` decimal(17,2) DEFAULT NULL COMMENT '经营活动产生的现金流量净额;NetCashFlowsFromOperatingActivities',
  `CashReceivedFromROI` decimal(17,2) DEFAULT NULL COMMENT '收回投资收到的现金;CashReceivedFromReturnOfInvestment',
  `CashReceivedFromOnvestments` decimal(17,2) DEFAULT NULL COMMENT '取得投资收益收到的现金',
  `NetCashAndOtherLongTermAssets` decimal(17,2) DEFAULT NULL COMMENT '处置固定资产、无形资产和其他长期资产收回的现金净额',
  `NetCashReceivedFromDSAOB` decimal(17,2) DEFAULT NULL COMMENT '处置子公司及其他营业单位收到的现金净额;NetCashReceivedFromDisposalSubsidiariesAndOtherBusiness',
  `CashReceivedRelatingToOIA` decimal(17,2) DEFAULT NULL COMMENT '收到其他与投资活动有关的现金;CashReceivedRelatingToOtherInvestingActivities',
  `TotalCashInflowsFromIA` decimal(17,2) DEFAULT NULL COMMENT '投资活动现金流入小计;TotalCashInflowsFromInvestingActivities',
  `CashPaidToAcquire` decimal(17,2) DEFAULT NULL COMMENT '购建固定资产、无形资产和其他长期资产支付的现金',
  `CashPaymentsForInvestments` decimal(17,2) DEFAULT NULL COMMENT '投资支付的现金',
  `NetCashPaidToASAOB` decimal(17,2) DEFAULT NULL COMMENT '取得子公司及其他营业单位支付的现金净额;NetCashPaidToAcquireSubsidiariesAndOtherBusiness',
  `CashPaymentsRelatedToTA` decimal(17,2) DEFAULT NULL COMMENT '支付其他与投资活动有关的现金;CashPaymentsRelatedToOtherInvestingActivities',
  `SubTotalOfCashOutflows` decimal(17,2) DEFAULT NULL COMMENT '投资活动现金流出小计',
  `NetCashFlowsFromIA` decimal(17,2) DEFAULT NULL COMMENT '投资活动产生的现金流量净额;NetCashFlowsFromInvestingActivities',
  `CashReceivedFromInvestors` decimal(17,2) DEFAULT NULL COMMENT '吸收投资收到的现金',
  `CashFromBorrowings` decimal(17,2) DEFAULT NULL COMMENT '取得借款收到的现金',
  `OtherCashReceivedRelatingTFA` decimal(17,2) DEFAULT NULL COMMENT '收到其他与筹资活动有关的现金;OtherCashReceivedRelatingToFinancingActivities',
  `TotalCashInflowsFromFA` decimal(17,2) DEFAULT NULL COMMENT '筹资活动现金流入小计TotalCashInflowsFromFinancingActivities',
  `CashRepaymentsForDebts` decimal(17,2) DEFAULT NULL COMMENT '偿还债务支付的现金',
  `CashPaymentsForDist` decimal(17,2) DEFAULT NULL COMMENT '分配股利、利润或偿付利息支付的现金',
  `CashPaymentsRelatedToOFA` decimal(17,2) DEFAULT NULL COMMENT '支付其他与筹资活动有关的现金;CashPaymentsRelatedToOtherFinancingActivities',
  `TotalCashOutflowsFromFA` decimal(17,2) DEFAULT NULL COMMENT '筹资活动现金流出小计;TotalCashOutflowsFromFinancingActivities',
  `NetCashFlowsFromFA` decimal(17,2) DEFAULT NULL COMMENT '筹资活动产生的现金流量净额;NetCashFlowsFromFinancingActivities',
  `EffectOfExchangRateCOC` decimal(17,2) DEFAULT NULL COMMENT '四、汇率变动对现金及现金等价物的影响;EffectOfExchangRateChangesOnCash',
  `NetIncreaseInCashAndCE` decimal(17,2) DEFAULT NULL COMMENT '五、现金及现金等价物净增加额;NetIncreaseInCashAndCashEquivalents',
  `InitialCashAndCashEB` decimal(17,2) DEFAULT NULL COMMENT '加:期初现金及现金等价物余额;InitialCashAndCashEquivalentsBalance',
  `TheFinalCashAndCashEB` decimal(17,2) DEFAULT NULL COMMENT '六、期末现金及现金等价物余额;TheFinalCashAndCashEquivalentsBalance',
  `ManagerOrgID` varchar(32) DEFAULT NULL COMMENT '管户机构编号',
  `ManagerUserID` varchar(32) DEFAULT NULL COMMENT '管户用户编号',
  `OperOrgID` varchar(32) DEFAULT NULL COMMENT '操作机构编号',
  `OperUserID` varchar(32) DEFAULT NULL COMMENT '操作用户编号',
  `OccurDate` varchar(10) DEFAULT NULL COMMENT '数据日期',
  `Extend1` varchar(30) DEFAULT NULL COMMENT '扩展字段1',
  `Extend2` varchar(30) DEFAULT NULL COMMENT '扩展字段2',
  `Extend3` varchar(30) DEFAULT NULL COMMENT '扩展字段3',
  `ImportType` varchar(10) DEFAULT NULL COMMENT '区分数据来源,分web和批量',
  PRIMARY KEY (`CustomerID`,`Stage`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='企业现金流量信息接口表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `pidr_int_entinfo`
--

DROP TABLE IF EXISTS `pidr_int_entinfo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pidr_int_entinfo` (
  `CustomerID` varchar(60) NOT NULL COMMENT '客户号',
  `EntName` varchar(160) DEFAULT NULL COMMENT '企业名称',
  `EntCertType` varchar(2) DEFAULT NULL COMMENT '企业身份标识类型',
  `EntCertNum` varchar(18) DEFAULT NULL COMMENT '企业身份标识号码',
  `FinStaYear` varchar(4) DEFAULT NULL COMMENT '报表年份',
  `SheetType` varchar(2) DEFAULT NULL COMMENT '报表类型',
  `SheetTypeDivide` varchar(1) DEFAULT NULL COMMENT '报表类型细分',
  `RegAdd` varchar(200) DEFAULT NULL COMMENT '登记注册地址',
  `AdmDivOfReg` varchar(6) DEFAULT NULL COMMENT '登记地行政区划代码',
  `EstablishDate` varchar(10) DEFAULT NULL COMMENT '成立日期',
  `BizRange` varchar(800) DEFAULT NULL COMMENT '业务范围',
  `MainBusSou` varchar(200) DEFAULT NULL COMMENT '主营业务收入来源',
  `EcoIndusCate` varchar(4) DEFAULT NULL COMMENT '行业分类代码',
  `EcoType` varchar(3) DEFAULT NULL COMMENT '经济类型代码',
  `InterRatingRes` varchar(3) DEFAULT NULL COMMENT '金融机构内部评级结果',
  `InterRatinDes` varchar(2000) DEFAULT NULL COMMENT '金融机构内评体系描述',
  `MainBusChan` varchar(1) DEFAULT NULL COMMENT '主营业务变更情况',
  `CreAssSup` varchar(1) DEFAULT NULL COMMENT '信贷资产支持',
  `PerChaSit` varchar(1) DEFAULT NULL COMMENT '近一年主要人员是否发生变动',
  `DefaTaxAmount` int(11) DEFAULT NULL COMMENT '近三年的欠税条数',
  `HousEquities` varchar(1) DEFAULT NULL COMMENT '经营地产权情况',
  `NumOfEmployees` int(11) DEFAULT NULL COMMENT '从业人员数量',
  `DirecortNum` int(11) DEFAULT NULL COMMENT '董事会成员(执行董事)数量',
  `SupervisorNum` int(11) DEFAULT NULL COMMENT '监事会成员(监事)数量',
  `IsInCounty` varchar(1) DEFAULT NULL COMMENT '是否县域企业',
  `HasIncFromAgri` varchar(1) DEFAULT NULL COMMENT '是否涉农企业',
  `LegRepName` varchar(60) DEFAULT NULL COMMENT '主要负责人名称',
  `LegRepIDType` varchar(2) DEFAULT NULL COMMENT '主要负责人身份标识类型',
  `LegRepIDNum` varchar(40) DEFAULT NULL COMMENT '主要负责人证件号码',
  `LegRepHouseAddStat` varchar(1) DEFAULT NULL COMMENT '主要负责人户籍情况',
  `LegRepEduLevel` varchar(2) DEFAULT NULL COMMENT '主要负责人学历情况',
  `LegRepWorkingYears` int(11) DEFAULT NULL COMMENT '主要负责人在本单位从业年限',
  `RegCapCurrency` varchar(3) DEFAULT NULL COMMENT '注册资本币种',
  `RegCap` decimal(17,2) DEFAULT NULL COMMENT '注册资本',
  `ManagerOrgID` varchar(32) DEFAULT NULL COMMENT '管户机构编号',
  `ManagerUserID` varchar(32) DEFAULT NULL COMMENT '管户用户编号',
  `OperOrgID` varchar(32) DEFAULT NULL COMMENT '操作机构编号',
  `OperUserID` varchar(32) DEFAULT NULL COMMENT '操作用户编号',
  `OccurDate` varchar(10) DEFAULT NULL COMMENT '数据日期',
  `Extend1` varchar(30) DEFAULT NULL COMMENT '扩展字段1',
  `Extend2` varchar(30) DEFAULT NULL COMMENT '扩展字段2',
  `Extend3` varchar(30) DEFAULT NULL COMMENT '扩展字段3',
  `ImportType` varchar(10) DEFAULT NULL COMMENT '区分数据来源,分web和批量',
  PRIMARY KEY (`CustomerID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='企业基本信息接口表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `pidr_int_error`
--

DROP TABLE IF EXISTS `pidr_int_error`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pidr_int_error` (
  `SERIALNO` varchar(32) NOT NULL COMMENT '错误流水号',
  `TABLENAME` varchar(32) DEFAULT NULL COMMENT '错误表名',
  `ERRORKEY` varchar(32) DEFAULT NULL COMMENT '重复主键',
  `ERRORKEYVALUE` varchar(250) DEFAULT NULL COMMENT '重复主键值',
  `OCCURDATE` varchar(10) DEFAULT NULL COMMENT '数据日期',
  `EXTEND1` varchar(30) DEFAULT NULL COMMENT '扩展字段1',
  `EXTEND2` varchar(30) DEFAULT NULL COMMENT '扩展字段2',
  `EXTEND3` varchar(30) DEFAULT NULL COMMENT '扩展字段3',
  PRIMARY KEY (`SERIALNO`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='接口导入数据重复表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `pidr_int_finstatement`
--

DROP TABLE IF EXISTS `pidr_int_finstatement`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pidr_int_finstatement` (
  `CustomerID` varchar(60) NOT NULL COMMENT '客户编号',
  `Stage` varchar(1) NOT NULL COMMENT '期次',
  `FinStaYear` varchar(4) NOT NULL COMMENT '报表年份',
  `SheetType` varchar(2) NOT NULL COMMENT '报表类型',
  `SheetTypeDivide` varchar(1) NOT NULL COMMENT '报表类型细分',
  `InterestPayable` decimal(17,2) DEFAULT NULL COMMENT '资产负债,补充,应付利息',
  `DividendsReceivable` decimal(17,2) DEFAULT NULL COMMENT '资产负债,补充,应收股利',
  `UnclearedGuarBEndOfTheTerm` decimal(17,2) DEFAULT NULL COMMENT '补充报表,未清担保余额',
  `ManagerOrgID` varchar(32) DEFAULT NULL COMMENT '管户机构编号',
  `ManagerUserID` varchar(32) DEFAULT NULL COMMENT '管户用户编号',
  `OperOrgID` varchar(32) DEFAULT NULL COMMENT '操作机构编号',
  `OperUserID` varchar(32) DEFAULT NULL COMMENT '操作用户编号',
  `OccurDate` varchar(10) DEFAULT NULL COMMENT '数据日期',
  `Extend1` varchar(30) DEFAULT NULL COMMENT '扩展字段1',
  `Extend2` varchar(30) DEFAULT NULL COMMENT '扩展字段2',
  `Extend3` varchar(30) DEFAULT NULL COMMENT '扩展字段3',
  `ImportType` varchar(10) DEFAULT NULL COMMENT '区分数据来源,分web和批量',
  PRIMARY KEY (`CustomerID`,`Stage`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='补充报表接口表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `pidr_int_income`
--

DROP TABLE IF EXISTS `pidr_int_income`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pidr_int_income` (
  `CustomerID` varchar(60) NOT NULL COMMENT '客户编号',
  `Stage` varchar(1) NOT NULL COMMENT '期次',
  `FinStaYear` varchar(4) NOT NULL COMMENT '报表年份',
  `SheetType` varchar(2) NOT NULL COMMENT '报表类型',
  `SheetTypeDivide` varchar(1) NOT NULL COMMENT '报表类型细分',
  `RevenueOfSales` decimal(17,2) DEFAULT NULL COMMENT '一、营业收入',
  `CostOfSales` decimal(17,2) DEFAULT NULL COMMENT '减:营业成本',
  `BusinessAndOtherTaxes` decimal(17,2) DEFAULT NULL COMMENT '税金及附加',
  `SellingExpenses` decimal(17,2) DEFAULT NULL COMMENT '销售费用',
  `GenAndAdministrativeExpenses` decimal(17,2) DEFAULT NULL COMMENT '管理费用;GeneralAndAdministrativeExpenses',
  `RDExpenses` decimal(17,2) DEFAULT NULL COMMENT '研发费用',
  `FinancialExpense` decimal(17,2) DEFAULT NULL COMMENT '财务费用',
  `InterestFeeOfFinancialExpense` decimal(17,2) DEFAULT NULL COMMENT '其中:利息费用',
  `IntIncomeOfFinancialExpense` decimal(17,2) DEFAULT NULL COMMENT '利息收入;InterestIncomeOfFinancialExpense',
  `OtherIncome` decimal(17,2) DEFAULT NULL COMMENT '加:其他收益',
  `InvestmentIncome` decimal(17,2) DEFAULT NULL COMMENT '投资收益(损失以“-”号填列)',
  `AssociatesAndJointVenturesInc` decimal(17,2) DEFAULT NULL COMMENT '其中:对联营企业和合营企业的投资收益;AssociatesAndJointVenturesIncom',
  `FinancialAssetsEndIncome` decimal(17,2) DEFAULT NULL COMMENT '以摊余成本计量的金融资产终止确认收益(损失以“-”号填列)',
  `NetExposureHedgingIncome` decimal(17,2) DEFAULT NULL COMMENT '净敞口套期收益(损失以“-”号填列)',
  `IncomeFromChangesInFairValue` decimal(17,2) DEFAULT NULL COMMENT '公允价值变动收益(损失以“-”号填列)',
  `CreditImpairmentLoss` decimal(17,2) DEFAULT NULL COMMENT '信用减值损失(损失以“-”号填列)',
  `ImpairmentLossOfAssets` decimal(17,2) DEFAULT NULL COMMENT '资产减值损失(损失以“-”号填列)',
  `IncomeFromAssetDisposal` decimal(17,2) DEFAULT NULL COMMENT '资产处置收益(损失以“-”号填列)',
  `OperatingProfits` decimal(17,2) DEFAULT NULL COMMENT '二、营业利润(亏损以“-”号填列)',
  `NonOperatingIncome` decimal(17,2) DEFAULT NULL COMMENT '加:营业外收入',
  `NonOperatingExpenses` decimal(17,2) DEFAULT NULL COMMENT '减:营业外支出	',
  `ProfitBeforeTax` decimal(17,2) DEFAULT NULL COMMENT '三、利润总额(亏损总额以“-”号填列)',
  `IncomeTaxExpense` decimal(17,2) DEFAULT NULL COMMENT '减:所得税费用',
  `NetProfit` decimal(17,2) DEFAULT NULL COMMENT '四、净利润(净亏损以“-”号填列)',
  `OthComprehensiveIncomeAfterTax` decimal(17,2) DEFAULT NULL COMMENT '五、其他综合收益的税后净额;OtherComprehensiveIncomeAfterTax',
  `TotalComprehensiveIncome` decimal(17,2) DEFAULT NULL COMMENT '六、综合收益总额',
  `EarningsPerShare` decimal(17,2) DEFAULT NULL COMMENT '七、每股收益:',
  `BasicEarningsPerShare` decimal(17,2) DEFAULT NULL COMMENT '(一)基本每股收益',
  `DilutedEarningsPerShare` decimal(17,2) DEFAULT NULL COMMENT '(二)稀释每股收益',
  `ManagerOrgID` varchar(32) DEFAULT NULL COMMENT '管户机构编号',
  `ManagerUserID` varchar(32) DEFAULT NULL COMMENT '管户用户编号',
  `OperOrgID` varchar(32) DEFAULT NULL COMMENT '操作机构编号',
  `OperUserID` varchar(32) DEFAULT NULL COMMENT '操作用户编号',
  `OccurDate` varchar(10) DEFAULT NULL COMMENT '数据日期',
  `Extend1` varchar(30) DEFAULT NULL COMMENT '扩展字段1',
  `Extend2` varchar(30) DEFAULT NULL COMMENT '扩展字段2',
  `Extend3` varchar(30) DEFAULT NULL COMMENT '扩展字段3',
  `ImportType` varchar(10) DEFAULT NULL COMMENT '区分数据来源,分web和批量',
  PRIMARY KEY (`CustomerID`,`Stage`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='企业利润信息接口表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `pidr_int_income_demo`
--

DROP TABLE IF EXISTS `pidr_int_income_demo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pidr_int_income_demo` (
  `CustomerID` varchar(60) NOT NULL COMMENT '客户编号',
  `FinStaYear` varchar(4) NOT NULL COMMENT '报表年份',
  `SheetType` varchar(2) NOT NULL COMMENT '报表类型',
  `SheetTypeDivide` varchar(1) NOT NULL COMMENT '报表类型细分',
  `ProjectName` varchar(50) NOT NULL COMMENT '项目名称',
  `StageMoney` decimal(17,2) DEFAULT NULL COMMENT '本期金额',
  `StageMoney2` decimal(17,2) DEFAULT NULL COMMENT '上期金额',
  PRIMARY KEY (`CustomerID`,`FinStaYear`,`SheetType`,`SheetTypeDivide`,`ProjectName`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='企业利润测试表_用完及删';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `pidr_int_invabroinfo`
--

DROP TABLE IF EXISTS `pidr_int_invabroinfo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pidr_int_invabroinfo` (
  `RelaId` varchar(60) NOT NULL COMMENT '关联编号',
  `CustomerID` varchar(60) NOT NULL COMMENT '客户编号',
  `InvEntName` varchar(160) DEFAULT NULL COMMENT '被投资企业名称',
  `InvEntIDType` varchar(2) DEFAULT NULL COMMENT '被投资企业身份标识类型',
  `InvEntIDNum` varchar(18) DEFAULT NULL COMMENT '被投资企业身份标识号码',
  `InvEntRegCap` decimal(17,2) DEFAULT NULL COMMENT '被投资企业注册资本',
  `InvEntEstablishDate` varchar(10) DEFAULT NULL COMMENT '被投资企业成立日期',
  `InvCurrency` varchar(3) DEFAULT NULL COMMENT '投资币种',
  `InvSubAmount` decimal(17,2) DEFAULT NULL COMMENT '投资认缴金额',
  `InvPaidAmount` decimal(17,2) DEFAULT NULL COMMENT '投资实缴金额',
  `ShareHoldRatio` decimal(5,2) DEFAULT NULL COMMENT '持股比例',
  `InvDate` varchar(10) DEFAULT NULL COMMENT '投资日期',
  `EffStatus` varchar(1) DEFAULT NULL COMMENT '有效标志',
  `ManagerOrgID` varchar(32) DEFAULT NULL COMMENT '管户机构编号',
  `ManagerUserID` varchar(32) DEFAULT NULL COMMENT '管户用户编号',
  `OperOrgID` varchar(32) DEFAULT NULL COMMENT '操作机构编号',
  `OperUserID` varchar(32) DEFAULT NULL COMMENT '操作用户编号',
  `OccurDate` varchar(10) DEFAULT NULL COMMENT '数据日期',
  `Extend1` varchar(30) DEFAULT NULL COMMENT '扩展字段1',
  `Extend2` varchar(30) DEFAULT NULL COMMENT '扩展字段2',
  `Extend3` varchar(30) DEFAULT NULL COMMENT '扩展字段3',
  `ImportType` varchar(10) DEFAULT NULL COMMENT '区分数据来源,分web和批量',
  PRIMARY KEY (`RelaId`,`CustomerID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='企业对外投资接口表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `pidr_int_mnshahodinfo`
--

DROP TABLE IF EXISTS `pidr_int_mnshahodinfo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pidr_int_mnshahodinfo` (
  `RelaId` varchar(60) NOT NULL COMMENT '关联编号',
  `CustomerID` varchar(60) NOT NULL COMMENT '客户编号',
  `SharHodType` varchar(2) DEFAULT NULL COMMENT '出资人类型',
  `SharHodCertType` varchar(1) DEFAULT NULL COMMENT '出资人身份类别',
  `SharHodName` varchar(160) DEFAULT NULL COMMENT '出资人名称',
  `SharHodIDType` varchar(2) DEFAULT NULL COMMENT '出资人身份标识类型',
  `SharHodIDNum` varchar(80) DEFAULT NULL COMMENT '出资人身份号码',
  `InvRatio` decimal(5,2) DEFAULT NULL COMMENT '出资比例',
  `EffStatus` varchar(1) DEFAULT NULL COMMENT '有效标志',
  `ManagerOrgID` varchar(32) DEFAULT NULL COMMENT '管户机构编号',
  `ManagerUserID` varchar(32) DEFAULT NULL COMMENT '管户用户编号',
  `OperOrgID` varchar(32) DEFAULT NULL COMMENT '操作机构编号',
  `OperUserID` varchar(32) DEFAULT NULL COMMENT '操作用户编号',
  `OccurDate` varchar(10) DEFAULT NULL COMMENT '数据日期',
  `Extend1` varchar(30) DEFAULT NULL COMMENT '扩展字段1',
  `Extend2` varchar(30) DEFAULT NULL COMMENT '扩展字段2',
  `Extend3` varchar(30) DEFAULT NULL COMMENT '扩展字段3',
  `ImportType` varchar(10) DEFAULT NULL COMMENT '区分数据来源,分web和批量',
  PRIMARY KEY (`RelaId`,`CustomerID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='企业注册资本及主要出资人接口表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `pidr_int_neginfo`
--

DROP TABLE IF EXISTS `pidr_int_neginfo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pidr_int_neginfo` (
  `RelaId` varchar(60) NOT NULL COMMENT '关联编号',
  `CustomerID` varchar(60) NOT NULL COMMENT '客户编号',
  `NegInfType` varchar(2) DEFAULT NULL COMMENT '负面信息类型',
  `NegInfContent` varchar(800) DEFAULT NULL COMMENT '信息内容',
  `InvolvedAmount` decimal(17,2) DEFAULT NULL COMMENT '涉案金额',
  `NegInfDate` varchar(10) DEFAULT NULL COMMENT '信息发生(公示)时间',
  `NegInfValidity` varchar(10) DEFAULT NULL COMMENT '有效期',
  `NegInfIssOrg` varchar(80) DEFAULT NULL COMMENT '信息发布机构',
  `EffStatus` varchar(1) DEFAULT NULL COMMENT '有效标志',
  `ManagerOrgID` varchar(32) DEFAULT NULL COMMENT '管户机构编号',
  `ManagerUserID` varchar(32) DEFAULT NULL COMMENT '管户用户编号',
  `OperOrgID` varchar(32) DEFAULT NULL COMMENT '操作机构编号',
  `OperUserID` varchar(32) DEFAULT NULL COMMENT '操作用户编号',
  `OccurDate` varchar(10) DEFAULT NULL COMMENT '数据日期',
  `Extend1` varchar(30) DEFAULT NULL COMMENT '扩展字段1',
  `Extend2` varchar(30) DEFAULT NULL COMMENT '扩展字段2',
  `Extend3` varchar(30) DEFAULT NULL COMMENT '扩展字段3',
  `ImportType` varchar(10) DEFAULT NULL COMMENT '区分数据来源,分web和批量',
  PRIMARY KEY (`RelaId`,`CustomerID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='企业负面信息接口表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `pidr_rate_balancessheet`
--

DROP TABLE IF EXISTS `pidr_rate_balancessheet`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pidr_rate_balancessheet` (
  `SessionId` varchar(16) DEFAULT NULL COMMENT '期次号',
  `CustomerID` varchar(60) NOT NULL COMMENT '客户编号',
  `Stage` varchar(1) NOT NULL COMMENT '期次',
  `FinStaYear` varchar(4) NOT NULL COMMENT '报表年份',
  `SheetType` varchar(2) NOT NULL COMMENT '报表类型',
  `SheetTypeDivide` varchar(1) NOT NULL COMMENT '报表类型细分',
  `CurrencyFunds` decimal(17,2) DEFAULT NULL COMMENT '货币资金',
  `FinancialAssetsHeldForTrading` decimal(17,2) DEFAULT NULL COMMENT '交易性金融资产',
  `DerivativeFinancialAssets` decimal(17,2) DEFAULT NULL COMMENT '衍生金融资产',
  `NotesReceivable` decimal(17,2) DEFAULT NULL COMMENT '应收票据',
  `AccountsReceivable` decimal(17,2) DEFAULT NULL COMMENT '应收账款',
  `AccountsReceivableFinancing` decimal(17,2) DEFAULT NULL COMMENT '应收款项融资',
  `Prepayments` decimal(17,2) DEFAULT NULL COMMENT '预付款项',
  `OtherReceivables` decimal(17,2) DEFAULT NULL COMMENT '其他应收款',
  `Inventories` decimal(17,2) DEFAULT NULL COMMENT '存货',
  `ContractAssets` decimal(17,2) DEFAULT NULL COMMENT '合同资产',
  `AssetsAvailableForSale` decimal(17,2) DEFAULT NULL COMMENT '持有待售资产',
  `CurPortionOfNonCurrentAssets` decimal(17,2) DEFAULT NULL COMMENT '一年内到期的非流动资产;CurrentPortionOfNonCurrentAssets',
  `OtherCurrentAssets` decimal(17,2) DEFAULT NULL COMMENT '其他流动资产',
  `TotalCurrentAssets` decimal(17,2) DEFAULT NULL COMMENT '流动资产合计',
  `DebtInvestment` decimal(17,2) DEFAULT NULL COMMENT '债权投资',
  `OtherDebtInvestment` decimal(17,2) DEFAULT NULL COMMENT '其他债权投资',
  `LongTermReceivables` decimal(17,2) DEFAULT NULL COMMENT '长期应收款',
  `LongTermEquityInvestment` decimal(17,2) DEFAULT NULL COMMENT '长期股权投资',
  `OthEquityInstrumentsInvestment` decimal(17,2) DEFAULT NULL COMMENT '其他权益工具投资;OtherEquityInstrumentsInvestment',
  `OtherNonCurrentFinancialAssets` decimal(17,2) DEFAULT NULL COMMENT '其他非流动金融资产',
  `InvestmentProperties` decimal(17,2) DEFAULT NULL COMMENT '投资性房地产',
  `FixedAssets` decimal(17,2) DEFAULT NULL COMMENT '固定资产',
  `ConstructionInProgress` decimal(17,2) DEFAULT NULL COMMENT '在建工程',
  `NonCurrentBiologicalAssets` decimal(17,2) DEFAULT NULL COMMENT '生产性生物资产',
  `OilAndGasAssets` decimal(17,2) DEFAULT NULL COMMENT '油气资产',
  `UseRightAssets` decimal(17,2) DEFAULT NULL COMMENT '使用权资产',
  `IntangibleAssets` decimal(17,2) DEFAULT NULL COMMENT '无形资产',
  `DevelopmentDisbursements` decimal(17,2) DEFAULT NULL COMMENT '开发支出',
  `Goodwill` decimal(17,2) DEFAULT NULL COMMENT '商誉',
  `LongTermDeferredExpenses` decimal(17,2) DEFAULT NULL COMMENT '长期待摊费用',
  `DeferredTaxAssets` decimal(17,2) DEFAULT NULL COMMENT '递延所得税资产',
  `OtherNonCurrentAssets` decimal(17,2) DEFAULT NULL COMMENT '其他非流动资产',
  `TotalNonCurrentAssets` decimal(17,2) DEFAULT NULL COMMENT '非流动资产合计',
  `TotalAssets` decimal(17,2) DEFAULT NULL COMMENT '资产总计',
  `ShortTermBorrowings` decimal(17,2) DEFAULT NULL COMMENT '短期借款',
  `FinLiabilitiesHeldForTrading` decimal(17,2) DEFAULT NULL COMMENT '交易性金融负债;FinancialLiabilitiesHeldForTrading',
  `DerivativeFinancialLiabilities` decimal(17,2) DEFAULT NULL COMMENT '衍生金融负债',
  `NotesPayable` decimal(17,2) DEFAULT NULL COMMENT '应付票据',
  `AccountsPayable` decimal(17,2) DEFAULT NULL COMMENT '应付账款',
  `ReceiptsInAdvance` decimal(17,2) DEFAULT NULL COMMENT '预收款项',
  `ContractualLiabilities` decimal(17,2) DEFAULT NULL COMMENT '合同负债',
  `EmployeeBenefitsPayable` decimal(17,2) DEFAULT NULL COMMENT '应付职工薪酬',
  `TaxesPayable` decimal(17,2) DEFAULT NULL COMMENT '应交税费',
  `OtherPayables` decimal(17,2) DEFAULT NULL COMMENT '其他应付款',
  `LiabilitiesHeldForSale` decimal(17,2) DEFAULT NULL COMMENT '持有待售负债',
  `CurPorOfLongTermLiabilities` decimal(17,2) DEFAULT NULL COMMENT '一年内到期的非流动负债CurrentPortionOfLongTermLiabilities',
  `OtherCurrentLiabilities` decimal(17,2) DEFAULT NULL COMMENT '其他流动负债',
  `TotalCurrentLiabilities` decimal(17,2) DEFAULT NULL COMMENT '流动负债合计',
  `LongTermBorrowings` decimal(17,2) DEFAULT NULL COMMENT '长期借款',
  `BondsPayables` decimal(17,2) DEFAULT NULL COMMENT '应付债券',
  `PreferredStockInBondsPayables` decimal(17,2) DEFAULT NULL COMMENT '其中:优先股',
  `PerpetualBondsInBondsPayables` decimal(17,2) DEFAULT NULL COMMENT '永续债',
  `LeaseLiabilities` decimal(17,2) DEFAULT NULL COMMENT '租赁负债',
  `LongTermPayables` decimal(17,2) DEFAULT NULL COMMENT '长期应付款',
  `Provisions` decimal(17,2) DEFAULT NULL COMMENT '预计负债',
  `DeferredIncome` decimal(17,2) DEFAULT NULL COMMENT '递延收益',
  `DeferredTaxLiabilities` decimal(17,2) DEFAULT NULL COMMENT '递延所得税负债',
  `OtherNonCurrentLiabilities` decimal(17,2) DEFAULT NULL COMMENT '其他非流动负债',
  `TotalNonCurrentLiabilities` decimal(17,2) DEFAULT NULL COMMENT '非流动负债合计',
  `TotalLiabilities` decimal(17,2) DEFAULT NULL COMMENT '负债合计',
  `PaidInCapitalOrShareCapital` decimal(17,2) DEFAULT NULL COMMENT '实收资本(或股本)',
  `OtherEquityInstruments` decimal(17,2) DEFAULT NULL COMMENT '其他权益工具投资',
  `PreStockInOthEquityInstruments` decimal(17,2) DEFAULT NULL COMMENT '其中:优先股;PreferredStockInOtherEquityInstruments',
  `PerBondsInOthEquityInstruments` decimal(17,2) DEFAULT NULL COMMENT '永续债;PerpetualBondsInOtherEquityInstruments',
  `CapitalrRserve` decimal(17,2) DEFAULT NULL COMMENT '资本公积',
  `LessTreasuryStocks` decimal(17,2) DEFAULT NULL COMMENT '减:库存股',
  `OtherComprehensiveIncome` decimal(17,2) DEFAULT NULL COMMENT '其他综合收益',
  `SpecialReserve` decimal(17,2) DEFAULT NULL COMMENT '专项储备',
  `SurplusReserve` decimal(17,2) DEFAULT NULL COMMENT '盈余公积',
  `UnappropriatedProfit` decimal(17,2) DEFAULT NULL COMMENT '未分配利润',
  `TotalEquity` decimal(17,2) DEFAULT NULL COMMENT '所有者权益(或股东权益)合计',
  `TotalEquityAndLiabilities` decimal(17,2) DEFAULT NULL COMMENT '负债和所有者权益(或股东权益)总计',
  `ManagerOrgID` varchar(32) DEFAULT NULL COMMENT '管户机构编号',
  `ManagerUserID` varchar(32) DEFAULT NULL COMMENT '管户用户编号',
  `OperOrgID` varchar(32) DEFAULT NULL COMMENT '操作机构编号',
  `OperUserID` varchar(32) DEFAULT NULL COMMENT '操作用户编号',
  `RecordFlag` varchar(1) DEFAULT NULL COMMENT '记录标志',
  `OccurDate` varchar(10) DEFAULT NULL COMMENT '数据日期',
  `Extend1` varchar(30) DEFAULT NULL COMMENT '扩展字段1',
  `Extend2` varchar(30) DEFAULT NULL COMMENT '扩展字段2',
  `Extend3` varchar(30) DEFAULT NULL COMMENT '扩展字段3',
  PRIMARY KEY (`CustomerID`,`Stage`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='企业资产负债表段当期表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `pidr_rate_bs`
--

DROP TABLE IF EXISTS `pidr_rate_bs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pidr_rate_bs` (
  `SessionId` varchar(16) DEFAULT NULL COMMENT '期次号',
  `CustomerId` varchar(60) NOT NULL COMMENT '客户编号',
  `InfRecType` varchar(3) DEFAULT NULL COMMENT '信息记录类型',
  `EntName` varchar(160) DEFAULT NULL COMMENT '企业名称',
  `EntCertType` varchar(2) DEFAULT NULL COMMENT '企业身份标识类型;20-统一社会信用代码',
  `EntCertNum` varchar(18) DEFAULT NULL COMMENT '企业身份标识号码',
  `FinStaYear` varchar(4) DEFAULT NULL COMMENT '报表年份',
  `SheetType` varchar(2) DEFAULT NULL COMMENT '报表类型',
  `SheetTypeDivide` varchar(1) DEFAULT NULL COMMENT '报表类型细分',
  `MngmtOrgCode` varchar(14) DEFAULT NULL COMMENT '业务管理金融机构代码',
  `RptDate` varchar(10) DEFAULT NULL COMMENT '信息报告日期',
  `RecordFlag` varchar(1) DEFAULT NULL COMMENT '记录标志',
  `OccurDate` varchar(10) DEFAULT NULL COMMENT '数据日期',
  `ManagerOrgID` varchar(32) DEFAULT NULL COMMENT '管户机构编号',
  `ManagerUserID` varchar(32) DEFAULT NULL COMMENT '管户用户编号',
  `OperOrgID` varchar(32) DEFAULT NULL COMMENT '操作机构编号',
  `OperUserID` varchar(32) DEFAULT NULL COMMENT '操作用户编号',
  `OperTime` varchar(19) DEFAULT NULL COMMENT '操作时间',
  `Extend1` varchar(30) DEFAULT NULL COMMENT '扩展字段1',
  `Extend2` varchar(30) DEFAULT NULL COMMENT '扩展字段2',
  `Extend3` varchar(30) DEFAULT NULL COMMENT '扩展字段3',
  PRIMARY KEY (`CustomerId`),
  KEY `index_pidr_rate_bs` (`EntCertType`,`EntCertNum`,`FinStaYear`,`MngmtOrgCode`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='评级基础段当期表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `pidr_rate_cashflow`
--

DROP TABLE IF EXISTS `pidr_rate_cashflow`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pidr_rate_cashflow` (
  `SessionId` varchar(16) DEFAULT NULL COMMENT '期次号',
  `CustomerId` varchar(60) NOT NULL COMMENT '客户编号',
  `Stage` varchar(1) NOT NULL COMMENT '期次',
  `FinStaYear` varchar(4) NOT NULL COMMENT '报表年份',
  `SheetType` varchar(2) NOT NULL COMMENT '报表类型',
  `SheetTypeDivide` varchar(1) NOT NULL COMMENT '报表类型细分',
  `CashReceivedFromSalesOGOROS` decimal(17,2) DEFAULT NULL COMMENT '销售商品、提供劳务收到的现金;CashReceivedFromSalesOfGoodsOrRendingOfServices',
  `TaxRefunds` decimal(17,2) DEFAULT NULL COMMENT '收到的税费返还',
  `OtherCashReceivedRTOA` decimal(17,2) DEFAULT NULL COMMENT '收到其他与经营活动有关的现金;OtherCashReceivedRelatingToOperatingActivities',
  `TotalCashInflowsFromOA` decimal(17,2) DEFAULT NULL COMMENT '经营活动现金流入小计;TotalCashInflowsFromOperatingActivities',
  `CashPaidForGoodsAndServices` decimal(17,2) DEFAULT NULL COMMENT '购买商品、接受劳务支付的现金',
  `CashPaidToAndOnBOE` decimal(17,2) DEFAULT NULL COMMENT '支付给职工以及为职工支付的现金;CashPaidToAndOnBehalfOfEmployees',
  `PaymentsOfAllTypesOfTaxes` decimal(17,2) DEFAULT NULL COMMENT '支付的各项税费',
  `OtherCashPaymentsFromOA` decimal(17,2) DEFAULT NULL COMMENT '支付其他与经营活动有关的现金;OtherCashPaymentsFromOperatingActivities',
  `TotalCashOutflowsFromOA` decimal(17,2) DEFAULT NULL COMMENT '经营活动现金流出小计;TotalCashOutflowsFromOperatingActivities',
  `NetCashFlowsFromOA` decimal(17,2) DEFAULT NULL COMMENT '经营活动产生的现金流量净额;NetCashFlowsFromOperatingActivities',
  `CashReceivedFromROI` decimal(17,2) DEFAULT NULL COMMENT '收回投资收到的现金;CashReceivedFromReturnOfInvestment',
  `CashReceivedFromOnvestments` decimal(17,2) DEFAULT NULL COMMENT '取得投资收益收到的现金',
  `NetCashAndOtherLongTermAssets` decimal(17,2) DEFAULT NULL COMMENT '处置固定资产、无形资产和其他长期资产收回的现金净额;NetCashReceivedFromDisposalOfFixedAssetsIntangibleAssetsAndOtherLongTermAssets',
  `NetCashReceivedFromDSAOB` decimal(17,2) DEFAULT NULL COMMENT '处置子公司及其他营业单位收到的现金净额;NetCashReceivedFromDisposalSubsidiariesAndOtherBusiness',
  `CashReceivedRelatingToOIA` decimal(17,2) DEFAULT NULL COMMENT '收到其他与投资活动有关的现金;CashReceivedRelatingToOtherInvestingActivities',
  `TotalCashInflowsFromIA` decimal(17,2) DEFAULT NULL COMMENT '投资活动现金流入小计;TotalCashInflowsFromInvestingActivities',
  `CashPaidToAcquire` decimal(17,2) DEFAULT NULL COMMENT '购建固定资产、无形资产和其他长期资产支付的现金;CashPaidToAcquireFixedAssetsIntangibleAssetsAndOtherLongTermAssents',
  `CashPaymentsForInvestments` decimal(17,2) DEFAULT NULL COMMENT '投资支付的现金',
  `NetCashPaidToASAOB` decimal(17,2) DEFAULT NULL COMMENT '取得子公司及其他营业单位支付的现金净额;NetCashPaidToAcquireSubsidiariesAndOtherBusiness',
  `CashPaymentsRelatedToTA` decimal(17,2) DEFAULT NULL COMMENT '支付其他与投资活动有关的现金;CashPaymentsRelatedToOtherInvestingActivities',
  `SubTotalOfCashOutflows` decimal(17,2) DEFAULT NULL COMMENT '投资活动现金流出小计',
  `NetCashFlowsFromIA` decimal(17,2) DEFAULT NULL COMMENT '投资活动产生的现金流量净额;NetCashFlowsFromInvestingActivities',
  `CashReceivedFromInvestors` decimal(17,2) DEFAULT NULL COMMENT '吸收投资收到的现金',
  `CashFromBorrowings` decimal(17,2) DEFAULT NULL COMMENT '取得借款收到的现金',
  `OtherCashReceivedRelatingTFA` decimal(17,2) DEFAULT NULL COMMENT '收到其他与筹资活动有关的现金;OtherCashReceivedRelatingToFinancingActivities',
  `TotalCashInflowsFromFA` decimal(17,2) DEFAULT NULL COMMENT '筹资活动现金流入小计TotalCashInflowsFromFinancingActivities',
  `CashRepaymentsForDebts` decimal(17,2) DEFAULT NULL COMMENT '偿还债务支付的现金',
  `CashPaymentsForDist` decimal(17,2) DEFAULT NULL COMMENT '分配股利、利润或偿付利息支付的现金',
  `CashPaymentsRelatedToOFA` decimal(17,2) DEFAULT NULL COMMENT '支付其他与筹资活动有关的现金;CashPaymentsRelatedToOtherFinancingActivities',
  `TotalCashOutflowsFromFA` decimal(17,2) DEFAULT NULL COMMENT '筹资活动现金流出小计;TotalCashOutflowsFromFinancingActivities',
  `NetCashFlowsFromFA` decimal(17,2) DEFAULT NULL COMMENT '筹资活动产生的现金流量净额;NetCashFlowsFromFinancingActivities',
  `EffectOfExchangRateCOC` decimal(17,2) DEFAULT NULL COMMENT '四、汇率变动对现金及现金等价物的影响;EffectOfExchangRateChangesOnCash',
  `NetIncreaseInCashAndCE` decimal(17,2) DEFAULT NULL COMMENT '五、现金及现金等价物净增加额;NetIncreaseInCashAndCashEquivalents',
  `InitialCashAndCashEB` decimal(17,2) DEFAULT NULL COMMENT '加:期初现金及现金等价物余额;InitialCashAndCashEquivalentsBalance',
  `TheFinalCashAndCashEB` decimal(17,2) DEFAULT NULL COMMENT '六、期末现金及现金等价物余额;TheFinalCashAndCashEquivalentsBalance',
  `RecordFlag` varchar(1) DEFAULT NULL COMMENT '记录标志',
  `OccurDate` varchar(10) DEFAULT NULL COMMENT '数据日期',
  `ManagerOrgID` varchar(32) DEFAULT NULL COMMENT '管户机构编号',
  `ManagerUserID` varchar(32) DEFAULT NULL COMMENT '管户用户编号',
  `OperOrgID` varchar(32) DEFAULT NULL COMMENT '操作机构编号',
  `OperUserID` varchar(32) DEFAULT NULL COMMENT '操作用户编号',
  `OperTime` varchar(19) DEFAULT NULL COMMENT '操作时间',
  `Extend1` varchar(30) DEFAULT NULL COMMENT '扩展字段1',
  `Extend2` varchar(30) DEFAULT NULL COMMENT '扩展字段2',
  `Extend3` varchar(30) DEFAULT NULL COMMENT '扩展字段3',
  PRIMARY KEY (`CustomerId`,`Stage`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='评级现金流量表段当期表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `pidr_rate_fsinf`
--

DROP TABLE IF EXISTS `pidr_rate_fsinf`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pidr_rate_fsinf` (
  `SessionId` varchar(16) DEFAULT NULL COMMENT '期次号',
  `CustomerId` varchar(60) NOT NULL COMMENT '客户编号',
  `RegAdd` varchar(200) DEFAULT NULL COMMENT '登记注册地址',
  `AdmDivOfReg` varchar(6) DEFAULT NULL COMMENT '登记地行政区划代码',
  `EstablishDate` varchar(10) DEFAULT NULL COMMENT '成立日期',
  `BizRange` varchar(800) DEFAULT NULL COMMENT '业务范围',
  `MainBusSou` varchar(200) DEFAULT NULL COMMENT '主营业务收入来源',
  `EcoIndusCate` varchar(4) DEFAULT NULL COMMENT '行业分类代码',
  `EcoType` varchar(3) DEFAULT NULL COMMENT '经济类型代码',
  `InterRatingRes` varchar(3) DEFAULT NULL COMMENT '金融机构内部评级结果',
  `InterRatinDes` varchar(2000) DEFAULT NULL COMMENT '金融机构内评体系描述',
  `MainBusChan` varchar(1) DEFAULT NULL COMMENT '主营业务变更情况',
  `CreAssSup` varchar(1) DEFAULT NULL COMMENT '信贷资产支持',
  `PerChaSit` varchar(1) DEFAULT NULL COMMENT '近一年主要人员是否发生变动',
  `DefaTaxAmount` int(11) DEFAULT NULL COMMENT '近三年的欠税条数',
  `HousEquities` varchar(1) DEFAULT NULL COMMENT '经营地产权情况',
  `NumOfEmployees` int(11) DEFAULT NULL COMMENT '从业人员数量',
  `DirecortNum` int(11) DEFAULT NULL COMMENT '董事会成员(执行董事)数量',
  `SupervisorNum` int(11) DEFAULT NULL COMMENT '监事会成员(监事)数量',
  `IsInCounty` varchar(1) DEFAULT NULL COMMENT '是否县域企业',
  `HasIncFromAgri` varchar(1) DEFAULT NULL COMMENT '是否涉农企业',
  `RecordFlag` varchar(1) DEFAULT NULL COMMENT '记录标志',
  `OccurDate` varchar(10) DEFAULT NULL COMMENT '数据日期',
  `ManagerOrgID` varchar(32) DEFAULT NULL COMMENT '管户机构编号',
  `ManagerUserID` varchar(32) DEFAULT NULL COMMENT '管户用户编号',
  `OperOrgID` varchar(32) DEFAULT NULL COMMENT '操作机构编号',
  `OperUserID` varchar(32) DEFAULT NULL COMMENT '操作用户编号',
  `OperTime` varchar(19) DEFAULT NULL COMMENT '操作时间',
  `Extend1` varchar(30) DEFAULT NULL COMMENT '扩展字段1',
  `Extend2` varchar(30) DEFAULT NULL COMMENT '扩展字段2',
  `Extend3` varchar(30) DEFAULT NULL COMMENT '扩展字段3',
  PRIMARY KEY (`CustomerId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='评级基本概况段当期表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `pidr_rate_income`
--

DROP TABLE IF EXISTS `pidr_rate_income`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pidr_rate_income` (
  `SessionId` varchar(16) DEFAULT NULL COMMENT '期次号',
  `CustomerID` varchar(60) NOT NULL COMMENT '客户编号',
  `Stage` varchar(1) NOT NULL COMMENT '期次',
  `FinStaYear` varchar(4) NOT NULL COMMENT '报表年份',
  `SheetType` varchar(2) NOT NULL COMMENT '报表类型',
  `SheetTypeDivide` varchar(1) NOT NULL COMMENT '报表类型细分',
  `RevenueOfSales` decimal(17,2) DEFAULT NULL COMMENT '一、营业收入',
  `CostOfSales` decimal(17,2) DEFAULT NULL COMMENT '减:营业成本',
  `BusinessAndOtherTaxes` decimal(17,2) DEFAULT NULL COMMENT '税金及附加',
  `SellingExpenses` decimal(17,2) DEFAULT NULL COMMENT '销售费用',
  `GenAndAdministrativeExpenses` decimal(17,2) DEFAULT NULL COMMENT '管理费用;GeneralAndAdministrativeExpenses',
  `RDExpenses` decimal(17,2) DEFAULT NULL COMMENT '研发费用',
  `FinancialExpense` decimal(17,2) DEFAULT NULL COMMENT '财务费用',
  `InterestFeeOfFinancialExpense` decimal(17,2) DEFAULT NULL COMMENT '其中:利息费用',
  `IntIncomeOfFinancialExpense` decimal(17,2) DEFAULT NULL COMMENT '利息收入;InterestIncomeOfFinancialExpense',
  `OtherIncome` decimal(17,2) DEFAULT NULL COMMENT '加:其他收益',
  `InvestmentIncome` decimal(17,2) DEFAULT NULL COMMENT '投资收益(损失以“-”号填列)',
  `AssociatesAndJointVenturesInc` decimal(17,2) DEFAULT NULL COMMENT '其中:对联营企业和合营企业的投资收益;AssociatesAndJointVenturesIncom',
  `FinancialAssetsEndIncome` decimal(17,2) DEFAULT NULL COMMENT '以摊余成本计量的金融资产终止确认收益(损失以“-”号填列)',
  `NetExposureHedgingIncome` decimal(17,2) DEFAULT NULL COMMENT '净敞口套期收益(损失以“-”号填列)',
  `IncomeFromChangesInFairValue` decimal(17,2) DEFAULT NULL COMMENT '公允价值变动收益(损失以“-”号填列)',
  `CreditImpairmentLoss` decimal(17,2) DEFAULT NULL COMMENT '信用减值损失(损失以“-”号填列)',
  `ImpairmentLossOfAssets` decimal(17,2) DEFAULT NULL COMMENT '资产减值损失(损失以“-”号填列)',
  `IncomeFromAssetDisposal` decimal(17,2) DEFAULT NULL COMMENT '资产处置收益(损失以“-”号填列)',
  `OperatingProfits` decimal(17,2) DEFAULT NULL COMMENT '二、营业利润(亏损以“-”号填列)',
  `NonOperatingIncome` decimal(17,2) DEFAULT NULL COMMENT '加:营业外收入',
  `NonOperatingExpenses` decimal(17,2) DEFAULT NULL COMMENT '减:营业外支出	',
  `ProfitBeforeTax` decimal(17,2) DEFAULT NULL COMMENT '三、利润总额(亏损总额以“-”号填列)',
  `IncomeTaxExpense` decimal(17,2) DEFAULT NULL COMMENT '减:所得税费用',
  `NetProfit` decimal(17,2) DEFAULT NULL COMMENT '四、净利润(净亏损以“-”号填列)',
  `OthComprehensiveIncomeAfterTax` decimal(17,2) DEFAULT NULL COMMENT '五、其他综合收益的税后净额;OtherComprehensiveIncomeAfterTax',
  `TotalComprehensiveIncome` decimal(17,2) DEFAULT NULL COMMENT '六、综合收益总额',
  `EarningsPerShare` decimal(17,2) DEFAULT NULL COMMENT '七、每股收益:',
  `BasicEarningsPerShare` decimal(17,2) DEFAULT NULL COMMENT '(一)基本每股收益',
  `DilutedEarningsPerShare` decimal(17,2) DEFAULT NULL COMMENT '(二)稀释每股收益',
  `ManagerOrgID` varchar(32) DEFAULT NULL COMMENT '管户机构编号',
  `ManagerUserID` varchar(32) DEFAULT NULL COMMENT '管户用户编号',
  `OperOrgID` varchar(32) DEFAULT NULL COMMENT '操作机构编号',
  `OperUserID` varchar(32) DEFAULT NULL COMMENT '操作用户编号',
  `OccurDate` varchar(10) DEFAULT NULL COMMENT '数据日期',
  `RecordFlag` varchar(1) DEFAULT NULL COMMENT '记录标志',
  `Extend1` varchar(30) DEFAULT NULL COMMENT '扩展字段1',
  `Extend2` varchar(30) DEFAULT NULL COMMENT '扩展字段2',
  `Extend3` varchar(30) DEFAULT NULL COMMENT '扩展字段3',
  PRIMARY KEY (`CustomerID`,`Stage`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='企业利润信息表段当期表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `pidr_rate_invabroinf`
--

DROP TABLE IF EXISTS `pidr_rate_invabroinf`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pidr_rate_invabroinf` (
  `SessionId` varchar(16) DEFAULT NULL COMMENT '期次号',
  `RelaId` varchar(60) NOT NULL COMMENT '关联编号',
  `CustomerId` varchar(60) NOT NULL COMMENT '客户编号',
  `InvEntName` varchar(160) DEFAULT NULL COMMENT '被投资企业名称',
  `InvEntIDType` varchar(2) DEFAULT NULL COMMENT '被投资企业身份标识类型',
  `InvEntIDNum` varchar(18) DEFAULT NULL COMMENT '被投资企业身份标识号码',
  `InvEntRegCap` decimal(17,2) DEFAULT NULL COMMENT '被投资企业注册资本',
  `InvEntEstablishDate` varchar(10) DEFAULT NULL COMMENT '被投资企业成立日期',
  `InvCurrency` varchar(3) DEFAULT NULL COMMENT '投资币种',
  `InvSubAmount` decimal(17,2) DEFAULT NULL COMMENT '投资认缴金额',
  `InvPaidAmount` decimal(17,2) DEFAULT NULL COMMENT '投资实缴金额',
  `ShareHoldRatio` decimal(5,2) DEFAULT NULL COMMENT '持股比例',
  `InvDate` varchar(10) DEFAULT NULL COMMENT '投资日期',
  `EffStatus` varchar(1) DEFAULT NULL COMMENT '有效标志',
  `RecordFlag` varchar(1) DEFAULT NULL COMMENT '记录标志',
  `OccurDate` varchar(10) DEFAULT NULL COMMENT '数据日期',
  `ManagerOrgID` varchar(32) DEFAULT NULL COMMENT '管户机构编号',
  `ManagerUserID` varchar(32) DEFAULT NULL COMMENT '管户用户编号',
  `OperOrgID` varchar(32) DEFAULT NULL COMMENT '操作机构编号',
  `OperUserID` varchar(32) DEFAULT NULL COMMENT '操作用户编号',
  `OperTime` varchar(19) DEFAULT NULL COMMENT '操作时间',
  `Extend1` varchar(30) DEFAULT NULL COMMENT '扩展字段1',
  `Extend2` varchar(30) DEFAULT NULL COMMENT '扩展字段2',
  `Extend3` varchar(30) DEFAULT NULL COMMENT '扩展字段3',
  PRIMARY KEY (`RelaId`,`CustomerId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='评级对外投资段当期表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `pidr_rate_legrepinf`
--

DROP TABLE IF EXISTS `pidr_rate_legrepinf`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pidr_rate_legrepinf` (
  `SessionId` varchar(16) DEFAULT NULL COMMENT '期次号',
  `CustomerId` varchar(60) NOT NULL COMMENT '客户编号',
  `LegRepName` varchar(60) DEFAULT NULL COMMENT '主要负责人名称',
  `LegRepIDType` varchar(2) DEFAULT NULL COMMENT '主要负责人身份标识类型',
  `LegRepIDNum` varchar(40) DEFAULT NULL COMMENT '主要负责人证件号码',
  `LegRepHouseAddStat` varchar(1) DEFAULT NULL COMMENT '主要负责人户籍情况',
  `LegRepEduLevel` varchar(2) DEFAULT NULL COMMENT '主要负责人学历',
  `LegRepWorkingYears` int(11) DEFAULT NULL COMMENT '主要负责人在本单位从业年限',
  `RecordFlag` varchar(1) DEFAULT NULL COMMENT '记录标志',
  `OccurDate` varchar(10) DEFAULT NULL COMMENT '数据日期',
  `ManagerOrgID` varchar(32) DEFAULT NULL COMMENT '管户机构编号',
  `ManagerUserID` varchar(32) DEFAULT NULL COMMENT '管户用户编号',
  `OperOrgID` varchar(32) DEFAULT NULL COMMENT '操作机构编号',
  `OperUserID` varchar(32) DEFAULT NULL COMMENT '操作用户编号',
  `OperTime` varchar(19) DEFAULT NULL COMMENT '操作时间',
  `Extend1` varchar(30) DEFAULT NULL COMMENT '扩展字段1',
  `Extend2` varchar(30) DEFAULT NULL COMMENT '扩展字段2',
  `Extend3` varchar(30) DEFAULT NULL COMMENT '扩展字段3',
  PRIMARY KEY (`CustomerId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='评级主要负责人段当期表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `pidr_rate_mnshahodinf`
--

DROP TABLE IF EXISTS `pidr_rate_mnshahodinf`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pidr_rate_mnshahodinf` (
  `SessionId` varchar(16) DEFAULT NULL COMMENT '期次号',
  `RelaId` varchar(60) NOT NULL COMMENT '关联编号',
  `CustomerId` varchar(60) NOT NULL COMMENT '客户编号',
  `SharHodType` varchar(2) DEFAULT NULL COMMENT '出资人类型',
  `SharHodCertType` varchar(1) DEFAULT NULL COMMENT '出资人身份类别',
  `SharHodName` varchar(160) DEFAULT NULL COMMENT '出资人名称',
  `SharHodIDType` varchar(2) DEFAULT NULL COMMENT '出资人身份标识类型',
  `SharHodIDNum` varchar(80) DEFAULT NULL COMMENT '出资人身份号码',
  `InvRatio` decimal(5,2) DEFAULT NULL COMMENT '出资比例',
  `EffStatus` varchar(1) DEFAULT NULL COMMENT '有效标志',
  `RecordFlag` varchar(1) DEFAULT NULL COMMENT '记录标志',
  `OccurDate` varchar(10) DEFAULT NULL COMMENT '数据日期',
  `ManagerOrgID` varchar(32) DEFAULT NULL COMMENT '管户机构编号',
  `ManagerUserID` varchar(32) DEFAULT NULL COMMENT '管户用户编号',
  `OperOrgID` varchar(32) DEFAULT NULL COMMENT '操作机构编号',
  `OperUserID` varchar(32) DEFAULT NULL COMMENT '操作用户编号',
  `OperTime` varchar(19) DEFAULT NULL COMMENT '操作时间',
  `Extend1` varchar(30) DEFAULT NULL COMMENT '扩展字段1',
  `Extend2` varchar(30) DEFAULT NULL COMMENT '扩展字段2',
  `Extend3` varchar(30) DEFAULT NULL COMMENT '扩展字段3',
  PRIMARY KEY (`RelaId`,`CustomerId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='评级注册资本及主要出资人段当期表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `pidr_rate_neginf`
--

DROP TABLE IF EXISTS `pidr_rate_neginf`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pidr_rate_neginf` (
  `SessionId` varchar(16) DEFAULT NULL COMMENT '期次号',
  `RelaId` varchar(60) NOT NULL COMMENT '关联编号',
  `CustomerId` varchar(60) NOT NULL COMMENT '客户编号',
  `NegInfType` varchar(2) DEFAULT NULL COMMENT '负面信息类型',
  `NegInfContent` varchar(800) DEFAULT NULL COMMENT '信息内容',
  `InvolvedAmount` decimal(17,2) DEFAULT NULL COMMENT '涉案金额',
  `NegInfDate` varchar(10) DEFAULT NULL COMMENT '信息发生(公示)时间',
  `NegInfValidity` varchar(10) DEFAULT NULL COMMENT '有效期',
  `NegInfIssOrg` varchar(80) DEFAULT NULL COMMENT '信息发布机构',
  `EffStatus` varchar(1) DEFAULT NULL COMMENT '有效标志',
  `RecordFlag` varchar(1) DEFAULT NULL COMMENT '记录标志',
  `OccurDate` varchar(10) DEFAULT NULL COMMENT '数据日期',
  `ManagerOrgID` varchar(32) DEFAULT NULL COMMENT '管户机构编号',
  `ManagerUserID` varchar(32) DEFAULT NULL COMMENT '管户用户编号',
  `OperOrgID` varchar(32) DEFAULT NULL COMMENT '操作机构编号',
  `OperUserID` varchar(32) DEFAULT NULL COMMENT '操作用户编号',
  `OperTime` varchar(19) DEFAULT NULL COMMENT '操作时间',
  `Extend1` varchar(30) DEFAULT NULL COMMENT '扩展字段1',
  `Extend2` varchar(30) DEFAULT NULL COMMENT '扩展字段2',
  `Extend3` varchar(30) DEFAULT NULL COMMENT '扩展字段3',
  PRIMARY KEY (`RelaId`,`CustomerId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='评级负面信息段当期表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `pidr_rate_regcap`
--

DROP TABLE IF EXISTS `pidr_rate_regcap`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pidr_rate_regcap` (
  `SessionId` varchar(16) DEFAULT NULL COMMENT '期次号',
  `CustomerId` varchar(60) NOT NULL COMMENT '客户编号',
  `RegCapCurrency` varchar(3) DEFAULT NULL COMMENT '注册资本币种',
  `RegCap` decimal(17,2) DEFAULT NULL COMMENT '注册资本',
  `RecordFlag` varchar(1) DEFAULT NULL COMMENT '记录标志',
  `OccurDate` varchar(10) DEFAULT NULL COMMENT '数据日期',
  `ManagerOrgID` varchar(32) DEFAULT NULL COMMENT '管户机构编号',
  `ManagerUserID` varchar(32) DEFAULT NULL COMMENT '管户用户编号',
  `OperOrgID` varchar(32) DEFAULT NULL COMMENT '操作机构编号',
  `OperUserID` varchar(32) DEFAULT NULL COMMENT '操作用户编号',
  `OperTime` varchar(19) DEFAULT NULL COMMENT '操作时间',
  `Extend1` varchar(30) DEFAULT NULL COMMENT '扩展字段1',
  `Extend2` varchar(30) DEFAULT NULL COMMENT '扩展字段2',
  `Extend3` varchar(30) DEFAULT NULL COMMENT '扩展字段3',
  PRIMARY KEY (`CustomerId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='评级信息注册资本当期表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `pidr_report_code`
--

DROP TABLE IF EXISTS `pidr_report_code`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pidr_report_code` (
  `REPORTCODE` varchar(20) NOT NULL COMMENT '报告编码',
  `REPORTTYPE` varchar(20) NOT NULL COMMENT '报告类型',
  `ISINUSE` varchar(1) DEFAULT NULL COMMENT '是否有效',
  PRIMARY KEY (`REPORTCODE`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `pidr_reportlogs`
--

DROP TABLE IF EXISTS `pidr_reportlogs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pidr_reportlogs` (
  `RLOGNO` varchar(128) NOT NULL COMMENT '内部编号',
  `VCHANNEL` varchar(10) NOT NULL COMMENT '来源',
  `SESSIONID` varchar(16) DEFAULT NULL COMMENT '报文期次',
  `REPORTTOTAL` decimal(7,0) DEFAULT NULL COMMENT '数量',
  `STARTTIME` varchar(20) DEFAULT NULL COMMENT '开始时间',
  `ENDTIME` varchar(20) DEFAULT NULL COMMENT '结束时间',
  `OPERATOR` varchar(20) DEFAULT NULL COMMENT '操作用户',
  `OPERORGID` varchar(20) DEFAULT NULL COMMENT '操作机构',
  `OCCURDATE` varchar(10) DEFAULT NULL COMMENT '数据日期',
  PRIMARY KEY (`RLOGNO`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='报文生成日志表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `pidr_session`
--

DROP TABLE IF EXISTS `pidr_session`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pidr_session` (
  `SESSIONID` varchar(16) NOT NULL COMMENT '会话编号',
  `STATUS` varchar(5) DEFAULT NULL COMMENT '报文状态',
  `MESSAGEFILECLASS` varchar(3) DEFAULT NULL COMMENT '报文文件种类',
  `CREATETIME` varchar(20) DEFAULT NULL COMMENT '创建时间',
  `MNGMTORGCODE` varchar(14) DEFAULT NULL COMMENT '业务管理金融机构代码',
  `REPORTFILENAME` varchar(350) DEFAULT NULL COMMENT '报文文件名称',
  `FILEPATH` varchar(800) DEFAULT NULL COMMENT '报文文件路径',
  `FEEDBACKFILENAME` varchar(35) DEFAULT NULL COMMENT '反馈报文文件名称',
  `FEEDBACKSTATUS` varchar(2) DEFAULT NULL COMMENT '反馈状态',
  `OPERATOR` varchar(20) DEFAULT NULL COMMENT '操作用户',
  `OPERORGID` varchar(20) DEFAULT NULL COMMENT '操作机构',
  `ENDTIME` varchar(20) DEFAULT NULL COMMENT '结束日期',
  `OCCURDATE` varchar(10) DEFAULT NULL COMMENT '数据日期',
  `FeedbackError` int(11) DEFAULT NULL COMMENT '反馈错误数量',
  PRIMARY KEY (`SESSIONID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='会话表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `pidr_transferfilter`
--

DROP TABLE IF EXISTS `pidr_transferfilter`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pidr_transferfilter` (
  `BUSIIDSERIALNO` varchar(60) NOT NULL COMMENT '业务标识号',
  `RECORDSCOPE` varchar(22) DEFAULT NULL COMMENT '过滤范围',
  `FILTERCAUSE` varchar(200) NOT NULL COMMENT '过滤原因',
  `OCCURDATE` varchar(10) DEFAULT NULL COMMENT '数据日期',
  `REMARK` varchar(250) DEFAULT NULL COMMENT '备注',
  `ITCBUSITYPE` varchar(10) NOT NULL COMMENT '拦截类型',
  PRIMARY KEY (`BUSIIDSERIALNO`,`FILTERCAUSE`,`ITCBUSITYPE`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='数据过滤表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `pidr_validate_library`
--

DROP TABLE IF EXISTS `pidr_validate_library`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pidr_validate_library` (
  `RULENO` varchar(20) NOT NULL COMMENT '规则编号',
  `INFRECTYPE` varchar(3) NOT NULL COMMENT '信息记录类型/报文类型',
  `RULESQL` varchar(2000) DEFAULT NULL COMMENT '规则语句',
  `STATUS` varchar(2) DEFAULT NULL COMMENT '状态',
  `INPUTDATE` varchar(10) DEFAULT NULL COMMENT '登记日期',
  `UPDATEDATE` varchar(10) DEFAULT NULL COMMENT '更新日期',
  `EXTEND1` varchar(30) DEFAULT NULL COMMENT '扩展字段1',
  `EXTEND2` varchar(30) DEFAULT NULL COMMENT '扩展字段2',
  `EXTEND3` varchar(30) DEFAULT NULL COMMENT '扩展字段3',
  PRIMARY KEY (`RULENO`,`INFRECTYPE`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='校验规则配置表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `pidr_validateerrors`
--

DROP TABLE IF EXISTS `pidr_validateerrors`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pidr_validateerrors` (
  `ERRNO` varchar(128) NOT NULL COMMENT '错误编号',
  `BUSIIDSERIALNO` varchar(200) DEFAULT NULL COMMENT '业务标识号',
  `BSBUSIIDSERIALNO` varchar(200) DEFAULT NULL COMMENT '基础段业务标识号',
  `INFRECTYPE` varchar(3) DEFAULT NULL COMMENT '信息记录类型/报文类型',
  `VALIDATELEVEL` varchar(1) DEFAULT NULL COMMENT '校验级别',
  `ERRCODE` varchar(40) DEFAULT NULL COMMENT '错误代码',
  `ERRMSG` varchar(900) DEFAULT NULL COMMENT '错误信息',
  `ERRTABLE` varchar(120) DEFAULT NULL COMMENT '错误表名',
  `ERRTABLENAME` varchar(100) DEFAULT NULL COMMENT '错误表中文名',
  `ERRFIELD` varchar(500) DEFAULT NULL COMMENT '错误字段',
  `ERRFIELDNAME` varchar(120) DEFAULT NULL COMMENT '错误字段中文名',
  `ERRFIELDVALUE` varchar(100) DEFAULT NULL COMMENT '错误字段值',
  `RULENO` varchar(20) DEFAULT NULL COMMENT '规则编号',
  `OPERATOR` varchar(20) DEFAULT NULL COMMENT '操作用户',
  `OPERORGID` varchar(20) DEFAULT NULL COMMENT '操作机构',
  `OCCURDATE` varchar(10) DEFAULT NULL COMMENT '数据日期',
  PRIMARY KEY (`ERRNO`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='校验错误表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `pidr_whitelist`
--

DROP TABLE IF EXISTS `pidr_whitelist`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pidr_whitelist` (
  `CustomerID` varchar(60) NOT NULL COMMENT '客户编号',
  `EntName` varchar(160) DEFAULT NULL COMMENT '企业名称',
  `EntCertType` varchar(2) DEFAULT NULL COMMENT '企业身份标识类型',
  `EntCertNum` varchar(18) DEFAULT NULL COMMENT '企业身份标识号码',
  `PIDREvalScore` decimal(6,2) DEFAULT NULL COMMENT '系统评估得分',
  `PBCEvalScore` varchar(6) DEFAULT NULL COMMENT '人行评估得分',
  `RunStatus` varchar(2) DEFAULT NULL COMMENT '执行状态',
  `RunTime` varchar(20) DEFAULT NULL COMMENT '执行时间',
  PRIMARY KEY (`CustomerID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='央评白名单数据表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `process_inst`
--

DROP TABLE IF EXISTS `process_inst`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `process_inst` (
  `SERIALNO` varchar(32) NOT NULL,
  `OBJECTTYPE` varchar(18) DEFAULT NULL,
  `OBJECTNO` varchar(32) DEFAULT NULL,
  `PHASETYPE` varchar(18) DEFAULT NULL,
  `APPLYTYPE` varchar(18) DEFAULT NULL,
  `FLOWNO` varchar(32) DEFAULT NULL,
  `FLOWNAME` varchar(80) DEFAULT NULL,
  `PHASENO` varchar(32) DEFAULT NULL,
  `PHASENAME` varchar(80) DEFAULT NULL,
  `OBJDESCRIBE` varchar(250) DEFAULT NULL,
  `OBJATTRIBUTE1` varchar(80) DEFAULT NULL,
  `OBJATTRIBUTE2` varchar(80) DEFAULT NULL,
  `OBJATTRIBUTE3` varchar(80) DEFAULT NULL,
  `OBJATTRIBUTE4` varchar(80) DEFAULT NULL,
  `OBJATTRIBUTE5` varchar(80) DEFAULT NULL,
  `ORGID` varchar(32) DEFAULT NULL,
  `ORGNAME` varchar(80) DEFAULT NULL,
  `USERID` varchar(32) DEFAULT NULL,
  `USERNAME` varchar(80) DEFAULT NULL,
  `INPUTDATE` varchar(20) DEFAULT NULL,
  `ARCHIVETIME` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`SERIALNO`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='流程实例表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `process_workitem`
--

DROP TABLE IF EXISTS `process_workitem`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `process_workitem` (
  `SERIALNO` varchar(32) NOT NULL,
  `OBJECTNO` varchar(32) DEFAULT NULL,
  `OBJECTTYPE` varchar(18) DEFAULT NULL,
  `RELATIVESERIALNO` varchar(32) DEFAULT NULL,
  `FLOWNO` varchar(32) DEFAULT NULL,
  `FLOWNAME` varchar(80) DEFAULT NULL,
  `PHASENO` varchar(32) DEFAULT NULL,
  `PHASENAME` varchar(80) DEFAULT NULL,
  `PHASETYPE` varchar(18) DEFAULT NULL,
  `APPLYTYPE` varchar(18) DEFAULT NULL,
  `USERID` varchar(32) DEFAULT NULL,
  `USERNAME` varchar(80) DEFAULT NULL,
  `ORGID` varchar(32) DEFAULT NULL,
  `ORGNAME` varchar(80) DEFAULT NULL,
  `BEGINTIME` varchar(20) DEFAULT NULL,
  `ENDTIME` varchar(20) DEFAULT NULL,
  `PHASECHOICE` varchar(80) DEFAULT NULL,
  `PHASEACTION` varchar(250) DEFAULT NULL,
  `PHASEOPINION` varchar(1600) DEFAULT NULL,
  `PHASEOPINION1` varchar(250) DEFAULT NULL,
  `PHASEOPINION2` varchar(250) DEFAULT NULL,
  `PHASEOPINION3` varchar(250) DEFAULT NULL,
  `PHASEOPINION4` varchar(250) DEFAULT NULL,
  `CHECKLISTRESULT` varchar(80) DEFAULT NULL,
  `AUTODECISION` varchar(80) DEFAULT NULL,
  `RISKSCANRESULT` varchar(80) DEFAULT NULL,
  `STANDARDTIME1` varchar(32) DEFAULT NULL,
  `STANDARDTIME2` varchar(32) DEFAULT NULL,
  `COSTLOB` varchar(32) DEFAULT NULL,
  `CLIENTX` int(11) DEFAULT NULL,
  `CLIENTY` int(11) DEFAULT NULL,
  `WIDTH` int(11) DEFAULT NULL,
  `HEIGTH` int(11) DEFAULT NULL,
  `GROUPINFO` varchar(1000) DEFAULT NULL,
  `PROCESSINSTNO` varchar(32) DEFAULT NULL,
  `RELATIVEDATA` varchar(1000) DEFAULT NULL,
  PRIMARY KEY (`SERIALNO`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='流程工作项表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `report_catalog`
--

DROP TABLE IF EXISTS `report_catalog`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `report_catalog` (
  `MODELNO` varchar(32) NOT NULL COMMENT '模型编号',
  `MODELNAME` varchar(80) DEFAULT NULL COMMENT '模型名称',
  `MODELTYPE` varchar(18) DEFAULT NULL COMMENT '模型类型',
  `MODELDESCRIBE` varchar(250) DEFAULT NULL COMMENT '模型描述',
  `MODELABBR` varchar(80) DEFAULT NULL COMMENT '模型缩写',
  `MODELCLASS` varchar(18) DEFAULT NULL COMMENT '模型分类',
  `ATTRIBUTE1` varchar(18) DEFAULT NULL COMMENT '模型属性1',
  `ATTRIBUTE2` varchar(18) DEFAULT NULL COMMENT '模型属性2',
  `DISPLAYMETHOD` varchar(250) DEFAULT NULL COMMENT '显示方法',
  `HEADERMETHOD` varchar(250) DEFAULT NULL COMMENT '表头描述',
  `DELETEFLAG` varchar(1) DEFAULT NULL COMMENT '删除标志',
  `REMARK` varchar(250) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`MODELNO`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='财务报表模型目录';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `report_data`
--

DROP TABLE IF EXISTS `report_data`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `report_data` (
  `REPORTNO` varchar(32) NOT NULL COMMENT '报表编号',
  `ROWNO` varchar(32) NOT NULL COMMENT '行编号',
  `ROWNAME` varchar(80) DEFAULT NULL COMMENT '行名称',
  `ROWSUBJECT` varchar(32) DEFAULT NULL COMMENT '对应科目',
  `DISPLAYORDER` varchar(32) DEFAULT NULL COMMENT '显示次序',
  `ROWDIMTYPE` varchar(18) DEFAULT NULL COMMENT '行量纲类型',
  `ROWATTRIBUTE` varchar(250) DEFAULT NULL COMMENT '行属性',
  `COL1VALUE` decimal(24,6) DEFAULT NULL COMMENT '列1值',
  `COL2VALUE` decimal(24,6) DEFAULT NULL COMMENT '列2值',
  `COL3VALUE` decimal(24,6) DEFAULT NULL COMMENT '列3值',
  `COL4VALUE` decimal(24,6) DEFAULT NULL COMMENT '列4值',
  `STANDARDVALUE` decimal(24,6) DEFAULT NULL COMMENT '标准值',
  PRIMARY KEY (`REPORTNO`,`ROWNO`),
  KEY `IDX1_REPORT_DATA` (`REPORTNO`,`ROWSUBJECT`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='财务报表数据';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `report_model`
--

DROP TABLE IF EXISTS `report_model`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `report_model` (
  `MODELNO` varchar(32) NOT NULL COMMENT '模型编号',
  `ROWNO` varchar(32) NOT NULL COMMENT '行编号',
  `ROWNAME` varchar(80) DEFAULT NULL COMMENT '财务项目名称',
  `ROWSUBJECT` varchar(32) DEFAULT NULL COMMENT '对应科目',
  `DISPLAYORDER` varchar(32) DEFAULT NULL COMMENT '显示次序',
  `ROWDIMTYPE` varchar(18) DEFAULT NULL COMMENT '行量纲类型',
  `ROWATTRIBUTE` varchar(250) DEFAULT NULL COMMENT '行属性',
  `COL1DEF` varchar(2000) DEFAULT NULL COMMENT '数据项1定义',
  `COL2DEF` varchar(2000) DEFAULT NULL COMMENT '数据项2定义',
  `COL3DEF` varchar(2000) DEFAULT NULL COMMENT '数据项3定义',
  `COL4DEF` varchar(2000) DEFAULT NULL COMMENT '数据项4定义',
  `STANDARDVALUE` decimal(24,6) DEFAULT NULL COMMENT '标准值',
  `DELETEFLAG` varchar(1) DEFAULT NULL COMMENT '删除标志',
  `FORMULAEXP1` varchar(2000) DEFAULT NULL COMMENT '公式解释1',
  `FORMULAEXP2` varchar(2000) DEFAULT NULL COMMENT '公式解释2',
  PRIMARY KEY (`MODELNO`,`ROWNO`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='财务报表模型';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `report_record`
--

DROP TABLE IF EXISTS `report_record`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `report_record` (
  `REPORTNO` varchar(32) NOT NULL COMMENT '报表编号',
  `OBJECTTYPE` varchar(18) DEFAULT NULL COMMENT '关联对象类型',
  `OBJECTNO` varchar(32) DEFAULT NULL COMMENT '关联对象编号',
  `REPORTSCOPE` varchar(18) DEFAULT NULL COMMENT '报表口径',
  `MODELNO` varchar(32) DEFAULT NULL COMMENT '模型编号',
  `REPORTNAME` varchar(80) DEFAULT NULL COMMENT '报表名称',
  `REPORTDATE` varchar(10) DEFAULT NULL COMMENT '报表日期',
  `INPUTTIME` varchar(20) DEFAULT NULL COMMENT '创建时间',
  `ORGID` varchar(32) DEFAULT NULL COMMENT '创建机构',
  `USERID` varchar(32) DEFAULT NULL COMMENT '创建人',
  `UPDATETIME` varchar(20) DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`REPORTNO`),
  KEY `IDX1_REPORT_RECORD` (`OBJECTNO`),
  KEY `IDX2_REPORT_RECORD` (`MODELNO`),
  KEY `IDX3_REPORT_RECORD` (`REPORTDATE`),
  KEY `IDX4_REPORT_RECORD` (`OBJECTTYPE`,`OBJECTNO`,`MODELNO`,`REPORTDATE`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='财务报表记录';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `report_serialno`
--

DROP TABLE IF EXISTS `report_serialno`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `report_serialno` (
  `REPORTCODE` varchar(3) DEFAULT NULL COMMENT '报文种类',
  `TABLENAME` varchar(100) DEFAULT NULL COMMENT '表名',
  `COLUMNNAME` varchar(50) DEFAULT NULL COMMENT '列名'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `role_info`
--

DROP TABLE IF EXISTS `role_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `role_info` (
  `ROLEID` varchar(32) NOT NULL COMMENT '角色编号',
  `SORTNO` varchar(32) DEFAULT NULL COMMENT '排序号',
  `ROLENAME` varchar(80) DEFAULT NULL COMMENT '角色名称',
  `ROLEATTRIBUTE` varchar(80) DEFAULT NULL COMMENT '角色属性',
  `ROLEDESCRIBE` varchar(250) DEFAULT NULL COMMENT '角色描述',
  `ROLESTATUS` varchar(80) DEFAULT NULL COMMENT '角色状态',
  `INPUTUSER` varchar(32) DEFAULT NULL COMMENT '录入人',
  `INPUTORG` varchar(32) DEFAULT NULL COMMENT '录入机构',
  `INPUTTIME` varchar(20) DEFAULT NULL COMMENT '录入时间',
  `UPDATEUSER` varchar(32) DEFAULT NULL COMMENT '更新人',
  `UPDATETIME` varchar(20) DEFAULT NULL COMMENT '更新时间',
  `REMARK` varchar(250) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`ROLEID`),
  KEY `IDX1_ROLE_INFO` (`SORTNO`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='角色表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `scenario_args`
--

DROP TABLE IF EXISTS `scenario_args`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `scenario_args` (
  `SCENARIOID` varchar(32) NOT NULL COMMENT '场景流水号',
  `ALARMARGID` varchar(32) NOT NULL COMMENT '预警参数ID',
  `SORTNO` varchar(10) DEFAULT NULL COMMENT '排序号',
  `ARGSSTRING` varchar(1000) DEFAULT NULL COMMENT '参数字串',
  `QUERYSQL` varchar(1000) DEFAULT NULL COMMENT '查询SQL',
  `STATUS` varchar(1) DEFAULT NULL COMMENT '是否有效',
  `INPUTUSER` varchar(32) DEFAULT NULL COMMENT '登记人',
  `INPUTORG` varchar(32) DEFAULT NULL COMMENT '登记机构',
  `INPUTTIME` varchar(20) DEFAULT NULL COMMENT '登记时间',
  `UPDATEUSER` varchar(32) DEFAULT NULL COMMENT '更新人',
  `UPDATETIME` varchar(20) DEFAULT NULL COMMENT '更新时间',
  `REMARK` varchar(250) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`SCENARIOID`,`ALARMARGID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='预警参数表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `scenario_catalog`
--

DROP TABLE IF EXISTS `scenario_catalog`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `scenario_catalog` (
  `SCENARIOID` varchar(32) NOT NULL COMMENT '场景编号',
  `SCENARIONAME` varchar(80) NOT NULL COMMENT '场景名称',
  `SCENARIODESCRIBE` varchar(250) DEFAULT NULL COMMENT '场景描述',
  `DEFAULTSUBTYPENO` varchar(20) DEFAULT NULL COMMENT '默认子类型编号',
  `INITIATECLASS` varchar(250) DEFAULT NULL COMMENT '初始化执行类',
  `INPUTUSER` varchar(32) DEFAULT NULL COMMENT '登记人',
  `INPUTORG` varchar(32) DEFAULT NULL COMMENT '登记机构',
  `INPUTTIME` varchar(20) DEFAULT NULL COMMENT '登记时间',
  `UPDATEUSER` varchar(32) DEFAULT NULL COMMENT '更新人',
  `UPDATETIME` varchar(20) DEFAULT NULL COMMENT '更新时间',
  `REMARK` varchar(250) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`SCENARIOID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='预警场景定义表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `scenario_group`
--

DROP TABLE IF EXISTS `scenario_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `scenario_group` (
  `SCENARIOID` varchar(32) NOT NULL COMMENT '场景号',
  `GROUPID` varchar(32) NOT NULL COMMENT '分组号',
  `SORTNO` varchar(10) DEFAULT NULL COMMENT '排序号',
  `GROUPNAME` varchar(1000) NOT NULL COMMENT '分组名称',
  `REMARK` varchar(1000) DEFAULT NULL COMMENT '备注',
  `INPUTUSER` varchar(32) DEFAULT NULL COMMENT '登记人',
  `INPUTORG` varchar(32) DEFAULT NULL COMMENT '登记机构',
  `INPUTTIME` varchar(20) DEFAULT NULL COMMENT '登记时间',
  `UPDATEUSER` varchar(32) DEFAULT NULL COMMENT '更新人',
  `UPDATETIME` varchar(20) DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`SCENARIOID`,`GROUPID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='预警模型分组';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `scenario_model`
--

DROP TABLE IF EXISTS `scenario_model`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `scenario_model` (
  `SCENARIOID` varchar(32) NOT NULL COMMENT '场景流水号',
  `MODELID` varchar(32) NOT NULL COMMENT '模型编号',
  `SORTNO` varchar(10) DEFAULT NULL COMMENT '排序号',
  `MODELNAME` varchar(250) NOT NULL COMMENT '模型名',
  `MODELDESCRIBE` varchar(1600) DEFAULT NULL COMMENT '模型详细描述',
  `MODELTYPE` varchar(20) NOT NULL COMMENT '模型类型',
  `SUBTYPENO` varchar(20) DEFAULT NULL COMMENT '子类型',
  `RUNCONDITION` varchar(250) DEFAULT NULL COMMENT '运行条件',
  `STATUS` varchar(1) DEFAULT NULL COMMENT '是否有效',
  `GROUPID` varchar(32) DEFAULT NULL COMMENT '分组号',
  `MODELKIND` varchar(32) DEFAULT NULL COMMENT '检查类型',
  `NOPASSDEAL` varchar(18) DEFAULT NULL COMMENT '检查未通过后的处理方法',
  `PASSDEAL` varchar(18) DEFAULT NULL COMMENT '检查通过后的处理方法',
  `PASSMESSAGE` varchar(1000) DEFAULT NULL COMMENT '检查通过后提示消息',
  `NOPASSMESSAGE` varchar(1000) DEFAULT NULL COMMENT '检查未通过后提示消息',
  `EXECUTESCRIPT` varchar(2000) DEFAULT NULL COMMENT '执行脚本',
  `BIZVIEWER` varchar(200) DEFAULT NULL COMMENT '业务查看',
  `REMARK` varchar(250) DEFAULT NULL COMMENT '备注',
  `INPUTUSER` varchar(32) DEFAULT NULL COMMENT '登记人',
  `INPUTORG` varchar(32) DEFAULT NULL COMMENT '登记机构',
  `INPUTTIME` varchar(20) DEFAULT NULL COMMENT '登记时间',
  `UPDATEUSER` varchar(32) DEFAULT NULL COMMENT '更新人',
  `UPDATETIME` varchar(20) DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`SCENARIOID`,`MODELID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='预警模型';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `scenario_relative`
--

DROP TABLE IF EXISTS `scenario_relative`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `scenario_relative` (
  `SCENARIOID` varchar(32) NOT NULL COMMENT '场景号',
  `GROUPID` varchar(32) NOT NULL COMMENT '分组号',
  `MODELID` varchar(32) NOT NULL COMMENT '模型编号',
  PRIMARY KEY (`SCENARIOID`,`GROUPID`,`MODELID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='预警分组模型关联表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `security_audit`
--

DROP TABLE IF EXISTS `security_audit`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `security_audit` (
  `CODETYPE` varchar(32) DEFAULT NULL COMMENT '规则类型',
  `ITEMNO` varchar(32) NOT NULL COMMENT '规则编号',
  `ITEMNAME` varchar(250) DEFAULT NULL COMMENT '规则名称',
  `ITEMVALUE` varchar(32) DEFAULT NULL COMMENT '规则值',
  `ISINUSE` varchar(1) DEFAULT NULL COMMENT '规则状态',
  PRIMARY KEY (`ITEMNO`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='安全审计规则';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `select_catalog`
--

DROP TABLE IF EXISTS `select_catalog`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `select_catalog` (
  `SELNAME` varchar(80) NOT NULL COMMENT '查询名称',
  `SELTYPE` varchar(18) DEFAULT NULL COMMENT '查询类型',
  `SELDESCRIBE` varchar(100) DEFAULT NULL COMMENT '查询说明',
  `SELTABLENAME` varchar(32) DEFAULT NULL COMMENT '查询表名',
  `SELPRIMARYKEY` varchar(80) DEFAULT NULL COMMENT '主键',
  `SELBROWSEMODE` varchar(18) DEFAULT NULL COMMENT '展现方式',
  `SELARGS` varchar(400) DEFAULT NULL COMMENT '参数',
  `SELHIDEFIELD` varchar(400) DEFAULT NULL COMMENT 'ID字段',
  `SELCODE` varchar(800) DEFAULT NULL COMMENT 'Name字段',
  `SELFIELDNAME` varchar(400) DEFAULT NULL COMMENT 'Value字段',
  `SELFIELDDISP` varchar(400) DEFAULT NULL COMMENT 'From子句',
  `SELRETURNVALUE` varchar(400) DEFAULT NULL COMMENT '返回域',
  `SELFILTERFIELD` varchar(400) DEFAULT NULL COMMENT 'OrdeBy子句',
  `ISINUSE` varchar(1) DEFAULT NULL COMMENT '是否有效',
  `MUTILORSINGLE` varchar(18) DEFAULT NULL COMMENT '选择模式',
  `ATTRIBUTE1` varchar(200) DEFAULT NULL COMMENT '展开节点值',
  `ATTRIBUTE2` varchar(200) DEFAULT NULL COMMENT '页节点是否可选',
  `ATTRIBUTE3` varchar(200) DEFAULT NULL COMMENT '属性3',
  `ATTRIBUTE4` varchar(200) DEFAULT NULL COMMENT '属性4',
  `ATTRIBUTE5` varchar(200) DEFAULT NULL COMMENT '属性5',
  `INPUTUSER` varchar(32) DEFAULT NULL COMMENT '登记人员',
  `INPUTORG` varchar(32) DEFAULT NULL COMMENT '登记机构',
  `INPUTTIME` varchar(20) DEFAULT NULL COMMENT '登记时间',
  `UPDATEUSER` varchar(32) DEFAULT NULL COMMENT '更新人',
  `UPDATETIME` varchar(20) DEFAULT NULL COMMENT '更新时间',
  `REMARK` varchar(250) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`SELNAME`),
  KEY `IDX1_SELECT_CATA` (`ISINUSE`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='选择对话框设置';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `system_log`
--

DROP TABLE IF EXISTS `system_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `system_log` (
  `SERIALNO` varchar(32) NOT NULL COMMENT '流水号',
  `OCCURTIME` varchar(20) DEFAULT NULL COMMENT '发生时间',
  `ORGID` varchar(32) DEFAULT NULL COMMENT '机构号',
  `USERID` varchar(32) DEFAULT NULL COMMENT '用户号',
  `EVENTTYPE` varchar(18) DEFAULT NULL COMMENT '事件类型',
  `EVENTDESCRIBE` varchar(250) DEFAULT NULL COMMENT '事件描述',
  `ORGNAME` varchar(80) DEFAULT NULL COMMENT '机构名称',
  `USERNAME` varchar(80) DEFAULT NULL COMMENT '用户名称',
  PRIMARY KEY (`SERIALNO`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='系统日志';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `task_job_dispatch`
--

DROP TABLE IF EXISTS `task_job_dispatch`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `task_job_dispatch` (
  `JobName` varchar(40) NOT NULL,
  `Status` varchar(1) NOT NULL,
  `DispatcherIp` varchar(40) NOT NULL,
  `BizDate` date DEFAULT NULL,
  `BeginTime` datetime DEFAULT NULL,
  `EndTime` datetime DEFAULT NULL,
  PRIMARY KEY (`JobName`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `task_job_group`
--

DROP TABLE IF EXISTS `task_job_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `task_job_group` (
  `JobName` varchar(40) NOT NULL,
  `GroupNo` varchar(40) NOT NULL,
  `Status` char(1) NOT NULL,
  `JobTag` varchar(40) DEFAULT NULL,
  `GroupContent` varchar(800) DEFAULT NULL,
  `ConsumerIP` varchar(40) DEFAULT NULL,
  `ErrorMessage` varchar(200) DEFAULT NULL,
  `BeginTime` datetime DEFAULT NULL,
  `EndTime` datetime DEFAULT NULL,
  `RetryCount` int(11) DEFAULT NULL,
  PRIMARY KEY (`JobName`,`GroupNo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `task_run_history`
--

DROP TABLE IF EXISTS `task_run_history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `task_run_history` (
  `SERIALNO` varchar(30) NOT NULL COMMENT '流水号',
  `STATUSTYPE` varchar(8) DEFAULT NULL COMMENT '执行主体',
  `TASKNAME` varchar(80) DEFAULT NULL COMMENT '任务名称',
  `TASKDESCRIBE` varchar(400) DEFAULT NULL COMMENT '任务描述',
  `UNITNAME` varchar(80) DEFAULT NULL COMMENT '单元名称',
  `UNITDESCRIBE` varchar(400) DEFAULT NULL COMMENT '单元描述',
  `STATUS` varchar(2) DEFAULT NULL COMMENT '运行状态',
  `INPUTDATE` varchar(32) DEFAULT NULL COMMENT '记录日期',
  `BEGINTIME` varchar(32) DEFAULT NULL COMMENT '开始时间',
  `ENDTIME` varchar(32) DEFAULT NULL COMMENT '结束时间',
  PRIMARY KEY (`SERIALNO`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='批量监听历史记录表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `task_run_interact`
--

DROP TABLE IF EXISTS `task_run_interact`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `task_run_interact` (
  `TASKNAME` varchar(80) NOT NULL COMMENT '任务名称',
  `UNITNAME` varchar(80) DEFAULT NULL COMMENT '单元名称',
  `INTERACTTYPE` varchar(10) NOT NULL COMMENT '干预类型',
  `ISINUSE` varchar(1) NOT NULL COMMENT '是否启用',
  PRIMARY KEY (`TASKNAME`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='批量干预记录表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `task_run_status`
--

DROP TABLE IF EXISTS `task_run_status`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `task_run_status` (
  `SERIALNO` varchar(30) NOT NULL COMMENT '流水号',
  `STATUSTYPE` varchar(8) DEFAULT NULL COMMENT '执行主体',
  `TASKNAME` varchar(80) DEFAULT NULL COMMENT '任务名称',
  `TASKDESCRIBE` varchar(400) DEFAULT NULL COMMENT '任务描述',
  `UNITNAME` varchar(80) DEFAULT NULL COMMENT '单元名称',
  `UNITDESCRIBE` varchar(400) DEFAULT NULL COMMENT '单元描述',
  `STATUS` varchar(2) DEFAULT NULL COMMENT '运行状态',
  `EXECUTESTATUS` decimal(8,0) DEFAULT NULL COMMENT '单元实际返回状态',
  `BEGINTIME` varchar(32) DEFAULT NULL COMMENT '开始时间',
  `ENDTIME` varchar(32) DEFAULT NULL COMMENT '结束时间',
  PRIMARY KEY (`SERIALNO`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='批量监听记录表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `timediff_info`
--

DROP TABLE IF EXISTS `timediff_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `timediff_info` (
  `TIMEDIFFID` varchar(40) NOT NULL COMMENT '时差编号',
  `TIMEDIFFNAME` varchar(80) DEFAULT NULL COMMENT '时差名称',
  `TIMEZONE` varchar(10) DEFAULT NULL COMMENT '时区',
  `DST` varchar(1) DEFAULT NULL COMMENT '是否启用夏令时(Daylight Saving Time)',
  `DSTSTARTDATE` varchar(32) DEFAULT NULL COMMENT '夏令时开始时间',
  `DSTENDDATE` varchar(32) DEFAULT NULL COMMENT '夏令时结束时间',
  `DSTADJUSTMINS` decimal(4,0) DEFAULT NULL COMMENT '夏令时调整分钟数,存在正负值',
  `TIMEDIFFERENCE` decimal(4,0) DEFAULT NULL COMMENT '时差',
  `REMARK` varchar(250) DEFAULT NULL COMMENT '备注',
  `STATUS` varchar(1) DEFAULT NULL COMMENT '状态',
  `INPUTUSER` varchar(32) DEFAULT NULL COMMENT '创建人员',
  `INPUTTIME` varchar(20) DEFAULT NULL COMMENT '创建时间',
  `UPDATEUSER` varchar(32) DEFAULT NULL COMMENT '更新人',
  `UPDATETIME` varchar(20) DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`TIMEDIFFID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='时差信息表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `user_bookmark`
--

DROP TABLE IF EXISTS `user_bookmark`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_bookmark` (
  `SERIALNO` varchar(32) NOT NULL COMMENT '编号',
  `USERID` varchar(32) DEFAULT NULL COMMENT '服务用户',
  `BOOKMARKNAME` varchar(80) DEFAULT NULL COMMENT '书签名称',
  `BOOKMARKURL` varchar(1000) DEFAULT NULL COMMENT '书签URL',
  `REMARK` varchar(200) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`SERIALNO`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='书签收藏';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `user_failedlist`
--

DROP TABLE IF EXISTS `user_failedlist`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_failedlist` (
  `LISTID` varchar(32) NOT NULL COMMENT '编号',
  `LOGONTIME` varchar(20) DEFAULT NULL COMMENT '登陆失败时间',
  `USERID` varchar(32) DEFAULT NULL COMMENT '用户ID',
  `USERNAME` varchar(32) DEFAULT NULL COMMENT '用户名称',
  `REMOTEADDR` varchar(18) DEFAULT NULL COMMENT '登陆地址',
  `REMOTEHOST` varchar(80) DEFAULT NULL COMMENT '登陆主机',
  `SERVERNAME` varchar(80) DEFAULT NULL COMMENT '服务名称',
  `SERVERPORT` varchar(10) DEFAULT NULL COMMENT '服务端口',
  `ERRORMESSAGE` varchar(200) DEFAULT NULL COMMENT '错误提示信息',
  PRIMARY KEY (`LISTID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用户登录失败列表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `user_info`
--

DROP TABLE IF EXISTS `user_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_info` (
  `USERID` varchar(32) NOT NULL COMMENT '用户编号',
  `LOGINID` varchar(32) DEFAULT NULL COMMENT '登录编号',
  `USERNAME` varchar(32) DEFAULT NULL COMMENT '用户姓名',
  `PASSWORD` varchar(32) DEFAULT NULL COMMENT '登录密码',
  `BELONGORG` varchar(32) DEFAULT NULL COMMENT '所属机构',
  `ATTRIBUTE1` varchar(80) DEFAULT NULL COMMENT '属性1',
  `ATTRIBUTE2` varchar(80) DEFAULT NULL COMMENT '属性2',
  `ATTRIBUTE3` varchar(80) DEFAULT NULL COMMENT '属性3',
  `ATTRIBUTE4` varchar(80) DEFAULT NULL COMMENT '属性4',
  `ATTRIBUTE5` varchar(80) DEFAULT NULL COMMENT '属性5',
  `ATTRIBUTE6` varchar(80) DEFAULT NULL COMMENT '属性6',
  `ATTRIBUTE7` varchar(80) DEFAULT NULL COMMENT '属性7',
  `ATTRIBUTE8` varchar(80) DEFAULT NULL COMMENT '属性8',
  `ATTRIBUTE` varchar(80) DEFAULT NULL COMMENT '属性',
  `DESCRIBE1` varchar(250) DEFAULT NULL COMMENT '描述1',
  `DESCRIBE2` varchar(250) DEFAULT NULL COMMENT '描述2',
  `DESCRIBE3` varchar(250) DEFAULT NULL COMMENT '描述3',
  `DESCRIBE4` varchar(250) DEFAULT NULL COMMENT '描述4',
  `STATUS` varchar(80) DEFAULT NULL COMMENT '状态',
  `CERTTYPE` varchar(18) DEFAULT NULL COMMENT '证件类型',
  `CERTID` varchar(32) DEFAULT NULL COMMENT '证件号码',
  `COMPANYTEL` varchar(32) DEFAULT NULL COMMENT '单位电话',
  `MOBILETEL` varchar(32) DEFAULT NULL COMMENT '手机',
  `EMAIL` varchar(80) DEFAULT NULL COMMENT '电子邮件',
  `ACCOUNTID` varchar(32) DEFAULT NULL COMMENT '账号',
  `ID1` varchar(32) DEFAULT NULL,
  `ID2` varchar(32) DEFAULT NULL,
  `SUM1` decimal(24,6) DEFAULT NULL,
  `SUM2` decimal(24,6) DEFAULT NULL,
  `INPUTORG` varchar(32) DEFAULT NULL COMMENT '录入机构',
  `INPUTUSER` varchar(32) DEFAULT NULL COMMENT '录入人员',
  `INPUTDATE` varchar(20) DEFAULT NULL COMMENT '录入日期',
  `INPUTTIME` varchar(20) DEFAULT NULL COMMENT '录入时间',
  `UPDATEUSER` varchar(32) DEFAULT NULL COMMENT '更新人员',
  `UPDATEDATE` varchar(20) DEFAULT NULL COMMENT '更新日期',
  `UPDATETIME` varchar(20) DEFAULT NULL COMMENT '更新时间',
  `REMARK` varchar(250) DEFAULT NULL COMMENT '备注',
  `BIRTHDAY` varchar(10) DEFAULT NULL COMMENT '出生日期',
  `GENDER` varchar(18) DEFAULT NULL COMMENT '性别',
  `FAMILYADD` varchar(250) DEFAULT NULL COMMENT '家庭住址',
  `AMLEVEL` varchar(18) DEFAULT NULL COMMENT '客户经理级别',
  `EDUCATIONALBG` varchar(18) DEFAULT NULL COMMENT '学历',
  `EDUCATIONEXP` varchar(800) DEFAULT NULL COMMENT '教育经历',
  `VOCATIONEXP` varchar(800) DEFAULT NULL COMMENT '工作经历',
  `TITLE` varchar(18) DEFAULT NULL COMMENT '行内职务',
  `POSITION` varchar(250) DEFAULT NULL COMMENT '职称',
  `QUALIFICATION` varchar(250) DEFAULT NULL COMMENT '任职资格',
  `NTID` varchar(32) DEFAULT NULL,
  `BELONGTEAM` varchar(32) DEFAULT NULL COMMENT '所属团队',
  `LOB` varchar(32) DEFAULT NULL COMMENT '业务条线',
  `SKINPATH` varchar(200) DEFAULT NULL COMMENT '皮肤路径',
  `LANGUAGE` varchar(32) DEFAULT NULL COMMENT '语言',
  PRIMARY KEY (`USERID`),
  KEY `IDX1_USER_INFO` (`BELONGORG`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用户信息';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `user_list`
--

DROP TABLE IF EXISTS `user_list`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_list` (
  `LISTID` varchar(32) NOT NULL COMMENT '流水编号',
  `SESSIONID` varchar(80) NOT NULL COMMENT 'session编号',
  `BEGINTIME` varchar(20) NOT NULL COMMENT '开始时间',
  `USERID` varchar(32) NOT NULL COMMENT '用户编号',
  `USERNAME` varchar(32) DEFAULT NULL COMMENT '用户名称',
  `ORGID` varchar(32) DEFAULT NULL COMMENT '机构编号',
  `ORGNAME` varchar(80) DEFAULT NULL COMMENT '机构名称',
  `REMOTEADDR` varchar(18) DEFAULT NULL COMMENT '登陆地址',
  `REMOTEHOST` varchar(80) DEFAULT NULL COMMENT '登陆主机',
  `ENDTIME` varchar(20) DEFAULT NULL COMMENT '结束时间',
  `SERVERNAME` varchar(80) DEFAULT NULL COMMENT '服务名称',
  `SERVERPORT` varchar(10) DEFAULT NULL COMMENT '服务端口',
  PRIMARY KEY (`LISTID`),
  KEY `IDX_USER_LIST` (`SESSIONID`,`BEGINTIME`,`USERID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用户登录列表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `user_logon_session`
--

DROP TABLE IF EXISTS `user_logon_session`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_logon_session` (
  `USERID` varchar(32) NOT NULL COMMENT '用户编号',
  `SESSIONID` varchar(80) DEFAULT NULL COMMENT 'session编号',
  `IP` varchar(80) DEFAULT NULL COMMENT 'IP',
  `UPDATETIME` varchar(32) DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`USERID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用户登录Session';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `user_markinfo`
--

DROP TABLE IF EXISTS `user_markinfo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_markinfo` (
  `USERID` varchar(25) NOT NULL COMMENT '用户编号',
  `PASSWORDUPDATEDATE` varchar(25) DEFAULT NULL COMMENT '更改密码时间',
  `VISITTIMES` int(11) DEFAULT '0' COMMENT '访问次数',
  `LOGONERRORTIMES` int(11) DEFAULT '0' COMMENT '登陆次数',
  `LASTSIGNINTIME` varchar(25) DEFAULT NULL COMMENT '上次登陆时间',
  `LASTSIGNOUTTIME` varchar(25) DEFAULT NULL COMMENT '上次登出时间',
  `CURSIGNINTIME` varchar(25) DEFAULT NULL COMMENT '本次登陆时间',
  `PASSWORDSTATE` varchar(10) DEFAULT NULL COMMENT '密码状态',
  `PASSWORDMESSAGE` varchar(100) DEFAULT NULL COMMENT '密码提示信息',
  PRIMARY KEY (`USERID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用户痕迹表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `user_pref`
--

DROP TABLE IF EXISTS `user_pref`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_pref` (
  `PREFERENCEID` varchar(32) NOT NULL COMMENT '偏好编号',
  `USERID` varchar(32) NOT NULL COMMENT '用户编号',
  `PREFERENCEVALUE` varchar(250) DEFAULT NULL COMMENT '偏好值',
  `INPUTTIME` varchar(20) DEFAULT NULL COMMENT '登记时间',
  `UPDATETIME` varchar(20) DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`PREFERENCEID`,`USERID`),
  KEY `IDX1_USER_PREF` (`USERID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用户偏好设置';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `user_pref_def`
--

DROP TABLE IF EXISTS `user_pref_def`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_pref_def` (
  `PREFERENCEID` varchar(32) NOT NULL COMMENT '偏好ID',
  `PREFERENCENAME` varchar(80) DEFAULT NULL COMMENT '偏好说明',
  `DEFAULTVALUE` varchar(250) DEFAULT NULL COMMENT '缺省值',
  `ENABLECACHE` varchar(18) DEFAULT NULL COMMENT '是否预读入',
  `INPUTUSER` varchar(32) DEFAULT NULL COMMENT '登记人',
  `INPUTORG` varchar(32) DEFAULT NULL COMMENT '登记机构',
  `INPUTTIME` varchar(20) DEFAULT NULL COMMENT '登记时间',
  `UPDATEUSER` varchar(32) DEFAULT NULL COMMENT '更新人',
  `UPDATETIME` varchar(20) DEFAULT NULL COMMENT '更新时间',
  `REMARK` varchar(250) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`PREFERENCEID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用户偏好类型';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `user_role`
--

DROP TABLE IF EXISTS `user_role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_role` (
  `USERID` varchar(32) NOT NULL COMMENT '所属用户号',
  `ROLEID` varchar(32) NOT NULL COMMENT '角色号',
  `GRANTOR` varchar(32) NOT NULL COMMENT '授权者',
  `BEGINTIME` varchar(20) NOT NULL COMMENT '开始时间',
  `ENDTIME` varchar(20) DEFAULT NULL COMMENT '结束时间',
  `ATTRIBUTE` varchar(80) DEFAULT NULL COMMENT '属性',
  `STATUS` varchar(80) DEFAULT NULL COMMENT '状态',
  `REMARK` varchar(250) DEFAULT NULL COMMENT '备注',
  `INPUTUSER` varchar(32) DEFAULT NULL COMMENT '登记人员',
  `INPUTORG` varchar(32) DEFAULT NULL COMMENT '登记机构',
  `INPUTTIME` varchar(20) DEFAULT NULL COMMENT '登记时间',
  `UPDATEUSER` varchar(32) DEFAULT NULL COMMENT '更新人员',
  `UPDATETIME` varchar(20) DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`USERID`,`ROLEID`,`GRANTOR`,`BEGINTIME`),
  KEY `IDX1_USER_ROLE` (`USERID`,`STATUS`,`ROLEID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用户角色关系';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `user_runtime`
--

DROP TABLE IF EXISTS `user_runtime`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_runtime` (
  `SERIALNO` varchar(32) NOT NULL COMMENT '流水号',
  `SESSIONID` varchar(100) NOT NULL COMMENT 'SESSION编号',
  `BEGINTIME` varchar(32) NOT NULL COMMENT '开始时间',
  `USERID` varchar(32) NOT NULL COMMENT '用户号',
  `USERNAME` varchar(80) DEFAULT NULL COMMENT '用户名',
  `JSPNAME` varchar(200) NOT NULL COMMENT 'JSP名称',
  `ENDTIME` varchar(32) DEFAULT NULL COMMENT '结束时间',
  `TIMECONSUMING` decimal(10,6) DEFAULT NULL COMMENT '耗时',
  PRIMARY KEY (`SERIALNO`),
  KEY `IDX1_USER_RUNTIME` (`SESSIONID`,`BEGINTIME`,`USERID`,`JSPNAME`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用户运行时信息';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `user_worktips`
--

DROP TABLE IF EXISTS `user_worktips`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_worktips` (
  `SERIALNO` varchar(32) NOT NULL COMMENT '流水号',
  `USERID` varchar(32) NOT NULL COMMENT '用户号',
  `TABID` varchar(32) NOT NULL COMMENT '标签号',
  `TABNAME` varchar(100) NOT NULL COMMENT '标签名称',
  `SCRIPT` varchar(500) DEFAULT NULL COMMENT '脚本路径',
  `CACHEFLAG` varchar(1) DEFAULT NULL COMMENT '缓冲标志',
  `CLOSEFLAG` varchar(1) DEFAULT NULL COMMENT '完成标志',
  `INPUTORG` varchar(32) DEFAULT NULL COMMENT '登记机构',
  `INPUTUSER` varchar(32) DEFAULT NULL COMMENT '登记用户',
  `INPUTTIME` varchar(20) DEFAULT NULL COMMENT '登记时间',
  `UPDATEUSER` varchar(32) DEFAULT NULL COMMENT '更新用户',
  `UPDATETIME` varchar(20) DEFAULT NULL COMMENT '更新时间',
  `UPDATEORG` varchar(32) DEFAULT NULL COMMENT '更新机构',
  `REMARK` varchar(250) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`SERIALNO`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用户工作日志表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Temporary view structure for view `v_example_ue`
--

DROP TABLE IF EXISTS `v_example_ue`;
/*!50001 DROP VIEW IF EXISTS `v_example_ue`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `v_example_ue` AS SELECT 
 1 AS `CUSTOMERID`,
 1 AS `CUSTOMERNAME`,
 1 AS `TELEPHONE`,
 1 AS `BUSINESSSUM`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `validate_rule_library_gel`
--

DROP TABLE IF EXISTS `validate_rule_library_gel`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `validate_rule_library_gel` (
  `RULENO` varchar(20) NOT NULL,
  `INFRECTYPE` varchar(3) NOT NULL,
  `BUSIIDSERIALNO` varchar(120) DEFAULT NULL,
  `BSBUSIIDSERIALNO` varchar(200) DEFAULT NULL,
  `VALIDATELEVEL` varchar(1) DEFAULT NULL,
  `ERRCODE` varchar(20) DEFAULT NULL,
  `ERRMSG` varchar(800) DEFAULT NULL,
  `ERRTABLE` varchar(60) DEFAULT NULL,
  `ERRTABLENAME` varchar(200) DEFAULT NULL,
  `ERRFIELD` varchar(60) DEFAULT NULL,
  `ERRFIELDNAME` varchar(200) DEFAULT NULL,
  `ERRFIELDVALUE` varchar(120) DEFAULT NULL,
  `SRCTABLE` varchar(60) DEFAULT NULL,
  `WHERECLAUSE` varchar(800) DEFAULT NULL,
  `STATUS` varchar(1) DEFAULT NULL,
  `INPUTDATE` varchar(10) DEFAULT NULL,
  `UPDATEDATE` varchar(10) DEFAULT NULL,
  `EXTEND1` varchar(30) DEFAULT NULL,
  `EXTEND2` varchar(30) DEFAULT NULL,
  `EXTEND3` varchar(30) DEFAULT NULL,
  `CHECKEDVALUE` varchar(100) DEFAULT NULL,
  `MANAGERORGID` varchar(32) DEFAULT NULL,
  PRIMARY KEY (`RULENO`,`INFRECTYPE`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `work_record`
--

DROP TABLE IF EXISTS `work_record`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `work_record` (
  `SERIALNO` varchar(32) NOT NULL COMMENT '流水号',
  `OBJECTTYPE` varchar(18) DEFAULT NULL COMMENT '对象类型',
  `OBJECTNO` varchar(32) DEFAULT NULL COMMENT '对象编号',
  `WORKTYPE` varchar(18) DEFAULT NULL COMMENT '工作类型',
  `WORKBRIEF` varchar(80) DEFAULT NULL COMMENT '内容摘要',
  `IMPORTANCE` varchar(18) DEFAULT NULL COMMENT '重要性',
  `URGENCY` varchar(18) DEFAULT NULL COMMENT '紧急处理',
  `PROMPTBEGINDATE` varchar(10) DEFAULT NULL COMMENT '开始提示日期',
  `PROMPTENDDATE` varchar(10) DEFAULT NULL COMMENT '结束提示日期',
  `PLANFINISHDATE` varchar(10) DEFAULT NULL COMMENT '计划完成日期',
  `ACTUALFINISHDATE` varchar(10) DEFAULT NULL COMMENT '实际完成日期',
  `WORKCONTENT` varchar(800) DEFAULT NULL COMMENT '工作内容',
  `WORKRESULT` varchar(800) DEFAULT NULL COMMENT '完成情况',
  `WORKREASON` varchar(800) DEFAULT NULL COMMENT '未完成理由',
  `REMARK` varchar(200) DEFAULT NULL COMMENT '备注',
  `OPERATEORGID` varchar(32) DEFAULT NULL COMMENT '经办机构',
  `OPERATEUSERID` varchar(32) DEFAULT NULL COMMENT '经办人员',
  `INPUTORGID` varchar(32) DEFAULT NULL COMMENT '创建机构',
  `INPUTUSERID` varchar(32) DEFAULT NULL COMMENT '创建人员',
  `INPUTDATE` varchar(10) DEFAULT NULL COMMENT '创建日期',
  `UPDATEDATE` varchar(10) DEFAULT NULL COMMENT '更新日期',
  PRIMARY KEY (`SERIALNO`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='工作计划及笔记';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Final view structure for view `finance_catalog`
--

/*!50001 DROP VIEW IF EXISTS `finance_catalog`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `finance_catalog` AS select `report_catalog`.`MODELTYPE` AS `REPORTTYPE`,`report_catalog`.`MODELNO` AS `REPORTNO`,`report_catalog`.`MODELNAME` AS `REPORTNAME`,`report_catalog`.`MODELDESCRIBE` AS `REPORTDESCRIBE`,`report_catalog`.`MODELCLASS` AS `BELONGINDUSTRY`,`report_catalog`.`MODELABBR` AS `REPORTABBR`,`report_catalog`.`HEADERMETHOD` AS `HEADERMETHOD`,`report_catalog`.`DISPLAYMETHOD` AS `DISPLAYMETHOD`,`report_catalog`.`DELETEFLAG` AS `DELETEFLAG`,`report_catalog`.`ATTRIBUTE2` AS `ATTRIBUTE2`,`report_catalog`.`ATTRIBUTE1` AS `ATTRIBUTE1`,`report_catalog`.`REMARK` AS `REMARK` from `report_catalog` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `finance_data`
--

/*!50001 DROP VIEW IF EXISTS `finance_data`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `finance_data` AS select `report_record`.`OBJECTNO` AS `CUSTOMERID`,substr(`customer_fsrecord`.`REPORTDATE`,1,7) AS `ACCOUNTMONTH`,`report_record`.`MODELNO` AS `MODELNO`,`report_data`.`REPORTNO` AS `REPORTNO`,`customer_fsrecord`.`REPORTSCOPE` AS `SCOPE`,`report_data`.`ROWSUBJECT` AS `FINANCEITEMNO`,`report_data`.`COL1VALUE` AS `ITEM1VALUE`,`report_data`.`COL2VALUE` AS `ITEM2VALUE`,`report_data`.`COL3VALUE` AS `ITEM1BASEVALUE`,`report_data`.`COL4VALUE` AS `ITEM2BASEVALUE`,`report_data`.`STANDARDVALUE` AS `STANDARDVALUE`,`report_data`.`DISPLAYORDER` AS `DISPLAYORDER`,`report_data`.`ROWATTRIBUTE` AS `ITEMATTRIBUTE`,`report_data`.`ROWNAME` AS `DISPLAYNAME`,`report_data`.`ROWNO` AS `DISPLAYNO` from ((`customer_fsrecord` join `report_record`) join `report_data`) where ((`report_record`.`OBJECTTYPE` = 'CustomerFS') and (`report_record`.`OBJECTNO` = `customer_fsrecord`.`CUSTOMERID`) and (`report_record`.`REPORTDATE` = `customer_fsrecord`.`REPORTDATE`) and (`report_data`.`REPORTNO` = `report_record`.`REPORTNO`) and (`customer_fsrecord`.`REPORTSCOPE` = `report_record`.`REPORTSCOPE`)) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `finance_model`
--

/*!50001 DROP VIEW IF EXISTS `finance_model`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `finance_model` AS select `report_model`.`COL1DEF` AS `ITEM1DEF`,`report_model`.`COL2DEF` AS `ITEM1BASEDEF`,`report_model`.`COL3DEF` AS `ITEM2DEF`,`report_model`.`COL4DEF` AS `ITEM2BASEDEF`,`report_model`.`DELETEFLAG` AS `DELETEFLAG`,`report_model`.`DISPLAYORDER` AS `LISTNO`,`report_model`.`MODELNO` AS `REPORTNO`,`report_model`.`ROWATTRIBUTE` AS `ITEMATTRIBUTE`,`report_model`.`ROWNAME` AS `DISPLAYNAME`,`report_model`.`ROWNO` AS `DISPLAYNO`,`report_model`.`ROWSUBJECT` AS `FINANCEITEMNO`,`report_model`.`STANDARDVALUE` AS `STANDARDVALUE` from `report_model` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `finance_record`
--

/*!50001 DROP VIEW IF EXISTS `finance_record`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `finance_record` AS select `customer_fsrecord`.`REPORTPERIOD` AS `REPORTPERIOD`,`customer_fsrecord`.`AUDITOPINION` AS `ATTRIBUTE1`,`customer_fsrecord`.`AUDITFLAG` AS `ATTRIBUTE2`,`customer_fsrecord`.`CUSTOMERID` AS `CUSTOMERID`,`customer_fsrecord`.`INPUTDATE` AS `INPUTDATE`,`report_record`.`INPUTTIME` AS `INPUTTIME`,`customer_fsrecord`.`UPDATEDATE` AS `LASTUPDATEDATE`,`report_record`.`OBJECTNO` AS `OBJECTNO`,`report_record`.`OBJECTTYPE` AS `OBJECTTYPE`,`customer_fsrecord`.`ORGID` AS `ORGID`,`customer_fsrecord`.`RECORDNO` AS `RECORDNO`,`customer_fsrecord`.`REMARK` AS `REMARK`,`customer_fsrecord`.`AUDITOFFICE` AS `REMARK1`,`report_record`.`ORGID` AS `REPORT_ORGID`,`report_record`.`USERID` AS `REPORT_USERID`,`customer_fsrecord`.`REPORTCURRENCY` AS `REPORTCURRENCY`,substr(`report_record`.`REPORTDATE`,1,7) AS `ACCOUNTMONTH`,`customer_fsrecord`.`REPORTDATE` AS `REPORTDATE`,`customer_fsrecord`.`REPORTFLAG` AS `REPORTFLAG`,`report_record`.`REPORTNAME` AS `REPORTNAME`,`report_record`.`MODELNO` AS `REPORTNO`,`report_record`.`REPORTNO` AS `REPORT_REPORTNO`,`customer_fsrecord`.`REPORTOPINION` AS `REPORTOPINION`,`customer_fsrecord`.`REPORTSCOPE` AS `REPORTSCOPE`,`customer_fsrecord`.`REPORTSTATUS` AS `REPORTSTATUS`,`customer_fsrecord`.`REPORTUNIT` AS `REPORTUNIT`,`report_record`.`UPDATETIME` AS `UPDATETIME`,`customer_fsrecord`.`USERID` AS `USERID` from (`customer_fsrecord` join `report_record`) where ((`report_record`.`OBJECTTYPE` = 'CustomerFS') and (`report_record`.`OBJECTNO` = `customer_fsrecord`.`CUSTOMERID`)) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `v_example_ue`
--

/*!50001 DROP VIEW IF EXISTS `v_example_ue`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `v_example_ue` AS select `example_datawindow`.`SERIALNO` AS `CUSTOMERID`,`example_datawindow`.`CUSTOMERNAME` AS `CUSTOMERNAME`,`example_datawindow`.`TELEPHONE` AS `TELEPHONE`,`example_number`.`NUMBER1` AS `BUSINESSSUM` from (`example_datawindow` left join `example_number` on((`example_datawindow`.`SERIALNO` = `example_number`.`SERIALNO`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-06-12 15:31:25
