global with sharing class ScheduleGoobleSoft implements Schedulable
{    
    /**
     * Method that Executed and Creates an Instance of the Batchable Class.
     */
    global void execute(SchedulableContext schedulableInstance) 
    {
        // Create the instance of the batch
        BatchResponsesForQuery gooblesoftInstance = new BatchResponsesForQuery();
        
        // Execute the batch
        Database.executeBatch(gooblesoftInstance,10);
    }
}