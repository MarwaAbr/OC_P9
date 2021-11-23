@isTest
private class P9_BatchTest_UpdateAllAccounts
{
    @isTest
    static void testMethod1() 
    {
      List<Account> accountsWithOrders = TestDataFactory.creatAccountsWithOrder(200);
      
        Test.startTest();
       
         P9_Batch_UpdateAllAccounts obj = new P9_Batch_UpdateAllAccounts();
         DataBase.executeBatch(obj); 
        Test.stopTest();
         System.debug(' '+[SELECT TotalAmount FROM Order WHERE AccountId =: accountsWithOrders[0].Id].TotalAmount);
        Account ac =[SELECT AnnualRevenue FROM Account WHERE Id =:accountsWithOrders[0].Id];
        System.assertEquals(accountsWithOrders.size()==200, true);
        System.assertEquals(ac.AnnualRevenue , 1500);
    }
}