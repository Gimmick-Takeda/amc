public class FeedItemManager{
    @future
    public static void DeleteFeedItem(Id parentid){
        List<FeedItem> feeds = [SELECT Id FROM FeedItem WHERE Type = 'CreateRecordEvent' AND ParentId =:parentid];
        delete feeds;
    }
}