/**
 * This is the class that test the functionality to perform the create ,update ,delete the lead.
 */
@isTest
private class TestSoapServices
{
    /**
     * This is the test method to create the lead and check whether the leads are created or not
     */
     static testMethod void testCreateLead() 
     {
         // Call the set mock test for lead creation
         Test.setMock(WebServiceMock.class, new TestSoapWebServiceInsert());
         
         // Create an instance for the class
         soapSforceComSchemasClassLeadmanipu.LeadManipulatorServicesSoap soapInstance = 
             new soapSforceComSchemasClassLeadmanipu.LeadManipulatorServicesSoap();
        
         // Call the insert method
         soapSforceComSchemasClassLeadmanipu.ResponseWrapper responseInstance =
             soapInstance.insertLeadManipulatorService('Testname',
                                                       'Testname',
                                                       'Test@email.com',
                                                       '123456789',
                                                       'TestCompany');
        // Test for the response.
        System.assertEquals('Mock response Result', responseInstance.status);
     }
    
    /**
     * This is the test method to create the lead and check whether the leads are updated or not
     */
     static testMethod void testUpdateLead() 
     {
         // Call the set mock test for lead update
         Test.setMock(WebServiceMock.class, new TestSoapWebserviceUpdate());
         
         // Create an instance for the class
         soapSforceComSchemasClassLeadmanipu.LeadManipulatorServicesSoap soapInstance = 
            new soapSforceComSchemasClassLeadmanipu.LeadManipulatorServicesSoap();
          
         // Call the update method
         soapSforceComSchemasClassLeadmanipu.ResponseWrapper responseInstance =
            soapInstance.updateLeadManipulatorService('Testname',
                                                      'Testname',
                                                      'Testing@email.com',
                                                      '7653490987');
       
         // Test for the response.
         System.assertEquals('Mock response Result', responseInstance.status);
    } 
        
    /**
     * This is the test method to create the lead and check whether the leads are deleted or not
     */
     static testMethod void testDeleteLead() 
     {
         // Call the set mock test for lead delete
         Test.setMock(WebServiceMock.class, new TestSoapWebServiceDelete());
         
         // Create an instance for the class
         soapSforceComSchemasClassLeadmanipu.LeadManipulatorServicesSoap soapInstance = 
            new soapSforceComSchemasClassLeadmanipu.LeadManipulatorServicesSoap  ();
         
         // Call method to delete lead
         soapSforceComSchemasClassLeadmanipu.ResponseWrapper responseInstance =
            soapInstance.deleteLeadManipulatorService('Testname',
                                                      'Testname',
                                                      'Testing@email.com',
                                                      '7653490987');
        
        // Test for the response.
        System.assertEquals('Mock response Result', responseInstance.status);
    }
}