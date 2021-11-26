public with sharing class P9_QR_Order {
    public P9_QR_Order() {

    }

    //Retourne liste de commandes statut 'Ordered' et apparttenant aux comptes de setAccountsIds
    public List<Order> getOrdersByAccountIds (Set<Id> setAccountIds){
        return [SELECT Id, TotalAmount, AccountId FROM Order WHERE AccountId IN: setAccountIds AND Status = 'Ordered'];
    }
    //Retourne la liste de commandes avec les champs Id, AccountId, TotalAmount.. Pour l'affichage
    public List<Order> getMyTeamOrders() {
        return [SELECT Id, AccountId, TotalAmount FROM Order WHERE Status= 'Ordered'];
    }
    //Retourne la somme des TotalAmount de toutes les commandes
    public AggregateResult getGroupedResults(){
       return [SELECT SUM(TotalAmount) total FROM Order WHERE Status = 'Ordered'];
    }
    
}
