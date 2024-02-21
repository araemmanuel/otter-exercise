trigger LeadTrigger on Lead (before insert, before update) {
    LeadTriggerHandler handler = new LeadTriggerHandler();
    if (Trigger.isBefore && Trigger.isInsert) {
        handler.checkExistingAccounts(Trigger.new);
    }
}