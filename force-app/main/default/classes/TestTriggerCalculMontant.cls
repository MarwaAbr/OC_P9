@isTest
private class TestTriggerCalculMontant {
    @TestSetup //géneration des données de test
    static void makeData (){
      
      List<Account> listAcc = TestDataFactory.creatAccountsWithOrders(1,1);
    }

    // Test du calcul de NetAmount d'une commande mise à jour
    @isTest
    static void test_UpdateNetAmount() {

        Order ord = [SELECT Status FROM Order LIMIT 1];
        Test.startTest();
        ord.Status = 'Ordered';
        update ord;
        Test.stopTest();
        Order ord1 = [SELECT NetAmount__c FROM Order LIMIT 1]; 
        System.assertEquals(ord1.NetAmount__c, 21300);
    }

    //Test de mise à jour d'une commande d'un compte ayant 100 commandes
    @isTest  
    static void test_UpdateOneOrder_ShipCost_From100(){
      //Données de Test
      List<Account> myAccount = TestDataFactory.creatAccountsWithOrders(1, 100);

      Order ord = [SELECT Id, ShipmentCost__c, NetAmount__c FROM Order LIMIT 1];
      ord.ShipmentCost__c = 300.00;
      Test.startTest();
      Database.SaveResult result = Database.update (ord, false);
      Test.stopTest();

      System.assert (result.isSuccess());
      System.assertEquals  (ord.ShipmentCost__c == 300.00, true);
      Order ord1 = [SELECT NetAmount__c FROM Order LIMIT 1];
      System.assertEquals  (ord1.NetAmount__c, 21200);
    }
}
