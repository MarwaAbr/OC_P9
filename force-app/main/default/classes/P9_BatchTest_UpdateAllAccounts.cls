@isTest
private class P9_BatchTest_UpdateAllAccounts
{
    @isTest
    static void test_ExecuteBatchToUpdate_CA_200Accounts() 
    {
      List<Account> accountsWithOrder = TestDataFactory.creatAccountsWithOrders(200, 1);

      List<Order> lstOrders = [SELECT Id FROM Order];

      for (Order ord: lstOrders){
        ord.Status = 'Ordered';
      }
      update lstOrders;

      Test.startTest();
        P9_Batch_UpdateAllAccounts obj = new P9_Batch_UpdateAllAccounts();
         DataBase.executeBatch(obj); 
      Test.stopTest();

      // System.debug(' '+[SELECT TotalAmount FROM Order WHERE AccountId =: accountsWithOrder[0].Id].TotalAmount);
      Account ac =[SELECT AnnualRevenue FROM Account WHERE Id =:accountsWithOrder[0].Id];
      Account ac1 =[SELECT AnnualRevenue FROM Account WHERE Id =:accountsWithOrder[100].Id];
      Account ac2 =[SELECT AnnualRevenue FROM Account WHERE Id =:accountsWithOrder[199].Id];
      System.assertEquals(accountsWithOrder.size()==200, true);
      System.assertEquals(ac.AnnualRevenue , 21500);
      System.assertEquals(ac1.AnnualRevenue , 21500);
      System.assertEquals(ac2.AnnualRevenue , 21500);
    }

    @isTest
    static void test_ExecuteBatchToUpdate_CA_100Accounts_With10Orders() 
    {
      List<Account> accountsWithOrder = TestDataFactory.creatAccountsWithOrders(100, 10);

      List<Order> lstOrders = [SELECT Id FROM Order];

      for (Order ord: lstOrders){
        ord.Status = 'Ordered';
      }
      update lstOrders;

      Test.startTest();
        P9_Batch_UpdateAllAccounts obj1 = new P9_Batch_UpdateAllAccounts();
         DataBase.executeBatch(obj1); 
      Test.stopTest();

      // System.debug(' '+[SELECT TotalAmount FROM Order WHERE AccountId =: accountsWithOrder[0].Id].TotalAmount);
      Account ac =[SELECT AnnualRevenue FROM Account WHERE Id =:accountsWithOrder[0].Id];
      Account ac1 =[SELECT AnnualRevenue FROM Account WHERE Id =:accountsWithOrder[50].Id];
      Account ac2 =[SELECT AnnualRevenue FROM Account WHERE Id =:accountsWithOrder[99].Id];
      System.assertEquals(accountsWithOrder.size()==100, true);
      System.assertEquals(ac.AnnualRevenue , 215000);
      System.assertEquals(ac1.AnnualRevenue , 215000);
      System.assertEquals(ac2.AnnualRevenue , 215000);
    }
}