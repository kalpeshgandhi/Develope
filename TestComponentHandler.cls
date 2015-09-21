/**
 * This is a test class for checking the response returned by the component. 
 */
@isTest
private class TestComponentHandler 
{
    
   /**
    * This is the test method that will check for response returned by the component 
    */
    static testMethod void testForResponseReturnedByComponent() 
    {
        
        // Create the instance of the query
        Query__c queryInstance = new Query__c(Query_Field__c = 'Test');
        
        List<Query__c> checkQueryList = 
            [
                SELECT
                    Id
                FROM
                    Query__c
            ];
        
        // Check for the size of the querylist
        System.assertEquals(0, checkQueryList.size());
        
        // Insert the queryInstance
        insert queryInstance;
        
        checkQueryList = 
            [
                SELECT
                    Id
                FROM
                    Query__c
                WHERE
                    Query_Field__c = 'Test'
            ];
        
        // Check for the size of the querylist
        System.assertEquals(1, checkQueryList.size());
        
        // Create the instance of the response
        Response__c responseInstance = new Response__c(
            Description__c = 'Test Description',
            Search_Query__c = queryInstance.Id,
            Title__c = 'Test Title',
            Links__c = 'Test Link'
        );
        
        // Fetch the response list
        List<Response__c> checkResponseList = 
            [
                SELECT
                    Id
                FROM
                    Response__c
            ];
        
        // Check for the size of the querylist
        System.assertEquals(0, checkResponseList.size());
        
        // Insert the queryInstance
        insert responseInstance;
        
        // Fetch the response list
        checkResponseList = 
            [
                SELECT
                    Id
                FROM
                    Response__c
                WHERE
                    Title__c = 'Test Title'
            ];
        
        // Check for the records inserted or not.
        System.assertEquals(1, checkResponseList.size());
        
        // Create the instance of the component 
        ResponseComponentController controllerInstance = new ResponseComponentController();
        
        // Assign the query Id 
        controllerInstance.queryId = queryInstance.Id;
        
        // Create the instance of the list of response
        List<Response__c> responseList = new List<Response__c>(); 
        
        // Start the test
        Test.startTest();
        
        // Save returned responses
        responseList = controllerInstance.getResponses();
        
        // Stop the test
        Test.stopTest();
        
        // Check for the returned list contains any record
        System.assertEquals(1, responseList.size());
    }
    
   /**
    * This is the test method that will check for no response returned by the component 
    */
    static testMethod void testForNoResponseReturnedComponent() 
    {
        // Create the instance of the query
        Query__c queryInstance = new Query__c(Query_Field__c = 'Test');
        
        List<Query__c> checkQueryList = 
            [
                SELECT
                    Id
                FROM
                    Query__c
            ];
        
        // Check for the size of the querylist
        System.assertEquals(0, checkQueryList.size());
        
        // Insert the queryInstance
        insert queryInstance;
        
        checkQueryList = 
            [
                SELECT
                    Id
                FROM
                    Query__c
                WHERE
                    Query_Field__c = 'Test'
            ];
        
        // Check for the size of the querylist
        System.assertEquals(1, checkQueryList.size());
        
        // Create the instance of the response
        Response__c responseInstance = new Response__c(
            Description__c = 'Test Description',
            Search_Query__c = queryInstance.Id,
            Title__c = 'Test Title',
            Links__c = 'Test Link'
        );
        
        // Fetch the response list
        List<Response__c> checkResponseList = 
            [
                SELECT
                    Id
                FROM
                    Response__c
            ];
        
        // Check for the size of the querylist
        System.assertEquals(0, checkResponseList.size());
        
        // Insert the queryInstance
        insert responseInstance;
        
        // Fetch the response list
        checkResponseList = 
            [
                SELECT
                    Id
                FROM
                    Response__c
                WHERE
                    Title__c = 'Test Title'
            ];
        
        // Check for the records inserted or not.
        System.assertEquals(1, checkResponseList.size());
        
        // Create the instance of the component 
        ResponseComponentController controllerInstance = new ResponseComponentController();
        
        // Create the instance of the list of response
        List<Response__c> responseList = new List<Response__c>(); 
        
        // Assign the query Id as blank 
        controllerInstance.queryId = '';
        
        // Start the test
        Test.startTest();
        
        // Save returned responses
        responseList = controllerInstance.getResponses();
        
        // Stop the test
        Test.stopTest();
        
        // Check for the returned list contains any record
        System.assertEquals(0, responseList.size());
    }
    
   /**
    * This is the test method that will check for Bulk response returned by the component 
    */
    static testMethod void testWithBulkResponseForComponent() 
    {
   
        // Create the instance of the query
        Query__c queryInstance = new Query__c(Query_Field__c = 'Test');
        
        List<Query__c> checkQueryList = 
            [
                SELECT
                    Id
                FROM
                    Query__c
            ];
        
        // Check for the size of the querylist
        System.assertEquals(0, checkQueryList.size());
        
        // Insert the queryInstance
        insert queryInstance;
        
        checkQueryList = 
            [
                SELECT
                    Id
                FROM
                    Query__c
                WHERE
                    Query_Field__c = 'Test'
            ];
        
        // Check for the size of the querylist
        System.assertEquals(1, checkQueryList.size());
        
        // Create the instance of the response
        List<Response__c> responseListInstance = new List<Response__c>();
        
        for(Integer i = 0; i < 200; i++)
        {
           responseListInstance.add(new Response__c(
               Description__c = 'Test Description',
               Search_Query__c = queryInstance.Id,
               Title__c = 'Test Title',
               Links__c = 'Test Link'
               )
           );
        }
        // Fetch the response list
        List<Response__c> checkResponseList = 
            [
                SELECT
                    Id
                FROM
                    Response__c
            ];
        
        // Check for the size of the querylist
        System.assertEquals(0, checkResponseList.size());
        
        // Insert the queryInstance
        insert responseListInstance;
        
        // Fetch the response list
        checkResponseList = 
            [
                SELECT
                    Id
                FROM
                    Response__c
                WHERE
                    Title__c = 'Test Title'
            ];
        
        // Check for the records inserted or not.
        System.assertEquals(200 , checkResponseList.size());
        
        // Create the instance of the component 
        ResponseComponentController controllerInstance = new ResponseComponentController();
        
        // Assign the query Id 
        controllerInstance.queryId = queryInstance.Id;
        
        // Create the instance of the list of response
        List<Response__c> responseList = new List<Response__c>(); 
        
        // Start the test
        Test.startTest();
        
        // Save returned responses
        responseList = controllerInstance.getResponses();
        
        // Stop the test
        Test.stopTest();
        
        // Check for the returned list contains any record
        System.assertEquals(200, responseList.size());
    }
}