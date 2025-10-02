@isTest
public class QuotationCountupTest {
    
    public static Id wkOppId = null;

    @testSetup
    static void setup() {
        Account acc = new Account();
        acc.Name = '株式会社Company';
        insert acc;
        
        Customer__c cuss = new Customer__c();
        cuss.Name = '特約店';
        insert cuss;
        
        Opportunity__c testopp = new Opportunity__c();
        testopp.Account__c = acc.Id;
        testopp.Customer__c = cuss.Id;
        insert testopp;
        System.assertEquals(String.isNotEmpty(testopp.Account__c), true);
        wkOppId = testopp.Id;
    }
    
    static testMethod void testMethod1() {

        Opportunity__c obj = new Opportunity__c();
        obj = [SELECT Id FROM Opportunity__c LIMIT 1];

        Test.startTest();
                
        QuotationCountup.updateNumber(obj.Id);
        
        Test.stopTest();
        
    }
}