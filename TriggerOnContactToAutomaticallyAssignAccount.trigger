/**
* ABC Containers require the ability to automatically associate a Contact created 
* in their Salesforce Instance with the respective account based on the email domain 
* specified in the primary email address of the Contact. 
* The association should happen real time as soon as a contact record is created 
* within the system.
*/
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