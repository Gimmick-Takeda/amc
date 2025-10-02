public class AccountOpActivityController {

    public AccountOpActivityController(){
        this.RecordCount = 10;
    }

    public PageReference Search() {
        
        Accounts = new List<AccountOpActivityItem>();
        // 取引先
        List<Account> accs = [SELECT Id,Name FROM Account Where CancerHospitalsArea__c = true or CancerHospitalsTDK__c = true limit : RecordCount];
        for(Account ac:accs){
            
            AccountOpActivityItem acoa = new AccountOpActivityItem();
            acoa.Account = ac;
            // 商談
            acoa.Opportunities = new List<OpportunityC>();
            
            // 商談外            
            OpportunityC oco = new OpportunityC();
            oco.Opportunity = new Opportunity__c();
            oco.Name = '商談外';            
            // 活動
            oco.Activities = new List<Task>();
            oco.Activities = [SELECT Id,Subject,ActivityDate,StatusView__c,DialyView__c FROM Task WHERE WhatId=:ac.Id AND ProductNameD__c LIKE '%i-densy%' Limit 10];         

            
            
            
            acoa.Opportunities.Add(oco);
            List<Opportunity__c> ops = [SELECT Id,Name FROM Opportunity__c WHERE Account__c =: ac.Id ];
            for(Opportunity__c op:ops){
                OpportunityC opc = new OpportunityC();
                opc.Opportunity = op;
                opc.Name = op.Name;
                // 商談商品
                opc.OpportunityLines = new List<OpportunityLineItem__c>();
                opc.OpportunityLines = [SELECT Id,Name,Product__r.Name,StageName__c,Quantity__c,DRT__c FROM OpportunityLineItem__c WHERE Opportunity__c =:op.Id and Product__r.Name LIKE 'IS-%' ];
                if(opc.OpportunityLines.size() == 0){
                    continue;
                }
                // 活動
                opc.Activities = new List<Task>();
                opc.Activities = [SELECT Id,Subject,ActivityDate,StatusView__c,DialyView__c FROM Task WHERE WhatId=:op.Id Limit 10];         
       
                acoa.Opportunities.Add(opc);
            }


            Accounts.Add(acoa);
        }
        
        //this.HitCount = Accounts.size() + '件ありました。';
        return null;
    }
    
    public List<AccountOpActivityItem> Accounts{get;set;}
    
    public Integer RecordCount{get;set;}
    
    public class AccountOpActivityItem{
        public Account Account{get;set;}
        public List<OpportunityC> Opportunities{get;set;}        
                
    }
    
    public class OpportunityC{
        public string Name{get;set;}
        public Opportunity__c Opportunity{get;set;}
        public List<OpportunityLineItem__c> OpportunityLines{get;set;}
        public List<Task> Activities{get;set;}
    }
    


}