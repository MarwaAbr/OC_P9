@isTest
private class TestTriggerUpdateAccountCA {

    // Test de mise à jour de CA après la mise à jour du statut de la commande
    @isTest 
    static void test_UpdateOrderStatus() {
      //Données de Test
      List<Account> myAccount = TestDataFactory.creatAccountsWithOrders(1, 1);
       
        Order ord = [SELECT Status FROM Order LIMIT 1];
        Test.startTest();
        ord.Status = 'Ordered';
        update ord;
        Test.stopTest();
        
        Account ac = [SELECT AnnualRevenue FROM Account LIMIT 1];
        System.assertEquals(ac.AnnualRevenue, 21500);
    }

    //Test de mise à jour d'une commande d'un compte ayant 100 commandes
    @isTest  
    static void test_UpdateOneOrder_Status_From100(){
      //Données de Test
      List<Account> myAccount = TestDataFactory.creatAccountsWithOrders(1, 100);

      Order ord = [SELECT Id, Status FROM Order LIMIT 1];
      Test.startTest();
       ord.Status= 'Ordered';
      Database.SaveResult result = Database.update (ord, false);
      Test.stopTest();
      System.assert (result.isSuccess());
      System.assertEquals  (ord.Status == 'Ordered', true);
      Account acc =[SELECT AnnualRevenue FROM Account LIMIT 1];
      System.assertEquals  (acc.AnnualRevenue, 21500);
    }

}
