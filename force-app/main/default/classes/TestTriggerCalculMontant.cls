@isTest
private class TestTriggerCalculMontant {
    @TestSetup //géneration des données de test
    static void makeData (){
        Account acc1 = TestDataFactory.creatAccount();
        insert acc1;
 
      Order ord = TestDataFactory.creatOrderWithTwoItems(acc1.Id);
    }

    // Test du calcul de NetAmout d'une commande mise à jour
    @isTest
    static void test() {

        Order ord = [SELECT Status  FROM Order LIMIT 1];
        Test.startTest();
        ord.Status = 'Ordered';
        update ord;
        Test.stopTest();
        Order ord1 = [SELECT NetAmount__c FROM Order LIMIT 1]; 
        System.assertEquals(ord1.NetAmount__c, 21300);
    }
}
