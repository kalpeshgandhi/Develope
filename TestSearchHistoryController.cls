/**
 * This is a test class to check the functionality of the search history page which displays the 
 * history of the queries and its responses.
 */
@isTest
private class TestSearchHistoryController 
{
    /**
     * This is a method that will check the response for a particular query.
     */
     static testMethod void testResponseRecords() 
     {
         
         // Create the instance of the query 
         Query__c queryInstance = new Query__c( Query_Field__c = 'test');
         
         // Fetch the query 
         List<Query__c> queryList = 
            [
                SELECT
                    Id
                FROM
                    Query__c
                WHERE
                    Query_Field__c = :'test'
            ];
            
         // Check if the contact is inserted or not 
         System.assertEquals(0, queryList.size());
         
         // Insert the queryInstance
         insert queryInstance;
         
         // Fetch the query 
         queryList = 
            [
                SELECT
                    Id
                FROM
                    Query__c
                WHERE
                    Query_Field__c = :'test'
            ];
            
         
         // Check if the contact is inserted or not 
         System.assertEquals(1, queryList.size());
        
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
        
         // Create the instance of the response
         Response__c responseInstance = new Response__c(
            Description__c = 'Test Description',
            Search_Query__c = queryInstance.Id,
            Title__c = 'Test Title',
            Links__c = 'Test Link'
         );
         
         insert responseInstance;

         // Fetch the response list
         checkResponseList = 
             [
                 SELECT
                     Id
                 FROM
                     Response__c
             ];
        
         // Check for the size of the querylist
         System.assertEquals(1, checkResponseList.size());
         
         // Create the instance of the class
         SearchHistoryController controllerInstance = new SearchHistoryController();

                  
         // Create the page reference
         PageReference pageReferenceforSearchHistory= Page.SearchHistory;
         
         // Set the current page as contact 
         Test.setCurrentPage(pageReferenceforSearchHistory);
         
         // Add the key and value to the map.
         pageReferenceforsearchHistory.getParameters().put('query',queryInstance.Id);
         
         // Start the test
         Test.startTest();
         
         // Get the returned results 
         List<Response__c> responseList = controllerInstance.getresponseResults();
         
         // Stop the test
         Test.stopTest();
        
         // Check if we are retrieving the queries to be displayed on the page
         System.assertEquals(1, responseList.size());
     }
     
    /**
     * This is a method that will check queries are fetched or not.
     */
     static testMethod void testForQueryRecords() 
     {
         
         // Create the instance of the query 
         Query__c queryInstance = new Query__c( Query_Field__c = 'test');
         
         // Fetch the query 
         List<Query__c> queryList = 
            [
                SELECT
                    Id
                FROM
                    Query__c
                WHERE
                    Query_Field__c = :'test'
            ];
            
         // Check if the contact is inserted or not 
         System.assertEquals(0,queryList.size());
         
         // Insert the queryInstance
         insert queryInstance;
         
         // Fetch the query 
         queryList = 
            [
                SELECT
                    Id
                FROM
                    Query__c
                WHERE
                    Query_Field__c = :'test'
            ];
            
         
         // Check if the contact is inserted or not 
         System.assertEquals(1,queryList.size());
         
          // Create the instance of the class
         SearchHistoryController controllerInstance = new SearchHistoryController();
                  
         // Create the page reference
         PageReference pageReferenceforSearchHistory = Page.SearchHistory;
         
         // Set the current page as contact 
         Test.setCurrentPage(pageReferenceforSearchHistory);
         
         // Start the test
         Test.startTest();
         
         // Get the returned results 
         List<Query__c> queryListInstance = controllerInstance.getsearchResults();
         
         // Stop the test
         Test.stopTest();
        
         // Check if we are retrieving the queries to be displayed on the page
         System.assertEquals(1, queryListInstance.size());
     }
         
    /**
     * This is a method that will check queries are fetched or not.
     */
     static testMethod void testForBulkQueryRecords() 
     {
         // Create the instance of the query 
         List<Query__c> queryList = new List<Query__c>();
         
         for(Integer i = 0; i< 200 ;i++)
         {
             queryList.add(new Query__c( Query_Field__c = 'test' + i));
         }
         
         // Fetch the query 
         List<Query__c> checkQueryList = 
            [
                SELECT
                    Id
                FROM
                    Query__c
                WHERE
                    Query_Field__c LIKE 'test%'
            ];
            
         // Check if the contact is inserted or not 
         System.assertEquals(0,checkQueryList.size());
         
         // Insert the queryInstance
         insert queryList;
         
         // Fetch the query 
         checkQueryList = 
            [
                SELECT
                    Id
                FROM
                    Query__c
                WHERE
                    Query_Field__c LIKE 'test%'
            ];
            
         
         // Check if the contact is inserted or not 
         System.assertEquals(200,checkQueryList.size());
         
          // Create the instance of the class
         SearchHistoryController controllerInstance = new SearchHistoryController();
                  
         // Create the page reference
         PageReference pageReferenceforSearchHistory = Page.SearchHistory;
         
         // Set the current page as contact 
         Test.setCurrentPage(pageReferenceforSearchHistory);
         
         // Start the test
         Test.startTest();
         
         // Get the returned results 
         List<Query__c> queryListInstance = controllerInstance.getsearchResults();
         
         // Stop the test
         Test.stopTest();
        
         // Check if we are retrieving the queries to be displayed on the page
         System.assertEquals(5,queryListInstance.size());
     }
     
     
    /**
     * This is a method that will check the response for a perticular query.
     */
     static testMethod void testBulkResponseRecords() 
     {
         // Create the instance of the query 
         Query__c queryInstance = new Query__c( Query_Field__c = 'test');
         
         // Fetch the query 
         List<Query__c> queryList = 
            [
                SELECT
                    Id
                FROM
                    Query__c
                WHERE
                    Query_Field__c = :'test'
            ];
            
         // Check if the contact is inserted or not 
         System.assertEquals(0, queryList.size());
         
         // Insert the queryInstance
         insert queryInstance;
         
         // Fetch the query 
         queryList = 
            [
                SELECT
                    Id
                FROM
                    Query__c
                WHERE
                    Query_Field__c = :'test'
            ];
            
         
         // Check if the contact is inserted or not 
         System.assertEquals(1, queryList.size());
        
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
        
         // Create the instance of the response
         List<Response__c> responseListInstance = new List<Response__c>();
         
         for(Integer i = 0; i < 200; i++)    
         { 
             responseListInstance.add( 
                new Response__c(Description__c = 'Test Description',
                Search_Query__c = queryInstance.Id,
                Title__c = 'Test Title',
                Links__c = 'Test Link'
                )
             );
         }
         insert responseListInstance;

         // Fetch the response list
         checkResponseList = 
             [
                 SELECT
                     Id
                 FROM
                     Response__c
             ];
        
         // Check for the size of the querylist
         System.assertEquals(200, checkResponseList.size());
         
         // Create the instance of the class
         SearchHistoryController controllerInstance = new SearchHistoryController();

                  
         // Create the page reference
         PageReference pageReferenceforSearchHistory= Page.SearchHistory;
         
         // Set the current page as contact 
         Test.setCurrentPage(pageReferenceforSearchHistory);
         
         // Add the key and value to the map.
         pageReferenceforsearchHistory.getParameters().put('query',queryInstance.Id);
         
         
         // Start the test
         Test.startTest();
         
         // Get the returned results 
         List<Response__c> responseList = controllerInstance.getresponseResults();
         
         // Stop the test
         Test.stopTest();
        
         // Check if we are retrieving the queries to be displayed on the page
         System.assertEquals(200, responseList.size());
     }
     
   /**
    * This is a method that will test the next button functionality.
    */
    static testMethod void TestForNextPage() 
    {  
        // Create the instance of the query list
        List<Query__c> queryList = new List<Query__c>();
         
        // Iterate for 200 times
        for(Integer i = 0; i < 200; i++) 
        {
            // Add the elements to the list
            queryList.add(new Query__c( Query_Field__c = 'test' + i));
        }
         
        // Fetch the query 
        List<Query__c> checkQueryList = 
           [
               SELECT
                   Id
               FROM
                   Query__c
               WHERE
                   Query_Field__c LIKE 'test%'
           ];
      
            
        // Check if the contact is inserted or not 
        System.assertEquals(0, checkQueryList.size());
         
        insert queryList;
        
        // Fetch the query 
        checkQueryList = 
           [
               SELECT
                   Id
               FROM
                   Query__c
               WHERE
                   Query_Field__c LIKE 'test%'
           ];
           
        // Check if the contact is inserted or not 
        System.assertEquals(200, checkQueryList.size());
        
        // Create the instance of the class
        SearchHistoryController controllerInstance = new SearchHistoryController();
        
        // Create the page reference
        PageReference pageReferenceforSearchHistory= Page.SearchHistory;
        
        // Set the current page as contact 
        Test.setCurrentPage(pageReferenceforSearchHistory);
        
        //Start the test
        Test.startTest();
        
        // Call the next method from controller
        controllerInstance.next();
         
        //Stop the test
        Test.stopTest();
        
        // Assign the page number
        Integer pageNumber = controllerInstance.pageNumberMethod;
        
        // Check the assert value
        System.assertEquals(2, pageNumber); 
    }
    
   /**
    * This is a method that will test the previous button functionality.
    */
    static testMethod void TestForPreviousPage() 
    {  
        // Create the instance of the query list
        List<Query__c> queryList = new List<Query__c>();
         
        // Iterate for 200 times
        for(Integer i = 0; i < 200; i++) 
        {
            // Add the elements to the list
            queryList.add(new Query__c( Query_Field__c = 'test' + i));
        }
         
        // Fetch the query 
        List<Query__c> checkQueryList = 
           [
               SELECT
                   Id
               FROM
                   Query__c
               WHERE
                   Query_Field__c LIKE 'test%'
           ];
      
            
        // Check if the contact is inserted or not 
        System.assertEquals(0, checkQueryList.size());
         
        // Insert the querylist
        insert queryList;
        
        // Fetch the query 
        checkQueryList = 
           [
               SELECT
                   Id
               FROM
                   Query__c
               WHERE
                   Query_Field__c LIKE 'test%'
           ];
           
        // Check if the contact is inserted or not 
        System.assertEquals(200,checkQueryList.size());
        
        // Create the instance of the class
        SearchHistoryController controllerInstance = new SearchHistoryController();
        
        // Create the page reference
        PageReference pageReferenceforSearchHistory = Page.SearchHistory;
        
        // Set the current page as contact 
        Test.setCurrentPage(pageReferenceforSearchHistory);

        // Call the next method from controller
        controllerInstance.next();
         
        // Assign the page number
        Integer pageNumber = controllerInstance.pageNumberMethod;
        
        // Check the assert value
        System.assertEquals(2, pageNumber); 
        
        //Start the test
        Test.startTest();
        
        // Call the previous method from controller
        controllerInstance.previous();
         
        //Stop the test
        Test.stopTest();

        // Assign the page number
        pageNumber = controllerInstance.pageNumberMethod;
        
        // Check the assert value
        System.assertEquals(1, pageNumber); 
    }
  
   /**
    * This is a method that will test the first button functionality.
    */
    static testMethod void TestForFirstPage() 
    {  
        // Create the instance of the query list
        List<Query__c> queryList = new List<Query__c>();
         
        // Iterate for 200 times
        for(Integer i = 0; i < 200; i++) 
        {
            // Add the elements to the list
            queryList.add(new Query__c( Query_Field__c = 'test' + i));
        }
         
        // Fetch the query 
        List<Query__c> checkQueryList = 
           [
               SELECT
                   Id
               FROM
                   Query__c
               WHERE
                   Query_Field__c LIKE 'test%'
           ];
      
            
        // Check if the contact is inserted or not 
        System.assertEquals(0, checkQueryList.size());
         
        insert queryList;
        
        // Fetch the query 
        checkQueryList = 
           [
               SELECT
                   Id
               FROM
                   Query__c
               WHERE
                   Query_Field__c LIKE 'test%'
           ];
           
        // Check if the contact is inserted or not 
        System.assertEquals(200, checkQueryList.size());
        
        // Create the instance of the class
        SearchHistoryController controllerInstance = new SearchHistoryController();
        
        // Create the page reference
        PageReference pageReferenceforSearchHistory = Page.SearchHistory;
        
        // Set the current page as contact 
        Test.setCurrentPage(pageReferenceforSearchHistory);
        
        // Call the next method from controller
        controllerInstance.next();

        // Assign the page number
        Integer pageNumber = controllerInstance.pageNumberMethod;
        
        // Check the assert value
        System.assertEquals(2, pageNumber); 
        
        // Call the first method from controller
        controllerInstance.firstPage();
         
        // Assign the page number
        pageNumber = controllerInstance.pageNumberMethod;
        
        // Check the assert value
        System.assertEquals(1, pageNumber); 
    }
    
   /**
    * This is a method that will test the page number.
    */
    static testMethod void TestForPageNumber() 
    {  
        // Create the instance of the query list
        List<Query__c> queryList = new List<Query__c>();
         
        // Iterate for 200 times
        for(Integer i = 0; i < 200; i++) 
        {
            // Add the elements to the list
            queryList.add(new Query__c( Query_Field__c = 'test' + i));
        }
         
        // Fetch the query 
        List<Query__c> checkQueryList = 
           [
               SELECT
                   Id
               FROM
                   Query__c
               WHERE
                   Query_Field__c LIKE 'test%'
           ];
      
            
        // Check if the contact is inserted or not 
        System.assertEquals(0, checkQueryList.size());
         
        insert queryList;
        
        // Fetch the query 
        checkQueryList = 
           [
               SELECT
                   Id
               FROM
                   Query__c
               WHERE
                   Query_Field__c LIKE 'test%'
           ];
           
        // Check if the contact is inserted or not 
        System.assertEquals(200, checkQueryList.size());
        
        // Create the instance of the class
        SearchHistoryController controllerInstance = new SearchHistoryController();
        
        // Create the page reference
        PageReference pageReferenceforSearchHistory = Page.SearchHistory;
        
        // Set the current page as contact 
        Test.setCurrentPage(pageReferenceforSearchHistory);
         
        // Start the test
        Test.startTest();
        
        // Assign the page number
        Integer pageNumber = controllerInstance.pageNumberMethod;
        
        // Stop the test
        Test.stopTest();
        
        // Check the assert value
        System.assertEquals(1, pageNumber); 
        
    }
    
   /**
    * This is a method that will test the hasnext functionality that checks is there a next 
    * page to be displayed.
    */
    static testMethod void TestForHasNext() 
    {  
        // Create the instance of the query list
        List<Query__c> queryList = new List<Query__c>();
         
        // Iterate for 200 times
        for(Integer i = 0; i < 200; i++) 
        {
            // Add the elements to the list
            queryList.add(new Query__c( Query_Field__c = 'test' + i));
        }
         
        // Fetch the query 
        List<Query__c> checkQueryList = 
           [
               SELECT
                   Id
               FROM
                   Query__c
               WHERE
                   Query_Field__c LIKE 'test%'
           ];
      
            
        // Check if the contact is inserted or not 
        System.assertEquals(0, checkQueryList.size());
         
        insert queryList;
        
        // Fetch the query 
        checkQueryList = 
           [
               SELECT
                   Id
               FROM
                   Query__c
               WHERE
                   Query_Field__c LIKE 'test%'
           ];
           
        // Check if the contact is inserted or not 
        System.assertEquals(200, checkQueryList.size());
        
        // Create the instance of the class
        SearchHistoryController controllerInstance = new SearchHistoryController();
        
        // Create the page reference
        PageReference pageReferenceforSearchHistory = Page.SearchHistory;
        
        // Set the current page as contact 
        Test.setCurrentPage(pageReferenceforSearchHistory);
        
        // Assign the page number
        Integer pageNumber = controllerInstance.pageNumberMethod;
        
        // Check the assert value
        System.assertEquals(1, pageNumber); 
        
        // Set the next page
        controllerInstance.next();
        
        // Assign the page number
        pageNumber = controllerInstance.pageNumberMethod;
        
        // Check the assert value
        System.assertEquals(2, pageNumber); 
        
        // Start the test
        Test.startTest();
        
        // Check for next page
        if(controllerInstance.hasnext)
        {
            // Set the next page
            controllerInstance.next();
        }
        // Stop the test
        Test.stopTest();
        
        // Check the assert value
        System.assertEquals(true, controllerInstance.hasnext); 
    }
    
   /**
    * This is a method that will test the hasprevious functionality that checks is there a previous 
    * page to be displayed.
    */
    static testMethod void TestForHasPrevious() 
    {  
        // Create the instance of the query list
        List<Query__c> queryList = new List<Query__c>();
         
        // Iterate for 200 times
        for(Integer i = 0; i < 200; i++) 
        {
            // Add the elements to the list
            queryList.add(new Query__c( Query_Field__c = 'test' + i));
        }
         
        // Fetch the query 
        List<Query__c> checkQueryList = 
           [
               SELECT
                   Id
               FROM
                   Query__c
               WHERE
                   Query_Field__c LIKE 'test%'
           ];
      
            
        // Check if the contact is inserted or not 
        System.assertEquals(0, checkQueryList.size());
         
        insert queryList;
        
        // Fetch the query 
        checkQueryList = 
           [
               SELECT
                   Id
               FROM
                   Query__c
               WHERE
                   Query_Field__c LIKE 'test%'
           ];
           
        // Check if the contact is inserted or not 
        System.assertEquals(200,checkQueryList.size());
        
        // Create the instance of the class
        SearchHistoryController controllerInstance = new SearchHistoryController();
        
        // Create the page reference
        PageReference pageReferenceforSearchHistory= Page.SearchHistory;
        
        // Set the current page as contact 
        Test.setCurrentPage(pageReferenceforSearchHistory);
        
        // Assign the page number
        Integer pageNumber = controllerInstance.pageNumberMethod;
        
        // Check the assert value
        System.assertEquals(1, pageNumber); 
        
        // Set the next page
        controllerInstance.next();
        
        // Assign the page number
        pageNumber = controllerInstance.pageNumberMethod;
        
        // Check the assert value
        System.assertEquals(2, pageNumber); 
        
        controllerInstance.next();
        
        // Assign the page number
        pageNumber = controllerInstance.pageNumberMethod;
        
        // Check the assert value
        System.assertEquals(3, pageNumber); 
        
        // Start the test
        Test.startTest();
        
        // Check for previous page
        if(controllerInstance.hasPrevious)
        {
            // Set the previous page
            controllerInstance.previous();
        }
        // Stop the test
        Test.stopTest();
        
        // Check the assert value
        System.assertEquals(true, controllerInstance.hasPrevious); 
    }
    
   /**
    * This is a method that will test the last button functionality
    */
    static testMethod void TestForLastPage() 
    {  
        // Create the instance of the query list
        List<Query__c> queryList = new List<Query__c>();
         
        // Iterate for 200 times
        for(Integer i = 0; i < 200; i++) 
        {
            // Add the elements to the list
            queryList.add(new Query__c( Query_Field__c = 'test' + i));
        }
         
        // Fetch the query 
        List<Query__c> checkQueryList = 
           [
               SELECT
                   Id
               FROM
                   Query__c
               WHERE
                   Query_Field__c LIKE 'test%'
           ];
      
            
        // Check if the contact is inserted or not 
        System.assertEquals(0, checkQueryList.size());
         
        insert queryList;
        
        // Fetch the query 
        checkQueryList = 
           [
               SELECT
                   Id
               FROM
                   Query__c
               WHERE
                   Query_Field__c LIKE 'test%'
           ];
           
        // Check if the contact is inserted or not 
        System.assertEquals(200, checkQueryList.size());
        
        // Create the instance of the class
        SearchHistoryController controllerInstance = new SearchHistoryController();
        
        // Create the page reference
        PageReference pageReferenceforSearchHistory = Page.SearchHistory;
        
        // Set the current page as contact 
        Test.setCurrentPage(pageReferenceforSearchHistory);

        // Call the next method from controller
        controllerInstance.next();
         
        // Assign the page number
        Integer pageNumber = controllerInstance.pageNumberMethod;
        
        
        // Check the assert value
        System.assertEquals(2, pageNumber); 
        
        // Start the test
        Test.startTest();
        
        // Call the next method from controller
        controllerInstance.lastPage();
        
        // Stop the test
        Test.stopTest();
        
        // Assign the page number
        pageNumber = controllerInstance.pageNumberMethod;
        
        // Check the assert value
        System.assertNotEquals(1, pageNumber); 
    }
}
