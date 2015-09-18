/**
 * This is the class that implements the webservice mock to create the fake response.
 */
@isTest
public class TestSoapWebserviceUpdate implements WebServiceMock
{
   /**
    * This is the method that is used to set the response
    */
    public void doInvoke(
                         Object stub,
                         Object request,
                         Map<String, Object> response,
                         String endpoint,
                         String soapAction,
                         String requestName,
                         String responseNS,
                         String responseName,
                         String responseType) 
   {
        // Create the instance of the response of the update method
        soapSforceComSchemasClassLeadmanipu.updateLeadManipulatorServiceResponse_element responseElement = 
            new soapSforceComSchemasClassLeadmanipu.updateLeadManipulatorServiceResponse_element();
        
        // Create the instance of the responce 
        responseElement.result = new soapSforceComSchemasClassLeadmanipu.ResponseWrapper();
        
        // Set the responce element
        responseElement.result.isSuccess = true;
        
        // Set the responce element
        responseElement.result.status = 'Mock response Result';
        
        // Add response element to the map
        response.put('response_x', responseElement);
   }
}