public class SetQuotationType {
    String HT;
    String QT;
    String ST;
    String QName;
    String QNo,QNo2,QNo3,QNo4;
    
    Opportunity__c opp = [SELECT ID,QuotationType__c,CustomerOutputName__c,AccountOutputName__c,WholesaleMQPrintName__c,ServiceProposal__c,ServiceCount__c
                              FROM Opportunity__c
                              WHERE ID =:ApexPages.currentPage().getParameters().get('id') ];
    
    public SetQuotationType(ApexPages.StandardController controller){
         
    }
    
    // property
    public String qt1 {
        get {
            String QNo = opp.QuotationType__c.left(3);
            if (QNo == '01：' || QNo == '03：' || QNo == '05：'|| QNo == '07：'){
                HT = 'Hyoshi_001';
            } else if (QNo == '01b' || QNo == '03b' || QNo == '05b'){
                HT = 'Hyoshi_001b';
            } else {
                HT = 'Hyoshi_002';
            }
                return HT;
            }
        set;
    }
    
    public String qt2 {
        get {
            String QNo2 = opp.QuotationType__c.left(3);
            if (QNo2 == '01：'){
                QT = 'Mitsumori_001b';
            } else if (QNo2 == '01b') {
                QT = 'Mitsumori_001c';
            } else if (QNo2 == '02：') {
                QT = 'Mitsumori_002b';
            } else if (QNo2 == '03：') {
                QT = 'Mitsumori_003b';
            } else if (QNo2 == '03b') {
                QT = 'Mitsumori_003c';
            } else if (QNo2 == '04：') {
                QT = 'Mitsumori_004b';
            } else if (QNo2 == '05：') {
                QT = 'Mitsumori_005c';
            } else if (QNo2 == '05b') {
                QT = 'Mitsumori_005d';
            } else if (QNo2 == '06：') {
                QT = 'Mitsumori_006b';
            } else if (QNo2 == '08：') {
                QT = 'Mitsumori_BGM_User';
            } else {
                QT = 'Mitsumori_BGM';
            }
                return QT;
            }
        set;
    }

    public String qt4 {
        get {
            String QNo4 = opp.QuotationType__c.left(3);
            if (opp.ServiceProposal__c == '提案なし' || opp.ServiceProposal__c == '' || opp.ServiceCount__c == 0) {
                ST = '';
            } else if (opp.ServiceProposal__c == '直販' && (QNo4 == '01：' || QNo4 == '03：'|| QNo4 == '05：')){
                ST = '';
            } else if (QNo4 == '01：' || QNo4 == '03：'|| QNo4 == '05：'){
                ST = 'Mitsumori_Hoshu001';
            } else if (QNo4 == '02：' || QNo4 == '04：'|| QNo4 == '06：'){
                ST = 'Mitsumori_Hoshu002';
            } else {
                ST = '';
            }
                return ST;
            }
        set;
    }
    
    // getter
    public String getQt3() {
        String QNo3 = opp.QuotationType__c.left(3);
        if (QNo3 == '01：' || QNo3 == '03：' || QNo3 == '05：'|| QNo3 == '07：'){
QName = opp.CustomerOutputName__c;
            } else if(QNo3 == '01b' || QNo3 == '03b' || QNo3 == '05b'){
QName = opp.WholesaleMQPrintName__c;
            } else {
                QName = opp.AccountOutputName__c;
            }
        return QName;
    }
}