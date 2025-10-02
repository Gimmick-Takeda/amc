@isTest
private class TodoEventManagerTest{
    
    private static Id testId = null;
    private static Id AccountId = null;
    
    @testSetup
    
    static void setup() {
        Account acc = new Account();
        acc.Name = '株式会社Company';
        insert acc;
        
        User tuser = new User();
        tuser.LastName = 'test';
        tuser.Email = 'test@test.com';
        tuser.Alias = 'test';
        tuser.TimeZoneSidKey='America/Los_Angeles';
        tuser.LocaleSidKey='en_GB';
        tuser.EmailEncodingKey = 'UTF-8';
        tuser.ProfileId = '00e10000000lUq3AAE';
        tuser.LanguageLocaleKey='en_US';
        tuser.Username='test@arkray.com';
        tuser.CommunityNickname = 'test';

        insert tuser;
        
        // クラス変数に値をセット(検証用)
        testId = tuser.Id;
        System.assertEquals(String.isNotEmpty(testId), true);
        
        AccountID = acc.Id;

    }
    
    static TestMethod void TodoEventManagerTest(){        
        
        Test.startTest();
        
        User tuser2 = [select Id from User limit 1];
        
        // Todo作成
        Task task = new Task();
        task.OwnerId = tuser2.Id;
        task.ActivityDate = date.today();
        task.IsBossCommentSendEmail__c = true;
        task.BossComment__c = '上司コメント';
        task.WhatId = AccountId ;
        
        insert task;
        //update task;
        
        // Todo作成
        Event event = new event();
        event.OwnerId = tuser2.Id;
        event.ActivityDate = date.today();
        event.IsBossCommentSendEmail__c = true;
        event.BossComment__c = '上司コメント';
        event.WhatId = AccountId ;
        event.ActivityDateTime = datetime.now();
        event.DurationInMinutes = 90;
        
        insert event;
        //update event;
        
        Test.stopTest();
        
    }

}