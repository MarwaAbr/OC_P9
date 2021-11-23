public with sharing class TestDataFactory {
    public TestDataFactory() {
        

    }

    public static Account creatAccount (){

        Account ac = new Account(Name = 'Test Account 1');
        return ac;
    }
   
    public static List<Account> creatAccountsWithOrder(Integer numAccts){
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
            Order ord = new Order (AccountId =act.Id, EffectiveDate = date.today(), Status = 'Draft', Pricebook2Id =pbe.Pricebook2Id, ShipmentCost__c = 200.00);
            lstOrders.add (ord);
        }
        insert lstOrders;

        List<OrderItem> ordItems = new List<OrderItem>();
        for (Order ord: lstOrders) {
            OrderItem oi1 = new OrderItem (OrderId = ord.Id, PricebookEntryId = pbe.Id, Quantity=10, UnitPrice = 150);
            ordItems.add(oi1);
        }
        insert ordItems;

        for (Order ord:lstOrders){
            ord.Status = 'Ordered';
        }
        update lstOrders;

        return lstAccounts;
    }

   public static Order creatOrderWithTwoItems (Id theAccountId){
   
    PricebookEntry pbe = creatProduct ();
    
    Order ord = new Order (AccountId = theAccountId, EffectiveDate = date.today(), Status = 'Draft', Pricebook2Id =pbe.Pricebook2Id, ShipmentCost__c = 200.00 );
    insert ord;
    OrderItem oi1 = new OrderItem (OrderId = ord.Id, PricebookEntryId = pbe.Id, Quantity=10, UnitPrice = 150);
    insert oi1;
    OrderItem oi2 = new OrderItem (OrderId = ord.Id, PricebookEntryId = pbe.Id, Quantity=20, UnitPrice = 1000);
    insert oi2;  

    return ord;

   }
   public static List<Order> creatCentOrders (Id theAccountId){

    List<Order> ords = new List<Order>();
    List<OrderItem> ordItems = new List<OrderItem>();
    PricebookEntry pbe = creatProduct ();
    
       for (Integer i=0; i<100; i++){
        Order ord = new Order (AccountId = theAccountId, EffectiveDate = date.today(), Status = 'Draft', Pricebook2Id =pbe.Pricebook2Id, ShipmentCost__c = 200.00 );
      ords.add(ord);
       
       }
     insert ords;
     for (Order ord: ords) {
        OrderItem oi1 = new OrderItem (OrderId = ord.Id, PricebookEntryId = pbe.Id, Quantity=10, UnitPrice = 150);
        ordItems.add(oi1);
    
    }
      
     insert ordItems;
     return ords;

   }
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
