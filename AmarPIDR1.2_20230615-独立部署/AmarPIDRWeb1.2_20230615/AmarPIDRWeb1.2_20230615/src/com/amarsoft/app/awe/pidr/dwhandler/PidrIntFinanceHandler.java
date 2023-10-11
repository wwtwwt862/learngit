package com.amarsoft.app.awe.pidr.dwhandler;

import java.math.BigDecimal;

import com.amarsoft.are.jbo.BizObject;
import com.amarsoft.are.jbo.JBOTransaction;
import com.amarsoft.are.lang.DataElement;
import com.amarsoft.awe.dw.handler.impl.CommonHandler;

/**
 * 	hlsong		2023-02-21
 * 	针对财报部分字段的计算规则
 * 	现金流量表
 */
public class PidrIntFinanceHandler extends CommonHandler {
	
	@Override
	protected void initDisplayForAdd(BizObject bo) throws Exception {
		DataElement[] dataElements = bo.getAttributes();
		for(int i =0 ;i<dataElements.length;i++) {
			DataElement data = dataElements[i];
			byte id = data.getType();//字段类型，4为double
			Object object = data.getValue();
			if(id == 4 && object == null) {
				bo.setAttributeValue(data.getLabel(),0.00);
			}
		}
	}
	
	@Override
	protected void initDisplayForEdit(BizObject bo) throws Exception {
		DataElement[] dataElements = bo.getAttributes();
		for(int i =0 ;i<dataElements.length;i++) {
			DataElement data = dataElements[i];
			byte id = data.getType();//字段类型，4为double
			Object object = data.getValue();
			if(id == 4 && object == null) {
				bo.setAttributeValue(data.getLabel(),0.00);
			}
		}
	}
}
