public with sharing class P9_SRV_Account {

    private static P9_QR_Account qrAccount = new P9_QR_Account ();
    private static P9_QR_Order qrOrder = new P9_QR_Order ();

    public P9_SRV_Account() {

    }
    public static void updateChiffreAffaire(Set<Id> setAccountIds){

        List<Account> accountsList = qrAccount.getAccounts(setAccountIds);
        List<Order> accountOrdersList = qrOrder.getOrdersByAccountIds(setAccountIds);
       
		for(Account ac : accountsList){
            ac.AnnualRevenue =0;
               for (Order ord : accountOrdersList ) {
                    if (ac.Id == ord.AccountId){
                        if (ac.AnnualRevenue ==null){ac.AnnualRevenue = 0;}
                     
                    ac.AnnualRevenue = ac.AnnualRevenue + ord.TotalAmount;
                   
                    }
               }   
              
        } 
     update  accountsList;
     
     

    }
}
           
    

