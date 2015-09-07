trigger CreateTheQuerysAndCallWebserviceTrigger on Email__c (after insert) 
{
    if(trigger.isAfter)
    {
        if(trigger.isInsert) 
        {
            
            TriggerForQueryGenerationHandler.generationOfQuery(trigger.new);
        }
    }
}
