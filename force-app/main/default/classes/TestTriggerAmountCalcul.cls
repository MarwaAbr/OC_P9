@isTest
private class TestTriggerAmountCalcul {
    // Test du calcul de NetAmount d'une commande mise à jour
    @isTest
    static void test_UpdateNetAmount() {
        //Arrange
        List<Account> listAcc = TestDataFactory.creatAccountsWithOrders(1,1);
        Order ord = [SELECT Status FROM Order LIMIT 1];
        //Act
        Test.startTest();
        ord.Status = 'Ordered';
        update ord;
        Test.stopTest();
        //Assert
        Order ord1 = [SELECT NetAmount__c FROM Order LIMIT 1]; 
        System.assertEquals(ord1.NetAmount__c, 21300);
    }
    //Test de mise à jour de ShipmentCost sur une commande d'un compte ayant 100 commandes
    @isTest  
    static void test_UpdateOneOrder_ShipCost_From100(){
      //Données de Test
      List<Account> myAccount = TestDataFactory.creatAccountsWithOrders(1, 100);
      //Arrange
      Order ord = [SELECT Id, ShipmentCost__c, NetAmount__c FROM Order LIMIT 1];
      ord.ShipmentCost__c = 300.00;
      //Act
      Test.startTest();
      Database.SaveResult result = Database.update (ord, false);
      Test.stopTest();
      //Assert
      System.assert (result.isSuccess());
      System.assertEquals  (ord.ShipmentCost__c == 300.00, true);
      Order ord1 = [SELECT NetAmount__c FROM Order LIMIT 1];
      System.assertEquals  (ord1.NetAmount__c, 21200);
    }

    //Test de mise à jour de ShipmentCost sur 200 commandes d'un compte 
    @isTest  
    static void test_Update200Orders_ShipCost(){
      //Données de Test
      List<Account> myAccount = TestDataFactory.creatAccountsWithOrders(1, 200);
      //Arrange
      List<Order> ordList = [SELECT Id, ShipmentCost__c, NetAmount__c FROM Order];
      //Act
      Test.startTest();
      for (Order ord:ordList){
        ord.ShipmentCost__c = 300.00;
      }
      update ordList;
      Test.stopTest();
      //Assert

     System.assertEquals(200, [select count() from Order where NetAmount__c = 21200]);
    }
}
