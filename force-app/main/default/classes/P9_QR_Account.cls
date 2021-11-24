public with sharing class P9_QR_Account {
    public P9_QR_Account() {

    }
    //Retourne la liste des comptes dont les Id dans "setAccountsIds"
    public List<Account> getAccounts (Set<Id> setAccountIds) {
        return [SELECT Id, AnnualRevenue FROM Account WHERE Id IN: setAccountIds];
    }

    
    // Retourne les comptes avec le statut 'Ordered'
    public Database.QueryLocator getAllAccounts(){
        return Database.getQueryLocator('SELECT Id FROM Account WHERE Id IN (SELECT AccountId FROM Order WHERE Status= \'Ordered\')');
    } 
    
}
