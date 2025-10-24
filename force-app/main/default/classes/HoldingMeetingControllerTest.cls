@isTest
public class HoldingMeetingControllerTest{
    @TestSetup
    static void makeData(){
        
        
    }
    static TestMethod void HoldingMeetingTest(){
        HoldingMeeting__c hms = new HoldingMeeting__c();
        List<DMQOL__c> DMQOLs= [SELECT Id,Name FROM DMQOL__c Limit 1];
        if(DMQOLs.size()>0){
        	hms.DMQOL__c = DMQOLs[0].Id;	
        }else{
        	hms.DMQOL__c = '';
        }
        insert hms;
    
    }
}