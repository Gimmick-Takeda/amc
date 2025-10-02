public class ConvertCode {
    public class AccountInfo{
        public string ShippingState{get;set;}
        public string Name{get;set;}
        public string StateAndName{get;set;}
        public string SFID{get;set;}
        public string SAPCode{get;set;}
    }
    public String log { get; set; }
    public String InputText { get; set; }
    public String OutputText{get;set;}
    public List<string> StateAccountnames{get;set;}
    public String NumberOfExecute { get; set; }
    
    public ConvertCode(){
        this.NumberOfExecute = '100';
    }

    private void setOutputText(List<string> lines){
        List<string> SFCodes = new List<string>();
        // 対象データをデータベースから取得
        List<AccountInfo> stateAccounts = new List<AccountInfo>();
        Set<String> stateAccounts2 = new Set<String>();

        for(string StateAccountname :lines){
            AccountInfo stateAccount = new AccountInfo();
            if(StateAccountname .trim().length()==0){
                stateAccount.ShippingState = '';
                stateAccount.Name = '';
            }else{
                List<string> State_Accountname = StateAccountname .Split(',');
                stateAccount.ShippingState = State_Accountname[0];
                stateAccount.Name = State_Accountname[1];
                stateAccount.StateAndName = stateAccount.ShippingState + stateAccount.Name;
                stateAccounts2.Add(stateAccount.Name.Replace(' ','%'));
            }
            stateAccounts.Add(stateAccount);
        }

        List<Account> acc0 = [SELECT Id,ShippingState,Name,CoreSystemCD__c From Account WHERE Name Like: stateAccounts2];

        Map<Id,Account> accs1 = New Map<Id,Account>(acc0);
        for(AccountInfo StateAccountname:stateAccounts){
            StateAccountname.SAPCode = '';
            StateAccountname.SFID = '';
            for(Account acc:accs1.Values() ){            
                if(StateAccountname.Name.Replace(' ','') == acc.Name.Replace(' ','')){
                    if(StateAccountname.ShippingState == acc.ShippingState){                    
                        StateAccountname.SAPCode = acc.CoreSystemCD__c;
                        StateAccountname.SFID = acc.Id;
                        accs1.Remove(acc.Id);
                        break;
                    }   
                }
            }    
        }
        for(AccountInfo ai:stateAccounts){
            this.OutputText += ai.SFID + '\r\n';
        }
        
    }


    public PageReference ConvertCoreSystemCD2Array() {
        setArray(this.InputText);
        return null;
    }




    // SAP to SFID
    public static string CSCD2SFID(string iText){
        List<string> CoreSystemCodes = iText.Split('\r\n');
        List<string> SFCodes = new List<string>();
        for(string CSCD:CoreSystemCodes){
            if(CSCD.trim().length()==0){
                SFCodes.Add('');
            }else{
                List<Account> accs = [SELECT Id From Account WHERE CoreSystemCD__c=:CSCD];
                if(accs.size()==1){
                    SFCodes.Add(accs[0].Id);            
                }else{
                    SFCodes.Add('');            
                }
            }
        }
        string oText = '';
        for(string SFCode:SFCodes){
            oText += SFCode + '\r\n';
        }
        return oText;
    }
    
    
    
    public void setArray(string iText){
        StateAccountnames = iText.Split('\r\n');
    }
    
    
    private List<AccountInfo> getAccountInfo(string iText){
        // テキストをリストに変換
        setArray(iText);

        List<string> SFCodes = new List<string>();
        // 対象データをデータベースから取得
        List<AccountInfo> stateAccounts = new List<AccountInfo>();
        Set<String> stateAccounts2 = new Set<String>();
        for(string StateAccountname :this.StateAccountnames){
            AccountInfo stateAccount = new AccountInfo();
            if(StateAccountname .trim().length()==0){
                stateAccount.ShippingState = '';
                stateAccount.Name = '';
            }else{
                List<string> State_Accountname = StateAccountname .Split(',');
                stateAccount.ShippingState = State_Accountname[0];
                stateAccount.Name = State_Accountname[1];
                stateAccount.StateAndName = stateAccount.ShippingState + stateAccount.Name;
                stateAccounts2.Add(stateAccount.Name.Replace(' ','%'));
            }
            stateAccounts.Add(stateAccount);
        }
        List<Account> acc0 = [SELECT Id,ShippingState,Name,CoreSystemCD__c From Account WHERE Name Like: stateAccounts2];
        Map<Id,Account> accs1 = New Map<Id,Account>(acc0);
        for(AccountInfo StateAccountname:stateAccounts){
            StateAccountname.SAPCode = '';
            StateAccountname.SFID = '';
            for(Account acc:accs1.Values() ){            
                if(StateAccountname.Name.Replace(' ','') == acc.Name.Replace(' ','')){
                    if(StateAccountname.ShippingState == acc.ShippingState){                    
                        StateAccountname.SAPCode = acc.CoreSystemCD__c;
                        StateAccountname.SFID = acc.Id;
                        accs1.Remove(acc.Id);
                        break;
                    }   
                }
            }    
        }
        return stateAccounts;
    }
    
    // State,AccountName to SFID
    public string StateAccountName2SFID(string iText){
        List<AccountInfo> stateAccounts = new List<AccountInfo>();
        stateAccounts = getAccountInfo(iText);
        string oText = '';
        for(AccountInfo s:stateAccounts ){
            oText += s.SFID+ '\r\n';
        }
        return oText;        
    }
    // State,AccountName to SAPCODE
    public string StateAccountName2SAPCODE(string iText){
        List<AccountInfo> stateAccounts = new List<AccountInfo>();
        stateAccounts = getAccountInfo(iText);
        string oText = '';
        for(AccountInfo s:stateAccounts ){
            oText += s.SAPCode + '\r\n';
        }
        return oText;
    }
    
    // USER.Name＝＞USERID
    public static string USERLastNameFirstName2USERID(string iText){
        List<string> UserNames = iText.Split('\r\n');
        List<string> UserCodes = new List<string>();
        for(string USERCD:UserNames ){
            if(USERCD.trim().length()==0){
                UserCodes.Add('');
            }else{
                List<User> uss= [SELECT Id From User WHERE Name=:USERCD];
                if(uss.size()==1){
                    UserCodes.Add(uss[0].Id);            
                }else{
                    UserCodes.Add('');            
                }
            }
        }
        string oText = '';
        for(string Code:UserCodes){
            oText += Code+ '\r\n';
        }
        return oText;
    }
    
    // 都道府県,施設名＝＞SAP得意先コード　変換 Step2(100件ずつ取り出して変換）
    public void Array2SFID() {
        Integer cnt = 0;
        List<string> temp1 = new List<string>();
        List<string> temp2 = new List<string>();
        Integer maxcnt = Integer.ValueOf(NumberOfExecute);
        for(String ai:StateAccountnames){
            if(cnt<maxcnt){
                temp1.Add(ai);
            }else{
                temp2.Add(ai);                    
            }
            cnt++;
        }
        StateAccountnames = temp2;
        this.log = '残り' + StateAccountnames.size().format() + '件';
        setOutputText(temp1);
    }
    

    // USER.Name＝＞USERID
    public PageReference ConvertUSERLastNameFirstName2USERID(){
        this.OutputText = USERLastNameFirstName2USERID(this.InputText);
        return null;
    }

    // State,AccountName to SFID    
    public PageReference ConvertStateAccountName2SFID(){
        this.OutputText = StateAccountName2SFID(this.InputText);
        return null;
    }
    
    public PageReference ConvertStateAccountName2SAPCODE() {
        this.OutputText = StateAccountName2SAPCODE(this.InputText);
        return null;
    }
    
    // SAP to SFID   
    public PageReference ConvertCoreSystemCD2SFID(){
        this.OutputText = CSCD2SFID(this.InputText);
        return null;
    }
    
    public PageReference ConvertArray2SFID() {
        Array2SFID();
        return null;
    }
}