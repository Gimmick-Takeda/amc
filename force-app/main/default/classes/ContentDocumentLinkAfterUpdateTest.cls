@isTest
public class ContentDocumentLinkAfterUpdateTest {
    @TestSetup
    static void makeData(){

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

        ContentVersion conVer = new ContentVersion(
                Title = 'TestContent'
                , PathOnClient = 'TestContent.txt'
                , VersionData = Blob.valueOf('TestContentData')
                , FirstPublishLocationId = [SELECT Id FROM ContentWorkSpace LIMIT 1].Id
        );

        insert conVer;

        ContentDocument contentDocument = [ SELECT Id, Title FROM ContentDocument WHERE LatestPublishedVersionId = : conVer.Id ];

        ContentDocumentLink link
            = new ContentDocumentLink(ContentDocumentId = contentDocument.Id,
                                    LinkedEntityId = hm.Id,
                                    ShareType = 'V',
                                    Visibility = 'AllUsers');

        insert link;

    }

    static testMethod void testMethod1(){
        Test.startTest();

        DMQOL__c dql1 = [SELECT Id FROM DMQOL__c WHERE Name =:'Test ToQ'];
        HoldingMeeting__c hm1 = [SELECT Id FROM HoldingMeeting__c WHERE DMQOL__c =: dql1.Id];
        User u1 = [SELECT Id FROM User WHERE LastName =:'testuser'];

        ContentVersion conVer1 = new ContentVersion(
                Title = 'TestContent1'
                , PathOnClient = 'TestContent1.txt'
                , VersionData = Blob.valueOf('TestContentData1')
                , FirstPublishLocationId = [SELECT Id FROM ContentWorkSpace LIMIT 1].Id
        );

        insert conVer1;

        ContentDocument contentDocument1 = [ SELECT Id, Title FROM ContentDocument WHERE LatestPublishedVersionId = : conVer1.Id ];

        ContentDocumentLink link1
            = new ContentDocumentLink(ContentDocumentId = contentDocument1.Id,
                                    LinkedEntityId = hm1.Id,
                                    ShareType = 'V',
                                    Visibility = 'AllUsers');

        insert link1;

        Test.stopTest();
    }

}