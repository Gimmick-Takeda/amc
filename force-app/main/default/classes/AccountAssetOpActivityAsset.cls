public with sharing class AccountAssetOpActivityAsset{
    
    public string FilterAsset{get;set;}    
    public string DebugSOQL{get;set;}
    public string ErrorMessage{get;set;}

    
    // 納入商品リストの作成
    public Map<Id,Map<string,List<Asset__c>>> getAsset2List(AccountAssetOpActivitySearchCondition sc,List<Account> acs){
        ErrorMessage = '';
        DebugSOQL = '';
        Map<Id,Map<string,List<Asset__c>>> retval = new Map<Id,Map<string,List<Asset__c>>>();
        // Asset__c取得                   

        List<Asset__c> assets;
        try{
            assets = [SELECT Id,Name,ProductName__c,ELAPSEDYEARS__c,Product__r.Name,Product__r.MakerName__c,Account__c,Account__r.Id,CategoryName1__c,CategoryName2__c From Asset__c WHERE Account__c IN:acs  AND IsOperationEnd__c = false Order By Account__r.Id,CategoryName1__c,CategoryName2__c Limit 5000] ;
        }catch(Exception ex){
            ErrorMessage = ex.getMessage(); 
            return retval;
        }
                                                
        // ループ用変数
        String NowId = '';
        String Category = '';
        Map<string,List<Asset__c>> acas = new Map<string,List<Asset__c>>();
        List<Asset__c> cate = new List<Asset__c>();
        
        for(Asset__c a:assets){
            string AcId = a.Account__r.Id;
            Category = a.CategoryName1__c + a.CategoryName2__c;
            if((a.CategoryName2__c == '検査システム') || (a.CategoryName2__c == '電子カルテ')){
                Category = 'システム';
            }else if((a.CategoryName1__c == 'POC') || (a.CategoryName1__c == 'その他')){
                Category = 'その他';
            }            
            
            if(retval.get(AcId) == null){
                acas = new Map<string,List<Asset__c>>();
                cate = new List<Asset__c>();
            }else{
                if(retval.get(AcId).get(Category) == null){
                    cate = new List<Asset__c>();
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