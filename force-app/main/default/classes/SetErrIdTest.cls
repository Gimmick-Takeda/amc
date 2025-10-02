@isTest
public class SetErrIdTest {
    
    public static Id wkOppId = null;

    @testSetup
    static void setup() {
        Account acc = new Account();
        acc.Name = '株式会社Company';
        insert acc;
        
        Customer__c cus = new Customer__c();
        cus.Name = '京都商事';
        cus.PaymentTerms__c = '月末払い';
        insert cus;
        
        Opportunity__c testopp = new Opportunity__c();
        testopp.Account__c = acc.Id;
        testopp.QuotationType__c = '05b：一式見積タイプ（相見積）';
        testopp.WholesaleMQ__c = cus.Id;
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
        SetErrId extController = new SetErrId(stdController);
        
        extController.getMessage2();
        
        Test.stopTest();
        
    }
    
}