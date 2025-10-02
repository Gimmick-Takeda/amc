@isTest(SeeAllData=true)
private class TaskCustomControllerTest{
    
    static TestMethod void ChangerTask(){
        // アカウントの登録
        Account ac = new Account();
        ac.Name = 'test';
        insert ac;
        // TODOの作成
        Task tsk = new Task();
        tsk.WhatId = ac.Id;
        tsk.OwnerId = UserInfo.getUserId();
        insert tsk;
        
        
        // テスト対象のページのオブジェクト化。テスト対象ページのカレントページ化
        PageReference pageRef = Page.Task;
        Test.setCurrentPage(pageRef);
        
        // テスト対象のVisualforceで使用sるうコントローラーのオブジェクト化
        TaskCustomController controller = new TaskCustomController();
        
        ApexPages.currentPage().getParameters().put('id',tsk.Id);
        controller.getTask();
        controller.Go();
        
        
        //コントローラのsaveメソッドのgetUrlを呼び出して、次ページの文字列を取得
        //String nextPage = controller.Go().getUrl();
        
        
        
        // 次ページ文字列が意図したものかどうかエラーチェック
        //System.assertEquals('/apex/failure?error=noParam', nextPage);
        
        //        controller.getTask();
        
        
        //System.CurrentPageReference().getParameters().put(‘Juhatyuu__r.Id’, j.Id);
        // entryItemsExtension tmpEntryItem = new entryItemsExtension(sc1);
        

        Test.startTest();

        Test.stopTest();
    }
}