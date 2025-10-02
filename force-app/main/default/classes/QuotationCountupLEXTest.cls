@isTest
public class QuotationCountupLEXTest {
    
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

        
        // 1.コントローラを利用するvisualforceページをテスト実行時の画面として設定
        PageReference pageRef = Page.Make_Quota; //ページ名にはVisualforceページのページ名を入れる
        pageRef.getParameters().put('id', obj.Id);
        Test.setCurrentPage(pageRef);

        Test.startTest();
                
        // 3.標準コントローラを生成
        // オブジェクトを渡してインスタンス化する
        ApexPages.StandardController stdController = new ApexPages.StandardController (obj);
        
        // 4.コントローラ拡張を生成
        // 標準コントローラを渡してインスタンス化する
        QuotationCountupLEX extController = new QuotationCountupLEX(stdController);
        
        extController.countup();
        
        Test.stopTest();
        
    }
    
    static testMethod void testMethod2() {

        Opportunity__c obj2 = new Opportunity__c();
        obj2 = [SELECT Id,QuotationNo__c FROM Opportunity__c LIMIT 1];
        obj2.QuotationNo__c = 1;
        update obj2;
        
        // 1.コントローラを利用するvisualforceページをテスト実行時の画面として設定
        PageReference pageRef = Page.Make_Quota; //ページ名にはVisualforceページのページ名を入れる
        pageRef.getParameters().put('id', obj2.Id);
        Test.setCurrentPage(pageRef);

        Test.startTest();
                
        // 3.標準コントローラを生成
        // オブジェクトを渡してインスタンス化する
        ApexPages.StandardController stdController = new ApexPages.StandardController (obj2);
        
        // 4.コントローラ拡張を生成
        // 標準コントローラを渡してインスタンス化する
        QuotationCountupLEX extController = new QuotationCountupLEX(stdController);
        
        extController.countup();
        
        Test.stopTest();
        
    }
}