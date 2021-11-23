@isTest
private class P9_SRVTest_Account {

    @TestSetup //données de test
    static void makeData(){
        Account acc1 = TestDataFactory.creatAccount();
        insert acc1;
        Order ord = TestDataFactory.creatOrderWithTwoItems(acc1.Id);
        ord.Status = 'Ordered';
        update ord;
    }
    @isTest    // test de calcul de chiffre d'affaire 
    static void test (){
    Account ac = [SELECT AnnualRevenue FROM Account LIMIT 1];
    Set<Id> setAccountId = new Set<Id>();
    setAccountId.add (ac.Id);

    Test.startTest();

    P9_SRV_Account.updateChiffreAffaire(setAccountId);

    Test.stopTest();
     System.assertEquals(ac.AnnualRevenue, 21500);
    }
}
