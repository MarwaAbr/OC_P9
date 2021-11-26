public without sharing class P9_LC_MyTeamOrdersController {
    P9_QR_Order P9_QR_Order_Call = new P9_QR_Order();
    //Fournir la liste de toutes les commandes pour la page visualforce
    public List<Order> TeamOrders {
        get { 
            List<Order> myTeamOrdersList =P9_QR_Order_Call.getMyTeamOrders();
            return (List<Order>) myTeamOrdersList;  }
        set;
    } 

    //Fournir la somme de Total Amount  de toutes les commandes pour la page visualforce
    public decimal SumOders{
        get{
            AggregateResult groupedResults = P9_QR_Order_Call.getGroupedResults();
			return (decimal)groupedResults.get('total');
        }
        set;
    }
}