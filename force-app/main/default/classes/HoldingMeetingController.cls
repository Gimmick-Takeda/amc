public class HoldingMeetingController{
    public static void HoldingMeetingAdded(List<HoldingMeeting__c> meetings)
    {
        // 関連のループ
        for(HoldingMeeting__c meeting:meetings)
        {
            // 関連付ける人物
            List<Association__c> assChildren = new List<Association__c>();
            // 人物一覧(アクティブメンバーのみ取得)
            List<Association__c> persons = [
            SELECT Id,Name,Contact__c 
            From Association__c 
            WHERE 
            	DMQOL__c =: meeting.DMQOL__c AND 
            	TQActiveMember__c = true
            ];
            
            for(Association__c person:persons){
                Association__c ass = new Association__c();
                ass.RecordTypeId = '01210000000EZuyAAG';
                ass.HoldingMeeting__c = meeting.Id;
                ass.Contact__c = person.Contact__c;
                ass.Participation__c = true;
                assChildren.Add(ass);
            }
            insert assChildren;
        }
    }
}