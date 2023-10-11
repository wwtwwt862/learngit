var sScreenWidth = screen.availWidth;
var sScreenHeight = screen.availHeight;
var sDefaultDialogStyle= "dialogWidth="+sScreenWidth+"px;dialogHeight="+sScreenHeight+"px;resizable=yes;maximize:yes;help:no;status:no;";
var OpenStyle="width="+sScreenWidth+"px,height="+sScreenHeight+"px,top=0,left=0,toolbar=no,scrollbars=yes,resizable=yes,status=no,menubar=no";
var sDefaultModelessDialogStyle = "dialogLeft="+(sScreenWidth*0.6)+";dialogWidth="+(sScreenWidth*0.4)+"px;dialogHeight="+(sScreenHeight)+"px;resizable=yes;status:yes;maximize:yes;help:no;";

function over_change(index,src,clrOver){
	if (!src.contains(event.fromElement)){ 
 		src.style.cursor = 'pointer';
 		src.background = clrOver;
 	}
}

function out_change(index,src,clrIn){
	if (!src.contains(event.toElement)){
		src.style.cursor = 'default';
		src.background = clrIn;
	}
}

bIsLocked=false;

function checkIfLocked(){
	if(bIsLocked){
		if(!confirm("您已经用弹出方式打开了一个新页面，离开本页面将可能导致出错。\n该错误将不会影响系统正常运行。\n您确定要离开本页面吗？")) 
			return true;
		else 
			return false;
	}else	
		return true;
}

//日期检查函数	
function isDate(value,separator){
	if(typeof separator != "string" || typeof value != "string" || value.length<10)
		return false;
	if(separator != "." && value.indexOf(".") > -1) return false;
	var sItems = value.split(separator); // value.split("/");
	
    if (sItems.length!=3) return false;
    if (isNaN(sItems[0])) return false;
    if (isNaN(sItems[1])) return false;
    if (isNaN(sItems[2])) return false;
    //年份必须为4位，月份和日必须为2位
    if (sItems[0].length!=4) return false;
    if (sItems[1].length!=2) return false;
    if (sItems[2].length!=2) return false;

    if (parseInt(sItems[0],10)<1900 || parseInt(sItems[0],10)>2150) return false;
    if (parseInt(sItems[1],10)<1 || parseInt(sItems[1],10)>12) return false;
    if (parseInt(sItems[2],10)<1 || parseInt(sItems[2],10)>31) return false;

    if ((sItems[1]<=7) && ((sItems[1] % 2)==0) && (sItems[2]>=31)) return false;
    if ((sItems[1]>=8) && ((sItems[1] % 2)==1) && (sItems[2]>=31)) return false;
    //本年不是闰年
	if (!((sItems[0] % 4)==0) && (sItems[1]==2) && (sItems[2]==29)){
		if ((sItems[1]==2) && (sItems[2]==29)) return false;
	}else{
		if ((sItems[1]==2) && (sItems[2]==30)) return false;
    }

    return true;
}

//改变工作区大小
function resizeLeft(){
	try{
		if(myleft.width==1){
			myleft.width=myleftwidth;
		}else{
			myleftwidth=myleft.width;
			myleft.width=1;
		 }
	}catch(e){ }
}
	 
function resizeTop(){
	if(mytop.height==25) {
		mytop.height=mytopheight;
	} else {
		mytopheight=top.mytop.height;
		mytop.height=25;
	 }
}

function maximizeWindow(){
	window.moveTo(0,0);
	if (document.all){ 
  		top.window.resizeTo(screen.availWidth,screen.availHeight); 
	} else if (document.layers||document.getElementById){ 
  		if (top.window.outerHeight<screen.availHeight||top.window.outerWidth<screen.availWidth){
    		top.window.outerHeight = screen.availHeight; 
    		top.window.outerWidth = screen.availWidth;
  		}
	}
}

function key_up(e){
	if( document.event.shiftKey  && document.event.ctrlKey && document.event.altKey ){
		alert("ss");
		return;
	}
}
function GetPropertiesString(objObject){ //byhu: 此函数可以察看传入对象的所有属性
   var varProp="";
   var strProperties = objObject.id + "\n";
   for (varProp in objObject){
      strProperties += varProp + " = " + objObject[varProp] + "\n";
   }
   return strProperties;
}

function reloadSelf(){
	//记住当前的页号和行号
	rememberPageRow();
	if(document.forms["DOFilter"]==null){
		self.location.reload();
	} else if(typeof(document.forms["DOFilter"])=="undefined"){
		self.location.reload();
	}else{
		document.forms["DOFilter"].submit();
	}
}
function rememberPageRow(){
	try{
		//document.getElementById("DWCurPage").value=curpage[0];
		var page = s_c_p[0];
		if(isNaN(page)) page = 0;
		document.getElementById("DWCurPage").value=page;
		document.getElementById("DWCurRow").value=getRow(0);
	}catch(e){}
}


function getSerialNo(sTableName,sColumnName,sPrefix,sSerialNoFormate){
	if(typeof(sPrefix)=="undefined" || sPrefix=="") sPrefix="";
	return RunJspAjax("/Frame/page/sys/GetSerialNo.jsp?TableName="+sTableName+"&ColumnName="+sColumnName+"&Prefix="+sPrefix+"&SerialNoFormate="+sSerialNoFormate);
}






function onSubmit(sUrl,sParameter) {
	var waitingInfo = document.getElementById(getNetuiTagName("waitingInfo"));
	//设置显示
	waitingInfo.style.display = ""; 
	//滚动开始
	progress_update(); 
	//间隔控制
	for(var i=0;i<1000000;i++){
		j=i+i;
	}
	OpenPage(sUrl,sParameter,""); 
}






function onFromAction(sUrl,sFormName) {
	var waitingInfo = document.getElementById(getNetuiTagName("waitingInfo"));
	waitingInfo.style.display = ""; 
	progress_update(); 
	for(var i=0;i<1000000;i++){
		j=i+i;
	}
	//改用消息框处理
	//showMess("正在处理, 请稍候......");
	if(sFormName == "report"){
		document.report.action = sUrl;
		document.report.submit();
	}
	if(sFormName == "DOFilter"){
		sUrl.submit();
	}
}

// Build the netui_names table to map the tagId attributes to the real id written into the HTML
if (netui_names == null)
var netui_names = new Object();
netui_names.selectButton="portlet_15_1selectButton";
// method which will return a real id for a tagId
function getNetuiTagName(id) {
	return netui_names[id];
}

// method which will return a real id for a tagId,
// the tag parameter will be used to find the scopeId for containers that may scope their ids
function getNetuiTagName(id, tag) {
	var scopeId = getScopeId(tag);
	if (scopeId == "")
		return netui_names[id];
	else
		return netui_names[scopeId + "__" + id];
}

// method which get a tag will find any scopeId that was inserted by the containers
function getScopeId(tag) {
	if (tag == null)
		return "";
	if (tag.getAttribute) { 
		if (tag.getAttribute('scopeId') != null)
			return tag.getAttribute('scopeId');
	} 
	if (tag.scopeId != null)
		return tag.scopeId;
		return getScopeId(tag.parentNode);
}

// Build the netui_names table to map the tagId attributes to the real id written into the HTML
if (netui_names == null)
var netui_names = new Object();
netui_names.waitingInfo="waitingInfo";

//滚动量
var progressEnd = 18; 
//滚动条颜色
var progressColor = 'green'; 
var progressInterval = 200; // set to time between updates (milli-seconds)
var progressAt = progressEnd;
var progressTimer;

function progress_clear() {
	for (var i = 1; i <= progressEnd; i++) 
		document.getElementById('progress'+i).style.backgroundColor = 'transparent';
	progressAt = 0;
}
function progress_update() {
	progressAt++;
	if (progressAt > progressEnd) progress_clear();
	else document.getElementById('progress'+progressAt).style.backgroundColor = progressColor;
	progressTimer = setTimeout('progress_update()',progressInterval);
}
function progress_stop() {
	clearTimeout(progressTimer);
	progress_clear();
}
//*******************************end*********************************







function checkPrimaryKey(sTable,sColumnString){
	if(typeof(sTable)=="undefined" || sTable=="") return false;
	if(typeof(sColumnString)=="undefined" || sColumnString=="") return false;
	var sParameters = "Type=PRIMARYKEY&TableName="+sTable+"";
	var sColumns=sColumnString.split("@");
	for(var i=0;i<sColumns.length;i++){
		if(i==5){
			alert("关键字最多5个");
			return false;
		}
		sParameters+="&FieldName"+(i+1)+"="+sColumns[i];
		sParameters+="&FieldValue"+(i+1)+"="+getItemValue(0,0,sColumns[i]);
	}
	var sReturnValue = RunJspAjax("/Common/ToolsB/CheckPrimaryKeyAction.jsp?"+sParameters);
	if(sReturnValue == "TRUE"){
		return true;
	}else{
		return false;
	}
}










function selectCode(codeNo,Caption,defaultValue,filterExpr){
    if(typeof(filterExpr) == "undefined") filterExpr = "";
    var codePage = "/Common/ToolsA/SelectCode.jsp";
    var sPara = "CodeNo="+codeNo+"&Caption="+Caption+"&DefaultValue="+defaultValue
				+"&ItemNoExpr="+encodeURIComponent(filterExpr);  //这里需要作编码转换，否则形如&,%,+这类字符传输会有问题
    style = "resizable=yes;dialogWidth=25;dialogHeight=10;center:yes;status:no;statusbar:no";
    AsDialog.PopView(codePage,sPara,style,function(sReturn){return sReturn;});
}

//*************************begin*************************************
//通用消息框处理，从as_dz.js移植而来。
function showMess(mess){
	ShowMessage(mess,true,true);
	setTimeout(hideMessage,500);
}
function waitMess(mess){
	ShowMessage(mess,true,false);
	setTimeout(hideMessage,1000*10);//max时间:等待10s
}
function hideMessage(){
	try{
		var msgDiv = document.getElementById("msgDiv");
		msgDiv.removeChild(document.getElementById("msgTxt"));
		msgDiv.removeChild(document.getElementById("msgTitle"));
		document.body.removeChild(msgDiv);
		document.body.removeChild(document.getElementById("bgDiv"));
	}catch(e){ }
}
function ShowMessage(str,showGb,clickHide){
	//可以通过对象检查来判断窗口是否已打开
	//采取替换或者取消的操作来避免重复打开
 	if(document.getElementById("msgDiv"))
		return ;	 	

	var msgw=300;//信息提示窗口的宽度
	var msgh=125;//信息提示窗口的高度
	var scrollTop = document.body.scrollTop+document.body.clientHeight*0.4+"px";
	
	//**绘制背景层**/	
	var bgObj=document.createElement("div");
	bgObj.setAttribute('id','bgDiv');
	bgObj.className = "message_bg";

	//背景层动作 点击关闭
	if(clickHide)
		bgObj.onclick=hideMessage;
	if(showGb)
		document.body.appendChild(bgObj);
	
	//**绘制信息层**/
	var msgObj=document.createElement("div");
	msgObj.setAttribute("id","msgDiv");
	msgObj.setAttribute("align","center");
	msgObj.className = "message_div";
	
	msgObj.style.top= scrollTop; //"40%";
	msgObj.style.marginTop = -75+document.documentElement.scrollTop+"px";
	//msgObj.style.width = msgw + "px";
	msgObj.style.height =msgh + "px";
	
	document.body.appendChild(msgObj);
	
	//**绘制标题层**/ 点击关闭
	var title=document.createElement("h4");
	title.setAttribute("id","msgTitle");
	title.setAttribute("align","left");
	title.className = "message_title";
	title.innerHTML="系统处理中...";
	if(clickHide){
		title.innerHTML="关闭";
		title.style.cursor="pointer";			
		title.onclick = hideMessage;
	}	
	
	document.getElementById("msgDiv").appendChild(title);
	
	//**输出提示信息**/
	str = "<br>"+str.replace(/\n/g,"<br>");
	var txt=document.createElement("p");
	txt.style.margin="1em 0";
	txt.setAttribute("id","msgTxt");
	txt.innerHTML=str;
	document.getElementById("msgDiv").appendChild(txt);
}
//*******************************end*********************************


//*************************begin*************************************
//脚本编辑器及saveParaToComp方法，非Datawindow相关，因此从as_dz.js移植过来。
var oTempObj; // 用于临时中转对象句柄
function editObjectValueWithScriptEditor(oObject,sScriptLanguage){
	var sTempLanguage;
	if(typeof(sScriptLanguage)!="undefined" && sScriptLanguage!="")
		sTempLanguage = sScriptLanguage;
	else sTempLanguage = "AmarScript";

	sInput = oObject.value;
	sInput = real2Amarsoft(sInput);
	sInput = replaceAll(sInput,"~","$[wave]");
	oTempObj = oObject;
	if(sTempLanguage=="AFS")
		saveParaToComp("ScriptText="+sInput+"&ScriptLanguage="+sTempLanguage,"openScriptEditorForAFSAndSetText()");
	else
		saveParaToComp("ScriptText="+sInput+"&ScriptLanguage="+sTempLanguage,"openScriptEditorAndSetText()");
}

function editObjectValueWithScriptEditorForAFS(oObject,sModelNo){
	var sTempModelNo;
	if(typeof(sModelNo)!="undefined" && sModelNo!="")
		sTempModelNo = sModelNo;
	else sTempModelNo = "";

	sInput = oObject.value;
	sInput = real2Amarsoft(sInput);
	sInput = replaceAll(sInput,"~","$[wave]");
	oTempObj = oObject;
    saveParaToComp("ScriptText="+sInput+"&ModelNo="+sTempModelNo,"openScriptEditorForAFSAndSetText()");
}

function editObjectValueWithScriptEditorForASScript(oObject){
	sInput = oObject.value;
	sInput = real2Amarsoft(sInput);
	sInput = replaceAll(sInput,"~","$[wave]");
	oTempObj = oObject;
    saveParaToComp("ScriptText="+sInput,"openScriptEditorForASScriptAndSetText()");
}

function openScriptEditorAndSetText(){
	var oMyobj = oTempObj;
	AsDialog.PopView("/Common/ScriptEditor/ScriptEditor.jsp","","",function(sOutPut){
		if(typeof(sOutPut)!="undefined" && sOutPut!="_CANCEL_"){
			oMyobj.value = amarsoft2Real(sOutPut);
		}
	});
}

function openScriptEditorForAFSAndSetText(){
	var oMyobj = oTempObj;
	AsDialog.PopView("/Common/ScriptEditor/ScriptEditorForAFS.jsp","","",function(sOutPut){
		if(typeof(sOutPut)!="undefined" && sOutPut!="_CANCEL_"){
			oMyobj.value = amarsoft2Real(sOutPut);
		}
	});
}

function openScriptEditorForASScriptAndSetText(){
	var oMyobj = oTempObj;
	AsDialog.PopView("/Common/ScriptEditor/ScriptEditorForASScript.jsp","","",function(sOutPut){
		if(typeof(sOutPut)!="undefined" && sOutPut!="_CANCEL_"){
			oMyobj.value = amarsoft2Real(sOutPut);
		}
	});
}
	
//用于动态生成iframe并通过post将数据传递至模态窗口 
function generateIframe(){
	iframeName=randomNumber().toString();
	iframeName = "frame"+iframeName.substring(2);

	//modify in 2008/04/10,2008/02/14 for https
	//var sHTML="<iframe name='"+iframeName+"'  style='display:none'>";
	var sHTML="<iframe name='"+iframeName+"' src='"+sWebRootPath+"/amarsoft.html' style='display:none'>";
	
	document.body.insertAdjacentHTML("afterBegin",sHTML);
	//alert(sHTML);
	return iframeName;
}
//用于动态生成 form 并通过post将数据传递至模态窗口 
function saveParaToComp(paraString,postAction){
	var sFormName=randomNumber().toString();
	sFormName = "form"+sFormName.substring(2);
	var targetFrameName=generateIframe();
	var sHTML = "";
	if(typeof(dialogStyle)=="undefined" || dialogStyle=="") dialogStyle="";
	var sParaStringToPost = real2Amarsoft(paraString);
	
	sHTML+="<form name='"+sFormName+"' id='"+sFormName+"' target='"+targetFrameName+"' style='display:none'>";
	sHTML+="<input type=hidden name='CompClientID' value='"+sCompClientID+"'>";
	sHTML+="<input type=hidden name='TempParaString' id='TempParaString' value=''>";
	sHTML+="</form>";
	document.body.insertAdjacentHTML("afterBegin",sHTML);

	var oForm = document.forms[sFormName];
	var oElement = oForm.elements["TempParaString"];
	oElement.value = sParaStringToPost;
	$.ajax({
		   type: "POST",
		   url: sWebRootPath+"/Frame/page/dw/SaveParaToComp.jsp",
		   processData: false,
		   async:false,
		   data:$("#" +sFormName,document).serialize(),
		   success: function(msg){
			   try{
				   eval(postAction);
			   }catch(e){
				   alert("错误："+e.name+" "+e.number+" :"+e.message+"\n\n后续动作定义错误:"+sPostAction);
			   }
		   }
	});
}

//用于动态生成 form 并通过post将数据传递至模态窗口 
function saveParaToCompSession(paraString,postAction){
	var sFormName=randomNumber().toString();
	sFormName = "form"+sFormName.substring(2);
	var targetFrameName=generateIframe();
	var sHTML = "";
	if(typeof(dialogStyle)=="undefined" || dialogStyle=="") dialogStyle="";
	var sParaStringToPost = real2Amarsoft(paraString);
	
	sHTML+="<form name='"+sFormName+"' id='"+sFormName+"' target='"+targetFrameName+"' style='display:none'>";
	sHTML+="<input type=hidden name='CompClientID' value='"+sCompClientID+"'>";
	sHTML+="<input type=hidden name='TempParaString' id='TempParaString' value=''>";
	sHTML+="</form>";
	document.body.insertAdjacentHTML("afterBegin",sHTML);

	var oForm = document.forms[sFormName];
	var oElement = oForm.elements["TempParaString"];
	oElement.value = sParaStringToPost;
	$.ajax({
		   type: "POST",
		   url: sWebRootPath+"/Frame/page/dw/SaveParaToCompSession.jsp",
		   processData: false,
		   async:false,
		   data:$("#" +sFormName,document).serialize(),
		   success: function(msg){
			   try{
				   eval(postAction);
			   }catch(e){
				   alert("错误："+e.name+" "+e.number+" :"+e.message+"\n\n后续动作定义错误:"+sPostAction);
			   }
		   }
	});
}
//*******************************end*********************************


//*************************begin*************************************
//JS端对字符串处理方法，非Datawindow相关，因此从as_dz.js移植过来。
//real,amarsoft,db,js,html,amarsoft_regex,real_regex
var sAmarReplace = new Array();
sAmarReplace[0] = new Array("\\",		"~[isl]",	"\\",	"\\\\",		"&#92;",		"~\\[isl\\]",	"\\\\");
sAmarReplace[1] = new Array("'",		"~[sqt]",	"''",	"\\'",		"&#39;",		"~\\[sqt\\]",	"\'");
sAmarReplace[2] = new Array("\"",		"~[dqt]",	"\"",	"\"",		"&#34;",		"~\\[dqt\\]",	"\"");
sAmarReplace[3] = new Array("<",		"~[alt]",	"<",	"<",		"&#60;",		"~\\[alt\\]",	"\<");
sAmarReplace[4] = new Array(">",		"~[agt]",	">",	">",		"&#62;",		"~\\[agt\\]",	"\>");
sAmarReplace[5] = new Array("\r\n",		"~[arn]",	"\r\n",	"\\r\\n",	"&#13;&#10;",	"~\\[arn\\]",	"\\r\\n"); //\r\n
sAmarReplace[6] = new Array("\r",		"~[aor]",	"\r\n",	"\\r\\n",	"&#13;&#10;",	"~\\[aor\\]",	"\\r");
sAmarReplace[7] = new Array("\n",		"~[aon]",	"\r\n",	"\\r\\n",	"&#13;&#10;",	"~\\[aon\\]",	"\\n");
sAmarReplace[8] = new Array("#",		"~[pds]",	"#",	"#",		"#",			"~\\[pds\\]",	"\#");
sAmarReplace[9] = new Array("(",		"~[lpr]",	"(",	"(",		"(",			"~\\[lpr\\]",	"\\(");
sAmarReplace[10] = new Array(")",		"~[rpr]",	")",	")",		")",			"~\\[rpr\\]",	"\\)");
sAmarReplace[11] = new Array("+",		"~[pls]",	"+",	"+",		"+",			"~\\[pls\\]",	"\\+");




function macroReplace(sAttributes,sSource,sBeginIdentifier,sEndIdentifier,iAttID,iAttValue){
	var iPosBegin=0,iPosEnd=0;
	var sAttributeID="";
	var sReturn = sSource;
	while((iPosBegin=sReturn.indexOf(sBeginIdentifier,iPosBegin))>=0){
		iPosEnd = sReturn.indexOf(sEndIdentifier,iPosBegin);
		sAttributeID = sReturn.substring(iPosBegin ,iPosEnd + sEndIdentifier.length);
		sReturn = sReturn.substring(0,iPosBegin) + getAttribute(sAttributes,sAttributeID,iAttID,iAttValue) + sReturn.substring(iPosEnd+sEndIdentifier.length);
	}
	return sReturn;
}


function getAttribute(sAttributes,sAttributeName,iAttID,iAttValue){
	var sAttributeValue;
	for(var i=0;i<sAttributes.length;i++){
		if (sAttributes[i][iAttID]==sAttributeName){
			sAttributeValue = sAttributes[i][iAttValue];
			return sAttributeValue;
		}	
	}	
	return sAttributeValue;
}

function temptest(){
	var tmpstr = "~[pds]12345~[alt]";
	alert(macroReplace(sAmarReplace,tmpstr,"~[","]",1,0));
}

function amarsoft2Html(sSource){
	try{
		if(typeof(sSource)!='string') return sSource;
		sReturn = sSource;
		//sReturn = macroReplace(sAmarReplace,sReturn,"~[","]",1,4);
		for(var i=0;i<sAmarReplace.length;i++)
			sReturn = replaceAll_regex(sReturn,sAmarReplace[i][5],sAmarReplace[i][4]);
		return sReturn;
	}catch(e){
		alert(e.name+" "+e.number+" :"+e.message);
	}	
}

function amarsoft2Real(sSource){
	try{
		if(typeof(sSource)!='string') return sSource;
		sReturn = sSource;
		//sReturn = macroReplace(sAmarReplace,sReturn,"~[","]",1,0);
		for(var i=0;i<sAmarReplace.length;i++)
			sReturn = replaceAll_regex(sReturn,sAmarReplace[i][5],sAmarReplace[i][0]);
		return sReturn;
	}catch(e){
		alert(e.name+" "+e.number+" :"+e.message);
	}	
}
function real2Amarsoft(sSource){
	try{
		if(typeof(sSource)!='string') return sSource;
		sReturn = sSource;
		for(var i=0;i<sAmarReplace.length;i++)
			//sReturn = replaceAll(sReturn,sAmarReplace[i][0],sAmarReplace[i][1]);
			sReturn = replaceAll_regex(sReturn,sAmarReplace[i][6],sAmarReplace[i][1]);
		
		return sReturn;
	}catch(e){
		alert(e.name+" "+e.number+" :"+e.message);
	}	
}

function html2Amarsoft(sSource){
	try{
		if(typeof(sSource)!='string') return sSource;
		sReturn = sSource;
		for(var i=0;i<sAmarReplace.length;i++)
			sReturn = replaceAll(sReturn,sAmarReplace[i][4],sAmarReplace[i][1]);
		
		return sReturn;
	}catch(e){
		alert(e.name+" "+e.number+" :"+e.message);
	}	
}

function html2Real(sSource){
	try{
		if(typeof(sSource)!='string') return sSource;
		sReturn = sSource;
		for(var i=0;i<sAmarReplace.length;i++)
			sReturn = replaceAll(sReturn,sAmarReplace[i][4],sAmarReplace[i][0]);
		
		return sReturn;
	}catch(e){
		alert(e.name+" "+e.number+" :"+e.message);
	}	
}

function replaceAll(sSource,sOldString,sNewString){
	try{
		if(typeof(sSource)!='string') return sSource;
		var iPosBegin = 0;
		sReturn = sSource;
		//alert(sReturn+"\r\n"+sOldString+"\r\n"+sNewString);
		iPosBegin = sReturn.indexOf(sOldString,iPosBegin);
		while(iPosBegin>=0){
			//sReturn = sReturn.replace(sOldString,sNewString);
			sReturn = sReturn.substring(0,iPosBegin)+sNewString+sReturn.substring(iPosBegin+sOldString.length);
			iPosBegin = sReturn.indexOf(sOldString,iPosBegin+sNewString.length);
		}
		return sReturn;
	}catch(e){
		alert(e.name+" "+e.number+" :"+e.message);
	}
}

function replaceAll_regex(sSource,sOldString,sNewString){
    if(typeof(sSource)!='string') return sSource;
    var p = new RegExp(sOldString,"g");
    return sSource.replace(p,sNewString);
}

//检查输入的数据的小数位是否超过规定的位数
function FormatNumber(srcStr,nBeforeDot,nAfterDot){ //格式化数字 (int srcStr,int 小数位数)
	srcStr = new String(srcStr);
	if(srcStr=="" || srcStr==null) return true;
	strLen = srcStr.length;	
	dotPos = srcStr.indexOf(".");		
	if(strLen > (nBeforeDot + nAfterDot +1)){return false;} 
	else {
		if (dotPos == -1) {
			if(strLen> (nBeforeDot + nAfterDot)){return false;}  
		}else if((strLen - dotPos) > (nAfterDot + 1)){return false;} 
	}	
	return true;	
}

//判断输入的数据是否全部为数字或一个点号(.)，如果是数字,返回true.
function reg_Num(str){
	var Letters = "-1234567890.,";
	var j = 0;		
	if(str=="" || str==null) return true;
	for (var i=0;i<str.length;i++) {
		var CheckChar = str.charAt(i);
		if (Letters.indexOf(CheckChar) == -1){return false;}
		if (CheckChar == "."){j = j + 1;}
	}
	if (j > 1){return false;}
	return true;
}

//验证数值 ,这个方法较方法reg_Num()更全面一点    add by zhuang 2010-03-23
function validateNum(str){
    var Letters = "-1234567890.,";
    var j = 0;
    var m = 0;   
    if(str=="0"){
    	return "true";
    }
    if(str=="" || str==null) return "true";//返回值为 “true”表示输入合法
    if(str.charAt(0)=="." || str.charAt(str.length-1)==".") {return "false";}//返回值为 “false”表示输入合法

    for(var i=0;i<str.length;i++){
        var CheckChar = str.charAt(i);
        if (Letters.indexOf(CheckChar) == -1){return "false";}
        if (CheckChar == "."){j = j + 1;} 
    }  
                        
    if (j > 1){
        return "false";
    }else{
    	if(j==1){
    		var sStrSubs = str.split(".");//截取整数部分
    		sStrSub =  sStrSubs[0];           
    	}else if(j==0){
    		sStrSub = str;    
        }
    	for (var k=0;k<sStrSub.length;k++){   
    		CheckChar = sStrSub.charAt(k);               
    		if (CheckChar == "0"){  
    			m = m + 1;
    		}else{
    			break;  
            }
        }
    	//m==1:当数值时整数，且输入的第一个数为0时的处理
    	if((m==1) && (str.indexOf(".")==-1)){
        	return k=1;
        }
    	if(m>1){
    		if(m==sStrSub.length){k = k - 1;}
    		return k;//返回第一个非无效 0 的下标 ，或当整数部分全为0时倒数第二个0的下标值
    	}else{
            return "true";
        }
    }
}

//根据自定义小数位数四舍五入,参数object为传入的数值,参数decimal为保留小数位数
function roundOff(number,digit){
	var sNumstr = 1;
	for (var i=0;i<digit;i++) {
		sNumstr=sNumstr*10;
	}
	sReturnValue = Math.round(parseFloat(number)*sNumstr)/sNumstr;
	return sReturnValue;
}

function amarValue(sMoney,iType){
	if (sMoney==null || typeof(sMoney)=='undefined') return "";
	//modify in 2008/04/10 for 几位小数
	//if(iType!=2 && iType!=5 )
	if(iType!=2 && iType!=5 && iType<=10)
		return sMoney;
	else{
		//modify in 2008/04/10 for 几位小数
		//if(iType==2)
		if(iType==2 || iType>10){
			if(isNaN(parseFloat(sMoney.replace(/,/g,"")))) return "";
			else return parseFloat(sMoney.replace(/,/g,""));
		}
		if(iType==5){
			if(isNaN(parseInt(sMoney.replace(/,/g,""), 10))) return "";
			else return parseInt(sMoney.replace(/,/g,""), 10);
		}
	}
}

//将(金额)整数部分转换成三位一小逗的显示格式（当整数部分位数 <=11 时，小数精度   >=6位；整数位越少，小数精度越高）
function amarMoney(dMoney,iType){  //dMoney:需要转换的金额， iType:转换后的小数位数
    if (dMoney==null || (dMoney==""&&dMoney!=0) || typeof(dMoney)=='undefined') return "";
    if(parseInt(iType,10)!=2 && parseInt(iType,10)!=5 && parseInt(iType,10)<11 ) return dMoney;
    else{
        if(parseInt(iType,10)>10)  iType=parseInt(iType,10)-10;
        else if(parseInt(iType,10)==5)  iType=0;

        if(dMoney==""){
            if( ("amar"+dMoney)=="amar") return "";
            else dMoney=0.00;
        }
        else
        	dMoney = parseFloat(dMoney,10);
        if(isNaN(dMoney)) dMoney=0.00;
        
        //modified by btan 2011/02/14
        //处理特殊情况。当传入的金额为0，精度要求大于等于6时，精度修正后会以科学技术法表示金额，导致转换出错。
		if(dMoney == 0){
			var sReturnValue = "0";
			for(var p=0; p<iType; p++){
				if(p==0) sReturnValue = "0.";
				sReturnValue += "0";
			}
			return sReturnValue;  //比如 0.000000
		}
        
        var sMoney="",i,sTemp="",itemCount,iLength,digit=3,sign="",s1="",s2="",sResultSet="";
        
        //显示修正。修正原理：对需求的小数位数(iType)的下一位数进行四舍五入运算
        var myFraction = 0.5;  //修正基数 （只能是小数）
			for(var ij=1;ij<=iType;ij++)
				myFraction *= 0.1;

        if(dMoney < 0){
            sign = "-";  //符号位
            dMoney = dMoney - myFraction;  //修正最后一位
            sMoney = dMoney.toString().substring(1); //截去符号位
        }else{
        	dMoney = dMoney + myFraction;
        	sMoney = dMoney.toString();
        }
        
        //分出整数部分和小数部分
        if(sMoney.indexOf(".")>-1){
        	s1 = sMoney.substring(0, sMoney.indexOf("."));  //整数部分
        	s2 = sMoney.substring(sMoney.indexOf(".")+1, sMoney.indexOf(".")+1+iType);  //小数部分
        }else{
        	s1 = sMoney;
        	for(var p=0; p<iType; p++){
        		s2 += "0";
			}
        }
       
        //三位一小逗
        iLength = s1.length;  //整数部分的长度（位数）
        itemCount = parseInt((iLength-1)/digit, 10) ;    //计算整数部分的显示段数    
        for (i=0;i<itemCount;i++){
            sTemp = ","+s1.substring(iLength-digit*(i+1),iLength-digit*i)+sTemp;
        }
        
        //将整数部分整理成最终显示模式（符号位+没有截取出来的最高几位+其余整数位）
        sResultSet = sign+s1.substring(0,iLength-digit*i)+sTemp;       
       
        //加上小数部分
        if(iType!=0)    sResultSet = sResultSet + "." + s2;    
       
        return sResultSet;
    }
}

//日期检查函数
function isASDate(value,separator){
	if(value==null||value.length<10) return false;
	var sItems = value.split(separator); // value.split("/");

	if (sItems.length!=3) return false;
	if (isNaN(sItems[0])) return false;
	if (isNaN(sItems[1])) return false;
	if (isNaN(sItems[2])) return false;
	//年份必须为4位，月份和日必须为2位
	if (sItems[0].length!=4) return false;
	if (sItems[1].length!=2) return false;
	if (sItems[2].length!=2) return false;

	if(parseInt(sItems[0],10) == 9999){
		if(parseInt(sItems[1],10) != 12 || parseInt(sItems[2],10) != 31){
			return false;
		}
	}
	if (parseInt(sItems[0],10)<1900 || (parseInt(sItems[0],10) != 9999 && parseInt(sItems[0],10)>2200)) return false;
	if (parseInt(sItems[1],10)<1 || parseInt(sItems[1],10)>12) return false;
	if (parseInt(sItems[2],10)<1 || parseInt(sItems[2],10)>31) return false;

	if ((sItems[1]<=7) && ((sItems[1] % 2)==0) && (sItems[2]>=31)) return false;
	if ((sItems[1]>=8) && ((sItems[1] % 2)==1) && (sItems[2]>=31)) return false;
	//本年不是闰年
	if (!((sItems[0] % 4)==0) && (sItems[1]==2) && (sItems[2]==29)){
		if ((sItems[1]==2) && (sItems[2]==29))
			return false;
	}else{
		if ((sItems[1]==2) && (sItems[2]==30))
			return false;
	}
	return true;
}	

//*******************************end*********************************