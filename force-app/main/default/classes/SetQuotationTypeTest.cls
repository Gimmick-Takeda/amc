@isTest
public class SetQuotationTypeTest {

    @testSetup
    static void setup() {
        Account acc = new Account();
        acc.Name = '株式会社Company';
        insert acc;
        
        Account acc2 = new Account();
        acc2.Name = '株式会社Company2';
        insert acc2;
        
        Account acc3 = new Account();
        acc3.Name = '株式会社Company3';
        insert acc3;
        
                
        Opportunity__c testopp = new Opportunity__c();
        testopp.Account__c = acc.Id;
        testopp.QuotationType__c = '08：BGM専用見積（施設）';
        testopp.ServiceProposal__c = '直販';
        insert testopp;
        // System.assertEquals(String.isNotEmpty(testopp.Account__c), true);
        
        Opportunity__c testopp2 = new Opportunity__c();
        testopp2.Account__c = acc2.Id;
        testopp2.QuotationType__c = '05b：一式見積タイプ（相見積）';
        testopp2.ServiceProposal__c = '提案なし';
        insert testopp2;
        
        Opportunity__c testopp3 = new Opportunity__c();
        testopp3.Account__c = acc3.Id;
        testopp3.QuotationType__c = '01：個別価格タイプ（卸）';
        testopp3.ServiceProposal__c = '卸経由';
        insert testopp3;
        
    }
    
    static testMethod void testMethod1() {

        Opportunity__c obj = new Opportunity__c();
        obj = [SELECT Id FROM Opportunity__c WHERE Account__r.Name='株式会社Company'];
        
        // 1.コントローラを利用するvisualforceページをテスト実行時の画面として設定
        PageReference pageRef = Page.Make_Quota_Preview; //ページ名にはVisualforceページのページ名を入れる
        pageRef.getParameters().put('id', obj.Id);
        Test.setCurrentPage(pageRef);

        Test.startTest();
                
        // 3.標準コントローラを生成
        // オブジェクトを渡してインスタンス化する
        ApexPages.StandardController stdController = new ApexPages.StandardController (obj);
        
        // 4.コントローラ拡張を生成
        // 標準コントローラを渡してインスタンス化する
        SetQuotationType extController = new SetQuotationType(stdController);
        
        System.assertEquals(extController.qt1 == null, false);
        
        System.assertEquals(extController.qt2 == null, false);

        System.assertEquals(extController.qt4 == null, false);
            
        extController.getQt3();
        
        Test.stopTest();
        
    }
    
    static testMethod void testMethod2() {

        Opportunity__c obj = new Opportunity__c();
        obj = [SELECT Id FROM Opportunity__c WHERE Account__r.Name='株式会社Company2'];
        
        // 1.コントローラを利用するvisualforceページをテスト実行時の画面として設定
        PageReference pageRef = Page.Make_Quota_Preview; //ページ名にはVisualforceページのページ名を入れる
        pageRef.getParameters().put('id', obj.Id);
        Test.setCurrentPage(pageRef);

        Test.startTest();
                
        // 3.標準コントローラを生成
        // オブジェクトを渡してインスタンス化する
        ApexPages.StandardController stdController = new ApexPages.StandardController (obj);
        
        // 4.コントローラ拡張を生成
        // 標準コントローラを渡してインスタンス化する
        SetQuotationType extController = new SetQuotationType(stdController);
        
        System.assertEquals(extController.qt1 == null, false);
        
        System.assertEquals(extController.qt2 == null, false);

        System.assertEquals(extController.qt4 == null, false);
            
        extController.getQt3();
        
        Test.stopTest();
        
    }
    
    static testMethod void testMethod3() {

        Opportunity__c obj = new Opportunity__c();
        obj = [SELECT Id FROM Opportunity__c WHERE Account__r.Name='株式会社Company3'];
        
        // 1.コントローラを利用するvisualforceページをテスト実行時の画面として設定
        PageReference pageRef = Page.Make_Quota_Preview; //ページ名にはVisualforceページのページ名を入れる
        pageRef.getParameters().put('id', obj.Id);
        Test.setCurrentPage(pageRef);

        Test.startTest();
                
        // 3.標準コントローラを生成
        // オブジェクトを渡してインスタンス化する
        ApexPages.StandardController stdController = new ApexPages.StandardController (obj);
        
        // 4.コントローラ拡張を生成
        // 標準コントローラを渡してインスタンス化する
        SetQuotationType extController = new SetQuotationType(stdController);
        
        System.assertEquals(extController.qt1 == null, false);
        
        System.assertEquals(extController.qt2 == null, false);

        System.assertEquals(extController.qt4 == null, false);
            
        extController.getQt3();
        
        Test.stopTest();
        
    }
    
}