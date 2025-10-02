public with sharing class OpportunityLineItemsController {
    
    @AuraEnabled(cacheable=true)
    public static List<OpportunityLineItem__c> getOpportunityLineItems(Id opportunityId) {
        try {
            if (opportunityId == null) {
                throw new AuraHandledException('商談IDが指定されていません');
            }
            
            // 商談商品の一覧を取得
            List<OpportunityLineItem__c> lineItems = [
                SELECT 
                    Id,
                    Name,
                    ProductName__c,
                    Product__c,
                    Product__r.Name,
                    Product__r.MakerName__c,
                    Quantity__c,
                    UnitPrice__c,
                    Subtotal__c,
                    StageName__c,
                    CloseDate__c,
                    Quota_Check__c,
                    RecordTypeId,
                    CreatedDate,
                    LastModifiedDate
                FROM OpportunityLineItem__c 
                WHERE Opportunity__c = :opportunityId
                ORDER BY CreatedDate DESC
                LIMIT 1000
            ];
            
            return lineItems;
            
        } catch (Exception e) {
            throw new AuraHandledException('商談商品の取得中にエラーが発生しました: ' + e.getMessage());
        }
    }
    
    @AuraEnabled
    public static String deleteOpportunityLineItem(Id lineItemId) {
        try {
            if (lineItemId == null) {
                throw new AuraHandledException('商談商品IDが指定されていません');
            }
            
            OpportunityLineItem__c lineItem = [
                SELECT Id, Name, ProductName__c 
                FROM OpportunityLineItem__c 
                WHERE Id = :lineItemId 
                LIMIT 1
            ];
            
            delete lineItem;
            
            return '商談商品「' + lineItem.Name + '」を削除しました';
            
        } catch (Exception e) {
            throw new AuraHandledException('商談商品の削除中にエラーが発生しました: ' + e.getMessage());
        }
    }
}




