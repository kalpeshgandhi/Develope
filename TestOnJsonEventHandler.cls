/**
 * This is a test class that will check the generation of generic records. The third party 
 * system will create events in a system to create any Sobject’s records.
 */
@isTest
private class TestOnJsonEventHandler 
{
   /**
    * This is a method that will check the functionality to check whether the object is created or 
    * not whenever the event object is inserted.
    */
    static testMethod void CheckStatus() 
    {
        
        // Create the instance of the controller
        EventObjectThatStoresAllSobject instanceEvent = new EventObjectThatStoresAllSobject();
        
        // Create the instance of the event 
        Event__c event = new Event__c();
        
        // Insert the JSON record
        event.Json_Record__c = '{ "Name" : "Kalpesh"}';
        
        // Insert the sobject type record
        event.ObjectType__c = 'Account';
        
        // Insert the status check
        event.Process_Status__c = false;
        
        // Insert the event
        insert event;
        
        // Start the test
        Test.startTest();
        
        // Execute the batch class
        Database.executeBatch(instanceEvent,1);
        
        // Stop the test
        Test.stopTest();
        
        // Fetch all the evet records that has status is true 
        List<Event__c> listEvent = 
            [
                SELECT 
                    Id,
                    Name,
                    Json_Record__c,
                    Process_Status__c,
                    ObjectType__c 
                FROM 
                    Event__c 
                WHERE 
                    Process_Status__c = true
           ];
       
       // Check the Listsize.
       System.assertEquals(1,listEvent.size());
    }
}