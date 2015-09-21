@isTest
public class TestGoogleMockCallOutWithNoResponse implements HttpCalloutMock 
{
   /**
    * This is a method that will set the response
    */
    public HTTPResponse respond(HTTPRequest req) 
    {
        // Create the instance
        HttpResponse httpResponse = new HttpResponse();
        
        // Set the status code
        httpResponse.setStatusCode(200);
        
        // Set the body
        httpResponse.setBody('');
        
        // Return the response
        return httpResponse;
    } 
}