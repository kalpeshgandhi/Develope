/**
* ABC Containers require the ability to automatically associate a Contact created 
* in their Salesforce Instance with the respective account based on the email domain 
* specified in the primary email address of the Contact. 
* The association should happen real time as soon as a contact record is created 
* within the system.
*/
trigger TriggerOnContactToAutomaticallyAssignAccount on Contact (before insert) 
{
    // Check if the trigger is before
    if(trigger.isbefore)
    {
        // Check if the trigger id insert
        if(trigger.isinsert)
        {
            // Call the handler method
            AutomaticallyAssignConTactTriggerHandler.assignAccountID(trigger.new); 
        }
    }
}