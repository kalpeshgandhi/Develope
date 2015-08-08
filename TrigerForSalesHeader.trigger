trigger TrigerForSalesHeader on Sales__c (after insert,after update, before insert, before update) 
{
    if(trigger.isbefore)
    {
        if(trigger.isInsert)
        {
            CasesForSalesHeaderHandler.createCase(trigger.new);
        }
    }

    if(trigger.isbefore)
    {
        if(trigger.isUpdate)
        {
             CasesForSalesHeaderHandler.createCase(trigger.new);
        }
    }
}