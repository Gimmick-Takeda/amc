global class QuotationCountup{
  webService static void updateNumber(String id){
      Opportunity__c opp = [SELECT Id,QuotationNo__c,Customer_Length__c
                         FROM Opportunity__c
                         WHERE Id =: id
                         LIMIT 1];
      if (opp.QuotationNo__c >= 1) {
          opp.QuotationNo__c += 1;
      } else {
          opp.QuotationNo__c = 1;
      }
        update opp;
  }
}