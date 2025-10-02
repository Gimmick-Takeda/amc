@isTest
private class AccountInfoManagerTest {
    
    private static Id wkOppId = null;

    @testSetup
    
    static void setup() {
        Account acc = new Account();
        acc.Name = '株式会社Company';
        acc.CCReagentSaleRank__c = 'S';
        acc.AssetsInfoText__c ='Test';
        insert acc;
        
        Account acc2 = new Account();
        acc2.Name = 'TEST2';
        acc2.CCReagentSaleRank__c = 'A';
        insert acc2;
        
        Product2__c pdc = new Product2__c();
        pdc.ProductShortName__c = 'TESTProducts';
        insert pdc;
        
        Asset__c ass = new Asset__c();
        ass.Account__c = acc2.Id;
        ass.Product__c = pdc.Id;
        Date d = Date.newInstance(2010, 4, 10);
        ass.ProductionStartDate__c = d;
        insert ass;
        
        Asset__c ass2 = new Asset__c();
        ass2.Account__c = acc2.Id;
        ass2.Product__c = pdc.Id;
        Date d2 = Date.newInstance(2008, 4, 10);
        ass2.ProductionStartDate__c = d2;
        insert ass2;
        
        Opportunity__c opp = new Opportunity__c();
        opp.Account__c = acc2.Id;
        insert opp;
        
        OpportunityLineItem__c opl = new OpportunityLineItem__c();
        opl.Opportunity__c = opp.Id;
        opl.StageName__c = 'A(100%)';
        opl.Product__c = pdc.Id;
        Date cd = Date.newInstance(2020, 4, 10);
        opl.CloseDate__c = cd;
        insert opl;
    }
    
    static testMethod void UpateAccountCCRankUnitTest() {
    	Test.startTest();
        AccountInfoManager.UpateAccountCCRank();
        AccountInfoManager.UpateAccountCCRankClear();  
        Test.stopTest();
    }
}