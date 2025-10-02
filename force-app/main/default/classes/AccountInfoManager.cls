public with sharing class AccountInfoManager {
	
	public static void UpateAccountCCRankClear(){
		List<Account> accounts = [SELECT Id,Name FROM Account 
									WHERE AssetsInfoText__c !=: '' Limit 200];
		for(Account ac:accounts){
			ac.AssetsInfoText__c = '';
		}
		update accounts;
	}	
	
	
	public static void UpateAccountCCRank(){
		List<Account> accounts = [SELECT Id,Name FROM Account 
									WHERE CCReagentSaleRank__c IN ('S','A','B','C','D','E') AND AssetsInfoText__c =: '' ORDER BY CCReagentSaleRank__c Limit 50];
		for(Account ac:accounts){
			UpdateAssets(ac.Id);
		}
	}
	
    @future
    public static void UpdateAssets(Id accountid){
    	// 取引先取得
		List<Account> accounts = [SELECT Id,Name,AssetsInfo__c,AssetsInfoText__c FROM Account 
								WHERE Id =: accountid Limit 2];
		if(accounts.size()==1){
			String assetinfos = '';
			String assetinfosText = '';
			
			// 納入商品取得
			List<Asset__c> assets = [SELECT Id,Name,ProductName__c,ELAPSEDYEARS__c FROM Asset__c 
									WHERE Account__c =: accountid AND IsOperationEnd__c = false ORDER BY DisplayPosition__c];
			for(Asset__c asset:assets){
				String color = 'Black';
				String mark = '';
				if(asset.ELAPSEDYEARS__c >= 4){
					mark = ' ☆';	
				}				
				if(asset.ELAPSEDYEARS__c >= 5){
					mark = ' ★';
					color = '#ff0000';	
				}
				String assetinfo = '<a href="/' + asset.Id + '" target="_blank">' + asset.ProductName__c + '</a>  <font color="' + color + '">' + asset.ELAPSEDYEARS__c + '年</font><br>';
				String assetinfoText = asset.ProductName__c + '  ' + asset.ELAPSEDYEARS__c + '年' + mark + '\n';
				assetinfos = assetinfos + assetinfo;
				assetinfosText = assetinfosText + assetinfoText;
			}
			
			// 商談商品取得
			List<OpportunityLineItem__c> ols = [SELECT Id,Name,StageName__c,ProductName__c,CloseDate__c FROM OpportunityLineItem__c WHERE Account__c =: accountid];
			String OpportunityLineItems = '';
			String OpportunityLineItemsText = '';
			for(OpportunityLineItem__c ol:ols){
				String olinfo = '<a href="/' + ol.Id + '" target="_blank">' + ol.ProductName__c + '【' + ol.StageName__c + '】' + '</a><br>';
				String olinfoText = ol.ProductName__c + '【' + ol.StageName__c + '】' + ol.CloseDate__c.format() + '\n';
				OpportunityLineItems = OpportunityLineItems + olinfo;
				OpportunityLineItemsText = OpportunityLineItemsText + olinfoText;
			}
			
			// accounts[0].AssetsInfo__c = '<table><tr><td>' + assetinfos + '</td><td>' + OpportunityLineItems + '</td></tr></table>'; 
			accounts[0].AssetsInfo__c = assetinfos;
			accounts[0].AssetsInfoText__c = assetinfosText + '----------------------\n' + OpportunityLineItemsText;
			update accounts[0];
		}
    }
}