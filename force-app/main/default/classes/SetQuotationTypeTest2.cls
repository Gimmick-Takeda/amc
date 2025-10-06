@isTest
public class SetQuotationTypeTest2 {

    @testSetup
    static void setup() {
        // テスト用のAccountを作成
        /*List<Account> accounts = new List<Account>();
        for(Integer i = 1; i <= 20; i++) {
            Account acc = new Account();
            acc.Name = 'テスト会社' + i;
            accounts.add(acc);
        }
        insert accounts;*/

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
            opportunities.add(opp);
        }
        
        // qt4の分岐をカバーする追加レコード
        Opportunity__c opp1 = new Opportunity__c();
        opp1.Account__c = acc.Id;
        opp1.QuotationType__c = '01：個別価格タイプ（卸）';
        opp1.ServiceProposal__c = '提案なし';
        opportunities.add(opp1);
        
        Opportunity__c opp2 = new Opportunity__c();
        opp2.Account__c = acc.Id;
        opp2.QuotationType__c = '02：個別価格タイプ（施設）';
        opp2.ServiceProposal__c = '直販';
        opportunities.add(opp2);
        
        insert opportunities;
    }
    
    // qt1プロパティのテスト - '01：', '03：', '05：', '07：' → 'Hyoshi_001'
    @isTest
    static void testQt1_Hyoshi001() {
        List<Opportunity__c> opps = [SELECT Id FROM Opportunity__c WHERE QuotationType__c LIKE '01：%' OR QuotationType__c LIKE '03：%' OR QuotationType__c LIKE '05：%' OR QuotationType__c LIKE '07：%'];
        
        for(Opportunity__c opp : opps) {
            PageReference pageRef = Page.Make_Quota_Preview;
            pageRef.getParameters().put('id', opp.Id);
            Test.setCurrentPage(pageRef);
            
            ApexPages.StandardController stdController = new ApexPages.StandardController(opp);
            SetQuotationType extController = new SetQuotationType(stdController);
            
            Test.startTest();
            String result = extController.qt1;
            Test.stopTest();
            
            System.assertEquals('Hyoshi_001', result, 'qt1 should return Hyoshi_001 for quotation types 01:, 03:, 05:, 07:');
        }
    }
    
    // qt1プロパティのテスト - '01b', '03b', '05b' → 'Hyoshi_001b'
    @isTest
    static void testQt1_Hyoshi001b() {
        List<Opportunity__c> opps = [SELECT Id FROM Opportunity__c WHERE QuotationType__c LIKE '01b%' OR QuotationType__c LIKE '03b%' OR QuotationType__c LIKE '05b%'];
        
        for(Opportunity__c opp : opps) {
            PageReference pageRef = Page.Make_Quota_Preview;
            pageRef.getParameters().put('id', opp.Id);
            Test.setCurrentPage(pageRef);
            
            ApexPages.StandardController stdController = new ApexPages.StandardController(opp);
            SetQuotationType extController = new SetQuotationType(stdController);
            
            Test.startTest();
            String result = extController.qt1;
            Test.stopTest();
            
            System.assertEquals('Hyoshi_001b', result, 'qt1 should return Hyoshi_001b for quotation types 01b, 03b, 05b');
        }
    }
    
    // qt1プロパティのテスト - その他 → 'Hyoshi_002'
    @isTest
    static void testQt1_Hyoshi002() {
        List<Opportunity__c> opps = [SELECT Id FROM Opportunity__c WHERE QuotationType__c LIKE '02：%' OR QuotationType__c LIKE '04：%' OR QuotationType__c LIKE '06：%' OR QuotationType__c LIKE '08：%' OR QuotationType__c LIKE '99：%'];
        
        for(Opportunity__c opp : opps) {
            PageReference pageRef = Page.Make_Quota_Preview;
            pageRef.getParameters().put('id', opp.Id);
            Test.setCurrentPage(pageRef);
            
            ApexPages.StandardController stdController = new ApexPages.StandardController(opp);
            SetQuotationType extController = new SetQuotationType(stdController);
            
            Test.startTest();
            String result = extController.qt1;
            Test.stopTest();
            
            System.assertEquals('Hyoshi_002', result, 'qt1 should return Hyoshi_002 for other quotation types');
        }
    }
    
    // qt2プロパティのテスト - 各分岐
    @isTest
    static void testQt2_AllBranches() {
        Map<String, String> expectedResults = new Map<String, String>{
            '01：' => 'Mitsumori_001b',
            '01b' => 'Mitsumori_001c',
            '02：' => 'Mitsumori_002b',
            '03：' => 'Mitsumori_003b',
            '03b' => 'Mitsumori_003c',
            '04：' => 'Mitsumori_004b',
            '05：' => 'Mitsumori_005c',
            '05b' => 'Mitsumori_005d',
            '06：' => 'Mitsumori_006b',
            '08：' => 'Mitsumori_BGM_User'
        };
        
        for(String key : expectedResults.keySet()) {
            Opportunity__c opp = [SELECT Id FROM Opportunity__c WHERE QuotationType__c LIKE :key + '%' LIMIT 1];
            
            PageReference pageRef = Page.Make_Quota_Preview;
            pageRef.getParameters().put('id', opp.Id);
            Test.setCurrentPage(pageRef);
            
            ApexPages.StandardController stdController = new ApexPages.StandardController(opp);
            SetQuotationType extController = new SetQuotationType(stdController);
            
            Test.startTest();
            String result = extController.qt2;
            Test.stopTest();
            
            System.assertEquals(expectedResults.get(key), result, 'qt2 should return ' + expectedResults.get(key) + ' for quotation type ' + key);
        }
    }
    
    // qt2プロパティのテスト - その他 → 'Mitsumori_BGM'
    @isTest
    static void testQt2_MitsumoriBGM() {
        Opportunity__c opp = [SELECT Id FROM Opportunity__c WHERE QuotationType__c LIKE '99：%' LIMIT 1];
        
        PageReference pageRef = Page.Make_Quota_Preview;
        pageRef.getParameters().put('id', opp.Id);
        Test.setCurrentPage(pageRef);
        
        ApexPages.StandardController stdController = new ApexPages.StandardController(opp);
        SetQuotationType extController = new SetQuotationType(stdController);
        
        Test.startTest();
        String result = extController.qt2;
        Test.stopTest();
        
        System.assertEquals('Mitsumori_BGM', result, 'qt2 should return Mitsumori_BGM for other quotation types');
    }
    
    // qt4プロパティのテスト - ServiceProposal__c == '提案なし' || ServiceCount__c == 0 → ''
    @isTest
    static void testQt4_EmptyForNoProposal() {
        Opportunity__c opp = [SELECT Id FROM Opportunity__c WHERE ServiceProposal__c = '提案なし' LIMIT 1];
        
        PageReference pageRef = Page.Make_Quota_Preview;
        pageRef.getParameters().put('id', opp.Id);
        Test.setCurrentPage(pageRef);
        
        ApexPages.StandardController stdController = new ApexPages.StandardController(opp);
        SetQuotationType extController = new SetQuotationType(stdController);
        
        Test.startTest();
        String result = extController.qt4;
        Test.stopTest();
        
        System.assertEquals('', result, 'qt4 should return empty string when ServiceProposal is 提案なし or ServiceCount is 0');
    }
    
    // qt4プロパティのテスト - ServiceProposal__c == '直販' && ('01：' || '03：' || '05：') → ''
    @isTest
    static void testQt4_EmptyForDirectSales() {
        List<Opportunity__c> opps = [SELECT Id FROM Opportunity__c WHERE ServiceProposal__c = '直販' AND (QuotationType__c LIKE '01：%' OR QuotationType__c LIKE '03：%' OR QuotationType__c LIKE '05：%')];
        
        for(Opportunity__c opp : opps) {
            PageReference pageRef = Page.Make_Quota_Preview;
            pageRef.getParameters().put('id', opp.Id);
            Test.setCurrentPage(pageRef);
            
            ApexPages.StandardController stdController = new ApexPages.StandardController(opp);
            SetQuotationType extController = new SetQuotationType(stdController);
            
            Test.startTest();
            String result = extController.qt4;
            Test.stopTest();
            
            System.assertEquals('', result, 'qt4 should return empty string for direct sales with quotation types 01:, 03:, 05:');
        }
    }
    
    // qt4プロパティのテスト - '01：' || '03：' || '05：' → 'Mitsumori_Hoshu001'
    @isTest
    static void testQt4_MitsumoriHoshu001() {
        List<Opportunity__c> opps = [SELECT Id FROM Opportunity__c WHERE ServiceProposal__c != '直販' AND (QuotationType__c LIKE '01：%' OR QuotationType__c LIKE '03：%' OR QuotationType__c LIKE '05：%')];
        
        for(Opportunity__c opp : opps) {
            PageReference pageRef = Page.Make_Quota_Preview;
            pageRef.getParameters().put('id', opp.Id);
            Test.setCurrentPage(pageRef);
            
            ApexPages.StandardController stdController = new ApexPages.StandardController(opp);
            SetQuotationType extController = new SetQuotationType(stdController);
            
            Test.startTest();
            String result = extController.qt4;
            Test.stopTest();
            
            System.assertEquals('Mitsumori_Hoshu001', result, 'qt4 should return Mitsumori_Hoshu001 for quotation types 01:, 03:, 05: when not direct sales');
        }
    }
    
    // qt4プロパティのテスト - '02：' || '04：' || '06：' → 'Mitsumori_Hoshu002'
    @isTest
    static void testQt4_MitsumoriHoshu002() {
        List<Opportunity__c> opps = [SELECT Id FROM Opportunity__c WHERE QuotationType__c LIKE '02：%' OR QuotationType__c LIKE '04：%' OR QuotationType__c LIKE '06：%'];
        
        for(Opportunity__c opp : opps) {
            PageReference pageRef = Page.Make_Quota_Preview;
            pageRef.getParameters().put('id', opp.Id);
            Test.setCurrentPage(pageRef);
            
            ApexPages.StandardController stdController = new ApexPages.StandardController(opp);
            SetQuotationType extController = new SetQuotationType(stdController);
            
            Test.startTest();
            String result = extController.qt4;
            Test.stopTest();
            
            System.assertEquals('Mitsumori_Hoshu002', result, 'qt4 should return Mitsumori_Hoshu002 for quotation types 02:, 04:, 06:');
        }
    }
    
    // qt4プロパティのテスト - その他 → ''
    @isTest
    static void testQt4_EmptyForOthers() {
        List<Opportunity__c> opps = [SELECT Id FROM Opportunity__c WHERE QuotationType__c LIKE '08：%' OR QuotationType__c LIKE '99：%'];
        
        for(Opportunity__c opp : opps) {
            PageReference pageRef = Page.Make_Quota_Preview;
            pageRef.getParameters().put('id', opp.Id);
            Test.setCurrentPage(pageRef);
            
            ApexPages.StandardController stdController = new ApexPages.StandardController(opp);
            SetQuotationType extController = new SetQuotationType(stdController);
            
            Test.startTest();
            String result = extController.qt4;
            Test.stopTest();
            
            System.assertEquals('', result, 'qt4 should return empty string for other quotation types');
        }
    }
    
    // getQt3メソッドのテスト - '01：' || '03：' || '05：' || '07：' → CustomerOutputName__c
    @isTest
    static void testGetQt3_CustomerOutputName() {
        List<Opportunity__c> opps = [SELECT Id, CustomerOutputName__c FROM Opportunity__c WHERE QuotationType__c LIKE '01：%' OR QuotationType__c LIKE '03：%' OR QuotationType__c LIKE '05：%' OR QuotationType__c LIKE '07：%'];
        
        for(Opportunity__c opp : opps) {
            PageReference pageRef = Page.Make_Quota_Preview;
            pageRef.getParameters().put('id', opp.Id);
            Test.setCurrentPage(pageRef);
            
            ApexPages.StandardController stdController = new ApexPages.StandardController(opp);
            SetQuotationType extController = new SetQuotationType(stdController);
            
            Test.startTest();
            String result = extController.getQt3();
            Test.stopTest();
            
            System.assertEquals(opp.CustomerOutputName__c, result, 'getQt3 should return CustomerOutputName__c for quotation types 01:, 03:, 05:, 07:');
        }
    }
    
    // getQt3メソッドのテスト - '01b' || '03b' || '05b' → WholesaleMQPrintName__c
    @isTest
    static void testGetQt3_WholesaleMQPrintName() {
        List<Opportunity__c> opps = [SELECT Id, WholesaleMQPrintName__c FROM Opportunity__c WHERE QuotationType__c LIKE '01b%' OR QuotationType__c LIKE '03b%' OR QuotationType__c LIKE '05b%'];
        
        for(Opportunity__c opp : opps) {
            PageReference pageRef = Page.Make_Quota_Preview;
            pageRef.getParameters().put('id', opp.Id);
            Test.setCurrentPage(pageRef);
            
            ApexPages.StandardController stdController = new ApexPages.StandardController(opp);
            SetQuotationType extController = new SetQuotationType(stdController);
            
            Test.startTest();
            String result = extController.getQt3();
            Test.stopTest();
            
            System.assertEquals(opp.WholesaleMQPrintName__c, result, 'getQt3 should return WholesaleMQPrintName__c for quotation types 01b, 03b, 05b');
        }
    }
    
    // getQt3メソッドのテスト - その他 → AccountOutputName__c
    @isTest
    static void testGetQt3_AccountOutputName() {
        List<Opportunity__c> opps = [SELECT Id, AccountOutputName__c FROM Opportunity__c WHERE QuotationType__c LIKE '02：%' OR QuotationType__c LIKE '04：%' OR QuotationType__c LIKE '06：%' OR QuotationType__c LIKE '08：%' OR QuotationType__c LIKE '99：%'];
        
        for(Opportunity__c opp : opps) {
            PageReference pageRef = Page.Make_Quota_Preview;
            pageRef.getParameters().put('id', opp.Id);
            Test.setCurrentPage(pageRef);
            
            ApexPages.StandardController stdController = new ApexPages.StandardController(opp);
            SetQuotationType extController = new SetQuotationType(stdController);
            
            Test.startTest();
            String result = extController.getQt3();
            Test.stopTest();
            
            System.assertEquals(opp.AccountOutputName__c, result, 'getQt3 should return AccountOutputName__c for other quotation types');
        }
    }
    
    // プロパティのsetterテスト
    @isTest
    static void testPropertySetters() {
        Opportunity__c opp = [SELECT Id FROM Opportunity__c LIMIT 1];
        
        PageReference pageRef = Page.Make_Quota_Preview;
        pageRef.getParameters().put('id', opp.Id);
        Test.setCurrentPage(pageRef);
        
        ApexPages.StandardController stdController = new ApexPages.StandardController(opp);
        SetQuotationType extController = new SetQuotationType(stdController);
        
        Test.startTest();
        extController.qt1 = 'test1';
        extController.qt2 = 'test2';
        extController.qt4 = 'test4';
        Test.stopTest();
        
        // setterが正常に動作することを確認
        System.assertEquals('test1', extController.qt1, 'qt1 setter should work');
        System.assertEquals('test2', extController.qt2, 'qt2 setter should work');
        System.assertEquals('test4', extController.qt4, 'qt4 setter should work');
    }
}
