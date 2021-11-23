global class P9_Batch_UpdateAccounts implements Database.Batchable<sObject>{

    private static P9_QR_Account qrAccount = new P9_QR_Account ();
    global Database.QueryLocator start(Database.BatchableContext info){ 
       //Requeter seulement les comptes qui ont au moins une commande avec le Status 'Ordered'
       return qrAccount.getAllAccounts();
   }
    
   global void execute(Database.BatchableContext info, List<Account> scope){   
       
   list<Order> listOrders =  [SELECT Id, TotalAmount, AccountId FROM Order WHERE AccountId IN: scope];
        
		for(integer i=0; i < scope.size(); i++){
			Account myAccount = scope[i];
			myAccount.AnnualRevenue = 0;
           for(integer j=0; j < listOrders.size(); j++){
               if(listOrders[j].AccountId == myAccount.Id){
                   myAccount.AnnualRevenue = myAccount.AnnualRevenue + listOrders[j].TotalAmount;
                   
               }                   
           }
       }
       
       update scope;
   }    
    
   global void finish(Database.BatchableContext info){     
       
   } 
}