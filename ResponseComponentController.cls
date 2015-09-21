/**
 * This is a handler class that returns the responses back to the component.
 */
public with sharing class ResponseComponentController 
{
    // Create the instance of the string 
    public String queryId {get; set;} 
   
   /**
    * This is a getter method that will fetch all the responses and will return the responses.
    */
    public List<Response__c> getResponses() 
    {
        // Return the responses 
        return [
                    SELECT 
                        Id, 
                        Description__c, 
                        TitleLinks__c,
                        Links__c,
                        Title__c
                    FROM
                        Response__c
                    WHERE 
                        Search_Query__c = :queryId
               ];
    }
}