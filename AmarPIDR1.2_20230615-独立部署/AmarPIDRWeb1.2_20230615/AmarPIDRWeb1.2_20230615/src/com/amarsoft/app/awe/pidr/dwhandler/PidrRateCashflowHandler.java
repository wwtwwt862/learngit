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
public class PidrRateCashflowHandler extends CommonHandler {
	
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
	
	protected void beforeUpdate(JBOTransaction tx, BizObject bo) throws Exception {
		//销售商品、提供劳务收到的现金
		double cashReceivedFSOGORO = bo.getAttribute("CashReceivedFromSalesOGOROS").getDouble();
		BigDecimal bigCashReceivedFSOGORO=new BigDecimal(String.valueOf(cashReceivedFSOGORO));
		//收到的税费返还
		double taxRefunds = bo.getAttribute("TaxRefunds").getDouble();
		BigDecimal bigTaxRefunds=new BigDecimal(String.valueOf(taxRefunds));
		//收到其他与经营活动有关的现金
		double otherCashRRTOA = bo.getAttribute("OtherCashReceivedRTOA").getDouble();
		BigDecimal bigOtherCashRRTOA=new BigDecimal(String.valueOf(otherCashRRTOA));
		/**
		 *  经营活动现金流入小计=销售商品、提供劳务收到的现金+收到的税费返还+收到其他与经营活动有关的现金
		 */
		double totalCFOA = bigCashReceivedFSOGORO.add(bigTaxRefunds).add(bigOtherCashRRTOA).doubleValue();
		bo.setAttributeValue("TotalCashInflowsFromOA", totalCFOA);
		
		//购买商品、接受劳务支付的现金
		double cashPFGAS = bo.getAttribute("CashPaidForGoodsAndServices").getDouble();
		BigDecimal bigCashPFGAS=new BigDecimal(String.valueOf(cashPFGAS));
		//支付给职工以及为职工支付的现金
		double cashPTAOBOE = bo.getAttribute("CashPaidToAndOnBOE").getDouble();
		BigDecimal bigCashPTAOBOE=new BigDecimal(String.valueOf(cashPTAOBOE));
		//支付的各项税费
		double paymentsOATOT = bo.getAttribute("PaymentsOfAllTypesOfTaxes").getDouble();
		BigDecimal bigPaymentsOATOT=new BigDecimal(String.valueOf(paymentsOATOT));
		//支付其他与经营活动有关的现金
		double otherCPFOA = bo.getAttribute("OtherCashPaymentsFromOA").getDouble();
		BigDecimal bigOtherCPFOA=new BigDecimal(String.valueOf(otherCPFOA));
		
		//经营活动现金流出小计
		double totalCOFOA =bigCashPFGAS.add(bigCashPTAOBOE).add(bigPaymentsOATOT).add(bigOtherCPFOA).doubleValue();
		bo.setAttributeValue("TotalCashOutflowsFromOA", totalCOFOA);
		/**
		 *  经营活动产生的现金流量净额=经营活动现金流入小计-经营活动现金流出小计
		 */
		double netCFFOA = new BigDecimal(String.valueOf(totalCFOA)).subtract(new BigDecimal(String.valueOf(totalCOFOA))).doubleValue();
		bo.setAttributeValue("NetCashFlowsFromOA", netCFFOA);
		 
		//收回投资收到的现金
		double cashRFROI = bo.getAttribute("CashReceivedFromROI").getDouble();
		BigDecimal bigCashRFROI=new BigDecimal(String.valueOf(cashRFROI));
		//取得投资收益收到的现金
		double cashRFO = bo.getAttribute("CashReceivedFromOnvestments").getDouble();
		BigDecimal bigCashRFO=new BigDecimal(String.valueOf(cashRFO));
		//处置固定资产、无形资产和其他长期资产收回的现金净额
		double netCAOLTA = bo.getAttribute("NetCashAndOtherLongTermAssets").getDouble();
		BigDecimal bigNetCAOLTA=new BigDecimal(String.valueOf(netCAOLTA));
		//处置子公司及其他营业单位收到的现金净额
		double netCRFDSAOB = bo.getAttribute("NetCashReceivedFromDSAOB").getDouble();
		BigDecimal bigNetCRFDSAOB=new BigDecimal(String.valueOf(netCRFDSAOB));
		//收到其他与投资活动有关的现金
		double cashRRTOIA = bo.getAttribute("CashReceivedRelatingToOIA").getDouble();
		BigDecimal bigCashRRTOIA=new BigDecimal(String.valueOf(cashRRTOIA));
		/**
		 *  投资活动现金流入小计=收回投资收到的现金+取得投资收益收到的现金+处置固定资产、无形资产和其他长期资产收回的现金净额+处置子公司及其他营业单位收到的现金净额+收到其他与投资活动有关的现金
		 */
		double totalCIFIA = bigCashRFROI.add(bigCashRFO).add(bigNetCAOLTA).add(bigNetCRFDSAOB).add(bigCashRRTOIA).doubleValue();
		bo.setAttributeValue("TotalCashInflowsFromIA", totalCIFIA);
		 
		//购建固定资产、无形资产和其他长期资产支付的现金
		double cashPaidToAcquire = bo.getAttribute("CashPaidToAcquire").getDouble();
		BigDecimal bigCashPaidToAcquire=new BigDecimal(String.valueOf(cashPaidToAcquire));
		//投资支付的现金
		double cashPFI = bo.getAttribute("CashPaymentsForInvestments").getDouble();
		BigDecimal bigCashPFI=new BigDecimal(String.valueOf(cashPFI));
		//取得子公司及其他营业单位支付的现金净额
		double netCPTSAOB = bo.getAttribute("NetCashPaidToASAOB").getDouble();
		BigDecimal bigNetCPTSAOB=new BigDecimal(String.valueOf(netCPTSAOB));
		//支付其他与投资活动有关的现金
		double cashPRTOIA = bo.getAttribute("CashPaymentsRelatedToTA").getDouble();
		BigDecimal bigCashPRTOIA=new BigDecimal(String.valueOf(cashPRTOIA));
		/**
		 *  投资活动现金流出小计=购建固定资产、无形资产和其他长期资产所支付的现金+投资支付的现金+取得子公司及其他营业单位支付的现金净额+支付其他与投资活动有关的现金
		 */
		double subTotalOfCashOutflows = bigCashPaidToAcquire.add(bigCashPFI).add(bigNetCPTSAOB).add(bigCashPRTOIA).doubleValue();
		bo.setAttributeValue("SubTotalOfCashOutflows", subTotalOfCashOutflows);
		/**
		 *  投资活动产生的现金流量净额=投资活动现金流入小计-投资活动现金流出小计
		 */
		double netCFFA =new BigDecimal(String.valueOf(totalCIFIA)).subtract(new BigDecimal(String.valueOf(subTotalOfCashOutflows))).doubleValue();
		bo.setAttributeValue("NetCashFlowsFromIA", netCFFA);
		 
		//吸收投资收到的现金
		double cashRFI = bo.getAttribute("CashReceivedFromInvestors").getDouble();
		BigDecimal bigCashRFI=new BigDecimal(String.valueOf(cashRFI));
		//取得借款收到的现金
		double cashFB = bo.getAttribute("CashFromBorrowings").getDouble();
		BigDecimal bigCashFB=new BigDecimal(String.valueOf(cashFB));
		//收到其他与筹资活动有关的现金
		double otherCRRTFA = bo.getAttribute("OtherCashReceivedRelatingTFA").getDouble();
		BigDecimal bigOtherCRRTFA=new BigDecimal(String.valueOf(otherCRRTFA));
		/**
		 *  筹资活动现金流入小计=吸收投资收到的现金+取得借款收到的现金+收到其他与筹资活动有关的现金
		 */
		double totalCashInflowsFromFinancingActivities = bigCashRFI.add(bigCashFB).add(bigOtherCRRTFA).doubleValue();
		bo.setAttributeValue("TotalCashInflowsFromFA", totalCashInflowsFromFinancingActivities);
		 
		//偿还债务支付的现金
		double cashRFD = bo.getAttribute("CashRepaymentsForDebts").getDouble();
		BigDecimal bigCashRFD=new BigDecimal(String.valueOf(cashRFD));
		//分配股利、利润或偿付利息支付的现金
		double cashPFD= bo.getAttribute("CashPaymentsForDist").getDouble();
		BigDecimal bigCashPFD=new BigDecimal(String.valueOf(cashPFD));
		//支付其他与筹资活动有关的现金
		double cashPRTOFA = bo.getAttribute("CashPaymentsRelatedToOFA").getDouble();
		BigDecimal bigCashPRTOFA=new BigDecimal(String.valueOf(cashPRTOFA));
		/**
		 *  筹资活动现金流出小计=偿还债务支付的现金+分配股利、利润或偿付利息支付的现金+支付其他与筹资活动有关的现金
		 */
		double totalCOFFA =bigCashRFD.add(bigCashPFD).add(bigCashPRTOFA).doubleValue();
		bo.setAttributeValue("TotalCashOutflowsFromFA", totalCOFFA);
		/**
		 *  筹资活动产生的现金流量净额=筹资活动现金流入小计-筹资活动现金流出小计
		 */
		double netCFFFA = new BigDecimal(String.valueOf(totalCashInflowsFromFinancingActivities)).subtract(new BigDecimal(String.valueOf(totalCOFFA))).doubleValue();
		bo.setAttributeValue("NetCashFlowsFromFA", netCFFFA);
		//四、汇率变动对现金及现金等价物的影响
		double effectOERCO = bo.getAttribute("EffectOfExchangRateCOC").getDouble();
		/**
		 *  五、现金及现金等价物净增加额 =经营活动产生的现金流量净额+投资活动产生的现金流量净额+筹资活动产生的现金流量净额+四、汇率变动对现金及现金等价物的影响
		 */
		double netIICCE = new BigDecimal(String.valueOf(netCFFOA)).add(new BigDecimal(String.valueOf(netCFFA)))
			.add(new BigDecimal(String.valueOf(netCFFFA)))
		    .add(new BigDecimal(String.valueOf(effectOERCO)))
	        .doubleValue();
		bo.setAttributeValue("NetIncreaseInCashAndCE", netIICCE);
		//加:期初现金及现金等价物余额
		double initialCCEEB = bo.getAttribute("InitialCashAndCashEB").getDouble();
		/**
		 *  六、期末现金及现金等价物余额=五、现金及现金等价物净增加额+加:期初现金及现金等价物余额
		 */
		double theFCACEB = new BigDecimal(String.valueOf(netIICCE)).add(new BigDecimal(String.valueOf(initialCCEEB))).doubleValue();
		bo.setAttributeValue("TheFinalCashAndCashEB", theFCACEB);
	}
}
