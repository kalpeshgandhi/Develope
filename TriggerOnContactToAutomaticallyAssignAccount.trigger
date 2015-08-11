trigger TriggerOnContactToAutomaticallyAssignAccount on Contact (before insert) 
{
    if(trigger.isbefore)
    {
        if(trigger.isinsert)
        {
            AutomaticallyAssignConTactTriggerHandler.assignAccountID(trigger.new); 
        }
    }
}