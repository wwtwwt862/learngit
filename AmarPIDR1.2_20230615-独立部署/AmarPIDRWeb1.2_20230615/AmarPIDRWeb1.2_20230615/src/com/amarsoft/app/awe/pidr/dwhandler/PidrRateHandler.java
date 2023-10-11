package com.amarsoft.app.awe.pidr.dwhandler;

import java.math.BigDecimal;

import com.amarsoft.are.jbo.BizObject;
import com.amarsoft.are.jbo.JBOTransaction;
import com.amarsoft.are.lang.DataElement;
import com.amarsoft.are.lang.StringX;
import com.amarsoft.awe.dw.handler.impl.CommonHandler;

/**
 * 	hlsong		2023-02-21 
 *  	针对财报部分字段的计算规则
 * 	资产负债表
 */
public class PidrRateHandler extends CommonHandler {
	
	@Override
	protected void initDisplayForAdd(BizObject bo) throws Exception {
		DataElement[] dataElements = bo.getAttributes();
		for(int i =0 ;i<dataElements.length;i++) {
			DataElement data = dataElements[i];
			byte id = data.getType();
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
			byte id = data.getType();
			Object object = data.getValue();
			if(id == 4 && object == null) {
				bo.setAttributeValue(data.getLabel(),0.00);
			}
		}
	}
	
	protected void beforeUpdate(JBOTransaction tx, BizObject bo) throws Exception {
		//货币资金
		double currencyFunds = bo.getAttribute("CurrencyFunds").getDouble();
		BigDecimal bigCurrencyFunds=new BigDecimal(String.valueOf(currencyFunds));
		//交易性金融资产
		double financialAHFT = bo.getAttribute("FinancialAssetsHeldForTrading").getDouble();
		BigDecimal bigFinancialAHFT=new BigDecimal(String.valueOf(financialAHFT));
		//衍生金融资产
		double derivativeFA = bo.getAttribute("DerivativeFinancialAssets").getDouble();
		BigDecimal bigDerivativeFA=new BigDecimal(String.valueOf(derivativeFA));
		//应收票据
		double notesReceivable = bo.getAttribute("NotesReceivable").getDouble();
		BigDecimal bigNotesReceivable=new BigDecimal(String.valueOf(notesReceivable));
		//应收账款
		double accountsReceivable = bo.getAttribute("AccountsReceivable").getDouble();
		BigDecimal bigAccountsReceivable=new BigDecimal(String.valueOf(accountsReceivable));
		//应收款项融资
		double accountsRF = bo.getAttribute("AccountsReceivableFinancing").getDouble();
		BigDecimal bigAccountsRF=new BigDecimal(String.valueOf(accountsRF));
		//预付款项
		double prepayments = bo.getAttribute("Prepayments").getDouble();
		BigDecimal bigPrepayments=new BigDecimal(String.valueOf(prepayments));
		//其他应收款
		double otherReceivables = bo.getAttribute("OtherReceivables").getDouble();
		BigDecimal bigOtherReceivables=new BigDecimal(String.valueOf(otherReceivables));
		//存货
		double inventories = bo.getAttribute("Inventories").getDouble();
		BigDecimal bigInventories=new BigDecimal(String.valueOf(inventories));
		//合同资产
		double contractAssets = bo.getAttribute("ContractAssets").getDouble();
		BigDecimal bigContractAssets=new BigDecimal(String.valueOf(contractAssets));
		//持有待售资产
		double assetsAFS = bo.getAttribute("AssetsAvailableForSale").getDouble();
		BigDecimal bigAssetsAFS=new BigDecimal(String.valueOf(assetsAFS));
		//一年内到期的非流动资产
		double currentPONCA = bo.getAttribute("CurPortionOfNonCurrentAssets").getDouble();
		BigDecimal bigCurrentCurrentPONCA=new BigDecimal(String.valueOf(currentPONCA));
		//其他流动资产
		double otherCurrentAssets = bo.getAttribute("OtherCurrentAssets").getDouble();
		BigDecimal bigOtherCurrentAssets=new BigDecimal(String.valueOf(otherCurrentAssets));
		/**
		 * 流动资产合计=货币资金+交易性金融资产+衍生金融资产+应收票据+应收账款+应收款项融资+预付款项+其他应收款+存货+合同资产+持有待售资产+一年内到期的非流动资产+其他流动资产
		 */
		double totalCurrentAssets=bigCurrencyFunds.add(bigFinancialAHFT).add(bigDerivativeFA).add(bigNotesReceivable).add(bigAccountsReceivable).add(bigAccountsRF)
																						.add(bigPrepayments).add(bigOtherReceivables).add(bigInventories).add(bigContractAssets).add(bigAssetsAFS)
																						.add(bigCurrentCurrentPONCA).add(bigOtherCurrentAssets).doubleValue();
		bo.setAttributeValue("TotalCurrentAssets", totalCurrentAssets);
		 
		//债权投资
		double debtInvestment = bo.getAttribute("DebtInvestment").getDouble();
		BigDecimal bigDebtInvestment=new BigDecimal(String.valueOf(debtInvestment));
		//其他债权投资
		double otherDI = bo.getAttribute("OtherDebtInvestment").getDouble();
		BigDecimal bigOtherDI=new BigDecimal(String.valueOf(otherDI));
		//长期应收款
		double longTR = bo.getAttribute("LongTermReceivables").getDouble();
		BigDecimal bigLongTR=new BigDecimal(String.valueOf(longTR));
		//长期股权投资
		double longTEI = bo.getAttribute("LongTermEquityInvestment").getDouble();
		BigDecimal bigLongTEI=new BigDecimal(String.valueOf(longTEI));
		//其他权益工具投资
		double otherEII = bo.getAttribute("OthEquityInstrumentsInvestment").getDouble();
		BigDecimal bigOtherEII=new BigDecimal(String.valueOf(otherEII));
		//其他非流动金融资产
		double otherNCFA = bo.getAttribute("OtherNonCurrentFinancialAssets").getDouble();
		BigDecimal bigOtherNCFA=new BigDecimal(String.valueOf(otherNCFA));
		//投资性房地产
		double investmentProperties = bo.getAttribute("InvestmentProperties").getDouble();
		BigDecimal bigInvestmentProperties=new BigDecimal(String.valueOf(investmentProperties));
		//固定资产
		double fixedAssets = bo.getAttribute("FixedAssets").getDouble();
		BigDecimal bigFixedAssets=new BigDecimal(String.valueOf(fixedAssets));
		//在建工程
		double constructionInProgress = bo.getAttribute("ConstructionInProgress").getDouble();
		BigDecimal bigConstructionInProgress=new BigDecimal(String.valueOf(constructionInProgress));
		//生产性生物资产
		double nonCBA = bo.getAttribute("NonCurrentBiologicalAssets").getDouble();
		BigDecimal bigNonCBA=new BigDecimal(String.valueOf(nonCBA));
		//油气资产
		double oilAGA = bo.getAttribute("OilAndGasAssets").getDouble();
		BigDecimal bigOilAGA=new BigDecimal(String.valueOf(oilAGA));
		//使用权资产
		double useRA = bo.getAttribute("UseRightAssets").getDouble();
		BigDecimal bigUseRA=new BigDecimal(String.valueOf(useRA));
		//无形资产
		double intangibleAssets = bo.getAttribute("IntangibleAssets").getDouble();
		BigDecimal bigIntangibleAssets=new BigDecimal(String.valueOf(intangibleAssets));
		//开发支出
		double developmentDisbursements = bo.getAttribute("DevelopmentDisbursements").getDouble();
		BigDecimal bigDevelopmentDisbursements=new BigDecimal(String.valueOf(developmentDisbursements));
		//商誉
		double goodwill = bo.getAttribute("Goodwill").getDouble();
		BigDecimal bigGoodwill=new BigDecimal(String.valueOf(goodwill));
		//长期待摊费用
		double longTDE = bo.getAttribute("LongTermDeferredExpenses").getDouble();
		BigDecimal bigLongTDE=new BigDecimal(String.valueOf(longTDE));
		//递延所得税资产
		double deferredTA = bo.getAttribute("DeferredTaxAssets").getDouble();
		BigDecimal bigDeferredTA=new BigDecimal(String.valueOf(deferredTA));
		//其他非流动资产
		double otherNCA = bo.getAttribute("OtherNonCurrentAssets").getDouble();
		BigDecimal bigOtherNCA=new BigDecimal(String.valueOf(otherNCA));
		/**
		 * 非流动资产合计=债权投资+其他债权投资+长期应收款+长期股权投资+其他权益工具投资+其他非流动金融资产+投资性房地产
		 * 								+固定资产+在建工程+生产性生物资产+油气资产+使用权资产+无形资产
		 * 								+开发支出+商誉+长期待摊费用+递延所得税资产+其他非流动资产
		 */
		double totalNonCurrentAssets = bigDebtInvestment.add(bigOtherDI).add(bigLongTR).add(bigLongTEI).add(bigOtherEII).add(bigOtherNCFA).add(bigInvestmentProperties)
																								  .add(bigFixedAssets).add(bigConstructionInProgress).add(bigNonCBA).add(bigOilAGA).add(bigUseRA).add(bigIntangibleAssets)
																								  .add(bigDevelopmentDisbursements).add(bigGoodwill).add(bigLongTDE).add(bigDeferredTA).add(bigOtherNCA).doubleValue();
		bo.setAttributeValue("totalNonCurrentAssets", totalNonCurrentAssets);
		 
		/**
		 * 资产总计=流动资产合计+非流动资产合计
		 */
		double totalAssets = new BigDecimal(String.valueOf(totalCurrentAssets)).add(new BigDecimal(String.valueOf(totalNonCurrentAssets))).doubleValue();
		bo.setAttributeValue("TotalAssets", totalAssets);
		
		//短期借款
		double shortTB = bo.getAttribute("ShortTermBorrowings").getDouble();
		BigDecimal bigShortTB=new BigDecimal(String.valueOf(shortTB));
		//交易性金融负债
		double financialLHFT = bo.getAttribute("FinLiabilitiesHeldForTrading").getDouble();
		BigDecimal bigFinancialLHFT=new BigDecimal(String.valueOf(financialLHFT));
		//衍生金融负债
		double derivativeFL = bo.getAttribute("DerivativeFinancialLiabilities").getDouble();
		BigDecimal bigDerivativeFL=new BigDecimal(String.valueOf(derivativeFL));
		//应付票据
		double notesPayable = bo.getAttribute("NotesPayable").getDouble();
		BigDecimal bigNotesPayable=new BigDecimal(String.valueOf(notesPayable));
		//应付账款
		double accountsPayable = bo.getAttribute("AccountsPayable").getDouble();
		BigDecimal bigAccountsPayable=new BigDecimal(String.valueOf(accountsPayable));
		//预收款项
		double receiptsIA = bo.getAttribute("ReceiptsInAdvance").getDouble();
		BigDecimal bigReceiptsIA=new BigDecimal(String.valueOf(receiptsIA));
		//合同负债
		double contractualLiabilities = bo.getAttribute("ContractualLiabilities").getDouble();
		BigDecimal bigContractualLiabilities=new BigDecimal(String.valueOf(contractualLiabilities));
		//应付职工薪酬
		double employeeBP = bo.getAttribute("EmployeeBenefitsPayable").getDouble();
		BigDecimal bigEmployeeBP=new BigDecimal(String.valueOf(employeeBP));
		//应交税费
		double taxesPayable = bo.getAttribute("TaxesPayable").getDouble();
		BigDecimal bigTaxesPayable=new BigDecimal(String.valueOf(taxesPayable));
		//其他应付款
		double otherPayables = bo.getAttribute("OtherPayables").getDouble();
		BigDecimal bigOtherPayables=new BigDecimal(String.valueOf(otherPayables));
		//持有待售负债
		double liabilitiesHFS= bo.getAttribute("LiabilitiesHeldForSale").getDouble();
		BigDecimal bigLiabilitiesHFS=new BigDecimal(String.valueOf(liabilitiesHFS));
		//一年内到期的非流动负债
		double currentPOLTL = bo.getAttribute("CurPorOfLongTermLiabilities").getDouble();
		BigDecimal bigCurrentPOLTL=new BigDecimal(String.valueOf(currentPOLTL));
		//其他流动负债
		double otherCurrentLiabilities = bo.getAttribute("OtherCurrentLiabilities").getDouble();
		BigDecimal bigOtherCurrentLiabilities=new BigDecimal(String.valueOf(otherCurrentLiabilities));
		/**
		 * 	流动负债合计=短期借款+交易性金融负债+衍生金融负债+应付票据+应付账款+预收款项 +合同负债+应付职工薪酬+应交税费+其他应付款+持有待售负债+一年内到期的非流动负债+其他流动负债
		 */
		double totalCurrentLiabilities = bigShortTB.add(bigFinancialLHFT).add(bigDerivativeFL).add(bigNotesPayable).add(bigAccountsPayable).add(bigReceiptsIA)
																											.add(bigContractualLiabilities).add(bigEmployeeBP).add(bigTaxesPayable).add(bigOtherPayables)
																											.add(bigLiabilitiesHFS).add(bigCurrentPOLTL).add(bigOtherCurrentLiabilities).doubleValue();
		bo.setAttributeValue("TotalCurrentLiabilities", totalCurrentLiabilities);
		 
		//长期借款
		double longTB = bo.getAttribute("LongTermBorrowings").getDouble();
		BigDecimal bigLongTB=new BigDecimal(String.valueOf(longTB));
		//应付债券
		double bondsPayables = bo.getAttribute("BondsPayables").getDouble();
		BigDecimal bigBondsPayables=new BigDecimal(String.valueOf(bondsPayables));
		//租赁负债
		double leaseLiabilities = bo.getAttribute("LeaseLiabilities").getDouble();
		BigDecimal bigLeaseLiabilities=new BigDecimal(String.valueOf(leaseLiabilities));
		//长期应付款
		double longTP = bo.getAttribute("LongTermPayables").getDouble();
		BigDecimal bigLongTP=new BigDecimal(String.valueOf(longTP));
		//预计负债
		double provisions = bo.getAttribute("Provisions").getDouble();
		BigDecimal bigProvisions=new BigDecimal(String.valueOf(provisions));
		//递延收益
		double deferredIncome = bo.getAttribute("DeferredIncome").getDouble();
		BigDecimal bigDeferredIncome=new BigDecimal(String.valueOf(deferredIncome));
		//递延所得税负债
		double deferredTL = bo.getAttribute("DeferredTaxLiabilities").getDouble();
		BigDecimal bigDeferredTL=new BigDecimal(String.valueOf(deferredTL));
		//其他非流动负债
		double otherNCL = bo.getAttribute("OtherNonCurrentLiabilities").getDouble();
		BigDecimal bigOtherNCL=new BigDecimal(String.valueOf(otherNCL));
		/**
		 * 非流动负债合计=长期借款+应付债券+租赁负债+长期应付款+预计负债+递延收益+递延所得税负债+其他非流动负债
		 */
		double totalNonCurrentLiabilities = bigLongTB.add(bigBondsPayables).add(bigLeaseLiabilities).add(bigLongTP).add(bigProvisions).add(bigDeferredIncome).add(bigDeferredTL).add(bigOtherNCL).doubleValue();
		bo.setAttributeValue("TotalNonCurrentLiabilities", totalNonCurrentLiabilities);
		/**
		 * 负债合计=流动负债合计+非流动负债合计
		 */
		double totalLiabilities = new BigDecimal(String.valueOf(totalCurrentLiabilities)).add(new BigDecimal(String.valueOf(totalNonCurrentLiabilities))).doubleValue();
		bo.setAttributeValue("TotalLiabilities", totalLiabilities);
		 
		//实收资本(或股本)
		double paidICOSC = bo.getAttribute("PaidInCapitalOrShareCapital").getDouble();
		BigDecimal bigPaidICOSC=new BigDecimal(String.valueOf(paidICOSC));
		//其他权益工具投资
		double otherEI = bo.getAttribute("OtherEquityInstruments").getDouble();
		BigDecimal bigOtherEI=new BigDecimal(String.valueOf(otherEI));
		//资本公积
		double capitalrRserve = bo.getAttribute("CapitalrRserve").getDouble();
		BigDecimal bigCapitalrRserve=new BigDecimal(String.valueOf(capitalrRserve));
		//减:库存股
		double lessTS = bo.getAttribute("LessTreasuryStocks").getDouble();
		BigDecimal bigLessTS=new BigDecimal(String.valueOf(lessTS));
		//其他综合收益
		double otherCI = bo.getAttribute("OtherComprehensiveIncome").getDouble();
		BigDecimal bigOtherCI=new BigDecimal(String.valueOf(otherCI));
		//专项储备
		double specialReserve = bo.getAttribute("SpecialReserve").getDouble();
		BigDecimal bigSpecialReserve=new BigDecimal(String.valueOf(specialReserve));
		//盈余公积
		double surplusReserve = bo.getAttribute("SurplusReserve").getDouble();
		BigDecimal bigSurplusReserve=new BigDecimal(String.valueOf(surplusReserve));
		//未分配利润
		double unappropriatedProfit = bo.getAttribute("UnappropriatedProfit").getDouble();
		BigDecimal bigUnappropriatedProfit=new BigDecimal(String.valueOf(unappropriatedProfit));
		/**
		 * 所有者权益(或股东权益)合计=实收资本+其他权益工具+资本公积-减:库存股+其他综合收益+专项储备+盈余公积+未分配利润
		 */
		double totalEquity = bigPaidICOSC.add(bigOtherEI).add(bigCapitalrRserve).subtract(bigLessTS).add(bigOtherCI).add(bigSpecialReserve).add(bigSurplusReserve).add(bigUnappropriatedProfit).doubleValue();
		bo.setAttributeValue("TotalEquity", totalEquity);
		/**
		 * 负债和所有者权益(或股东权益)总计=负债合计+所有者权益(或股东权益)合计
		 */
		double totalEquityAndLiabilities =new BigDecimal(String.valueOf(totalLiabilities)).add(new BigDecimal(String.valueOf(totalEquity))).doubleValue();
		bo.setAttributeValue("TotalEquityAndLiabilities", totalEquityAndLiabilities);
	}
}
