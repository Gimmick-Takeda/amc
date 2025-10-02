public with sharing class AccountAssetOpActivityViewCondition{
    // -------------------------------------------------------------------------------------------
    // 表示条件
    // -------------------------------------------------------------------------------------------   
    public boolean SSO { get; set; }
    public boolean TDFK { get; set; }
    public boolean CoreSystemCD{get;set;}
    public boolean Beds { get; set; }
    public boolean PCRank { get; set; }
    public boolean CC { get; set; }
    public boolean PC { get; set; }
    public boolean LabSystem { get; set; }
    public boolean A1c { get; set; }
    public boolean GLU {get;set;}
    public boolean SMBG { get; set; }
    public boolean Aution { get; set; }
    public boolean Sediment { get; set; }
    public boolean OsmoticPressure {get;set;}
    public boolean GENE { get; set; }
    public boolean Other { get; set; }                

    public boolean CCUser{ get; set; }
    public boolean SS { get; set; }
    
    
    
    public AccountAssetOpActivityViewCondition(){
        SSO = false;
        TDFK = false;
        CoreSystemCD = false;
        Beds = false;
        PCRank = false;
        CC = false;
        PC = false;
        LabSystem = false;
        A1c = false;
        GLU = false;
        SMBG = false;
        Aution = false;
        Sediment = false;
        OsmoticPressure = false;
        GENE = false;
        Other = false;                
        
        CCUser= false;
        SS = false;        
        
    }
    
    
      
}