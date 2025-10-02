public with sharing class ChangeRepresentativeController {


    // コントラクタ
    public ChangeRepresentativeController (){
        List<AccountAddInfo__c> AAIs= [SELECT Id,Account__r.Name,Account__r.ShippingState,Account__r.ShippingCity,Account__r.ShippingStreet,Account__r.Classification__c,CCUser__c,PCUser__c 
        FROM AccountAddInfo__c 
        LIMIT 0];      
        Accounts = ChangeList(AAIs);
    }   
    // リストの変換
    private List<AccountOwner> ChangeList(List<AccountAddInfo__c> accounts){
        List<AccountOwner> retval = new List<AccountOwner>();
        for(AccountAddInfo__c ac:accounts)
        {
            AccountOwner ao = new AccountOwner();
            ao.Selected = false;
            ao.AAI = ac;
            retval.Add(ao);        
        }
        return retval;
    }
    // データ更新
    public PageReference UpdateData() {
        List<AccountAddInfo__c> updateaai = new List<AccountAddInfo__c>();
        for(AccountOwner a:Accounts){
            if(a.IsChanged == true){
                updateaai.Add(a.AAI);            
                a.IsChanged = false;
            }
        }
        update updateaai;
        return null;
    }
    // PC担当者変更
    public PageReference ChangeOwnerPC() {
        for(integer i=0;i<Accounts.Size();i++){
            if(Accounts[i].Selected){
                Accounts[i].AAI.PCUser__c = NewOwner.Id;
                Accounts[i].IsChanged = true;
            }
        }    
        return null;
    }
    // CC担当者変更
    public PageReference ChangeOwnerCC() {
        for(integer i=0;i<Accounts.Size();i++){
            if(Accounts[i].Selected){
                Accounts[i].AAI.CCUser__c = NewOwner.Id;            
                Accounts[i].IsChanged = true;
            }
        }
        return null;
    }
    // 選択解除
    public PageReference Deselect() {
        for(integer i=0;i<Accounts.Size();i++){
            Accounts[i].Selected = false;
        }
        return null;
    }
    // 全選択
    public PageReference SelectAll() {
        for(integer i=0;i<Accounts.Size();i++){
            Accounts[i].Selected = true;
        }
        return null;
    }

    // 担当者検索
    public PageReference OwnerSearch() {
        List<User> users = [SELECT Id,Name FROM USER WHERE Name Like : '%' + NewOwnerShearch + '%'];
        if(users.size()==1)
        {
            NewOwner = users[0];
        }
        return null;
    }
    // 住所検索
    public PageReference Search() {
        String StateL= this.State + '%';
        String CityL = this.City + '%';
        String StreetL = this.Street + '%';
        String ClassificationL = this.Classification + '%';
        List<AccountAddInfo__c> AAIs= [SELECT Id,Account__r.Name,Account__r.ShippingState,Account__r.ShippingCity,Account__r.ShippingStreet,Account__r.Classification__c,CCUser__c,PCUser__c 
        FROM AccountAddInfo__c 
        WHERE 
        (Account__r.ShippingState Like: StateL) and 
        (Account__r.ShippingCity Like: CityL) and  
        (Account__r.ShippingStreet Like: StreetL ) and
        (Account__r.Classification__c Like: ClassificationL )
        LIMIT 1000];        
        Accounts = ChangeList(AAIs);
        this.HitCount = Accounts.size() + '件ありました。';
        return null;
    }
    // インプット情報
    public String HitCount{get;set;}
    public String State{get;set;}
    public String City{get;set;}
    public String Street{get;set;}
    public String Classification { get; set; }
    public String NewOwnerShearch { get; set; }
    public User NewOwner{get;set;}
    public List<AccountAddInfo__c> AAIs{get;set;}
    public List<AccountOwner> Accounts {get;set;}    
    public Class AccountOwner{
        public Boolean Selected{get;set;}
        public Boolean IsChanged{get;set;}
        public AccountAddInfo__c AAI{get;set;}  
    }
}