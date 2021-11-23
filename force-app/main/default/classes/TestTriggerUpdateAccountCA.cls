@isTest
private class TestTriggerUpdateAccountCA {
    // Préparations des données de Tests
    @TestSetup
    static void makeData (){
        Account acc1 = TestDataFactory.creatAccount();
        insert acc1;
 
      Order ord = TestDataFactory.creatOrderWithTwoItems(acc1.Id);
      
    }
    @isTest 
    // Test de mise à jour de chiffre d'affaire après la mise à jour du statut de la commade
    static void test() {
       
       Order ord = [SELECT Status FROM Order LIMIT 1];
        Test.startTest();
        ord.Status = 'Ordered';
        update ord;
       
        Test.stopTest();
        Account ac = [SELECT AnnualRevenue FROM Account LIMIT 1];
        System.assertEquals(ac.AnnualRevenue, 21500);
    }
    @isTest  
    //Test de mise à jour d'une commande d'un compte ayant 100 commandes
    static void test2(){
      Account acc1 = TestDataFactory.creatAccount();
      insert acc1;
      List<Order> ords = TestDataFactory.creatCentOrders(acc1.Id);
     
     Order ord = [SELECT Id, Status FROM Order LIMIT 1];
      Test.startTest();
     // for (Order orr: ords){
       ord.Status= 'Ordered';
      //}
      
     
      Database.SaveResult result = Database.update (ord, false);
      Test.stopTest();
      System.assert (result.isSuccess());
      
    }
}
