@isTest(SeeAllData=true)
private class AssociationControllerTest{
    static TestMethod void AssociationTest(){
        Association__c ass = new Association__c();
        List<Account> accs = [SELECT Id,Name FROM Account Limit 1];
        //List<Person__c> persons = [SELECT Id,Name FROM Person__c Limit 1];
        List<Contact> persons = [SELECT Id,Name FROM Contact Limit 1];
        ass.Account__c = accs[0].Id;
        ass.Contact__c = persons[0].Id;
        insert ass;
        
    }

}