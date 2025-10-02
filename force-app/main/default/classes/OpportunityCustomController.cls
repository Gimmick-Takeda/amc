public with sharing class OpportunityCustomController {
    public list <OpportunityLineItem__c> oli {get;set;}

    public list <OpportunityLineItem__c> oli_Machine {get;set;}


    public OpportunityCustomController() {
        oli = [SELECT ProductName__c FROM OpportunityLineItem__c WHERE RecordTypeId = '012BC000000W8nFYAS' AND Opportunity__c =: ApexPages.currentPage().getParameters().get('id')];
        oli_Machine = [SELECT ProductName__c,Quantity__c,Subtotal__c,Quota_Check__c FROM OpportunityLineItem__c WHERE RecordTypeId != '012BC000000W8nFYAS' AND Opportunity__c =: ApexPages.currentPage().getParameters().get('id')];

    }
}