/**
 * This is a test class that will test the sending of mails using the batch apex
 */
@isTest
private class TestForResponseBatchApex 
{
   /**
    * This is the test method that will check for responses are sent in batches or not 
    */
    static testMethod void testForResponseSentUsingBatch() 
    {
        // Create the instance of the query
        Query__c queryInstance = new Query__c(Query_Field__c= 'test');
        
        // Create the instance of the contact
        Contact contactInstance = new Contact(LastName = 'Test',Email = 'test@123.com');
        
        List<Query__c> checkQueryList = 
            [
                SELECT
                    Id
                FROM
                    Query__c
            ];
       
        
        // Check for the size of the query list
        System.assertEquals(0 , checkQueryList.size());
        
        List<Contact> checkContactList = 
            [
                SELECT
                    Id
                FROM
                    Contact
            ];
        
        // Check for the size of the contact list
        System.assertEquals(0 , checkContactList.size());
        
        // Insert the contact Instance
        insert contactInstance;
        
        // Insert the query Instance
        insert queryInstance;
        
        checkQueryList = 
            [
                SELECT
                    Id
                FROM
                    Query__c
            ];
        
        // Check for the size of the query list
        System.assertEquals(1 , checkQueryList.size());
        
        checkContactList = 
            [
                SELECT
                    Id
                FROM
                    Contact
            ];
        
        // Check for the size of the contact list
        System.assertEquals(1 , checkContactList.size());
        
        // Create the instance of the queryForContact
        QueryForContact__c queryForContactInstance = 
            new QueryForContact__c(
                                   Contact_Details__c = contactInstance.Id,
                                   QueryDetails__c = queryInstance.Id
                                   ); 
        
        List<QueryForContact__c> checkQueryForContactList = 
            [
                SELECT
                    Id
                FROM
                    QueryForContact__c
            ];
        
        // Check for the size of the query list
        System.assertEquals(0 , checkQueryForContactList.size());
        
        insert queryForContactInstance;
    
        checkQueryForContactList = 
            [
                SELECT
                    Id
                FROM
                    QueryForContact__c
            ];
        
        // Check for the size of the contact list
        System.assertEquals(1 , checkQueryForContactList.size());
        
        // Create the instance of the batch apex class
        BatchResponsesForQuery batchInstance = new BatchResponsesForQuery();
        
        // Start the test
        Test.startTest();
        
        // Execute the batch
        Database.executeBatch(batchInstance,1);
        
        // Stop the test
        Test.StopTest();
        
        // Fetch the queryforcontact
        List<QueryForContact__c> queryForContactListInstance = 
            [
                SELECT
                    Id,
                    ResponseSend__c
                FROM
                    QueryForContact__c
                WHERE 
                    Id = :queryForContactInstance.Id
            ];
        
        // Check if the mail is send or not
        System.assertEquals(true,queryForContactListInstance[0].ResponseSend__c);
    }
    
   /**
    * This is the test method that will check for responses are sent in batches or not 
    */
    static testMethod void testForResponseNotSentUsingBatch() 
    {
        // Create the instance of the query
        Query__c queryInstance = new Query__c(Query_Field__c= 'test');
        
        // Create the instance of the contact
        Contact contactInstance = new Contact(LastName = 'Test');
        
        List<Query__c> checkQueryList = 
            [
                SELECT
                    Id
                FROM
                    Query__c
            ];
       
        
        // Check for the size of the query list
        System.assertEquals(0 , checkQueryList.size());
        
        List<Contact> checkContactList = 
            [
                SELECT
                    Id
                FROM
                    Contact
            ];
        
        // Check for the size of the contact list
        System.assertEquals(0 , checkContactList.size());
        
        // Insert the contact Instance
        insert contactInstance;
        
        // Insert the query Instance
        insert queryInstance;
        
        checkQueryList = 
            [
                SELECT
                    Id
                FROM
                    Query__c
            ];
        
        // Check for the size of the querylist
        System.assertEquals(1 , checkQueryList.size());
        
        checkContactList = 
            [
                SELECT
                    Id
                FROM
                    Contact
            ];
        
        // Check for the size of the contact list
        System.assertEquals(1 , checkContactList.size());
        
        // Create the instance of the queryForContact
        QueryForContact__c queryForContactInstance = 
            new QueryForContact__c(
                                   Contact_Details__c = contactInstance.Id,
                                   QueryDetails__c = queryInstance.Id
                                   ); 
        
        List<QueryForContact__c> checkQueryForContactList = 
            [
                SELECT
                    Id
                FROM
                    QueryForContact__c
            ];
        
        // Check for the size of the querylist
        System.assertEquals(0 , checkQueryForContactList.size());
        
        insert queryForContactInstance;
    
        checkQueryForContactList = 
            [
                SELECT
                    Id
                FROM
                    QueryForContact__c
            ];
        
        // Check for the size of the contact list
        System.assertEquals(1 , checkQueryForContactList.size());
        
        // Create the instance of the batch apex class
        BatchResponsesForQuery batchInstance = new BatchResponsesForQuery();
        
        // Start the test
        Test.startTest();
        
        // Execute the batch
        Database.executeBatch(batchInstance,1);
        
        // Stop the test
        Test.StopTest();
        
        // Fetch the queryforcontact
        List<QueryForContact__c> queryForContactListInstance = 
            [
                SELECT
                    Id,
                    ResponseSend__c
                FROM
                    QueryForContact__c
                WHERE 
                    Id = :queryForContactInstance.Id
            ];
        
        // Check if the mail is send or not
        System.assertEquals(false,queryForContactListInstance[0].ResponseSend__c);
    }
}
