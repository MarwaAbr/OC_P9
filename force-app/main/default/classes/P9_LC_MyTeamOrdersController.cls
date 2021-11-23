public without sharing class P9_LC_MyTeamOrdersController {

    public List<Order> TeamOrders {
        get { List<Order> myTeamOrdersList = [SELECT Id, AccountId, TotalAmount FROM Order];
            return (List<Order>) myTeamOrdersList;  }
        set;
    } 
    public decimal SumOders{
        get{
			AggregateResult groupedResults = [SELECT SUM(TotalAmount) total FROM Order];
			return (decimal)groupedResults.get('total');

        }
        set;
    }
}