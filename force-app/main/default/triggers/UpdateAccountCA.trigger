
trigger UpdateAccountCA on Order (after update) {
   // Calls appropriate methods from Domain class
   fflib_SObjectDomain.triggerHandler(P9_DM_Orders.class);
}