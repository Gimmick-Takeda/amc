public class ALAccount {
	
  public ALAccount(ApexPages.StandardController stdController){
  }
	
    public void writeal() {
        try{
            String userid = UserInfo.getUserId();
            String url = ApexPages.currentPage().getUrl();
            AccessLog__c acclog = new AccessLog__c();
            acclog.AccessURL__c = url;
            acclog.User__c = userid;
            acclog.Type__c = 'AL';
            acclog.AccessURL__c = url;
            acclog.ObjectName__c = 'Account';
            insert acclog;
        }catch(Exception e){
        
        }
    }    
}