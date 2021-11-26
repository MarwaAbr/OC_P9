trigger AmountCalcul on Order (before update) {
	// Calls appropriate methods from Domain class
	fflib_SObjectDomain.triggerHandler(P9_DM_Orders.class);
}