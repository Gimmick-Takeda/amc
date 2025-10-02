public class TaskCustomController {

    public Task getTask() {
        string TaskId = ApexPages.currentPage().getParameters().get('id');
        Task[] tasks = new Task[]{};
        tasks = [SELECT Subject FROM Task WHERE Id=:TaskId];
        Task task = new Task();
        task = tasks[0];
        return task;
    }
    
    public PageReference Go() {
        string TaskId = ApexPages.currentPage().getParameters().get('id');
        Task[] Tasks = [SELECT Subject,OwnerId FROM Task WHERE Id=:TaskId];
        Task uTask;
        try{
            uTask = Tasks[0];
            uTask.OwnerId = UserInfo.getUserId();
            UPDATE uTask;        
        }catch (Exception e){
            
        }

        return (new ApexPages.StandardController(uTask)).view();
    }
}