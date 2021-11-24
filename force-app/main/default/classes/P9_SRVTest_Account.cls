@isTest
private class P9_SRVTest_Account {

    @TestSetup //données de test
    static void makeData(){
        List<Account> list1Acc = TestDataFactory.creatAccountsWithOrders(1, 1);
        Order ord =[SELECT Id FROM Order LIMIT 1];
        ord.Status = 'Ordered';
        update ord;
    }
    @isTest    // test de méthode de calcul de chiffre d'affaire 
    static void test_updateChiffreAffaire (){
    Account acc = [SELECT Id FROM Account LIMIT 1];
    Set<Id> setAccountId = new Set<Id>();
    setAccountId.add (acc.Id);

    Test.startTest();

    P9_SRV_Account.updateChiffreAffaire(setAccountId);

    Test.stopTest();

    Account acc1 = [SELECT AnnualRevenue FROM Account LIMIT 1];
     System.assertEquals(acc1.AnnualRevenue, 21500);
    }
}
