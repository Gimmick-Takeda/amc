public class AccountController{
    public static void AccountAdded(List<Account> accounts)
    {
       List<AccountAddInfo__c> ais = new List<AccountAddInfo__c>();
       for(Account acc:accounts)
       {
           AccountAddInfo__c ai = new AccountAddInfo__c(Account__c=acc.Id);
           ais.Add(ai);
       }
       insert ais;
    }
}