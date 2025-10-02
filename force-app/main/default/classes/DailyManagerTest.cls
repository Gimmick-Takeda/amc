@isTest(SeeAllData=true)
private class DailyManagerTest{
    
    static TestMethod void UpdateLocationTest(){
    
        // 取引先
        Account ac = new Account(Name='ApexTest取引先');
        insert ac;
        
        List<Account> acs = [SELECT Id,Name FROM Account WHERE Name=:'ApexTest取引先'];

        Event ev = new Event (Subject='Test',StartDateTime=datetime.valueOf('2014-01-01 11:00:00:00'),EndDateTime=datetime.valueOf('2014-01-01 12:00:00:00'));
        ev.DurationInMinutes = 60;
        ev.WhatId= acs[0].Id;


        // 商談
        Opportunity__c op = new Opportunity__c();
        op.Account__c = acs[0].Id;
        insert op;
        List<Opportunity__c> ops = [SELECT Id FROM Opportunity__c WHERE Account__r.Name=:'ApexTest取引先'];
        
        Event ev2 = new Event (Subject='Test',StartDateTime=datetime.valueOf('2014-01-01 11:00:00:00'),EndDateTime=datetime.valueOf('2014-01-01 12:00:00:00'));
        ev2.DurationInMinutes = 60;
        ev2.WhatId = ops[0].Id;
        Test.startTest();
        insert ev;
        insert ev2;
        Test.stopTest();
    }
}