/**
 * This is the class that test the functionality to perform the create ,update ,delete the lead.
 */
@isTest
private class TestLeadManipulationRest {

   /**
    *  Here is test method to test creation of lead
    */
    static testmethod void testForLeadCreation()
    {
        // Call the set mock test for lead creation
        Test.setMock(HttpCalloutMock.class, new TestClassRestHttpCallOutInsert());
        
        // Create the instance of the service class
        RestService serviceInstance = new RestService();
        
        // Save the responce in the httpresponse
        HttpResponse responceInstance = serviceInstance.leadCreate();
        
        // Set the response type in the string
        String contentTypeInstance = responceInstance.getHeader('Content-Type');
        
        // Check the type is json
        System.assert(contentTypeInstance == 'application/json');
        
        // Set the response of the body
        String bodyValueInstance = responceInstance.getBody();
        
        // Set the response status in the string
        String expectedResultValue = '{"status":"Success"}';
        
        // Check the expected value matches the actual response
        System.assertEquals(expectedResultValue, bodyValueInstance);
        
        // Check the status code 
        System.assertEquals(200, responceInstance.getStatusCode());
    }
    
    
    static testmethod void testForLeadUpdate()
    {
        // Call the set mock test for lead creation
        Test.setMock(HttpCalloutMock.class, new TestHttpResponceMockUpdate());
        
        // Create the instance of the service class
        RestService serviceInstance = new RestService();
        
        // Save the responce in the httpresponse
        HttpResponse responceInstance = serviceInstance.leadUpdate();
        
        // Set the response type in the string
        String contentTypeInstance = responceInstance.getHeader('Content-Type');
        
        // Check the type is json
        System.assert(contentTypeInstance == 'application/json');
        
        // Set the response of the body
        String bodyValueInstance = responceInstance.getBody();
        
        // Set the response status in the string
        String expectedResultValue = '{"status":"Success"}';
        
        // Check the expected value matches the actual response
        System.assertEquals(expectedResultValue, bodyValueInstance);
        
        // Check the status code 
        System.assertEquals(200, responceInstance.getStatusCode());
    } 
    
    static testmethod void testForLeadDelete()
    {
        // Call the set mock test for lead creation
        Test.setMock(HttpCalloutMock.class, new TestHttpResponseMockDelete());
        
        // Create the instance of the service class
        RestService serviceInstance = new RestService();
        
        // Save the responce in the httpresponse
        HttpResponse responceInstance = serviceInstance.leadDelete();
        
        // Set the response type in the string
        String contentTypeInstance = responceInstance.getHeader('Content-Type');
        
        // Check the type is json
        System.assert(contentTypeInstance == 'application/json');
        
        // Set the response of the body
        String bodyValueInstance = responceInstance.getBody();
        
        // Set the response status in the string
        String expectedResultValue = '{"status":"Success"}';
        
        // Check the expected value matches the actual response
        System.assertEquals(expectedResultValue, bodyValueInstance);
        
        // Check the status code 
        System.assertEquals(200, responceInstance.getStatusCode());
    } 
    
}