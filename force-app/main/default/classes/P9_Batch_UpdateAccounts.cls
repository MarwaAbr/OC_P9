global class P9_Batch_UpdateAccounts implements Database.Batchable<sObject>{

    private static P9_QR_Account qrAccount = new P9_QR_Account ();
    global Database.QueryLocator start(Database.BatchableContext info){ 
       //Requeter seulement les comptes qui ont au moins une commande avec le Status 'Ordered'
       return qrAccount.getAllAccounts();
   }
    
   global void execute(Database.BatchableContext info, List<Account> scope){   
       //Collection des Identifiants des comptes
    Set<Id> setAccountIds = (new Map<Id,SObject>(scope)).keySet();
    //Appel A la méthode de mise à jour de CA sur les comptes 
    P9_SRV_Account.updateChiffreAffaire(setAccountIds);
  }    
    
   global void finish(Database.BatchableContext info){     
       
   } 
}