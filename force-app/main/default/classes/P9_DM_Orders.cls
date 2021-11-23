public with sharing class P9_DM_Orders extends fflib_SObjectDomain {

    public P9_DM_Orders(List<Order> sObjectList) {
        super(sObjectList);
    }
    public class Constructor implements fflib_SObjectDomain.IConstructable {
        public fflib_SObjectDomain construct(List<SObject> sObjectList) {
            return new Orders(sObjectList);
        }
    }

    public override void onAfterUpdate (Map<Id,SObject> existingRecords){
        set<Id> setAccountIds = new set<Id>();
        for(Order ord : (List<Order>) Records) {
            if(ord.AccountId!=null) {
                setAccountIds.add(ord.AccountId);
            }
            
        }
        P9_SRV_Account.updateChiffreAffaire(setAccountIds);   
    }

    public override void onBeforeUpdate (Map<Id,SObject> existingRecords){
        for(Order ord : (List<Order>) Records) {
            if (ord.ShipmentCost__c ==null) {ord.ShipmentCost__c =0;
            }
            ord.NetAmount__c = 0;
            ord.NetAmount__c = ord.TotalAmount - ord.ShipmentCost__c;  
        }
    }
    public override void onValidate(Map<Id,SObject> existingRecords) {
        // Validate changes to Orders
        Set<Id> newList = new Set<Id>();
        for(Order ord : (List<Order>) Records) {
            Order existingOrd = (Order) existingRecords.get(ord.Id);
            if(ord.Status != existingOrd.Status && ord.Status == 'Ordered') {
             
                newList.add(ord.AccountId);
            }
        }

       P9_SRV_Account.updateChiffreAffaire(newList); 
        
    }
}