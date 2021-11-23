global class P9_Batch_UpdateAllAccounts implements Database.Batchable<sObject>{

  private static P9_QR_Account qrAccount = new P9_QR_Account ();

  global Database.QueryLocator start(Database.BatchableContext info){ 
       //Requeter seulement les comptes qui ont au moins une commande avec le Status 'Ordered'
      return qrAccount.getAllAccounts();
   }
    
   global void execute(Database.BatchableContext info, List<Account> scope){
       Set<Id> setAccountIds = (new Map<Id,SObject>(scope)).keySet();
     P9_SRV_Account.updateChiffreAffaire(setAccountIds);
   }    
    
   global void finish(Database.BatchableContext info){     
       
   } 
}