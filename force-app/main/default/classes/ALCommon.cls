public class ALCommon {
  public ALCommon(ApexPages.StandardController stdController){
  }
  public PageReference init() {
  	//init('');
  	return null;
  }
  
  public PageReference writeDMQOL() {
  	log('DMQOL');
  	return null;
  }  
  
  public PageReference writeContact() {
  	log('Contact');
  	return null;
  }    
  
  // Account
  public PageReference writeAccount() {
  	log('Account');
  	return null;
  }    
  // Asset
  public PageReference writeAsset() {
  	log('Asset');
  	return null;
  }    
  // AccountAddInfo
  public PageReference writeAccountAddInfo() {
  	log('AccountAddInfo');
  	return null;
  }    
  // Opportunity
  public PageReference writeOpportunity() {
  	log('Opportunity');
  	return null;
  }    
  // OpportunityLineItem
  public PageReference writeOpportunityLineItem() {
  	log('OpportunityLineItem');
  	return null;
  }    
  // ScienceDaily
  public PageReference writeScienceDaily() {
  	log('ScienceDaily');
  	return null;
  }    
  // AssetList
  public PageReference writeAssetList() {
  	log('VFAssetList');
  	return null;
  }  
  
  
  
  public PageReference initDMQOL() {
  	log('DMQOL');
  	return null;
  }
  
  public PageReference initContact() {
  	log('Contact');
  	return null;
  }  
  
	public void log(String ObjectName) {
	    try{
	        String userid = UserInfo.getUserId();
	        if(userid=='00510000001BxGfAAK'){
	        	return;
	        }
	        String url = ApexPages.currentPage().getUrl();
	        AccessLog__c acclog = new AccessLog__c();
	        acclog.User__c = userid;
	        
	        acclog.Type__c = 'AL';
	        acclog.AccessURL__c = url;
	        acclog.ObjectName__c = ObjectName;
	        if(ObjectName == 'Account'){
	        	String Id = System.currentPageReference().getParameters().get('id');
	        	acclog.Account__c = Id;
	        }
	        	
	        
	        
	        insert acclog;
	    }catch(Exception e){
	    
	    }
	    //return null;
	}    

}