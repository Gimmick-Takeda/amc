@isTest(SeeAllData=true)
private class ChangeRepresentativeControllerTest{
    static TestMethod PageReference ChangeRepresentativeControllerTest(){
    	
      ChangeRepresentativeController c = new ChangeRepresentativeController();
      c.State = '島根県';
      c.Search();
      c.Deselect();      
      c.SelectAll();
      c.NewOwnerShearch = '権限 テスト2';
      c.OwnerSearch();
      c.ChangeOwnerCC();
      c.ChangeOwnerPC();
      c.UpdateData();
      return null;
    }
}