package com.amarsoft.app.awe.pidr.dwhandler;

import java.math.BigDecimal;

import com.amarsoft.are.jbo.BizObject;
import com.amarsoft.are.jbo.JBOTransaction;
import com.amarsoft.are.lang.DataElement;
import com.amarsoft.awe.dw.handler.impl.CommonHandler;

/**
 *      hlsong		2023-02-21 
 * 	针对财报部分字段的计算规则
 * 	利润表
 */
public class PidrRateIncomeHandler extends CommonHandler {
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
		//一、营业收入
		double revenueOS = bo.getAttribute("RevenueOfSales").getDouble();
		BigDecimal bigRevenueOS=new BigDecimal(String.valueOf(revenueOS));
		//减:营业成本
		double costOS = bo.getAttribute("CostOfSales").getDouble();
		BigDecimal bigCostOS=new BigDecimal(String.valueOf(costOS));
		//税金及附加
		double businessAOT = bo.getAttribute("BusinessAndOtherTaxes").getDouble();
		BigDecimal bigBusinessAOT=new BigDecimal(String.valueOf(businessAOT));
		//销售费用
		double sellingExpenses = bo.getAttribute("SellingExpenses").getDouble();
		BigDecimal bigSellingExpenses=new BigDecimal(String.valueOf(sellingExpenses));
		//管理费用
		double generalAAE = bo.getAttribute("GenAndAdministrativeExpenses").getDouble();
		BigDecimal bigGeneralAAE=new BigDecimal(String.valueOf(generalAAE));
		//研发费用
		double rDExpenses = bo.getAttribute("RDExpenses").getDouble();
		BigDecimal bigRDExpenses=new BigDecimal(String.valueOf(rDExpenses));
		//财务费用
		double financialExpense = bo.getAttribute("FinancialExpense").getDouble();
		BigDecimal bigFinancialExpense=new BigDecimal(String.valueOf(financialExpense));
		//其中:利息费用
		double interestFOFE = bo.getAttribute("InterestFeeOfFinancialExpense").getDouble();
		BigDecimal bigInterestFOFE=new BigDecimal(String.valueOf(interestFOFE));
		//利息收入
		double interestIOFE = bo.getAttribute("IntIncomeOfFinancialExpense").getDouble();
		BigDecimal bigInterestIOFE=new BigDecimal(String.valueOf(interestIOFE));
		//加:其他收益
		double otherIncome = bo.getAttribute("OtherIncome").getDouble();
		BigDecimal bigOtherIncome=new BigDecimal(String.valueOf(otherIncome));
		//投资收益(损失以“-”号填列)
		double investmentIncome = bo.getAttribute("InvestmentIncome").getDouble();
		BigDecimal bigInvestmentIncome=new BigDecimal(String.valueOf(investmentIncome));
		//其中:对联营企业和合营企业的投资收益
		double associatesAJVI = bo.getAttribute("AssociatesAndJointVenturesInc").getDouble();
		BigDecimal bigAssociatesAJVI=new BigDecimal(String.valueOf(associatesAJVI));
		//以摊余成本计量的金融资产终止确认收益(损失以“-”号填列)
		double financialAEI = bo.getAttribute("FinancialAssetsEndIncome").getDouble();
		BigDecimal bigFinancialAEI=new BigDecimal(String.valueOf(financialAEI));
		//净敞口套期收益(损失以“-”号填列)
		double netEHI = bo.getAttribute("NetExposureHedgingIncome").getDouble();
		BigDecimal bigNetEHI=new BigDecimal(String.valueOf(netEHI));
		//公允价值变动收益(损失以“-”号填列)
		double incomeFCIFV = bo.getAttribute("IncomeFromChangesInFairValue").getDouble();
		BigDecimal bigIncomeFCIFV=new BigDecimal(String.valueOf(incomeFCIFV));
		//信用减值损失(损失以“-”号填列)
		double creditIL = bo.getAttribute("CreditImpairmentLoss").getDouble();
		BigDecimal bigCreditIL=new BigDecimal(String.valueOf(creditIL));
		//资产减值损失(损失以“-”号填列)
		double impairmentLOA = bo.getAttribute("ImpairmentLossOfAssets").getDouble();
		BigDecimal bigImpairmentLOA=new BigDecimal(String.valueOf(impairmentLOA));
		//资产处置收益(损失以“-”号填列)
		double incomeFAD= bo.getAttribute("IncomeFromAssetDisposal").getDouble();
		BigDecimal bigIncomeFAD=new BigDecimal(String.valueOf(incomeFAD));
		/**
		 * 	二、营业利润(亏损以“-”号填列)=一、营业收入-营业成本-税金及附加-销售费用-管理费用-研发费用-财务费用
		 * 	+加:其他收益 +投资收益(损失以“-”号填列)+净敞口套期收益(损失以“-”号填列)+公允价值变动收益(损失以“-”号填列)
		 * 	+信用减值损失(损失以“-”号填列)+资产减值损失(损失以“-”号填列)+资产处置收益(损失以“-”号填列)
		 */
		double operatingProfits = bigRevenueOS.subtract(bigCostOS).subtract(bigBusinessAOT).subtract(bigSellingExpenses).subtract(bigGeneralAAE).subtract(bigRDExpenses).subtract(bigFinancialExpense)
				.add(bigOtherIncome)
				.add(bigInvestmentIncome)
				.add(bigNetEHI)
				.add(bigIncomeFCIFV)
				.add(bigCreditIL)
				.add(bigImpairmentLOA)
				.add(bigIncomeFAD)
				.doubleValue();
		
		bo.setAttributeValue("OperatingProfits", operatingProfits);
		
		//加:营业外收入
		double nonOI = bo.getAttribute("NonOperatingIncome").getDouble();
		BigDecimal bigNonOI=new BigDecimal(String.valueOf(nonOI));
		//"减:营业外支出
		double nonOE= bo.getAttribute("NonOperatingExpenses").getDouble();
		BigDecimal bigNonOE=new BigDecimal(String.valueOf(nonOE));
		/**
		 *  三、利润总额(亏损总额以“-”号填列)=二、营业利润(亏损以“-”号填列)+加:营业外收入-减:营业外支出
		 */
		double profitBeforeTax = new BigDecimal(String.valueOf(operatingProfits)).add(bigNonOI).subtract(bigNonOE).doubleValue();
		bo.setAttributeValue("ProfitBeforeTax", profitBeforeTax);
		
		//减:所得税费用
		double incomeTaxExpense = bo.getAttribute("IncomeTaxExpense").getDouble();
		BigDecimal bigIncomeTaxExpense=new BigDecimal(String.valueOf(incomeTaxExpense));
		/**
		 *  四、净利润(净亏损以“-”号填列)=三、利润总额(亏损总额以“-”号填列 -减:所得税费用。
		 */
		double netProfit = new BigDecimal(String.valueOf(profitBeforeTax)).subtract(bigIncomeTaxExpense).doubleValue();
		bo.setAttributeValue("NetProfit", netProfit);

	}
}
