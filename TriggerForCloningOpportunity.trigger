trigger TriggerForCloningOpportunity on Opportunity (after insert) 
{
    Triggers__c triggerinstance=new Triggers__c();
    triggerinstance=Triggers__c.getInstance();
    if(triggerinstance.Disable_trigger__c)
    {
	   if(trigger.isafter)
	   {
	        if(trigger.isinsert)
            {
                 CloningOfOpportunityHandler.cloningOpportunity(Trigger.new);
            }
	   }
    }
}