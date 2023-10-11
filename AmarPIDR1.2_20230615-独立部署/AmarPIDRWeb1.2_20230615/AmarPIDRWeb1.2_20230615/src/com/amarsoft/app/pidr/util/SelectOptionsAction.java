package com.amarsoft.app.pidr.util;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import com.amarsoft.are.jbo.BizObject;
import com.amarsoft.are.jbo.BizObjectManager;
import com.amarsoft.are.jbo.BizObjectQuery;
import com.amarsoft.are.jbo.JBOException;
import com.amarsoft.are.jbo.JBOFactory;
import com.amarsoft.are.jbo.JBOTransaction;
import com.amarsoft.are.lang.StringX;
import com.amarsoft.are.util.json.JSONEncoder;

public class SelectOptionsAction {
	
	private String codeNo;
	private String subCodeNo;
	private String pbCode;
	
	public String getSelectOptions(JBOTransaction tx) throws JBOException {
		BizObjectManager bom = JBOFactory.getBizObjectManager("jbo.pidr.PIDR_CODE_LIBRARY");
		String sql = "select PbCode,PbItemName from O where CodeNo=:CodeNo and SubCodeNo=:SubCodeNo";
		if("2".equals(subCodeNo)) {
			sql += " and CbCode = '20'";
		}
		BizObjectQuery query = bom.createQuery(sql)
				.setParameter("CodeNo", codeNo)
				.setParameter("SubCodeNo", subCodeNo);
		List<BizObject> list = query.getResultList(false);
		
		if(list.isEmpty()) {
			return "NULL";
		}
		ArrayList<HashMap> mapList = new ArrayList<HashMap>();
		for (BizObject bo : list) {
			HashMap<String, String> map = new HashMap<String, String>();
			map.put("PbCode", bo.getAttribute("PbCode").getString());
			map.put("PbItemName", bo.getAttribute("PbItemName").getString());
			mapList.add(map);
		}
		if(!StringX.isEmpty(pbCode)) {
			sql += " and PbCode=:PbCode";
			query = bom.createQuery(sql).setParameter("CodeNo", codeNo).setParameter("SubCodeNo", subCodeNo).setParameter("PbCode", pbCode);
			BizObject object = query.getSingleResult(false);
			if(object!=null){
				HashMap<String, String> map = new HashMap<String, String>();
				map.put("PbCode", object.getAttribute("PbCode").getString());
				map.put("PbItemName", object.getAttribute("PbItemName").getString());
				mapList.add(map);
			}
		}
		if(StringX.isEmpty(pbCode)) {
			HashMap<String, String> map = new HashMap<String, String>();
			map.put("PbCode", "");
			map.put("PbItemName", "--请选择--");
			mapList.add(map);
		}
		String result = JSONEncoder.encode(mapList);
		return result;
	}

	public String getCodeNo() {
		return codeNo;
	}

	public void setCodeNo(String codeNo) {
		this.codeNo = codeNo;
	}

	public String getSubCodeNo() {
		return subCodeNo;
	}

	public void setSubCodeNo(String subCodeNo) {
		this.subCodeNo = subCodeNo;
	}

	public String getPbCode() {
		return pbCode;
	}

	public void setPbCode(String pbCode) {
		this.pbCode = pbCode;
	}
}
