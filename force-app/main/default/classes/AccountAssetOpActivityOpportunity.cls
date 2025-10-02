public with sharing class AccountAssetOpActivityOpportunity{
    
    public string FilterAsset{get;set;}    
    public string DebugSOQL{get;set;}
    public string ErrorMessage{get;set;}
    
    // 商談商品リストの作成
    public Map<Id,Map<string,List<OpportunityLineItem__c>>> getOpli2List(AccountAssetOpActivitySearchCondition sc,List<Account> acs){
        ErrorMessage = '';
        DebugSOQL = '';    
        Map<Id,Map<string,List<OpportunityLineItem__c>>> retval = new Map<Id,Map<string,List<OpportunityLineItem__c>>>();
        // OpportunityLineItem__c取得           
        List<OpportunityLineItem__c> assets;
        try{
            assets = [SELECT Id,Name,ProductName__c,Product__r.Name,Product__r.MakerName__c,StageName__c,CloseDate__c,Opportunity__r.Account__r.Id,Product__r.CategoryName1__c,Product__r.CategoryName2__c FROM OpportunityLineItem__c WHERE Opportunity__r.Account__r.Id IN:acs AND StageName__c IN:sc.StageNameList Order By Opportunity__r.Account__r.Id,Product__r.CategoryName1__c,Product__r.CategoryName2__c Limit 5000];
        }catch(Exception ex){
            ErrorMessage = ex.getMessage();
            return retval;
        }
                                 
                                 
        // ループ用変数
        String NowId = '';
        String Category = '';
        Map<string,List<OpportunityLineItem__c>> acas = new Map<string,List<OpportunityLineItem__c>>();
        List<OpportunityLineItem__c> cate = new List<OpportunityLineItem__c>();
        
        for(OpportunityLineItem__c a:assets){
            string AcId = a.Opportunity__r.Account__r.Id;
            Category = a.Product__r.CategoryName1__c + a.Product__r.CategoryName2__c;
            if((a.Product__r.CategoryName2__c == '検査システム') || (a.Product__r.CategoryName2__c == '電子カルテ')){
                Category = 'システム';
            }else if((a.Product__r.CategoryName1__c == 'POC') || (a.Product__r.CategoryName1__c == 'その他')){
                Category = 'その他';
            }
            if(retval.get(AcId) == null){
                acas = new Map<string,List<OpportunityLineItem__c>>();
                cate = new List<OpportunityLineItem__c>();
            }else{
                if(retval.get(AcId).get(Category) == null){
                    cate = new List<OpportunityLineItem__c>();
                }else{
                    acas.remove(Category);
                }
                retval.remove(AcId);
            }
            cate.add(a);
            acas.put(Category,cate);
            retval.put(AcId,acas);
        }
        return retval;
    }
    
    
}