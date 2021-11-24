public without sharing class P9_LC_MyTeamOrdersController {
    
    //Fournir la liste de toutes les commandes pour la page visualforce
    public List<Order> TeamOrders {
        get { List<Order> myTeamOrdersList = [SELECT Id, AccountId, TotalAmount FROM Order];
            return (List<Order>) myTeamOrdersList;  }
        set;
    } 

    //Fournir la somme de Total Amount  de toutes les commandes pour la page visualforce
    public decimal SumOders{
        get{
			AggregateResult groupedResults = [SELECT SUM(TotalAmount) total FROM Order];
			return (decimal)groupedResults.get('total');

        }
        set;
    }
}