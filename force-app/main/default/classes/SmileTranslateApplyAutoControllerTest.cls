@isTest(SeeAllData=true)
private class SmileTranslateApplyAutoControllerTest{
    static TestMethod PageReference SmileTranslateApplyAutoControllerTest (){
        SmileTranslateApplyAutoController controller = new SmileTranslateApplyAutoController();
        List<STTestData__c> STTestData = [SELECT Id,TestData__c FROM STTestData__c];
        for(STTestData__c t:STTestData){
            controller.ApplyText2ST(t.TestData__c);
        }
        return null;
    }
}