/**
 * This is a method that will test the functionality to insert,update,delete the lead record using 
 * rest webservice.
 */
@isTest
private class TestRestClass 
{
   /**
    * This is a method that will test the functionality to insert the lead record using 
    * rest webservice.
    */
    static testMethod void testForLeadInsert() 
    {
        // Create the instance of the wrapper instance 
        LeadManipulationRestServiceClass.ResponseWrapper wrapperInstance = 
            new LeadManipulationRestServiceClass.ResponseWrapper();
       
        // Fetch all the leads matching the criteria.
        List<Lead> leadInstanceList = 
            [
                SELECT 
                    Id, 
                    FirstName, 
                    LastName,
                    Email, 
                    Phone 
                FROM 
                    Lead 
            ];
        
        // Check if the record is inserted or not 
        System.assertEquals(0,leadInstanceList.size());
        
        // Start the test
        Test.startTest();
        
        // Insert the data through the webservice
        wrapperInstance = 
        LeadManipulationRestServiceClass.insertLeadManipulatorService('TestLead', 
                                                                      'Data', 
                                                                      'testLead@testdata.com',
                                                                      '1234567890',
                                                                      'TestCompany'
                                                                      );
        
        // Stop the test
        Test.stopTest();
        
        leadInstanceList = 
            [
                SELECT 
                    Id, 
                    FirstName, 
                    LastName,
                    Email, 
                    Phone 
                FROM 
                    Lead 
                WHERE 
                    FirstName = 'TestLead'
            ];
        
        // Check if the record is inserted or not 
        System.assertEquals(1,leadInstanceList.size());
    } 
    
    
    /**
    * This is a method that will test the functionality to check whether lead record is inserted 
    * when required field is missing using rest webservice.
    */
    static testMethod void testForLeadNotInsertedWhenRequiredFieldMissing() 
    {
        // Create the instance of the wrapper instance 
        LeadManipulationRestServiceClass.ResponseWrapper wrapperInstance = 
            new LeadManipulationRestServiceClass.ResponseWrapper();
       
        // Fetch all the leads matching the criteria.
        List<Lead> leadInstanceList = 
            [
                SELECT 
                    Id, 
                    FirstName, 
                    LastName,
                    Email, 
                    Phone 
                FROM 
                    Lead 
            ];
        
        // Check if the record is inserted or not 
        System.assertEquals(0,leadInstanceList.size());
        
        // Start the test
        Test.startTest();
        
        // Insert the data through the webservice
        wrapperInstance = 
        LeadManipulationRestServiceClass.insertLeadManipulatorService('TestLead', 
                                                                      'Data', 
                                                                      'testLead@testdata.com',
                                                                      '1234567890',
                                                                      ''
                                                                      );
        
        // Stop the test
        Test.stopTest();
        
        leadInstanceList = 
            [
                SELECT 
                    Id, 
                    FirstName, 
                    LastName,
                    Email, 
                    Phone 
                FROM 
                    Lead 
                WHERE 
                    FirstName = 'TestLead'
            ];
        
        // Check if the record is inserted or not 
        System.assertEquals(0,leadInstanceList.size());
    } 
    
    /**
    * This is a method that will test the functionality to check whether lead record is inserted 
    * when required field is missing using rest webservice.
    */
    static testMethod void testForLeadNotInserted() 
    {
        // Create the instance of the wrapper instance 
        LeadManipulationRestServiceClass.ResponseWrapper wrapperInstance = 
            new LeadManipulationRestServiceClass.ResponseWrapper();
       
        // Fetch all the leads matching the criteria.
        List<Lead> leadInstanceList = 
            [
                SELECT 
                    Id, 
                    FirstName, 
                    LastName,
                    Email, 
                    Phone 
                FROM 
                    Lead 
            ];
        
        // Check if the record is inserted or not 
        System.assertEquals(0,leadInstanceList.size());
        
        // Start the test
        Test.startTest();
        
        // Insert the data through the webservice
        wrapperInstance = 
        LeadManipulationRestServiceClass.insertLeadManipulatorService('TestLead', 
                                                                      'Data', 
                                                                      'testLead@testdata',
                                                                      '1234567890',
                                                                      'TestSolution'
                                                                     );
        
        // Stop the test
        Test.stopTest();
        
        // Fetch the query
        leadInstanceList = 
            [
                SELECT 
                    Id, 
                    FirstName, 
                    LastName,
                    Email, 
                    Phone 
                FROM 
                    Lead 
                WHERE 
                    FirstName = 'TestLead'
            ];
        
        // Check if the record is inserted or not 
        System.assertEquals(0,leadInstanceList.size());
    }
    
    /**
    * This is a method that will test the functionality to update the lead record using 
    * rest webservice.
    */
    static testMethod void testForLeadUpdate() 
    {
        // Create the instance of the wrapper instance 
        LeadManipulationRestServiceClass.ResponseWrapper wrapperInstance = 
            new LeadManipulationRestServiceClass.ResponseWrapper();
       
        // Fetch all the leads matching the criteria.
        List<Lead> leadInstanceList = 
            [
                SELECT 
                    Id, 
                    FirstName, 
                    LastName,
                    Email, 
                    Phone 
                FROM 
                    Lead 
                WHERE 
                    FirstName = 'TestLead'
            ];
        
        // Check if the record is inserted or not 
        System.assertEquals(0,leadInstanceList.size());
        
        // Insert the data through the webservice
        wrapperInstance = 
        LeadManipulationRestServiceClass.insertLeadManipulatorService('TestLead', 
                                                                      'Data', 
                                                                      'testLead@testdata.com',
                                                                      '1234567890',
                                                                      'TestCompany'
                                                                        );
        
        // Fetch the records
        leadInstanceList = 
            [
                SELECT 
                    Id, 
                    FirstName, 
                    LastName,
                    Email, 
                    Phone 
                FROM 
                    Lead 
                WHERE 
                    FirstName = 'TestLead'
            ];
        
        // Check if the record is inserted or not 
        System.assertEquals(1,leadInstanceList.size());
        
        // Start the test
        Test.startTest();
        
        // Insert the data through the webservice
        wrapperInstance = 
        LeadManipulationRestServiceClass.updateLeadManipulatorService('TestLead', 
                                                                      'Data', 
                                                                      'lead@testdata.com',
                                                                      '987654321'
                                                                      );
        
        // Stop the test
        Test.stopTest();
        
        // Fetch the records
        leadInstanceList = 
            [
                SELECT 
                    Id, 
                    FirstName, 
                    LastName,
                    Email, 
                    Phone 
                FROM 
                    Lead 
                WHERE 
                    FirstName = 'TestLead'
                AND 
                    LastName = 'Data'
                AND 
                    Email = 'lead@testdata.com'
                AND 
                    Phone = '987654321'
            ];
        
        // Check if the record is updated or not 
        System.assertEquals(1,leadInstanceList.size());
    } 
    
   /**
    * This is a method that will test the functionality to check whether lead record is updated 
    * when criteria does not match using rest webservice.
    */
    static testMethod void testForLeadNotUpdate() 
    {
        // Create the instance of the wrapper instance 
        LeadManipulationRestServiceClass.ResponseWrapper wrapperInstance = 
            new LeadManipulationRestServiceClass.ResponseWrapper();
       
        // Fetch all the leads matching the criteria.
        List<Lead> leadInstanceList = 
            [
                SELECT 
                    Id, 
                    FirstName, 
                    LastName,
                    Email, 
                    Phone 
                FROM 
                    Lead 
            ];
        
        // Check if the record is inserted or not 
        System.assertEquals(0,leadInstanceList.size());
        
        // Insert the data through the webservice
        wrapperInstance = 
        LeadManipulationRestServiceClass.insertLeadManipulatorService('TestLead', 
                                                                      'Data', 
                                                                      'testLead@testdata.com',
                                                                      '1234567890',
                                                                      'TestCompany'
                                                                     );
        
        // Fetch the records
        leadInstanceList = 
            [
                SELECT 
                    Id, 
                    FirstName, 
                    LastName,
                    Email, 
                    Phone 
                FROM 
                    Lead 
                WHERE 
                    FirstName = 'TestLead'
            ];
        
        // Check if the record is inserted or not 
        System.assertEquals(1,leadInstanceList.size());
        
        // Start the test
        Test.startTest();
        
        // Insert the data through the webservice
        wrapperInstance = 
        LeadManipulationRestServiceClass.updateLeadManipulatorService('TestLead', 
                                                                      'DataRecord', 
                                                                      'lead@testdata.com',
                                                                      '987654321'
                                                                     );
        
        // Stop the test
        Test.stopTest();
        
        // Fetch the records
        leadInstanceList = 
            [
                SELECT 
                    Id, 
                    FirstName, 
                    LastName,
                    Email, 
                    Phone 
                FROM 
                    Lead 
                WHERE 
                    FirstName = 'TestLead'
                AND 
                    LastName = 'Data'
                AND 
                    Email = 'lead@testdata.com'
                AND 
                    Phone = '987654321'
            ];
        
        // Check if the record is updated or not 
        System.assertEquals(0,leadInstanceList.size());
    } 
    
    /**
    * This is a method that will test the functionality to delete the lead record using 
    * rest webservice.
    */
    static testMethod void testForLeadDelete() 
    {
        // Create the instance of the wrapper instance 
        LeadManipulationRestServiceClass.ResponseWrapper wrapperInstance = 
            new LeadManipulationRestServiceClass.ResponseWrapper();
       
        // Fetch all the leads matching the criteria.
        List<Lead> leadInstanceList = 
            [
                SELECT 
                    Id, 
                    FirstName, 
                    LastName,
                    Email, 
                    Phone 
                FROM 
                    Lead 
            ];
        
        // Check if the record is inserted or not 
        System.assertEquals(0,leadInstanceList.size());
        
        // Insert the data through the webservice
        wrapperInstance = 
        LeadManipulationRestServiceClass.insertLeadManipulatorService('TestLead', 
                                                                      'Data', 
                                                                      'testLead@testdata.com',
                                                                      '1234567890',
                                                                      'TestCompany'
                                                                     );
        
        // Fetch the records
        leadInstanceList = 
            [
                SELECT 
                    Id, 
                    FirstName, 
                    LastName,
                    Email, 
                    Phone 
                FROM 
                    Lead 
                WHERE 
                    FirstName = 'TestLead'
            ];
        
        // Check if the record is inserted or not 
        System.assertEquals(1,leadInstanceList.size());
        
        RestContext.request = new RestRequest();
        
        // Assign the firstname from parameter
        String firstName = RestContext.request.params.put('firstName','TestLead');
        
        // Assign the lastname from parameter
        String lastName = RestContext.request.params.put('lastName','Data');
        
        // Assign the email from parameter
        String email = RestContext.request.params.put('email','testLead@testdata.com');
        
        // Assign the phone from parameter
        String phone = RestContext.request.params.put('phone','1234567890');
        
        // Start the test
        Test.startTest();
        
        // Insert the data through the webservice
        wrapperInstance = 
        LeadManipulationRestServiceClass.deleteLeadManipulatorService();
        
        // Stop the test
        Test.stopTest();
        
        // Fetch the records
        leadInstanceList = 
            [
                SELECT 
                    Id, 
                    FirstName, 
                    LastName,
                    Email, 
                    Phone 
                FROM 
                    Lead 
                WHERE 
                    FirstName = 'TestLead'
                AND 
                    LastName = 'Data'
                AND 
                    Email = 'testLead@testdata.com'
                AND 
                    Phone = '1234567890'
            ];
        
        // Check if the record is updated or not 
        System.assertEquals(0,leadInstanceList.size());
    }
  
    /**
    * This is a method that will test the functionality to check whether lead record is deleted 
    * when criteria does not match using rest webservice.
    */
    static testMethod void testForLeadNotDelete() 
    {
        // Create the instance of the wrapper instance 
        LeadManipulationRestServiceClass.ResponseWrapper wrapperInstance = 
            new LeadManipulationRestServiceClass.ResponseWrapper();
       
        // Fetch all the leads matching the criteria.
        List<Lead> leadInstanceList = 
            [
                SELECT 
                    Id, 
                    FirstName, 
                    LastName,
                    Email, 
                    Phone 
                FROM 
                    Lead 
            ];
        
        // Check if the record is inserted or not 
        System.assertEquals(0,leadInstanceList.size());
        
        // Insert the data through the webservice
        wrapperInstance = 
        LeadManipulationRestServiceClass.insertLeadManipulatorService('TestLead', 
                                                                      'Data', 
                                                                      'testLead@testdata.com',
                                                                      '1234567890',
                                                                      'TestCompany'
                                                                     );
        
        // Fetch the records
        leadInstanceList = 
            [
                SELECT 
                    Id, 
                    FirstName, 
                    LastName,
                    Email, 
                    Phone 
                FROM 
                    Lead 
                WHERE 
                    FirstName = 'TestLead'
            ];
        
        // Check if the record is inserted or not 
        System.assertEquals(1,leadInstanceList.size());
        
        RestContext.request = new RestRequest();
        
        // Assign the firstname from parameter
        String firstName = RestContext.request.params.put('firstName','Test');
        
        // Assign the lastname from parameter
        String lastName = RestContext.request.params.put('lastName','DataRecord');
        
        // Assign the email from parameter
        String email = RestContext.request.params.put('email','testLead@testdata.com');
        
        // Assign the phone from parameter
        String phone = RestContext.request.params.put('phone','1234567890');
        
        // Start the test
        Test.startTest();
        
        // Insert the data through the webservice
        wrapperInstance = 
        LeadManipulationRestServiceClass.deleteLeadManipulatorService();
        
        // Stop the test
        Test.stopTest();
        
        // Fetch the records
        leadInstanceList = 
            [
                SELECT 
                    Id, 
                    FirstName, 
                    LastName,
                    Email, 
                    Phone 
                FROM 
                    Lead 
                WHERE 
                    FirstName = 'TestLead'
                AND 
                    LastName = 'Data'
                AND 
                    Email = 'testLead@testdata.com'
                AND 
                    Phone = '1234567890'
            ];
        
        // Check if the record is updated or not 
        System.assertEquals(1,leadInstanceList.size());
    }

}