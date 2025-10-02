@isTest(SeeAllData=true)
private class AccountControllerTest{
    static TestMethod PageReference AccountRedirectTest(){
        
        Account ac = new Account(Name='AccountRedirectControllerTest');
        insert ac;
        List<Account> acs = [SELECT Id,Name FROM Account WHERE Name='AccountRedirectControllerTest'];
        string AccountId = acs[0].Id;
        PageReference pr = new PageReference('/apex/AccountRedirect?id=' + AccountId);
        
        string url = pr.getUrl();
        delete acs;
        return pr;
    }
}