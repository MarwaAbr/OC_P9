//Class Domain pour l'objet Order
public with sharing class P9_DM_Orders extends fflib_SObjectDomain {

    public P9_DM_Orders(List<Order> sObjectList) {
        super(sObjectList);
    }
    public class Constructor implements fflib_SObjectDomain.IConstructable {
        public fflib_SObjectDomain construct(List<SObject> sObjectList) {
            return new P9_DM_Orders(sObjectList);
        }
    }
    //Mise à jour de CA sur les comptes après la mise à jour de commandes associées
    //Appelée à partir de "UpdateAccountCA.trigger"
    public override void onAfterUpdate (Map<Id,SObject> existingRecords){
        set<Id> setAccountIds = new set<Id>();
        for(Order ord : (List<Order>) Records) {
            if(ord.AccountId!=null) {
                setAccountIds.add(ord.AccountId);
            }
            
        }
        P9_SRV_Account.updateChiffreAffaire(setAccountIds);   
    }
    //Mise à jour de NetAmount sur les commandes avant la mise à jour de ces commandes 
    //Appelée à partir de "CalculMontant.trigger"
    public override void onBeforeUpdate (Map<Id,SObject> existingRecords){
        for(Order ord : (List<Order>) Records) {
            if (ord.ShipmentCost__c ==null) {ord.ShipmentCost__c =0;
            }
            ord.NetAmount__c = 0;
            ord.NetAmount__c = ord.TotalAmount - ord.ShipmentCost__c;  
        }
    }
}