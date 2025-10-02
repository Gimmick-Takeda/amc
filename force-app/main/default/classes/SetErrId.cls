public class SetErrId{
    
    String ErrText;
    String HeadText;
    
    String Text0 = 'ダウンロードが始まらない場合は以下リンクをクリックしてください。';
    String Text1 = '得意先が入力されていません。';
    String Text2 = '相見積先が入力されていません。';
    String Text3 = '回収条件が入力されていません。';
    String Text4 = '回収条件（相見積先）が入力されていません。';
    String Text5 = '提案価格が入力されていない商品があります。';
    String Text6 = '相見積価格が入力されていない商品があります。';
    String Text7 = 'オープン価格の商品が含まれています。';
    String Text8 = 'セット品名が記載されていません。';
    
    Opportunity__c opp = [SELECT ID,QuotationNo__c,QuotationType__c,Customer_Length__c,AccountPriceCheck__c,OpenPriceCount__c,SetProductNameLength__c,WholesaleMQNameCount__c,PaymentTermsNameLength__c,MQPaymentNameLength__c,MQPriceNoInput__c
                              FROM Opportunity__c
                              WHERE ID =:ApexPages.currentPage().getParameters().get('id') ];
    
    public SetErrId(ApexPages.StandardController controller){
         
    }
    
    // property
    public String message {
        
        get {
            String QNo = opp.QuotationType__c.left(3);
            if ((QNo == '01：' || QNo == '03：' || QNo == '05：'|| QNo == '07：') && opp.Customer_Length__c == 0) {
                ErrText = Text1;
            } else if ((QNo == '01b' || QNo == '03b' || QNo == '05b') && opp.WholesaleMQNameCount__c == 0){
                ErrText = Text2;
            } else if ((QNo == '01：' || QNo == '03：' || QNo == '05：'|| QNo == '07：') && opp.PaymentTermsNameLength__c == 0){
                ErrText = Text3;
            } else if ((QNo == '01b' || QNo == '03b' || QNo == '05b') && opp.MQPaymentNameLength__c == 0){
                ErrText = Text4;
            } else if ((QNo == '02:' || QNo == '04:' || QNo == '06:'|| QNo == '08：') && opp.AccountPriceCheck__c > 0){
                ErrText = Text5;
            } else if ((QNo == '01b' || QNo == '03b') && opp.MQPriceNoInput__c > 0){
                ErrText = Text6;
            } else if ((QNo == '03:' || QNo == '04:' || QNo == '03b') && opp.OpenPriceCount__c > 0){
                ErrText = Text7;
            } else if ((QNo == '05:' || QNo == '06:') && opp.SetProductNameLength__c == 0){
                ErrText = Text8;
            } else {
                ErrText = Text0;
            }
                return ErrText;
            }
        set;
    }
        
    // getter
    public String getMessage2() {
        String QNo2 = opp.QuotationType__c.left(2);
        if ( message == Text0) {
            HeadText = 'しばらくお待ちください';
        } else {
            HeadText = 'エラー';
        }
        return HeadText;
    }  
}