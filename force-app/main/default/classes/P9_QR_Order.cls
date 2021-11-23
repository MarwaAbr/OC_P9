public with sharing class P9_QR_Order {
    public P9_QR_Order() {

    }
    public List<Order> getOrdersByAccountIds (Set<Id> setAccountIds){
        return [SELECT Id, TotalAmount, AccountId FROM Order WHERE AccountId IN: setAccountIds AND Status = 'Ordered'];
    }
}
