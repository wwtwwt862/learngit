package com.amarsoft.app.pidr.dw.ui.tool;

import java.io.File;

import com.amarsoft.are.ARE;
/** 
* @ClassName: EncFileIsExists 
* @Description: TODO(判断enc文件是否存在) 
* @author kwwu
* @date 2021-05-18
*  
*/
public class EncFileIsExists {
    public String encFileIsExists() {
        String filePath = ARE.getProperty("PIDRUploadFeedbackFilePath").replace("report", "encfile");//获取enc文件存储路径
        File file = new File(filePath);
        String[] str = file.list();
        if(file.exists()&&file.isDirectory()) {
            for(int i=0;i<str.length;i++) {
                if(str[i].endsWith(".enc")) {//如果有enc文件，则需要先预处理
                    ARE.getLog().info(filePath+"存在需要处理的enc文件");
                    return "true";
                }
            }
        }
        ARE.getLog().info(filePath+"不存在需要处理的enc文件");
        return "false";
    }
    
}
