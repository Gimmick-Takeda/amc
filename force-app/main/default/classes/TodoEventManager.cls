public class TodoEventManager{
    
    
    public static void SendMailBossComment(string OwnerEmail,
                                        string BossEmail,
                                        string AccountName,
                                        string BossComment,
                                        string ActivityDate,
                                        string OfficeOrganization,
                                        string Interview,
                                        string Process,
                                        string Purpose,
                                        string Location,
                                        string Product,
                                        string Reagent,
                                        string State,
                                        string DialyView,
                                        string link){
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        // To
        mail.setToAddresses(new String[] {OwnerEmail});
        // CC
        mail.setCCAddresses(new String[] {BossEmail});
        // 返信先メールアドレス
        
        // 件名
        mail.setSubject(AccountName + ' ' + ActivityDate + 'の上司コメント');                    
        // 本文
        String body = '';
        // 上司コメント
        body = body + '上司コメント：' + BossComment + '\r\n';
        // 訪問先
        body = body + '取引先　　　：' + AccountName + '\r\n';
        // 訪問日
        body = body + '訪問日　　　：' + ActivityDate + '\r\n';
        // 職制
        if(OfficeOrganization.length() > 0){body = body + '職制　　　　：' + OfficeOrganization + '\r\n';}
        // 面談者
        if(Interview.length() > 0){body = body + '面談者　　　：' + Interview + '\r\n';}
        // プロセス
        if(Process.length() > 0){body = body + 'プロセス　　：' + Process + '\r\n';}
        // 目的
        if(Purpose.length() > 0){body = body + '目的　　　　：' + Purpose + '\r\n';}
        // 場所
        if(Location.length() > 0){body = body + '場所　　　　：' + Location + '\r\n';}
        // 商品
        if(Product.length() > 0){body = body + '商品　　　　：' + Product + '\r\n';}
        // 試薬
        if(Reagent.length() > 0){body = body + '試薬　　　　：' + Reagent + '\r\n';}
        // 状況
        if(State.length() > 0){body = body + '状況　　　　：' + State + '\r\n';}
        body = body + '日報　　　　：' + DialyView + '\r\n';
        body = body + 'リンク　　　：' + link + '\r\n';
        
        mail.setPlainTextBody(body);                    
        // 送信
        Messaging.sendEmail( new Messaging.SingleEmailMessage[] { mail } );  
    }
    
    public static void SendMailBossComment(List<Event> evs){
        // ログ
        AccessLog__c al = new AccessLog__c();

        if (evs.size() == 1){
            Event ev = evs[0];
            if(ev.BossComment__c != null){
                // Eventの情報取得
                List<Event> events = [SELECT Id,
                                        LastModifiedBy.Email,
                                        Owner.Id,
                                        Owner.Email,
                                        What.Id,
                                        BossComment__c,
                                        IsBossCommentSendEmail__c,
                                        ActivityDate,DialyView__c,
                                        OfficeOrganizationPC__c,
                                        OfficeOrganization__c,
                                        Interview__c,
                                        Process__c,
                                        Purpose__c,
                                        Location__c,
                                        Product__c,
                                        ReagentItem__c,
                                        StatusCC__c
                                        FROM Event 
                                        WHERE Id =: ev.ID];
                // 更新者の設定が「コメントメール送信する」にチェックが入っている場合のみメール送信する。
                if(events[0].IsBossCommentSendEmail__c == true){

                    String AccountName = '';
                    string OwnerEmail = events[0].Owner.Email;
                    string BossEmail = events[0].LastModifiedBy.Email;
                    string BossComment = events[0].BossComment__c;
                    string ActivityDate = String.ValueOf(events[0].ActivityDate);
                    string OfficeOrganization = '';
                    string Interview = '';
                    string Process = '';
                    string Purpose = '';
                    string Location = '';
                    string Product = '';
                    string Reagent = '';
                    string State = '';
                    string DialyView = '';


                    
                    // 取引先の情報取得
                    List<Account> accounts = [SELECT Id,Name FROM Account WHERE Id =: events[0].What.Id];
                    if (accounts.size() > 0){AccountName = accounts[0].Name;}
                    string link = URL.getSalesforceBaseUrl().toExternalForm() + '/' + events[0].Id;

                    // 職制
                    if(events[0].OfficeOrganizationPC__c != null){OfficeOrganization = events[0].OfficeOrganizationPC__c;}
                    if(events[0].OfficeOrganization__c != null){OfficeOrganization = events[0].OfficeOrganization__c;}  
      
                    // 面談者
                    if(events[0].Interview__c != null){Interview = events[0].Interview__c;}

                    // プロセス
                    if(events[0].Process__c != null){Process = events[0].Process__c;}
                    // 目的
                    if(events[0].Purpose__c != null){Purpose = events[0].Purpose__c;}
                    // 場所
                    if(events[0].Location__c != null){Location = events[0].Location__c;}   
                    
 
                                     
                    // 商品
                    if(events[0].Product__c != null){Product = events[0].Product__c;}                    
                    // 試薬
                    if(events[0].ReagentItem__c != null){Reagent = events[0].ReagentItem__c;}                    
                    // 状況
                    if(events[0].StatusCC__c != null){State = events[0].StatusCC__c;}                    
                    // 日報
                    if(events[0].DialyView__c != null){DialyView = events[0].DialyView__c;}

        al.state__c = 'aaa';
        insert al; 
                    
                    SendMailBossComment(
                        OwnerEmail,
                        BossEmail,
                        AccountName,
                        BossComment,
                        ActivityDate,
                        OfficeOrganization,
                        Interview,
                        Process,
                        Purpose,
                        Location,
                        Product,
                        Reagent,
                        State,
                        DialyView,
                        link);
                          
                }else{
                }
            }
        }
        al.state__c = 'aa';
        insert al;
    }

public static void SendMailBossComment(List<Task> tsk){
        // ログ
        AccessLog__c al = new AccessLog__c();
        if (tsk.size() == 1){
            Task task = tsk[0];
            if(task.BossComment__c != null){
                // Eventの情報取得
                List<Task> Tasks = [SELECT Id,
                                        LastModifiedBy.Email,
                                        Owner.Id,
                                        Owner.Email,
                                        What.Id,
                                        BossComment__c,
                                        IsBossCommentSendEmail__c,
                                        ActivityDate,DialyView__c,
                                        OfficeOrganizationPC__c,
                                        OfficeOrganization__c,
                                        Interview__c,
                                        Process__c,
                                        Purpose__c,
                                        Location__c,
                                        Product__c,
                                        ReagentItem__c,
                                        StatusCC__c
                                        FROM Task 
                                        WHERE Id =: task.ID];
                // 更新者の設定が「コメントメール送信する」にチェックが入っている場合のみメール送信する。
                if(tasks[0].IsBossCommentSendEmail__c == true){
                    String AccountName = '';
                    string OwnerEmail = tasks[0].Owner.Email;
                    string BossEmail = tasks[0].LastModifiedBy.Email;
                    string BossComment = tasks[0].BossComment__c;
                    string ActivityDate = String.ValueOf(tasks[0].ActivityDate);
                    string OfficeOrganization = '';
                    string Interview = '';
                    string Process = '';
                    string Purpose = '';
                    string Location = '';
                    string Product = '';
                    string Reagent = '';
                    string State = '';                    
                    string DialyView = '';
                    
                    // 取引先の情報取得
                    List<Account> accounts = [SELECT Id,Name FROM Account WHERE Id =: tasks[0].What.Id];
                    if (accounts.size() > 0){AccountName = accounts[0].Name;}
                    string link = URL.getSalesforceBaseUrl().toExternalForm() + '/' + tasks[0].Id;
                    // 職制
                    if(tasks[0].OfficeOrganizationPC__c != null){OfficeOrganization = tasks[0].OfficeOrganizationPC__c;}
                    if(tasks[0].OfficeOrganization__c != null){OfficeOrganization = OfficeOrganization + tasks[0].OfficeOrganization__c;}                    
                    // 面談者
                    if(tasks[0].Interview__c != null){Interview = tasks[0].Interview__c;}
                    // プロセス
                    if(tasks[0].Process__c != null){Process = tasks[0].Process__c;}
                    // 目的
                    if(tasks[0].Purpose__c != null){Purpose = tasks[0].Purpose__c;}
                    // 場所
                    if(tasks[0].Location__c != null){Location = tasks[0].Location__c;}                    
                    // 商品
                    if(tasks[0].Product__c != null){Product = tasks[0].Product__c;}                    
                    // 試薬
                    if(tasks[0].ReagentItem__c != null){Reagent = tasks[0].ReagentItem__c;}                    
                    // 状況
                    if(tasks[0].StatusCC__c != null){State = tasks[0].StatusCC__c;}
                    // 日報
                    if(tasks[0].DialyView__c != null){DialyView = tasks[0].DialyView__c;}
                    SendMailBossComment(
                        OwnerEmail,
                        BossEmail,
                        AccountName,
                        BossComment,
                        ActivityDate,
                        OfficeOrganization,
                        Interview,
                        Process,
                        Purpose,
                        Location,
                        Product,
                        Reagent,
                        State,
                        DialyView,
                        link);
                }else{
                }
            }
        }
        al.state__c = 'aa';
        insert al;        
    }


}