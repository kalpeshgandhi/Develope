trigger TriggerOnContactToAutomaticallyAssignAccount on Contact (before insert,after insert) 
{
    if(trigger.isbefore)
    {
        if(trigger.isinsert)
        {
            AutomaticallyAssignConTactTriggerHandler.assignAccountID(trigger.new); 
        }
    }
  
    
}