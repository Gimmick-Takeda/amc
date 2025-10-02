@isTest(SeeAllData=true)
public class HoldingMeetingAfterUpdateTest {

/*
    @testSetup
    static void setup() {
        
        DMQOL__c dql = new DMQOL__c(Name = 'Test ToQ');
        insert dql;
        
        HoldingMeeting__c hm = new HoldingMeeting__c();
        hm.DMQOL__c = dql.id;
        insert hm;
    }
*/
    static testMethod void testMethod1(){
        HoldingMeeting__c hm1 = new HoldingMeeting__c();
        hm1 =  [SELECT Id,ExpenseApproval__c FROM HoldingMeeting__c WHERE Id =: 'a0R5F00000d85m4'];
            hm1.ExpenseApproval__c = true;
            upsert hm1;
    }

}