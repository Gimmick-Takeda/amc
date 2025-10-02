@isTest(SeeAllData=true)
private class AfterInserEventTest{
    static TestMethod void DataInsertTest(){
    
    
        // テスト用データ生成
        Account ac = New Account();
        ac.Name = 'AfterInserEventTest';
        insert ac;
        List<Account> ac1 = [SELECT Id,Name FROM Account WHERE Name =: ac.name];
        
        //Product2__c product = new Product2__c();
        //product.Name = 'AfterInserEventTest';
        //product.ProductNameFKey__c = 'AfterInserEventTest';
        //product.MakerName__c = 'AfterInserEventTest';
        //insert product;
        //List<Product2__c> products = [SELECT Id FROM Product2__c WHERE Name =: product.Name];
        
    
        // 納入商品
        //Asset__c asset = new Asset__c();
        //asset.Account__c = ac1[0].Id;
        //asset.Product__c = products[0].Id;
        //insert asset;
        
        
        
        // TODO
        Task task = new Task();
        
        insert task;
        
        // EVENT
        //Event event = new Event();
        //event.DurationInMinutes = 30;
        //event.ActivityDateTime = DateTime.Now();
        //insert event;
        
        // 商談
        Opportunity__c op = new Opportunity__c();
        op.Account__c = ac1[0].Id;
        op.Disincentive__c = 'AfterInserEventTest';
        insert op;
        List<Opportunity__c> ops = [SELECT Id,Name,Description__c FROM Opportunity__c WHERE Disincentive__c =: op.Disincentive__c];
        
        
        // 商談商品
        //OpportunityLineItem__c opl = new OpportunityLineItem__c();
        //opl.Opportunity__c = ops[0].Id;
        //opl.Product__c = products[0].Id;
        //insert opl;

        // 学術日報
        ScienceDaily__c sd = new ScienceDaily__c();
        sd.VisitDate__c = DateTime.Now().Date();
        sd.Interview__c = 'test';
        sd.Account__c = ac.Id;
        sd.IsInputByAction__c = true;
        insert sd;

        
    }

}