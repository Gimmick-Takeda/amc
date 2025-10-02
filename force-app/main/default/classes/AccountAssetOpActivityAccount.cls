public with sharing class AccountAssetOpActivityAccount{


    public string DebugSOQL{get;set;}
    public string Message{get;set;}    
    public string ErrorMessage{get;set;}
    
    public List<Account> searchAccount(AccountAssetOpActivitySearchCondition sc){
        DebugSOQL = '';
        Message = '';
        ErrorMessage = '';
        AccessLog__c aclog = new AccessLog__c();
        aclog.State__c = 'Search()';
        aclog.Pagename__c = 'AccountAssetOpActiviy';
        string userid = UserInfo.getUserId();
        aclog.User__c = userid;
        insert aclog;
        Message = '';    
        
        
        // 取引先
        string SOQL = 'SELECT Id,Name,ShippingState,ShippingCity,CoreSystemCD__c,SSO2__c,CCUSER__r.Name,PCUSER__r.Name,PCUpperLevel__c,RCTMS_MWERT02Text__c,SFCODE__c,Item114__c,Item119__c,Item157__c,Item158__c,Item159__c,Item160__c,Item168__c,DMDrCount__c,AccreditedTrainingFacility__c,AccreditedEducationalInstitutionNoF__c,EducationRelatedFacilities__c,CooperationEducationalFacilities__c,CancerHospitalsArea__c,CancerHospitalsTDK__c FROM Account';
        if(sc.filter != null){
            if(sc.filter != ''){
                SOQL += ' WHERE ' + sc.Filter;
            }
        }
        SOQL += ' Order by SSO2__c,TDFKNumber__c ';
        if(sc.RecordCount != null){
            SOQL += ' Limit ' + sc.RecordCount.Format();
        }

        List<Account> accs;
        try{
            accs = Database.query(SOQL);
        }catch(Exception ex){
            DebugSOQL = SOQL;
            ErrorMessage = ex.getMessage();
            return null;
        }    
        
        return accs;
        
    }

}