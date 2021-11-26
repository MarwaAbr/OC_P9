@isTest
private class P9_BatchTest_UpdateAllAccounts
{   
    //Executer le batch P9_Batch_UpdateAllAccounts pour 200Accounts ayants chacun 1 Order.
    @isTest
    static void test_ExecuteBatchToUpdate_CA_200Accounts() 
    {
      //Arrange
      List<Account> accountsWithOrder = TestDataFactory.creatAccountsWithOrders(200, 1);
      List<Order> lstOrders = [SELECT Id FROM Order];

      for (Order ord: lstOrders){
        ord.Status = 'Ordered';
      }
      update lstOrders;
      //Act
      Test.startTest();
        P9_Batch_UpdateAllAccounts obj = new P9_Batch_UpdateAllAccounts();
         DataBase.executeBatch(obj); 
      Test.stopTest();
      //Assert   
          //S'assurer de la mise à jour de CA sur tous les comptes
      System.assertEquals(accountsWithOrder.size()==200, true);
      System.assertEquals(200, [select count() from Account where AnnualRevenue = 21500]);
      System.assertEquals(200, [select count() from Order where Status = 'Ordered']);
    }
    
    //Executer le batch P9_Batch_UpdateAllAccounts pour 100Accounts ayants chacun 10 Orders.
    @isTest
    static void test_ExecuteBatchToUpdate_CA_100Accounts_With10Orders() 
    {
      //Arrange
      List<Account> accountsWithOrder = TestDataFactory.creatAccountsWithOrders(100, 10);
      List<Order> lstOrders = [SELECT Id FROM Order];

      for (Order ord: lstOrders){
        ord.Status = 'Ordered';
      }
      update lstOrders;
      //Act
      Test.startTest();
        P9_Batch_UpdateAllAccounts obj1 = new P9_Batch_UpdateAllAccounts();
         DataBase.executeBatch(obj1); 
      Test.stopTest();

      // Assert
      //S'assurer de la mise à jour de CA sur tous les comptes
      System.assertEquals(accountsWithOrder.size()==100, true);
      System.assertEquals(100, [select count() from Account where AnnualRevenue = 215000]);
    }
}