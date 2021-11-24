public with sharing class TestDataFactory {
    public TestDataFactory() {
        

    }
   //Création des comptes avec Commandes 
    public static List<Account> creatAccountsWithOrders(Integer numAccts, Integer numOrds){

        List<Account> lstAccounts= new List<Account>();
        for(Integer i=0 ;i <numAccts;i++)
        {
            Account acc = new Account();
            acc.Name ='Name'+i;
            lstAccounts.add(acc);
        }
        insert lstAccounts;

        PricebookEntry pbe = creatProduct ();

        List<Order> lstOrders = new List<Order>();
        for (Account act : lstAccounts){
            for(Integer j=0; j< numOrds; j++){
            Order ord = new Order (AccountId =act.Id, EffectiveDate = date.today(), Status = 'Draft', Pricebook2Id =pbe.Pricebook2Id, ShipmentCost__c = 200.00);
            lstOrders.add (ord);
            }
        }
        insert lstOrders;

        List<OrderItem> lstOrdItems = new List<OrderItem>();
        for (Order ord: lstOrders) {
            OrderItem oi1 = new OrderItem (OrderId = ord.Id, PricebookEntryId = pbe.Id, Quantity=10, UnitPrice = 150);
            lstOrdItems.add(oi1);
            OrderItem oi2 = new OrderItem (OrderId = ord.Id, PricebookEntryId = pbe.Id, Quantity=20, UnitPrice = 1000);
            lstOrdItems.add(oi2); 
        }
        insert lstOrdItems;

        return lstAccounts;
    }

    // Creation d'un produit avec PricebookEntry
   private static PricebookEntry creatProduct (){
    Product2 pd1 = new Product2(Name = 'Chemise Verte longue XYX', Family = 'Chemise');
    Insert pd1;
    //Create the PricebookEntry
    PricebookEntry pbe = new PricebookEntry(
        Pricebook2Id = Test.getStandardPricebookId(),
        Product2Id = pd1.Id,
        UnitPrice = 1020,
        IsActive = true
    );
    insert pbe;
    return pbe;
   }
}
