public class SmileTranslateApplyAutoController {
    public String InputText { get; set; }
    public String Message{get;set;}
    public PageReference ApplyAuto() {
        this.Message = 'ApplyAuto';
        String STAID = ApplyText2ST(this.InputText);
        PageReference pageRef = new PageReference('/' + STAID);
        return pageRef;
    }
    
    /**
    * 
    */
    public String ApplyText2ST (String inputText){
        this.Message = 'ApplyText2ST ';
        // テキストを行に分解    
        String[] lines = inputText.Split('\r');
        // レコード作成
        SmileTranslateApply__c st = new SmileTranslateApply__c();
        st.DataSource__c = inputText;
        // 行でループ
        for(String line:lines){
            // １行をタブで分割
            String[] items = line.Split('\t');
            if(items.size()>1){
                String itemname = items[0].trim();
                this.Message += itemname ;
                st.State__c = '1000 申込受付';
                if(itemname.equals('■お申し込み番号')){
                    this.Message += '■お申し込み番号';
                    st.ApplyNumber__c = items[1];
                }

                if(itemname.equals('■契約者法人名')){
                    st.CorporateName__c = items[1];
                    this.Message += '■法人名';
                }
                
                if(itemname.equals('■契約者法人名（かな）')){
                    st.CorporateNameKana__c = items[1];
                    this.Message += '■法人名';
                }                
                
                if(itemname.equals('■契約者業種')){
                    st.Business__c = items[1];
                }
                
                if(itemname.equals('■契約者所在地郵便番号')){
                    st.LocationZipCode__c = items[1];
                }

                if(itemname.equals('■契約者所在地')){
                    st.Location__c = items[1];
                }
                
                if(itemname.equals('■契約者代表者')){
                    st.Representative__c = items[1];
                }   
                if(itemname.equals('■契約者代表者（かな）')){
                    st.RepresentativeKana__c = items[1];
                }                           
                
                if(itemname.equals('■契約者電話番号')){
                    st.PhoneNnumber__c = items[1];
                }            
                if(itemname.equals('■契約者FAX番号')){
                    st.FAX__c = items[1];
                }            
                
                if(itemname.equals('■契約者ご担当者')){
                    st.PersonInCharge__c = items[1];
                }
                
                if(itemname.equals('■契約者ご担当者（かな）')){
                    st.PersonInChargeKana__c = items[1];
                }                            
                    
                
                if(itemname.equals('■契約者部署')){
                    st.Unit__c = items[1];
                }            
                
                if(itemname.equals('■契約者携帯電話')){
                    st.MobilePhone__c = items[1];
                }
                
                
                if(itemname.equals('■登録タイプ')){
                    st.RegistrationType__c = items[1];
                }
                                
                if(itemname.equals('■社員番号')){
                    st.EmployeeNumber__c = items[1];
                }
                                
                if(itemname.equals('■社員名')){
                    st.EmployeeName__c = items[1];
                }
                                
                if(itemname.equals('■社員メールアドレス')){
                    st.EmployeeEmailAddress__c = items[1];
                }
                                
                if(itemname.equals('■申込書送付先')){
                    st.ApplicationFormDestination__c = items[1];
                }
                                
                if(itemname.equals('■申込書送付先住所（郵便番号）')){
                    st.ApplicationFormAddressZipCode__c = items[1];
                }
                                
                if(itemname.equals('■申込書送付先住所')){
                    st.ApplicationFormAddress__c = items[1];
                }
                if(itemname.equals('■登録日時')){
                    st.WebApplyDate__c = items[1];
                }
                
                if(itemname.equals('■契約者メールアドレス')){
                    st.ContractorEmailAddress__c = items[1];
                }
                                
                if(itemname.equals('■支払方法')){
                    st.PaymentMethod__c = items[1];
                }
                                
                if(itemname.equals('■特約店名')){
                    st.RiderShopName__c = items[1];
                }                                                
                if(itemname.equals('■支払回数')){
                    st.NumberOfPayments__c = items[1];
                }                
                
                if(itemname.equals('■特記事項')){
                    st.SpecialInstruction__c = items[1].replace('\\r','\r').replace('\\n','\n');
                }                
                                                
                
                         
            }  
        }
        Database.SaveResult result = database.insert(st,true);
        Id STAID = result.getId();
        Message = '';
        List<String> ItemNumbers = New List<String>();
        ItemNumbers.Add('■使用者１');
        ItemNumbers.Add('■使用者２');
        ItemNumbers.Add('■使用者３');
        ItemNumbers.Add('■使用者４');
        ItemNumbers.Add('■使用者５');
        for(String ItemNo:ItemNumbers){
            Boolean IsExists = false;
            SmileTranslateUser__c stuser;
            for(String line:lines){
                if(line.length() < 5){
                    Continue;
                }
                if(line.Substring(0,6).trim() == ItemNo){                  
                    String[] items2 = line.Split('\t');
                    if(items2.size() > 1){    
                        Message = '1';
                        if(items2[1].length() > 0){                        
                            if(items2[0].trim() == ItemNo + 'FACETIME着信用の連絡先情報'){                                    
                                IsExists = true;
                                stuser = new SmileTranslateUser__c();
                                stuser.SmileTranslateApply__c = STAID;
                            }
                            if(IsExists){
                                
                                if(items2[0].trim() == ItemNo + 'FACETIME着信用の連絡先情報'){

                                    stuser.FaceTimeContactInformation__c = items2[1];
                                }
                                if(items2[0].trim() == ItemNo + 'メールアドレス'){
                                    stuser.STUEMail__c = items2[1];
                                }
                                if(items2[0].trim() == ItemNo + 'ご契約者の所在地と同じかどうか'){
                                    stuser.STUserIsSameAddressText__c = items2[1];
                                }
                                if(items2[0].trim() == ItemNo + '施設名'){
                                    stuser.STAccountName__c = items2[1];
                                }                                
                                if(items2[0].trim() == ItemNo + '施設名（かな）'){
                                    stuser.STAccountKana__c = items2[1];
                                }                                
                                if(items2[0].trim() == ItemNo + '住所（郵便番号）'){
                                    stuser.STUZipCode__c = items2[1];
                                }
                                if(items2[0].trim() == ItemNo + '住所'){
                                    stuser.STUAddress__c = items2[1];
                                }
                                if(items2[0].trim() == ItemNo + '電話番号'){
                                    stuser.STUTel__c = items2[1];
                                }                                
                            }                                
                        }
                    }                        
                }
            }
            if(IsExists){
                insert stuser;
            }
        }
        InputText = '';
        PageReference pageRef = new PageReference('/' + STAID);

        return STAID;         
    }
}