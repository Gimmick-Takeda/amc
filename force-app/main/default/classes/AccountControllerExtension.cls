public class AccountControllerExtension {
  private final Account account;
  
  // SMBG採用状況
  public List<SMBGAdoption__c> ExSMBGAdoptions;
  public List<SMBGAdoption__c> getExSMBGAdoptions(){
    return ExSMBGAdoptions;
  }
  
  // 関連
  public List<Association__c> ExAssociations;
  public List<Association__c> getExAssociations(){
    return ExAssociations;
  }  
  
  // 納入商品
  public List<Asset__c> ExAssets;
  public List<Asset__c> getExAssets(){
    return ExAssets;
  }
  
  // 電子カルテ
  public List<Asset__c> ExAssetsKarte;
  public List<Asset__c> getExAssetsKarte(){
    return ExAssetsKarte;
  }
  // 検査システム
  public List<Asset__c> ExAssetsLabSystem;
  public List<Asset__c> getExAssetsLabSystem(){
    return ExAssetsLabSystem;
  }
  // A1c
  public List<Asset__c> ExAssetsA1c;
  public List<Asset__c> getExAssetsA1c(){
    return ExAssetsA1c;
  }  
  // 血糖
  public List<Asset__c> ExAssetsGLU;
  public List<Asset__c> getExAssetsGLU(){
    return ExAssetsGLU;
  }  
  // 尿定性
  public List<Asset__c> ExAssetsAution;
  public List<Asset__c> getExAssetsAution(){
    return ExAssetsAution;
  }  
  // 沈査
  public List<Asset__c> ExAssetsTinsa;
  public List<Asset__c> getExAssetsTinsa(){
    return ExAssetsTinsa;
  }  
  // 浸透圧
  public List<Asset__c> ExAssetsOM;
  public List<Asset__c> getExAssetsOM(){
    return ExAssetsOM;
  }    
  // CRP
  public List<Asset__c> ExAssetsCRP;
  public List<Asset__c> getExAssetsCRP(){
    return ExAssetsCRP;
  }    
  // アンモニア
  public List<Asset__c> ExAssetsAnmonia;
  public List<Asset__c> getExAssetsAnmonia(){
    return ExAssetsTinsa;
  }    
  // インフルエンザ
  public List<Asset__c> ExAssetsInfuru;
  public List<Asset__c> getExAssetsInfuru(){
    return ExAssetsInfuru;
  }    
  // 乳酸
  public List<Asset__c> ExAssetsUA;
  public List<Asset__c> getExAssetsUA(){
    return ExAssetsUA;
  }    
  // 免疫
  public List<Asset__c> ExAssetsMeneki;
  public List<Asset__c> getExAssetsMeneki(){
    return ExAssetsMeneki;
  }    
  // 生化学
  public List<Asset__c> ExAssetsSeika;
  public List<Asset__c> getExAssetsSeika(){
    return ExAssetsSeika;
  }    
  // 血ガス
  public List<Asset__c> ExAssetsGas;
  public List<Asset__c> getExAssetsGas(){
    return ExAssetsGas;
  }    
  // 血算
  public List<Asset__c> ExAssetsKessan;
  public List<Asset__c> getExAssetsKessan(){
    return ExAssetsKessan;
  }    
  // 電解質
  public List<Asset__c> ExAssetsDenkaishitsu;
  public List<Asset__c> getExAssetsDenkaishitsu(){
    return ExAssetsDenkaishitsu;
  }    
  // 遺伝子
  public List<Asset__c> ExAssetsIdenshi;
  public List<Asset__c> getExAssetsIdenshi(){
    return ExAssetsIdenshi;
  }    
  // その他
  public List<Asset__c> ExAssetsOther;
  public List<Asset__c> getExAssetsOther(){
    return ExAssetsTinsa;
  }    
  // 
  // 
  
  
  
  public AccountControllerExtension(ApexPages.StandardController stdController){
    this.account = (Account)stdController.getRecord();
    
    // ユーザー取得
    

  }
  
  private void writeLog(){
    // ログ記録
    List<AccessLog__c> acs = new List<AccessLog__c>();
    AccessLog__c ac = new AccessLog__c();
    ac.User__c = UserInfo.getUserId();
    ac.Account__c = this.Account.Id;
    ac.ObjectName__c = 'Account';
    acs.Add(ac);
    insert acs;
  }
  
  public void init() {
    
    
    ExSMBGAdoptions = [SELECT Id,Name,Maker__c,Meter__c,SensorShare__c
    FROM SMBGAdoption__c
    WHERE 
    Account__c =: account.Id AND 
    IsDeleted = false 
    ];
    
    ExAssociations = [SELECT Id,Name,JobCategory__c,Contact__c,Contact__r.Name,CDE__c,Post__c,KeyPerson__c
    FROM Association__c
    WHERE 
    Account__c =: account.Id AND 
    IsDeleted = false 
    ];
    
    ExAssets = [SELECT Id,Name,CategoryName1__c,CategoryName2__c,EquipmentDistributor__c,ReagentDistributor__c,ProductName__c,Maker__c 
    FROM Asset__c 
    WHERE 
    Account__c =: account.Id AND 
    IsDeleted = false AND
    IsOperationEnd__c = false
    ORDER BY DisplayPositionPC__c
    ];
    
// 電子カルテ
  ExAssetsKarte = [SELECT Id,Name,CategoryName1__c,CategoryName2__c,EquipmentDistributor__c,ReagentDistributor__c,ProductName__c,Maker__c,ELAPSEDYEARS__c 
    FROM Asset__c 
    WHERE 
    Account__c =: account.Id AND 
    IsDeleted = false AND
    IsOperationEnd__c = false AND
    CategoryName2__c = '電子カルテ' 
    ORDER BY DisplayPositionPC__c
    ];

  // 検査システム
  ExAssetsLabSystem = [SELECT Id,Name,CategoryName1__c,CategoryName2__c,EquipmentDistributor__c,ReagentDistributor__c,ProductName__c,Maker__c,ELAPSEDYEARS__c  
    FROM Asset__c 
    WHERE 
    Account__c =: account.Id AND 
    IsDeleted = false AND
    IsOperationEnd__c = false AND
    CategoryName2__c = '検査システム'
    ORDER BY DisplayPositionPC__c
    ];

  // A1c
  ExAssetsA1c = [SELECT Id,Name,CategoryName1__c,CategoryName2__c,EquipmentDistributor__c,ReagentDistributor__c,ProductName__c,Maker__c,ELAPSEDYEARS__c 
    FROM Asset__c 
    WHERE 
    Account__c =: account.Id AND 
    IsDeleted = false AND
    IsOperationEnd__c = false AND
    CategoryName2__c = 'A1c'
    ORDER BY DisplayPositionPC__c
    ];

  // 血糖
  ExAssetsGLU = [SELECT Id,Name,CategoryName1__c,CategoryName2__c,EquipmentDistributor__c,ReagentDistributor__c,ProductName__c,Maker__c,ELAPSEDYEARS__c 
    FROM Asset__c 
    WHERE 
    Account__c =: account.Id AND 
    IsDeleted = false AND
    IsOperationEnd__c = false AND
    CategoryName2__c = '血糖'
    ORDER BY DisplayPositionPC__c
    ];

  // 尿定性
  ExAssetsAution = [SELECT Id,Name,CategoryName1__c,CategoryName2__c,EquipmentDistributor__c,ReagentDistributor__c,ProductName__c,Maker__c,ELAPSEDYEARS__c 
    FROM Asset__c 
    WHERE 
    Account__c =: account.Id AND 
    IsDeleted = false AND
    IsOperationEnd__c = false AND
    CategoryName2__c = '尿定性'
    ORDER BY DisplayPositionPC__c
    ];

  // 沈査
  ExAssetsTinsa = [SELECT Id,Name,CategoryName1__c,CategoryName2__c,EquipmentDistributor__c,ReagentDistributor__c,ProductName__c,Maker__c,ELAPSEDYEARS__c  
    FROM Asset__c 
    WHERE 
    Account__c =: account.Id AND 
    IsDeleted = false AND
    IsOperationEnd__c = false AND
    CategoryName2__c = '沈査'
    ORDER BY DisplayPositionPC__c
    ];

    
    
  // 浸透圧
  ExAssetsOM = [SELECT Id,Name,CategoryName1__c,CategoryName2__c,EquipmentDistributor__c,ReagentDistributor__c,ProductName__c,Maker__c,ELAPSEDYEARS__c  
    FROM Asset__c 
    WHERE 
    Account__c =: account.Id AND 
    IsDeleted = false AND
    IsOperationEnd__c = false AND
    CategoryName2__c = '浸透圧'
    ORDER BY DisplayPositionPC__c
    ];
  // CRP
  ExAssetsCRP = [SELECT Id,Name,CategoryName1__c,CategoryName2__c,EquipmentDistributor__c,ReagentDistributor__c,ProductName__c,Maker__c,ELAPSEDYEARS__c 
    FROM Asset__c 
    WHERE 
    Account__c =: account.Id AND 
    IsDeleted = false AND
    IsOperationEnd__c = false AND
    CategoryName2__c = 'CRP'
    ORDER BY DisplayPositionPC__c
    ];
  // アンモニア
  ExAssetsAnmonia = [SELECT Id,Name,CategoryName1__c,CategoryName2__c,EquipmentDistributor__c,ReagentDistributor__c,ProductName__c,Maker__c,ELAPSEDYEARS__c  
    FROM Asset__c 
    WHERE 
    Account__c =: account.Id AND 
    IsDeleted = false AND
    IsOperationEnd__c = false AND
    CategoryName2__c = 'アンモニア'
    ORDER BY DisplayPositionPC__c
    ];
  // インフルエンザ
  ExAssetsInfuru = [SELECT Id,Name,CategoryName1__c,CategoryName2__c,EquipmentDistributor__c,ReagentDistributor__c,ProductName__c,Maker__c,ELAPSEDYEARS__c 
    FROM Asset__c 
    WHERE 
    Account__c =: account.Id AND 
    IsDeleted = false AND
    IsOperationEnd__c = false AND
    CategoryName2__c = 'インフルエンザ'
    ORDER BY DisplayPositionPC__c
    ];
  // 乳酸
  ExAssetsUA = [SELECT Id,Name,CategoryName1__c,CategoryName2__c,EquipmentDistributor__c,ReagentDistributor__c,ProductName__c,Maker__c,ELAPSEDYEARS__c 
    FROM Asset__c 
    WHERE 
    Account__c =: account.Id AND 
    IsDeleted = false AND
    IsOperationEnd__c = false AND
    CategoryName2__c = '乳酸'
    ORDER BY DisplayPositionPC__c
    ];
  // 免疫
  ExAssetsMeneki = [SELECT Id,Name,CategoryName1__c,CategoryName2__c,EquipmentDistributor__c,ReagentDistributor__c,ProductName__c,Maker__c,ELAPSEDYEARS__c 
    FROM Asset__c 
    WHERE 
    Account__c =: account.Id AND 
    IsDeleted = false AND
    IsOperationEnd__c = false AND
    CategoryName2__c = '免疫,免疫2'
    ORDER BY DisplayPositionPC__c
    ];
  // 生化学
  ExAssetsSeika = [SELECT Id,Name,CategoryName1__c,CategoryName2__c,EquipmentDistributor__c,ReagentDistributor__c,ProductName__c,Maker__c,ELAPSEDYEARS__c 
    FROM Asset__c 
    WHERE 
    Account__c =: account.Id AND 
    IsDeleted = false AND
    IsOperationEnd__c = false AND
    CategoryName2__c = '生化学'
    ORDER BY DisplayPositionPC__c
    ];
  // 血ガス
  ExAssetsGas = [SELECT Id,Name,CategoryName1__c,CategoryName2__c,EquipmentDistributor__c,ReagentDistributor__c,ProductName__c,Maker__c,ELAPSEDYEARS__c 
    FROM Asset__c 
    WHERE 
    Account__c =: account.Id AND 
    IsDeleted = false AND
    IsOperationEnd__c = false AND
    CategoryName2__c = '血ガス'
    ORDER BY DisplayPositionPC__c
    ];
  // 血算
  ExAssetsKessan = [SELECT Id,Name,CategoryName1__c,CategoryName2__c,EquipmentDistributor__c,ReagentDistributor__c,ProductName__c,Maker__c,ELAPSEDYEARS__c 
    FROM Asset__c 
    WHERE 
    Account__c =: account.Id AND 
    IsDeleted = false AND
    IsOperationEnd__c = false AND
    CategoryName2__c = '血算'
    ORDER BY DisplayPositionPC__c
    ];
  // 電解質
  ExAssetsDenkaishitsu = [SELECT Id,Name,CategoryName1__c,CategoryName2__c,EquipmentDistributor__c,ReagentDistributor__c,ProductName__c,Maker__c,ELAPSEDYEARS__c 
    FROM Asset__c 
    WHERE 
    Account__c =: account.Id AND 
    IsDeleted = false AND
    IsOperationEnd__c = false AND
    CategoryName2__c = '電解質'
    ORDER BY DisplayPositionPC__c
    ];
  // 遺伝子
  ExAssetsIdenshi = [SELECT Id,Name,CategoryName1__c,CategoryName2__c,EquipmentDistributor__c,ReagentDistributor__c,ProductName__c,Maker__c,ELAPSEDYEARS__c 
    FROM Asset__c 
    WHERE 
    Account__c =: account.Id AND 
    IsDeleted = false AND
    IsOperationEnd__c = false AND
    CategoryName2__c = '遺伝子'
    ORDER BY DisplayPositionPC__c
    ];    
  // その他
  ExAssetsOther = [SELECT Id,Name,CategoryName1__c,CategoryName2__c,EquipmentDistributor__c,ReagentDistributor__c,ProductName__c,Maker__c,ELAPSEDYEARS__c 
    FROM Asset__c 
    WHERE 
    Account__c =: account.Id AND 
    IsDeleted = false AND
    IsOperationEnd__c = false AND
    CategoryName2__c = 'その他'
    ORDER BY DisplayPositionPC__c
    ];
  
  
    
    
    
    writeLog();
  }
}