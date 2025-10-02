public class QuotationCountupLEX{
    
     public QuotationCountupLEX(ApexPages.StandardController controller){
        
    }
    
    public void countup() {

        Opportunity__c opp = [SELECT ID,QuotationNo__c,QuotationType__c,Customer_Length__c,AccountPriceCheck__c,OpenPriceCount__c,SetProductNameLength__c,WholesaleMQNameCount__c,MQPaymentNameLength__c,MQPriceNoInput__c
                          FROM Opportunity__c
                          WHERE ID =:ApexPages.currentPage().getParameters().get('id') ];
        
        if (opp.QuotationType__c == '01：個別価格タイプ（卸）' && opp.Customer_Length__c == 0) {
        } else if (opp.QuotationType__c == '01b：個別価格タイプ（相見積）' && (opp.WholesaleMQNameCount__c == 0 || opp.MQPaymentNameLength__c == 0 || opp.MQPriceNoInput__c > 0)){
        } else if (opp.QuotationType__c == '02：個別価格タイプ（施設）' && opp.AccountPriceCheck__c > 0){
        } else if (opp.QuotationType__c == '03：一括値引タイプ（卸）' && (opp.OpenPriceCount__c > 0 || opp.Customer_Length__c == 0)){
        } else if (opp.QuotationType__c == '03b：一括値引タイプ（相見積）' && (opp.WholesaleMQNameCount__c == 0 || opp.MQPaymentNameLength__c == 0 || opp.MQPriceNoInput__c > 0)){
        } else if (opp.QuotationType__c == '04：一括値引タイプ（施設）' && (opp.OpenPriceCount__c > 0 || opp.AccountPriceCheck__c > 0)){
        } else if (opp.QuotationType__c == '05：一式見積タイプ（卸）' && (opp.Customer_Length__c == 0 || opp.SetProductNameLength__c == 0)){
        } else if (opp.QuotationType__c == '05b：一式見積タイプ（相見積）' && (opp.WholesaleMQNameCount__c == 0 || opp.MQPaymentNameLength__c == 0 || opp.MQPriceNoInput__c > 0)){
        } else if (opp.QuotationType__c == '06：一式見積タイプ（施設）' && (opp.AccountPriceCheck__c > 0 || opp.SetProductNameLength__c == 0)){
        } else {
            if (opp.QuotationNo__c >= 1) {
                opp.QuotationNo__c += 1;
            } else {
                opp.QuotationNo__c = 1;
            }
            update opp;
        }
    }    
    
}