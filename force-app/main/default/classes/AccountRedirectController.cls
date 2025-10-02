public class AccountRedirectController {

    public string log{get;set;}
    public string RedirectUrl{get;set;}

    public PageReference Go() {
        
        // AccountId取得
        string AccountId = ApexPages.currentPage().getParameters().get('id');
        return PageRedirect(AccountId);
    }
    
    
    private void writeLog(string userid,string Pagename,string AccountId,string State,string url){
        // 成功・失敗のログ
        AccessLog__c aclresult = new AccessLog__c();
        // UserId
        aclresult.User__c = userid;
        // ページ名
        aclresult.Pagename__c = Pagename;
        // AccountId
        aclresult.Account__c = AccountId;
        aclresult.State__c = State;        
        aclresult.RedirectUrl__c = url;
        insert aclresult;     
    }
    

    
    public PageReference PageRedirect(string AccountId){
        // アクセスログ
        string userid = UserInfo.getUserId();
        AccessLog__c acl = new AccessLog__c();
        // UserId
        acl.User__c = userid;
        // ページ名
        acl.Pagename__c = 'AccountRedirect';
        // AccountId
        acl.Account__c = AccountId;
        insert acl;
        // AccountId取得
        Account[] Accounts = [SELECT Id,Name FROM Account WHERE Id=:AccountId];
        Account acc;
        string Id2;
        try{
            if(Accounts.Size() == 1){
                acc = Accounts[0];
                Id2 = acc.Id;                    
            }else{
                Id2 = '';
            }

        }catch(Exception ex)
        {
                Id2 = '';                    
        }

        // 成功・失敗のログ
        if(Id2.Length() > 0){
            writeLog(userid,'AccountRedirect',AccountId,'','');
        }else{
            writeLog(userid,'AccountRedirect',AccountId,'False','Id取得失敗');
            return null;
        } 

        //PageReference pr = new PageReference('/apex/AccountRedirect?id=' + AccountId);
        try{
            List<Document> documents = [SELECT Id FROM Document WHERE DeveloperName = 'Redirect'];
            if(documents.size()==1){
                string DocumentId = documents[0].Id;
                PageReference pr = new PageReference('/servlet/servlet.FileDownload');
                pr.getParameters().put('n', 'account'); 
                pr.getParameters().put('id', Id2); 
                pr.getParameters().put('file', DocumentId); 
                // pr.setRedirect(true);
                string url = pr.getUrl();
                log = url;
                writeLog(userid,'AccountRedirect',AccountId,'Success',url);                
//                return null;
                return pr;
            }else{
                // 失敗のログ
                writeLog(userid,'AccountRedirect',AccountId,'False','ドキュメント取得失敗');
                return null;
            }
        }catch(Exception ex){
            // 失敗のログ
            writeLog(userid,'AccountRedirect',AccountId,'False','Exception Throw');
            return null;
        }
        //return (new ApexPages.StandardController(acc)).view();
    }
}