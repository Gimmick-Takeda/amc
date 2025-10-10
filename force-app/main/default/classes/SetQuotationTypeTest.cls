@isTest
public class SetQuotationTypeTest {

    @testSetup
    static void setup() {
        Account acc = new Account();
        acc.Name = '株式会社Company';
        insert acc;

        // すべての分岐をカバーするOpportunity__cレコードを作成
        List<Opportunity__c> opportunities = new List<Opportunity__c>();
        
        // qt1, qt2, getQt3の分岐をカバー
        String[] quotationTypes = new String[]{
            '01：個別価格タイプ（卸）',
            '01b：個別価格タイプ（相見積）',
            '02：個別価格タイプ（施設）',
            '03：一括値引タイプ（卸）',
            '03b：一括値引タイプ（相見積）',
            '04：一括値引タイプ（施設）',
            '05：一式見積タイプ（卸）',
            '05b：一式見積タイプ（相見積）',
            '06：一式見積タイプ（施設）',
            '07：BGM専用見積（卸）',
            '08：BGM専用見積（施設）'
        };
        
        for(Integer i = 0; i < quotationTypes.size(); i++) {
            Opportunity__c opp = new Opportunity__c();
            opp.Account__c = acc.Id;
            opp.QuotationType__c = quotationTypes[i];
            opp.ServiceProposal__c = '卸経由';
            opportunities.add(opp);
        }
        
        insert opportunities;

        // 商品レコードを作成
        Product2__c prod = new Product2__c();
        prod.Name = 'ServiceProduct';
        prod.IsActive__c = true;
        prod.CategoryName1__c = '保守';
        insert prod;

        // 商談商品(保守)を作成
        List<OpportunityLineItem__c> opls = new List<OpportunityLineItem__c>();
        for(Integer i = 0; i < opportunities.size(); i++) {
            OpportunityLineItem__c opl = new OpportunityLineItem__c();
            opl.Opportunity__c = opportunities[i].Id;
            opl.Product__c = prod.Id;
            opl.RecordTypeId = '012BC000000W8nFYAS';
            opls.add(opl);
        }
        insert opls;
    }
    
    static testMethod void testMethodAll() {

        List<Opportunity__c> opps = [SELECT Id FROM Opportunity__c WHERE Account__r.Name='株式会社Company'];
        
        Test.startTest();
        for(Opportunity__c opp : opps) {
            PageReference pageRef = Page.Make_Quota_Preview;
            pageRef.getParameters().put('id', opp.Id);
            Test.setCurrentPage(pageRef);
            ApexPages.StandardController stdController = new ApexPages.StandardController(opp);
            SetQuotationType extController = new SetQuotationType(stdController);
            System.assertEquals(extController.qt1 == null, false);
            System.assertEquals(extController.qt2 == null, false);
            System.assertEquals(extController.qt4 == null, false);
            extController.getQt3();
        }
        Test.stopTest();
    }
    
}