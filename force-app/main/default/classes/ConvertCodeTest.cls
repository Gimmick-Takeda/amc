@isTest
private class ConvertCodeTest {

    static testMethod void ConvertCoreSystemCD2SFIDTest() {
        Test.startTest();
        // 施設登録
        Account ac1 = new Account(Name='test1',CoreSystemCD__c='1234');
        insert ac1;
        Account ac2 = new Account(Name='test2',CoreSystemCD__c='5678');
        insert ac2;        
        string inputtext = '1234\r\n5678\n\r\n\r \n\r12';
        string output;
        output = ConvertCode.CSCD2SFID(inputtext);
        Test.stopTest();
    }
    
    static testMethod void ConvertStateAccountName2SFIDTest() {
        Test.startTest();
        // 施設登録
        Account ac1 = new Account(Name='test1',ShippingState='東京都');
        insert ac1;
        Account ac2 = new Account(Name='test2',ShippingState='大阪府');
        insert ac2;        
        string inputtext = '東京都,test1\r\n大阪府,test2\n\r\n\r \n\r愛知県,愛知病院';
        string output;
        ConvertCode cc = new ConvertCode();
        output = cc.StateAccountName2SFID(inputtext);
        Test.stopTest();
    }

    static testMethod void ConvertStateAccountName2SAPCodeTest() {
        Test.startTest();
        // 施設登録
        Account ac1 = new Account(Name='test1',ShippingState='東京都');
        insert ac1;
        Account ac2 = new Account(Name='test2',ShippingState='大阪府');
        insert ac2;        
        string inputtext = '東京都,test1\r\n大阪府,test2\n\r\n\r \n\r愛知県,愛知病院';
        string output;
        ConvertCode cc = new ConvertCode();
        output = cc.StateAccountName2SAPCode(inputtext);
        Test.stopTest();
    }
    
    static testMethod void USERLastNameFirstName2USERIDTest() {
        Test.startTest();
        string inputtext = '権限 テスト\r\n';
        string output;
        ConvertCode cc = new ConvertCode();
        output = ConvertCode.USERLastNameFirstName2USERID(inputtext);
        Test.stopTest();
    }
    
    static testMethod void Array2SFIDTest() {
        Test.startTest();
        string inputtext = '京都府,アークレイ病院\r\n';
        string output;
        ConvertCode cc = new ConvertCode();
        cc.setArray(inputtext);
        cc.Array2SFID();
        Test.stopTest();
    }
    
}