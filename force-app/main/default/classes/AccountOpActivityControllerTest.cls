@isTest(SeeAllData=true)
private class AccountOpActivityControllerTest{
    static TestMethod PageReference SearchTest(){
        
        AccountOpActivityController aoc = New AccountOpActivityController();        
        aoc.Search();
        return null;
        
        //AccountRedirectController arc = New AccountRedirectController();
        //arc.Go();
    }
}