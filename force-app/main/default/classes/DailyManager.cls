public class DailyManager{
    public static void UpdateLocation(List<Event> evs){
        // 変更された対象の行動取得
        List<Event> events = [SELECT ID,What.Type,What.Id,Location FROM EVENT WHERE Id IN: evs ];
        // ループ処理
        for(Event ev : events){
            if(ev.What.Type == 'Account'){
                // 取引先
                String AccountId = ev.What.Id;
                List<Account> ac = [SELECT Name FROM Account WHERE Id =: AccountId];
                ev.Location = ac[0].Name;
            }else if(ev.What.Type == 'Opportunity__c'){
                // 商談
                String OpId= ev.What.Id;
                // 商談取得
                List<Opportunity__c> op = [SELECT Name,Account__c FROM Opportunity__c WHERE Id =: OpId];
                String SName = op[0].Name;
                String AcId = op[0].Account__c ;
                List<Account> ac = [SELECT Name FROM Account WHERE Id =: AcId ];
                ev.Location = ac[0].Name + SName;
            }
        }
        // 更新
        update events ;
    }
}