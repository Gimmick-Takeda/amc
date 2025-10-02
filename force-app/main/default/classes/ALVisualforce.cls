public with sharing class ALVisualforce {
    public PageReference init() {
        try{
            String userid = UserInfo.getUserId();
            String url = ApexPages.currentPage().getUrl();
            AccessLog__c acclog = new AccessLog__c();
            acclog.User__c = userid;
            acclog.Type__c = 'AL';
            acclog.AccessURL__c = url;
            acclog.ObjectName__c = 'ALVF';
            insert acclog;
        }catch(Exception e){
        
        }
        return null;
    }   
}