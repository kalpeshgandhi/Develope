/**
 * This is a controller for the page that will show the query list and associated results.
 */
public with sharing class SearchHistoryController 
{
    
    // Declare the list of the query.
    public List<Query__c> queryList{get; set;}
    
    // Declare the list of the response
    public List<Response__c> responseList{get; set;}
    
    // Declare the boolean variable.
    public Boolean searchSection{get; set;}
    
    // Declare the Id.
    public Id selectedQueryId{get; set;}
    
    // Declare the boolean variable.
    public Boolean resultSection{get; set;}
    
   /**
    * This is a constructor that will initialize the list and variables.
    */
    public SearchHistoryController()
    {
        
        // Initialize the response list
        responseList = new List<Response__c>();
        
        // Initialize the query list
        queryList = new List<Query__c>();
        
        // Initialize the boolean variable as true
        searchSection = true;
        
        // Initialize the boolean variable as true
        resultSection = false;
    }
    
   /**
    * This is the getter that will return the response result
    */
    public List<Response__c> getresponseResults()
    {
        
        // Assign the query id 
        selectedQueryId = ApexPages.currentPage().getParameters().get('query');
        
        // Fetch the response
        responseList = 
            [ 
                SELECT
                    Id,
                    TitleLinks__c,
                    Search_Query__c,
                    Description__c,
                    Links__c,
                    Title__c
                FROM
                    Response__c
                WHERE
                    Search_Query__c = :selectedQueryId
                LIMIT 200
            ];
        
        // Return the response list
        return responseList;
    }
     
   /**
    * This is a method that will return the search results
    */
    public List<Query__c> getsearchResults()
    {
        
        // Get the records
        queryList = queryRecords.getRecords();
        
        // Return the query list
        return queryList;
    }
    
   /**
    * This is a method that will show the result section
    */
    public void showResultSection()
    {
        
         // Assign the boolean value as true
         resultSection = true;
    }
    
   /**
    * This is a method that indicates whether there are more next records
    */
    public Boolean hasNext 
    {
        get 
        {
            // Return the next set
            return queryRecords.getHasNext();
        }
        set;
    }
    
   /**
    * This is a method that indicates whether there are more previous records
    */
    public Boolean hasPrevious 
    {
        get 
        {
            // Return the previous set
            return queryRecords.getHasPrevious();
        }
        set;
    }

   /**
    * This is a method that indicates that returns the page number
    */
    public Integer pageNumberMethod 
    {
        get 
        {
            // Return the page number 
            return queryRecords.getPageNumber();
        }
        set;
    }

    /**
     * This is a method that returns the first page of records
     */
     public void firstPage() 
     {
         // Return the first page
         queryRecords.first();
     }
     
    /**
     * This is a method that returns the last page of records
     */
     public void lastPage() 
     {
         // Return the last page
         queryRecords.last();
     }
     
    /**
     * This is a method that returns the previous page of records
     */
     public void previous() 
     {
         // Return the previous page
         queryRecords.previous();
     }
     
    /**
     * This is a method that returns the next page of records
     */
     public void next() 
     {
         // Return the next page
         queryRecords.next();
     }
     
    /**
     * This is a standard set controller that will fetch all the query records
     */
     public ApexPages.StandardSetController queryRecords 
     {
        get 
        {
            // Check of the instance is null or not
            if(queryRecords == null) 
            {
                // Fetch the query
                queryRecords = 
                new ApexPages.StandardSetController(
                    Database.getQueryLocator(
                        [ 
                            SELECT
                                Id,
                                Query_Field__c
                            FROM
                                Query__c
                            LIMIT 200
                        ]
                    )
                );
                // sets the number of records in each page set
                queryRecords.setPageSize(5);
            }
            return queryRecords;
        }
        set;
    }
}
