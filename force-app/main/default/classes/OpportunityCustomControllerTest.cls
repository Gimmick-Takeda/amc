@isTest
public class OpportunityCustomControllerTest {
    @isTest
    static void testControllerForMachineAndService() {
    //テスト用のAccountを作成
    Account acc = new Account(Name = 'Test Account');
    insert acc; 
    // テスト用のOpportunity__cを作成
    Opportunity__c opp = new Opportunity__c(Account__c = acc.Id);
    insert opp;
    // テスト用の登録商品を作成
    Product2__c prodMachine = new Product2__c(Name = 'MachineProduct', IsActive__c = true);
    insert prodMachine;

        // Machine用のOpportunityLineItem__c
        OpportunityLineItem__c oliMachine = new OpportunityLineItem__c(
            Product__c = prodMachine.Id,
            Quantity__c = 5,
            Quota_Check__c = true,
            Opportunity__c = opp.Id
        );
        insert oliMachine;


        // ページパラメータをセット
        Test.setCurrentPageReference(new PageReference('/apex/OPL_Mobile_Machine'));
        ApexPages.currentPage().getParameters().put('id', opp.Id);
        OpportunityCustomController controller = new OpportunityCustomController();
        System.assertEquals(1, controller.oli_Machine.size(), 'oli_Machineの件数が正しいこと');
        System.assertEquals(5, controller.oli_Machine[0].Quantity__c);
        System.assertEquals(true, controller.oli_Machine[0].Quota_Check__c);

    }
}
