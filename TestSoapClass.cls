/**
 * This is method that will test the operations of the insert update and delete of leads using soap 
 * for provider side.
 */
@isTest
private class TestSoapClass 
{
   /**
    * This is a method that will test the functionality to insert the lead record using 
    * soap webservice.
    */
    static testMethod void testForLeadInsert() 
    {
        // Create the instance of the wrapper instance 
        LeadManipulatorServicesSoap.ResponseWrapper wrapperInstance = 
            new LeadManipulatorServicesSoap.ResponseWrapper();
       
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
        LeadManipulatorServicesSoap.insertLeadManipulatorService('TestLead', 
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
    * when required field is missing using soap webservice.
    */
    static testMethod void testForLeadNotInsertedWhenRequiredFieldMissing() 
    {
        // Create the instance of the wrapper instance 
        LeadManipulatorServicesSoap.ResponseWrapper wrapperInstance = 
            new LeadManipulatorServicesSoap.ResponseWrapper();
       
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
        LeadManipulatorServicesSoap.insertLeadManipulatorService('TestLead', 
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
    * when required field is missing using soap webservice.
    */
    static testMethod void testForLeadNotInserted() 
    {
        // Create the instance of the wrapper instance 
        LeadManipulatorServicesSoap.ResponseWrapper wrapperInstance = 
            new LeadManipulatorServicesSoap.ResponseWrapper();
       
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
        LeadManipulatorServicesSoap.insertLeadManipulatorService('TestLead', 
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
    * soap webservice.
    */
    static testMethod void testForLeadUpdate() 
    {
        // Create the instance of the wrapper instance 
        LeadManipulatorServicesSoap.ResponseWrapper wrapperInstance = 
            new LeadManipulatorServicesSoap.ResponseWrapper();
       
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
        LeadManipulatorServicesSoap.insertLeadManipulatorService('TestLead', 
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
        LeadManipulatorServicesSoap.updateLeadManipulatorService('TestLead', 
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
    * when criteria does not match using soap webservice.
    */
    static testMethod void testForLeadNotUpdate() 
    {
        // Create the instance of the wrapper instance 
        LeadManipulatorServicesSoap.ResponseWrapper wrapperInstance = 
            new LeadManipulatorServicesSoap.ResponseWrapper();
       
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
        LeadManipulatorServicesSoap.insertLeadManipulatorService('TestLead', 
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
        LeadManipulatorServicesSoap.updateLeadManipulatorService('TestLead', 
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
    * soap webservice.
    */
    static testMethod void testForLeadDelete() 
    {
        // Create the instance of the wrapper instance 
        LeadManipulatorServicesSoap.ResponseWrapper wrapperInstance = 
            new LeadManipulatorServicesSoap.ResponseWrapper();
       
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
        LeadManipulatorServicesSoap.insertLeadManipulatorService('TestLead', 
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
        LeadManipulatorServicesSoap.deleteLeadManipulatorService('TestLead', 
                                                                 'Data', 
                                                                 'testLead@testdata.com',
                                                                 '1234567890'
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
                    Email = 'testLead@testdata.com'
                AND 
                    Phone = '1234567890'
            ];
        
        // Check if the record is updated or not 
        System.assertEquals(0,leadInstanceList.size());
    }
    
   /**
    * This is a method that will test the functionality to check whether lead record is deleted 
    * when criteria does not match using soap webservice.
    */
    static testMethod void testForLeadNotDeleted() 
    {
        // Create the instance of the wrapper instance 
        LeadManipulatorServicesSoap.ResponseWrapper wrapperInstance = 
            new LeadManipulatorServicesSoap.ResponseWrapper();
       
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
        LeadManipulatorServicesSoap.insertLeadManipulatorService('TestLead', 
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
        LeadManipulatorServicesSoap.deleteLeadManipulatorService('TestLead', 
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
                    Email = 'testLead@testdata.com'
                AND 
                    Phone = '1234567890'
            ];
        
        // Check if the record is updated or not 
        System.assertEquals(1,leadInstanceList.size());
    }
}