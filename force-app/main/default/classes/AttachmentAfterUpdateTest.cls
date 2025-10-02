@isTest
public class AttachmentAfterUpdateTest {
    @testSetup
    static void setup() {
        DMQOL__c dql = new DMQOL__c(Name = 'Test ToQ');

        insert dql;

        Profile p = [Select Id from Profile Where Name = 'システム管理者'];

        User u = new User(
            LastName = 'testuser',
            Alias = 'newUser',
            Email = 'test@xx.xxx.com',
            UserName = 'test@arkray.co.jp.test',
            ProfileId = p.Id,
            EmailEncodingKey = 'ISO-2022-JP',
            LanguageLocaleKey = 'ja',
            LocaleSidKey = 'ja_JP',
            TimeZoneSidKey = 'Asia/Tokyo'
        );

        insert u;

        HoldingMeeting__c hm = new HoldingMeeting__c();
        hm.DMQOL__c = dql.id;
        hm.ImplementationDate__c = Date.today() ;
        hm.VenueCosts__c = 2000;
        hm.FoodBudget__c = 3000;
        hm.PromotionContents__c = 'Promotion';
        hm.ARKRAYEmployeeAttendance1__c = u.Id;
        hm.DetailsOfActivities__c = 'Activities';
        hm.Promotion_Product__c = 'AE-4021';

        insert hm;

        DMQOL__c dql1 = [SELECT Id FROM DMQOL__c WHERE Name =:'Test ToQ'];
        HoldingMeeting__c hm1 = [SELECT Id FROM HoldingMeeting__c WHERE DMQOL__c =: dql1.Id];

        Attachment att1 = new Attachment();

        att1.Name = 'Test1';
        att1.ParentId = hm1.Id;
        att1.Body = Blob.valueOf('Test1');

        insert att1;

    }

    static testMethod void testMethod1(){

        Test.startTest();

        DMQOL__c dql2 = [SELECT Id FROM DMQOL__c WHERE Name =:'Test ToQ'];
        HoldingMeeting__c hm2 = [SELECT Id FROM HoldingMeeting__c WHERE DMQOL__c =: dql2.Id];

        Attachment att2 = new Attachment();

        att2.Name = 'Test2';
        att2.ParentId = hm2.Id;
        att2.Body = Blob.valueOf('Test2');

        insert att2;

        Test.stopTest();
    }
}