/**
 * This is the class that implements the httpcallout mock to create the fake response.
 */
public with sharing class TestClassRestHttpCallOutInsert implements HttpCalloutMock 
{
   /**
    * This is a method that will set the response
    */
    public HTTPResponse respond(HTTPRequest req) 
    {
        // Create the instance
        HttpResponse httpResponse = new HttpResponse();
        
        // Set the header content type
        httpResponse .setHeader('Content-Type', 'application/json');
        
        // Set the status code
        httpResponse.setStatusCode(200);
        
        // Set the body
        httpResponse.setBody('{"status":"Success"}');
        
        // Return the response
        return httpResponse;
    } 
}