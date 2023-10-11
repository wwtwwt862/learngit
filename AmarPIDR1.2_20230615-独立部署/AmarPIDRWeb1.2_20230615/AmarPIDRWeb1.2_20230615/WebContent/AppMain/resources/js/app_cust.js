/* 这里放app可调整的js方法和变量，比如在应用中调整的一些底层js变量*/
function createDateStrFilter(obj,tableIndex,iColIndex){
	var sMin = "1900-01-01", sMax = "2100-12-31";
	SelectDate(obj,'yyyy-MM-dd',sMin,sMax,undefined,undefined,undefined,false);
}

function createDateFilter(tableIndex,iColIndex){
	var colname = isNaN(iColIndex)?iColIndex:DZ[tableIndex][1][iColIndex][15];
	var filterOption = getFilterAreaOption(tableIndex,colname);
	var options = {autoUpdateInput:false , alwaysShowCalendars:true, showCustomRangeLabel:true};
	options.ranges = {
//            '今天': [moment(), moment()],
//            '昨天': [moment().subtract(1, 'days'), moment().subtract(1, 'days')],
            '前7天': [moment().subtract(6, 'days'), moment()],
            '前30天': [moment().subtract(29, 'days'), moment()],
            '本月': [moment().startOf('month'), moment().endOf('month')],
            '上个月': [moment().subtract(1, 'month').startOf('month'), moment().subtract(1, 'month').endOf('month')],
            '最近三个月': [moment().subtract(3, 'month'), moment()],
            '最近半年': [moment().subtract(6, 'month'), moment()],
            '最近一年': [moment().subtract(1, 'year'), moment()]
          };
	options.locale = {
      direction: 'ltr',
      format: 'YYYY-MM-DD',
      separator: ' - ',
      applyLabel: '确定',
      cancelLabel: '取消',
      fromLabel: '从',
      toLabel: '到',
      customRangeLabel: '自定义',
      daysOfWeek: ['日', '一', '二', '三', '四', '五','六'],
      monthNames: ['一月', '二月', '三月', '四月', '五月', '六月', '七月', '八月', '九月', '十月', '十一月', '十二月'],
      firstDay: 1
    };
	var rangeStart = $(getFilterAreaInput(tableIndex, colname, 0));
	var rangeEnd = $(getFilterAreaInput(tableIndex, colname, 1));
	var onDateSelected = function(start, end, label){
		rangeStart.val(start.format(options.locale.format));
		MRCheckDate(rangeStart[0]);
		TableFactory.fireEvent(rangeStart[0],'onchange');
		
		rangeEnd.val(end.format(options.locale.format));
		MRCheckDate(rangeEnd[0]);
		TableFactory.fireEvent(rangeEnd[0],'onchange');
	};
	rangeStart.daterangepicker(options, onDateSelected);
	rangeEnd.bind("click",function(){
		rangeStart.click();
	});
	//rangeEnd.daterangepicker(options, onDateSelected);
} 

//IE浏览器的js中startsWith与endsWith不适配问题
String.prototype.startsWith = String.prototype.startsWith || function(str){
	var reg = new RegExp("^" + str);
	return reg.test(this);
}
String.prototype.endsWith = String.prototype.endsWith || function(str){
	var reg = new RegExp(str + "$");
	return reg.test(this);
}




