public with sharing class AccountAssetOpActivitySearchCondition{

    /// フィルター条件
    public List<SelectOption> StateListItems{get;set;}
    public string State{get;set;}
    public string City{get;set;}
    
    public List<String> AccountIds {get;set;}

    // -------------------------------------------------------------------------------------------
    // 取引先条件
    // -------------------------------------------------------------------------------------------
    public boolean CC{get;set;}
    // PC上位先
    public boolean PCUpperLevelc {get;set;}
    // 任意法人グループ
    public List<SelectOption> RCTMSMWERT02ListItems{get;set;}
    public string RCTMSMWERT02Textc {get;set;}    
    // 分類
    public List<SelectOption> ClassificationListItems{get;set;}
    public string Classification{get;set;}
    // 検査センター名
    public List<SelectOption> LabNameListItems{get;set;}
    public string LabName{get;set;}
    // 検査センター区分名
    public List<SelectOption> LabClassificationnListItems{get;set;}
    public string LabClassification{get;set;}
    // -------------------------------------------------------------------------------------------    

    // -------------------------------------------------------------------------------------------
    // 医療機関情報条件
    // -------------------------------------------------------------------------------------------    
    public boolean UseHospitalInfo { get; set; }    
    // 糖尿病透析予防指導管理料
    public boolean Item119{get;set;}
    // 糖尿病合併症管理料
    public boolean Item114{get;set;}
    // 検体検査管理加算Ｉ〜ＩV
    public boolean Item157{get;set;}
    public boolean Item158{get;set;}
    public boolean Item159{get;set;}        
    public boolean Item160{get;set;}
    // 皮下連続式グルコース測定
    public boolean Item168{get;set;}
    // 糖尿病専門医
    public boolean DMDrCount{get;set;}
    // 認定教育施設
    public boolean AccreditedTrainingFacility{get;set;}
    // 認定教育施設（無床）
    public boolean AccreditedEducationalInstitutionNoF{get;set;}
    // 教育関連施設
    public boolean EducationRelatedFacilities{get;set;}
    // 連携教育施設
    public boolean CooperationEducationalFacilities{get;set;}
    // がん拠点病院【地域】
    public boolean CancerHospitalsArea{get;set;}
    // がん拠点病院【都道府県】
    public boolean CancerHospitalsTDK{get;set;}
    // レコード数
    public Integer RecordCount{get;set;}
    
    // -------------------------------------------------------------------------------------------

    // -------------------------------------------------------------------------------------------
    // 商談条件
    // -------------------------------------------------------------------------------------------
    // フェーズ
    public List<SelectOption> StageNameListItems{get;set;}
    public List<String> StageNameList{get;set;}


    public string Filter{get;set;}
    public String FilterURL { get; set; }
    
    
    public AccountAssetOpActivitySearchCondition(){
        
        // 商談フェーズ
        StageNameListItems  = new List<SelectOption>();
        StageNameList = new List<String>();
        List<Schema.PicklistEntry> Stagelistitems = OpportunityLineItem__c.StageName__c.getDescribe().getPicklistValues();
        for (Schema.PicklistEntry pEntryStage : Stagelistitems){ 
            string stagevalue = pEntryStage.getValue();
            StageNameListItems.add(new SelectOption(pEntryStage.getValue(),pEntryStage.getValue()));
            StageNameList.add(stagevalue);
        }
        
        // 任意法人グループ
        RCTMSMWERT02ListItems = new List<SelectOption>();
        RCTMSMWERT02ListItems.add(new SelectOption('',''));        
        List<Schema.PicklistEntry> listitems = Account.RCTMS_MWERT02Text__c.getDescribe().getPicklistValues();
        for (Schema.PicklistEntry pEntryTemp : listitems){ 
            RCTMSMWERT02ListItems.add(new SelectOption(pEntryTemp.getValue(),pEntryTemp.getValue()));
        }
        // 分類
        ClassificationListItems = new List<SelectOption>();
        ClassificationListItems.add(new SelectOption('%',''));        
        List<Schema.PicklistEntry> listitems2 = Account.Classification__c.getDescribe().getPicklistValues();
        for (Schema.PicklistEntry pEntryTemp2 : listitems2){ 
            ClassificationListItems.add(new SelectOption(pEntryTemp2.getValue(),pEntryTemp2.getValue()));
        }
        // 検査センター名
        LabNameListItems = new List<SelectOption>();
        LabNameListItems.add(new SelectOption('',''));        
        List<Schema.PicklistEntry> listitems3 = Account.LabName__c.getDescribe().getPicklistValues();
        for (Schema.PicklistEntry pEntryTemp3: listitems3){ 
            LabNameListItems.add(new SelectOption(pEntryTemp3.getValue(),pEntryTemp3.getValue()));
        }        
        // 検査センター区分名
        LabClassificationnListItems = new List<SelectOption>();
        LabClassificationnListItems.add(new SelectOption('',''));        
        List<Schema.PicklistEntry> listitems4 = Account.LabClassification__c.getDescribe().getPicklistValues();
        for (Schema.PicklistEntry pEntryTemp4 : listitems4){ 
            LabClassificationnListItems.add(new SelectOption(pEntryTemp4.getValue(),pEntryTemp4.getValue()));
        }    
        StateListItems = new List<SelectOption>();     
        StateListItems.add(new SelectOption('北海道','北海道'));
        StateListItems.add(new SelectOption('青森県','青森県'));
        StateListItems.add(new SelectOption('岩手県','岩手県'));
        StateListItems.add(new SelectOption('宮城県','宮城県'));
        StateListItems.add(new SelectOption('秋田県','秋田県'));
        StateListItems.add(new SelectOption('山形県','山形県'));
        StateListItems.add(new SelectOption('福島県','福島県'));
        StateListItems.add(new SelectOption('茨城県','茨城県'));
        StateListItems.add(new SelectOption('栃木県','栃木県'));
        StateListItems.add(new SelectOption('群馬県','群馬県'));
        StateListItems.add(new SelectOption('埼玉県','埼玉県'));
        StateListItems.add(new SelectOption('千葉県','千葉県'));
        StateListItems.add(new SelectOption('東京都','東京都'));
        StateListItems.add(new SelectOption('神奈川県','神奈川県'));
        StateListItems.add(new SelectOption('新潟県','新潟県'));
        StateListItems.add(new SelectOption('富山県','富山県'));
        StateListItems.add(new SelectOption('石川県','石川県'));
        StateListItems.add(new SelectOption('福井県','福井県'));
        StateListItems.add(new SelectOption('山梨県','山梨県'));
        StateListItems.add(new SelectOption('長野県','長野県'));
        StateListItems.add(new SelectOption('岐阜県','岐阜県'));
        StateListItems.add(new SelectOption('静岡県','静岡県'));
        StateListItems.add(new SelectOption('愛知県','愛知県'));
        StateListItems.add(new SelectOption('三重県','三重県'));
        StateListItems.add(new SelectOption('滋賀県','滋賀県'));
        StateListItems.add(new SelectOption('京都府','京都府'));
        StateListItems.add(new SelectOption('大阪府','大阪府'));
        StateListItems.add(new SelectOption('兵庫県','兵庫県'));
        StateListItems.add(new SelectOption('奈良県','奈良県'));
        StateListItems.add(new SelectOption('和歌山県','和歌山県'));
        StateListItems.add(new SelectOption('鳥取県','鳥取県'));
        StateListItems.add(new SelectOption('島根県','島根県'));
        StateListItems.add(new SelectOption('岡山県','岡山県'));
        StateListItems.add(new SelectOption('広島県','広島県'));
        StateListItems.add(new SelectOption('山口県','山口県'));
        StateListItems.add(new SelectOption('徳島県','徳島県'));
        StateListItems.add(new SelectOption('香川県','香川県'));
        StateListItems.add(new SelectOption('愛媛県','愛媛県'));
        StateListItems.add(new SelectOption('高知県','高知県'));
        StateListItems.add(new SelectOption('福岡県','福岡県'));
        StateListItems.add(new SelectOption('佐賀県','佐賀県'));
        StateListItems.add(new SelectOption('長崎県','長崎県'));
        StateListItems.add(new SelectOption('熊本県','熊本県'));
        StateListItems.add(new SelectOption('大分県','大分県'));
        StateListItems.add(new SelectOption('宮崎県','宮崎県'));
        StateListItems.add(new SelectOption('鹿児島県','鹿児島県'));
        StateListItems.add(new SelectOption('沖縄県','沖縄県'));
        StateListItems.add(new SelectOption('%',''));            
    
        // 医療機関情報で絞り込む
        UseHospitalInfo = true;
        // 糖尿病透析予防指導管理料
        Item119 = true;
        // 糖尿病合併症管理料
        Item114 = true;
        // 検体検査管理加算Ｉ〜ＩV
        Item157 = true;
        Item158 = true;
        Item159 = true;
        Item160 = true;
        
        // 皮下連続式グルコース測定
        Item168 = true;
        // 糖尿病専門医
        DMDrCount = true;
        // 認定教育施設
        AccreditedTrainingFacility = true;
        // 認定教育施設（無床）
        AccreditedEducationalInstitutionNoF = true;
        // 教育関連施設
        EducationRelatedFacilities = true;
        // 連携教育施設
        CooperationEducationalFacilities = true;
        // がん拠点病院【地域】
        CancerHospitalsArea = true;
        // がん拠点病院【都道府県】
        CancerHospitalsTDK = true;
   
        
        RecordCount = 500;
    }


    /// 検索条件作成
    public PageReference CreateSearchFilter() {
        // 都道府県
        Filter = '((ShippingState LIKE \'' + State + '\') AND ';
        // 市区郡
        Filter += '(ShippingCity LIKE \'' + City + '%\') AND ';
        // 任意法人グループ
        if(RCTMSMWERT02Textc == null){
        
        }else if(RCTMSMWERT02Textc.Length() > 0){
            Filter += '(RCTMS_MWERT02Text__c  LIKE \'' + RCTMSMWERT02Textc + '\') AND ';
        }
        if(LabName == null){
        
        }else if(LabName.Length() > 0){
            Filter += '(LabName__c  = \'' + LabName + '\') AND ';
        }
        if(LabClassification == null){
        
        }else if(LabClassification.Length() > 0){
            Filter += '(LabClassification__c  = \'' + LabClassification + '\') AND ';
        }                
        
        
        
        // PC上位先
        if(PCUpperLevelc != null){
            if(PCUpperLevelc){
                Filter += '(PCUpperLevel__c  = true) AND ';
            }
        }
        // 施設分類
        Filter += '(Classification__c LIKE \'' + Classification+ '\') '; 
        Filter += ')  ';
        if(UseHospitalInfo){
            List<String> AccountFilter = new List<string>();
            // 糖尿病透析予防指導管理料
            if(Item119 == true){AccountFilter.Add('Item119__c = true');}
            // 糖尿病合併症管理料
            if(Item114 == true){AccountFilter.Add('Item114__c = true');}
            // 検体検査管理加算I
            if(Item157 == true){AccountFilter.Add('Item157__c = true');}
            // 検体検査管理加算II
            if(Item158 == true){AccountFilter.Add('Item158__c = true');}        
            // 検体検査管理加算III
            if(Item159 == true){AccountFilter.Add('Item159__c = true');}        
            // 検体検査管理加算IV
            if(Item160 == true){AccountFilter.Add('Item160__c = true');}        
            // 皮下連続式グルコース測定
            if(Item168 == true){AccountFilter.Add('Item168__c = true');}
            // 糖尿病専門医
            if(DMDrCount == true){AccountFilter.Add('DMDrCount__c > 0' );}
            // 認定教育施設
            if(AccreditedTrainingFacility == true){AccountFilter.Add('AccreditedTrainingFacility__c = true');}
            // 認定教育施設（無床）
            if(AccreditedEducationalInstitutionNoF == true){AccountFilter.Add('AccreditedEducationalInstitutionNoF__c = true');}
            // 教育関連施設
            if(EducationRelatedFacilities == true){AccountFilter.Add('EducationRelatedFacilities__c = true');}
            // 連携教育施設
            if(CooperationEducationalFacilities == true){AccountFilter.Add('CooperationEducationalFacilities__c = true');}
            // がん拠点病院【地域】
            if(CancerHospitalsArea == true){AccountFilter.Add('CancerHospitalsArea__c = true');}
            // がん拠点病院【都道府県】
            if(CancerHospitalsTDK == true){AccountFilter.Add('CancerHospitalsTDK__c = true');}        
            if(AccountFilter.size() > 0){
                Filter += ' AND (';
                for(string acFilter:AccountFilter){
                    Filter += ' (' + acFilter + ') OR ';
                }
                Filter = Filter .Substring(0,Filter.Length() - 4);
                Filter += ')';
            }
        }
        

        
        // LoadUriParamernter();
        
        return null;
    }
    
    private void LoadUriParamernter(){
        /// フィルター条件
        State = ApexPages.currentPage().getParameters().get('State');
        City = ApexPages.currentPage().getParameters().get('City');
    
        // -------------------------------------------------------------------------------------------
        // 取引先条件
        // -------------------------------------------------------------------------------------------
        //CC = Boolean.ValueOf(ApexPages.currentPage().getParameters().get('CC'));
        // PC上位先
        //PCUpperLevelc = Boolean.ValueOf(ApexPages.currentPage().getParameters().get('PCUpperLevelc'));
        // 任意法人グループ
    
        RCTMSMWERT02Textc = ApexPages.currentPage().getParameters().get('RCTMSMWERT02Textc');
        // 分類
    
        Classification = ApexPages.currentPage().getParameters().get('Classification');
        // 検査センター名
    
        LabName = ApexPages.currentPage().getParameters().get('LabName');
        // 検査センター区分名
    
        LabClassification = ApexPages.currentPage().getParameters().get('LabClassification');
        // -------------------------------------------------------------------------------------------    
    
        // -------------------------------------------------------------------------------------------
        // 医療機関情報条件
        // -------------------------------------------------------------------------------------------    
        //UseHospitalInfo = Boolean.ValueOf(ApexPages.currentPage().getParameters().get('UseHospitalInfo'));
        // 糖尿病透析予防指導管理料
        //Item119 = Boolean.ValueOf(ApexPages.currentPage().getParameters().get('Item119'));
        // 糖尿病合併症管理料
        //Item114 = Boolean.ValueOf(ApexPages.currentPage().getParameters().get('Item114'));
        // 検体検査管理加算Ｉ〜ＩV
        //Item157 = Boolean.ValueOf(ApexPages.currentPage().getParameters().get('Item157'));
        //Item158 = Boolean.ValueOf(ApexPages.currentPage().getParameters().get('Item158'));
        //Item159 = Boolean.ValueOf(ApexPages.currentPage().getParameters().get('Item159'));
        //Item160 = Boolean.ValueOf(ApexPages.currentPage().getParameters().get('Item160'));
        // 皮下連続式グルコース測定
        //Item168 = Boolean.ValueOf(ApexPages.currentPage().getParameters().get('Item168'));
        // 糖尿病専門医
        //DMDrCount = Boolean.ValueOf(ApexPages.currentPage().getParameters().get('DMDrCount'));
        // 認定教育施設
        //AccreditedTrainingFacility = Boolean.ValueOf(ApexPages.currentPage().getParameters().get('AccreditedTrainingFacility'));
        // 認定教育施設（無床）
        //AccreditedEducationalInstitutionNoF = Boolean.ValueOf(ApexPages.currentPage().getParameters().get('AccreditedEducationalInstitutionNoF'));
        // 教育関連施設
        //EducationRelatedFacilities = Boolean.ValueOf(ApexPages.currentPage().getParameters().get('EducationRelatedFacilities'));
        // 連携教育施設
        //CooperationEducationalFacilities = Boolean.ValueOf(ApexPages.currentPage().getParameters().get('CooperationEducationalFacilities'));
        // がん拠点病院【地域】
        //CancerHospitalsArea = Boolean.ValueOf(ApexPages.currentPage().getParameters().get('CancerHospitalsArea'));
        // がん拠点病院【都道府県】
        //CancerHospitalsTDK = Boolean.ValueOf(ApexPages.currentPage().getParameters().get('CancerHospitalsTDK'));
        // レコード数
        //RecordCount = Integer.ValueOf(ApexPages.currentPage().getParameters().get('RecordCount'));
        
        // -------------------------------------------------------------------------------------------
    
        // -------------------------------------------------------------------------------------------
        // 商談条件
        // -------------------------------------------------------------------------------------------
        //StageNotNegotiation = Boolean.ValueOf(ApexPages.currentPage().getParameters().get('StageNotNegotiation'));
        //StageNotOrderd = Boolean.ValueOf(ApexPages.currentPage().getParameters().get('StageNotOrderd'));
        //StageOrdersReceived = Boolean.ValueOf(ApexPages.currentPage().getParameters().get('StageOrdersReceived'));
        //StageA = Boolean.ValueOf(ApexPages.currentPage().getParameters().get('StageA'));
        //StageB = Boolean.ValueOf(ApexPages.currentPage().getParameters().get('StageB'));
        //StageC = Boolean.ValueOf(ApexPages.currentPage().getParameters().get('StageC'));
        //StageD = Boolean.ValueOf(ApexPages.currentPage().getParameters().get('StageD'));
        //StageE = Boolean.ValueOf(ApexPages.currentPage().getParameters().get('StageE'));
        //StageLead = Boolean.ValueOf(ApexPages.currentPage().getParameters().get('StageLead'));    
        
    
    }
    


}