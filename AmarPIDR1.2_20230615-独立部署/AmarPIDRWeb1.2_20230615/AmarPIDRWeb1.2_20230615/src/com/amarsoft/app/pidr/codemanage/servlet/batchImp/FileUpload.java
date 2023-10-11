package com.amarsoft.app.pidr.codemanage.servlet.batchImp;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUploadBase;
import org.apache.commons.fileupload.ProgressListener;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

import com.amarsoft.app.pidr.common.PIDRConstants;
import com.amarsoft.are.ARE;
import com.amarsoft.are.jbo.BizObject;
import com.amarsoft.are.jbo.BizObjectManager;
import com.amarsoft.are.jbo.JBOException;
import com.amarsoft.are.jbo.JBOFactory;
import com.amarsoft.are.jbo.JBOTransaction;
import com.amarsoft.are.jbo.impl.BizObjectTableMapper;
import com.amarsoft.are.lang.StringX;
import com.amarsoft.awe.Configure;
import com.amarsoft.awe.util.DBKeyHelp;
import com.amarsoft.awe.util.DateXHelp;
import com.amarsoft.awe.util.Transaction;
import com.amarsoft.context.ASUser;

/**
 * 文件上传，记录文件信息
 * @author jyshen
 * @since 2023-02-16
 */
public class FileUpload{
	private HttpServletResponse response;
	private HttpServletRequest request;
	private Configure curConfig;
	private ServletContext sc;
	private String	savePath="";//web-inf
	private File tempFile;//临时文件
	private ASUser curUser;
	private int a = PIDRConstants.IMPORTRESULT_1;
	private String compClientID  = "";
	private List<ItemFile> files = null;
	private String docNo = "";
	
	/**
	 * 有参构造器
	 * @param docNo
	 */
	public FileUpload(String docNo) { this.docNo = docNo; }
	/**
	 * 无参构造器
	 */
	public FileUpload() {}
		
	/**
	 * 初始化
	 * @param sc
	 * @param request
	 * @param curConfig
	 * @param curUser
	 * @param a
	 * @param compClientID
	 * @param savePath
	 * @param tempFile
	 */
	public  void init(ServletContext sc, HttpServletRequest request, Configure curConfig, ASUser curUser,
			int a,String compClientID,String savePath,File tempFile) {
		this.sc = sc;
		this.request = request;
		this.curConfig = curConfig;
		this.curUser = curUser;
		this.a = a;
		this.compClientID = compClientID;
		this.savePath = savePath;
		this.tempFile = tempFile;
	}
	 
	/**
	 * 文件上传
	 * @return
	 * @throws ServletException
	 * @throws IOException
	 */
	public int uploadFile() throws ServletException, IOException {
		OutputStream os = null;
		InputStream is = null;
		try {
			JBOTransaction tx = Transaction.createTransaction(PIDRConstants.DATASOURCE_PIDR);
	         // 使用Apache文件上传组件处理文件上传步骤：
	         // 1、创建一个DiskFileItemFactory工厂
	         DiskFileItemFactory factory = new DiskFileItemFactory();
	         // 设置工厂的缓冲区的大小，当上传的文件大小超过缓冲区的大小时，就会生成一个临时文件存放到指定的临时目录当中。
	         factory.setSizeThreshold(1024 * 100);// 设置缓冲区的大小为100KB，如果不指定，那么缓冲区的大小默认是10KB
	         // 设置上传时生成的临时文件的保存目录
	         factory.setRepository(tempFile);
	         // 2、创建一个文件上传解析器
	         ServletFileUpload upload = new ServletFileUpload(factory);
	         // 监听文件上传进度
	         upload.setProgressListener(new ProgressListener() {
	             public void update(long arg0, long arg1, int arg2) {
	                 ARE.getLog().info("文件大小为：" + arg1 + ",当前已处理：" + arg0);
	             }
	         });
	         // 解决上传文件名的中文乱码
	         upload.setHeaderEncoding("utf-8");
	         // 3、判断提交上来的数据是否是上传表单的数据
	         if (!ServletFileUpload.isMultipartContent(request)) {
	             // 不是multipart/form-data方式提交
	        	 ARE.getLog().debug("不是multipart/form-data方式提交!");
	        	 a = PIDRConstants.IMPORTRESULT_7;
	        	 request.getRequestDispatcher("/PIDR/CodeManage/CodeTableImport.jsp?CloseFlag="+a+"&CompClientID=" + compClientID).forward(request, response);
	             return a;
	         }
	         // 设置上传单个文件的大小的最大值，目前是设置为1024*1024*100字节，也就是100MB
	         upload.setFileSizeMax(1024 * 1024 * 100);
	         // 设置上传文件总量的最大值，最大值=同时上传的多个文件的大小的最大值的和，目前设置为200MB
	         upload.setSizeMax(1024 * 1024 * 100);
	         // 4、使用ServletFileUpload解析器解析上传数据，解析结果返回的是一个List<FileItem>集合，每一个FileItem对应一个Form表单的输入项
	         List<FileItem> list = upload.parseRequest(request);
	         files = new ArrayList<ItemFile>();
	         for (FileItem item : list) {
	             if (item.isFormField()) {
	                 // 普通数据项
	                 //String name = item.getFieldName();
	                // String value = item.getString("utf-8");
	             } else {
	                 // 文件数据
	                 // 文件名称
	                 String fileName = item.getName();
	                 if (fileName == null || "".equals(fileName.trim())) {
	                     // 文件名为空,不保存数据
	                     continue;
	                 }
	                 // 注意：不同的浏览器提交的文件名是不一样的，有些浏览器提交上来的文件名是带有路径的，
	                 // 只保留文件名，并且区分不同系统的分隔符
	                 ARE.getLog().info("上传的文件名为：" + fileName);
	                 fileName = fileName.substring(fileName.lastIndexOf(File.separator) + 1);
	                 ARE.getLog().info("保存的文件名为：" + fileName);
	                 // 得到上传文件的扩展名
	                 String fileExtName = fileName.substring(fileName.lastIndexOf(".") + 1);
	                 // 如果需要限制上传的文件类型，那么可以通过文件的扩展名来判断上传的文件类型是否合法
	                 ARE.getLog().info("上传的文件的扩展名是：" + fileExtName);
	                 // 获取item中的上传文件的输入流,以及文件输出流
	                 is = item.getInputStream();
	                 // 得到文件保存的名称
	                 String saveFilename = makeFileName(fileName);
	                 saveFilename = curUser.getUserID()+"_"+saveFilename;
	                 // 得到文件的保存目录
	                 String beginTime = DateXHelp.getDateString();
	                 String fillPath = File.separator +beginTime;//相对路径目录
	                 fillPath = fillPath +File.separator+saveFilename;//相对路径
	                 savePath = savePath+fillPath;//绝对路径目录
	                 String realSavePath = makePath(saveFilename, savePath);//创建目录
	                 String fullPath = realSavePath+File.separator+saveFilename;//绝对路径
	                 ARE.getLog().info("文件的保存目录：" + realSavePath);
	                 os = new FileOutputStream(realSavePath+File.separator+saveFilename);
	                 // 以下是文件的保存
	                 // 创建缓冲区
	                 byte[] buffer = new byte[1024 * 5];
	                 int len = 0;
	                 while ((len = is.read(buffer)) > 0) {
	                     os.write(buffer, 0, len);
	                 }
	                 ItemFile itemFile = new ItemFile();
	                 itemFile.setFileExtName(fileExtName);
	                 itemFile.setFileFullPath(fullPath);
	                 itemFile.setFileName(fileName);
	                 files.add(itemFile);
	                 // 删除处理文件上传时生成的临时文件
	                 item.delete();
	                 a = saveRecord(tx, item,saveFilename,fillPath, fullPath, 
	                		 this.curConfig.getConfigure("FileSaveMode"), beginTime);
	                 if(PIDRConstants.IMPORTRESULT_1 != a) {
	                	  request.getRequestDispatcher("/PIDR/CodeManage/CodeTableImport.jsp?CloseFlag="+a+"&CompClientID=" + compClientID).forward(request,
	         	                 response);
	         	         return a; 
	                 }
	               
	             }
	         }
	     } catch (FileUploadBase.FileSizeLimitExceededException e) {
	    	 a = PIDRConstants.IMPORTRESULT_2;
	         request.setAttribute("message", "单个文件超出最大值！！！");
	         request.getRequestDispatcher("/PIDR/CodeManage/CodeTableImport.jsp?CloseFlag="+a+"&CompClientID=" + compClientID).forward(request,
	                 response);
	         return a;
	     } catch (FileUploadBase.SizeLimitExceededException e) {
	    	 a = PIDRConstants.IMPORTRESULT_2;
	         ARE.getLog().debug("上传文件的总的大小超出限制的最大值！！！");
	         request.setAttribute("message", "上传文件的总的大小超出限制的最大值！！！");
	         request.getRequestDispatcher("/PIDR/CodeManage/CodeTableImport.jsp?CloseFlag="+a+"&CompClientID=" + compClientID).forward(request,
	                 response);
	         return a;
	     } catch (Exception e) {
	    	 ARE.getLog().debug("输出流异常!");
	    	 a = PIDRConstants.IMPORTRESULT_5;
	    	 request.getRequestDispatcher("/PIDR/CodeManage/CodeTableImport.jsp?CloseFlag="+a+"&CompClientID=" + compClientID).forward(request,
	                 response);
	    	 return a;
	     }finally {
	    	 if(is != null) {
	    		 try {
	    			 is.close();
	    		 }catch(IOException e) {
	    			 ARE.getLog().error(e.getMessage(),e);
	    		 }
	    		 
	    	 }
	    	 if(os != null) {
	    		 try {
	    			 os.close(); 
	    		 }catch(IOException e) {
	    			 ARE.getLog().error(e.getMessage(),e);
	    		 }
	    		 
	    	 }
	     }
		return a;
	}

	 /**
     * @function 生成上传文件的文件名，文件名以：uuid+"_"+文件的原始名称
     * @param fileName
     * @return
     */
    public String makeFileName(String fileName) {
        // 为防止文件覆盖的现象发生，要为上传文件产生一个唯一的文件名
        return UUID.randomUUID().toString() + "_" + fileName;
    }

    /**
     * 为防止一个目录下出现太多文件，使用hash算法打散存储
     * 
     * @param filename
     * @param savePath
     * @return
     */
    public String makePath(String filename, String savePath) {
        // 得到文件名的hashCode的值，得到的就是filename这个字符串对象在内存中的地址
         filename.hashCode();
        // 构造新的保存目录
        String dir = savePath;
        // File既可以代表文件也可以代表目录
        File file = new File(dir);
        // 如果目录不存在
        if (!file.exists()) {
            file.mkdirs();
        }
        return dir;
    }

    /**
     * 记录文档附件库
     * @return 
     */
    public int saveRecord(JBOTransaction tx, FileItem item, String fileName,String fillPath, 
    		String sFullPath, String sFileSaveMode, String sBeginTime) {
    	try {
    		BizObjectManager bm = JBOFactory.getBizObjectManager(tx, "jbo.sys.DOC_ATTACHMENT");
    		String trueTable = ((BizObjectTableMapper)bm).getTable();
    		BizObject bo = bm.newObject();
    		String sAttachmentNo = DBKeyHelp.getSerialNo(trueTable, "AttachmentNo");
    		if(StringX.isEmpty(docNo)) {
    			docNo = DBKeyHelp.getSerialNo(trueTable, "DocNo");
    		}
    		bo.setAttributeValue("FilePath", fillPath);
    		bo.setAttributeValue("FullPath", sFullPath);
    		bo.setAttributeValue("DocNo", docNo);
    		bo.setAttributeValue("AttachmentNo", sAttachmentNo);
    		bo.setAttributeValue("FileSaveMode", sFileSaveMode);
    		bo.setAttributeValue("FileName", fileName);
    		bo.setAttributeValue("ContentType", item.getContentType());
    		bo.setAttributeValue("ContentLength", item.getSize());
    		bo.setAttributeValue("BeginTime", sBeginTime);
    		bo.setAttributeValue("EndTime", DateXHelp.getDateTimeString());
    		bo.setAttributeValue("InputUser", this.curUser.getUserID());
    		bo.setAttributeValue("InputOrg", this.curUser.getOrgID());
    		bm.saveObject(bo);
    		return PIDRConstants.IMPORTRESULT_1;
    	} catch (JBOException e) {
    		ARE.getLog(getClass()).error("记录文件信息失败" + e.getLocalizedMessage());
    		return PIDRConstants.IMPORTRESULT_8;
    	} catch (Exception e) {
    		ARE.getLog(getClass()).error("记录文件信息失败" + e.getLocalizedMessage());
    		return PIDRConstants.IMPORTRESULT_6;
    	}
    }
    
	public HttpServletResponse getResponse() {
		return response;
	}

	public void setResponse(HttpServletResponse response) {
		this.response = response;
	}

	public HttpServletRequest getRequest() {
		return request;
	}

	public void setRequest(HttpServletRequest request) {
		this.request = request;
	}

	public Configure getCurConfig() {
		return curConfig;
	}

	public void setCurConfig(Configure curConfig) {
		this.curConfig = curConfig;
	}

	public ServletContext getSc() {
		return sc;
	}

	public void setSc(ServletContext sc) {
		this.sc = sc;
	}

	public String getSavePath() {
		return savePath;
	}

	public void setSavePath(String savePath) {
		this.savePath = savePath;
	}

	public File getTempFile() {
		return tempFile;
	}

	public void setTempFile(File tempFile) {
		this.tempFile = tempFile;
	}

	public ASUser getCurUser() {
		return curUser;
	}

	public void setCurUser(ASUser curUser) {
		this.curUser = curUser;
	}

	public int getA() {
		return a;
	}

	public void setA(int a) {
		this.a = a;
	}

	public String getCompClientID() {
		return compClientID;
	}

	public void setCompClientID(String compClientID) {
		this.compClientID = compClientID;
	}

	public List<ItemFile> getFiles() {
		return files;
	}

	public void setFiles(List<ItemFile> files) {
		this.files = files;
	}

}
