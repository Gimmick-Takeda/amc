public class AssociationController{
    public static void AssociationChanged(List<Association__c> Associations)
    {
        // 関連のループ
        for(Association__c ass:Associations)
        {
            if(ass.Contact__c==null) continue;
            // 人物          
            Contact person;
            List<Contact> persons = [SELECT Id,Name,AccountId,Department   
            FROM Contact 
            WHERE Id=:ass.Contact__c];
            if(persons.size()!=1)            
            {
                continue;
            }else{
                person = persons[0];           
            }           
            // 主勤務先の場合
            if(ass.MainPlaceOfWork__c==true){
            	
                // 勤務先が入っている場合
                if(ass.Account__c!=null){
                	person.AccountId = ass.Account__c;
                	person.Department = ass.Department__c;
                	person.Title = ass.Post__c;
                	person.JobCategory__c = ass.JobCategory__c;
                    person.Account__c = ass.Account__c;
                }
            }
            // 糖Q会情報更新
            List<Association__c> DMAssociations = [SELECT Id,DMQOL__r.Name 
                FROM Association__c 
                WHERE Contact__c=:person.Id AND DMQOL__c!=null];
            string DMQOL = '';
            for(Association__c asdm:DMAssociations){
                DMQOL = DMQOL + asdm.DMQOL__r.Name + ' ';
            }
            person.DMQOL__c = DMQOL.Trim();
            update person;
        }
    }
}