/**
 * This is a method that will test the inbound emails. Whether the email is send back to the sender 
 * if any exception is caused or if he specifies the query in wrong format or not. It checks if 
 * contact is already present in the org ,if not new contact is added.
 */
@isTest
private class TestClassForEmailService 
{
    
   /**
    * This is the test method that will check if the contact is inserted if the sender is not 
    * already present contact in the org.
    */
    static testMethod void testForContactInserted() 
    {
        
        // Create an instance of the inbound email
        Messaging.InboundEmail email = new Messaging.InboundEmail();
        
        // Create an instance of the inbound envelope
        Messaging.InboundEnvelope envelopeInstance = new Messaging.InboundEnvelope();
     
        // Assign the subject
        email.subject = 'test';
        
        // Assign the from address
        email.fromAddress = 'test@123.com';
        
        // Assign the from name
        email.fromName = 'test';
        
        // Assign the body
        email.plainTextBody = '(test)';
      
        // Create the instance of class
        GoobleForceEmailService emailServiceObj = new GoobleForceEmailService();
        
        // Fetch the contact
        List<Contact> contactInstance = 
            [
                SELECT
                    Id
                FROM
                    Contact
                WHERE
                    Email = :email.fromAddress
            ];
        
        // Check if the contact is inserted or not 
        System.assertEquals(0,contactInstance.size());
        
        // Start the test
        Test.startTest();
        
        // Call the set mock test
        Test.setMock(HttpCalloutMock.class, new TestForGoobleMockCallOut());
        
        // Call method with parameters as email and envelope
        emailServiceObj.handleInboundEmail(email, envelopeInstance);
        
        // Stop the test
        Test.stopTest();
        
        // Create the instance of the contact
        contactInstance = 
            [
                SELECT
                    Id
                FROM
                    Contact
                WHERE
                    Email = :email.fromAddress
            ];
        // Check if the contact is inserted or not 
        System.assertEquals(1, contactInstance.size());
    }
    
   /**
    * This is the test method that will check if the contact is not inserted if the sender is not 
    * already present contact in the org.
    */
    static testMethod void testForContactNotInserted() 
    {
        
        // Call the set mock test
        Test.setMock(HttpCalloutMock.class, new TestForGoobleMockCallOut());
        
        // Create an instance of the inbound email
        Messaging.InboundEmail email = new Messaging.InboundEmail();
        
        // Create an instance of the inbound envelope
        Messaging.InboundEnvelope envelopeInstance = new Messaging.InboundEnvelope();
     
        // Assign the subject
        email.subject = 'test';
        
        // Assign the from address
        email.fromAddress = 'test@123.com';
        
        // Assign the body
        email.plainTextBody = '(test)';
      
        // Create the instance of class
        GoobleForceEmailService emailServiceObj = new GoobleForceEmailService();
        
        // Fetch the contact
        List<Contact> contactInstance = 
            [
                SELECT
                    Id
                FROM
                    Contact
                WHERE
                    Email = :email.fromAddress
            ];
        // Check if the contact is inserted or not 
        System.assertEquals(0, contactInstance.size());
        
        // Start the test
        Test.startTest();
        
        // Call method with parameters as email and envelope
        emailServiceObj.handleInboundEmail(email, envelopeInstance);
        
        // Stop the test
        Test.stopTest();
        
        // Create the instance of the contact
        contactInstance = 
            [
                SELECT
                    Id
                FROM
                    Contact
                WHERE
                    Email = :email.fromAddress
            ];
        // Check if the contact is inserted or not 
        System.assertEquals(0, contactInstance.size());
    }
    
   /**
    * This is the test method that will check if the contact is already present in the org.
    */
    static testMethod void testForContactAlreadyPresent() 
    {
        
        // Call the set mock test
        Test.setMock(HttpCalloutMock.class, new TestForGoobleMockCallOut());

        // Create an instance of the inbound email
        Messaging.InboundEmail email = new Messaging.InboundEmail();
        
        // Create an instance of the inbound envelope
        Messaging.InboundEnvelope envelopeInstance = new Messaging.InboundEnvelope();
     
        // Assign the subject
        email.subject = 'test';
        
        // Assign the from address
        email.fromAddress = 'test@123.com';
        
        // Assign the body
        email.plainTextBody = '(test)';
        
        // Create the contact instance
        Contact contactInstance = new Contact(LastName = 'test',Email= 'test@123.com');
        
        // Insert the contact
        insert contactInstance;
        
        // Check contact is inserted or not
        System.assert(String.isNotBlank(contactInstance.Id));
        
        // Create the instance of class
        GoobleForceEmailService emailServiceObj = new GoobleForceEmailService();
        
        // Fetch the contact
        List<Contact> contactList = 
            [
                SELECT
                    Id
                FROM
                    Contact
                WHERE
                    Email = :email.fromAddress
            ];
            
        // Check if the contact is inserted or not 
        System.assertEquals(1, contactList.size());
        
        // Start the test
        Test.startTest();
        
        // Call method with parameters as email and envelope
        emailServiceObj.handleInboundEmail(email, envelopeInstance);
        
        // Stop the test
        Test.stopTest();
        
        // Create the instance of the contact
        contactList = 
            [
                SELECT
                    Id
                FROM
                    Contact
                WHERE
                    Email = :email.fromAddress
            ];
        // Check if the contact is inserted or not 
        System.assertEquals(1, contactList.size());
    }
    
   /**
    * This is the test method that will check if the email is inserted if the sender has send the 
    * query in appropriate format. 
    */
    static testMethod void testForEmailInserted() 
    {
        
        // Create an instance of the inbound email
        Messaging.InboundEmail email = new Messaging.InboundEmail();
        
        // Create an instance of the inbound envelope
        Messaging.InboundEnvelope envelopeInstance = new Messaging.InboundEnvelope();
     
        // Assign the subject
        email.subject = 'test';
        
        // Assign the from address
        email.fromAddress = 'test@123.com';
        
        // Assign the from name
        email.fromName = 'test';
        
        // Assign the body
        email.plainTextBody = '(test)';
      
        // Create the instance of class
        GoobleForceEmailService emailServiceObj = new GoobleForceEmailService();
        
        // Fetch the contact 
        List<Contact> contactInstance = 
            [
                SELECT
                    Id
                FROM
                    Contact
                WHERE
                    Email = :email.fromAddress
            ];
        // Check if the contact is inserted or not 
        System.assertEquals(0,contactInstance.size());
        
        // Fetch the email 
        List<Email__c> emailList = 
            [
                SELECT
                    Id
                FROM
                    Email__c
                WHERE
                    Subject__c = :'test'
            ];

        // Check if the contact is inserted or not 
        System.assertEquals(0,emailList.size());
        
        // Start the test
        Test.startTest();
        
        // Call the set mock test
        Test.setMock(HttpCalloutMock.class, new TestForGoobleMockCallOut());
        
        // Call method with parameters as email and envelope
        emailServiceObj.handleInboundEmail(email, envelopeInstance);
        
        // Stop the test
        Test.stopTest();
        
        // Create the instance of the contact
        contactInstance = 
            [
                SELECT
                    Id
                FROM
                    Contact
                WHERE
                    Email = :email.fromAddress
            ];

        // Check if the contact is inserted or not 
        System.assertEquals(1,contactInstance.size());
        
        // Fetch the email 
        emailList = 
            [
                SELECT
                    Id
                FROM
                    Email__c
                WHERE
                    Subject__c = :'test'
            ];

        // Check if the contact is inserted or not 
        System.assertEquals(1,emailList.size());
    }
    
   /**
    * This is the test method that will check if the email is not inserted if the sender has 
    * not send the query in appropriate format. 
    */
    static testMethod void testForEmailNotInserted() 
    {
        
        // Create an instance of the inbound email
        Messaging.InboundEmail email = new Messaging.InboundEmail();
        
        // Create an instance of the inbound envelope
        Messaging.InboundEnvelope envelopeInstance = new Messaging.InboundEnvelope();
     
        // Assign the subject
        email.subject = 'test';
        
        // Assign the from address
        email.fromAddress = 'test@123.com';
        
        // Assign the from name
        email.fromName = 'test';
        
        // Assign the body
        email.plainTextBody = '';
        
        // Create the instance of the inbound email results
        Messaging.InboundEmailResult result = new Messaging.InboundEmailresult();
        
        // Create the instance of class
        GoobleForceEmailService emailServiceObj = new GoobleForceEmailService();
        
        // Fetch the contact 
        List<Contact> contactInstance = 
            [
                SELECT
                    Id
                FROM
                    Contact
                WHERE
                    Email = :email.fromAddress
            ];

        // Check if the contact is inserted or not 
        System.assertEquals(0,contactInstance.size());
        
        // Fetch the email 
        List<Email__c> emailList = 
            [
                SELECT
                    Id
                FROM
                    Email__c
                WHERE
                    Subject__c = :'test'
            ];

        // Check if the contact is inserted or not 
        System.assertEquals(0,emailList.size());
        
        // Start the test
        Test.startTest();
        
        // Call the set mock test
        Test.setMock(HttpCalloutMock.class, new TestForGoobleMockCallOut());
        
        // Call method with parameters as email and envelope
        result = emailServiceObj.handleInboundEmail(email, envelopeInstance);
        
        // Stop the test
        Test.stopTest();
        
        // Create the instance of the contact
        contactInstance = 
            [
                SELECT
                    Id
                FROM
                    Contact
                WHERE
                    Email = :email.fromAddress
            ];

        // Check if the contact is inserted or not 
        System.assertEquals(1, contactInstance.size());
        
        // Fetch the email 
        emailList = 
            [
                SELECT
                    Id
                FROM
                    Email__c
                WHERE
                    Subject__c = :'test'
            ];

        // Check if the email is inserted or not 
        System.assertEquals(0, emailList.size());
        
        // Check if the email is inserted or not 
        System.assertEquals(false, result.success);
        
        // Check if the email is inserted or not 
        System.assertEquals('Please specify the query in proper format.\nFor Example : '
             + ' (Your Query) \n \n'+ 'Thank you for your request' 
             + 'We are happy to serve you.',result.message);
    }
    
   /**
    * This is the test method that will check if the query is inserted if the sender has send the 
    * query in appropriate format. 
    */
    static testMethod void testForQueryInserted() 
    {
        
        // Create an instance of the inbound email
        Messaging.InboundEmail email = new Messaging.InboundEmail();
        
        // Create an instance of the inbound envelope
        Messaging.InboundEnvelope envelopeInstance = new Messaging.InboundEnvelope();
     
        // Assign the subject
        email.subject = 'test';
        
        // Assign the from address
        email.fromAddress = 'test@123.com';
        
        // Assign the from name
        email.fromName = 'test';
        
        // Assign the body
        email.plainTextBody = '(test)';
      
        // Create the instance of class
        GoobleForceEmailService emailServiceObj = new GoobleForceEmailService();
        
        // Fetch the contact 
        List<Contact> contactInstance = 
            [
                SELECT
                    Id
                FROM
                    Contact
                WHERE
                    Email = :email.fromAddress
            ];

        // Check if the contact is inserted or not 
        System.assertEquals(0, contactInstance.size());
        
        // Fetch the email 
        List<Email__c> emailList = 
            [
                SELECT
                    Id
                FROM
                    Email__c
                WHERE
                    Subject__c = :'test'
            ];

        // Check if the contact is inserted or not 
        System.assertEquals(0, emailList.size());
        
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
        
        // Start the test
        Test.startTest();

        // Call the set mock test
        Test.setMock(HttpCalloutMock.class, new TestForGoobleMockCallOut());
        
        // Call method with parameters as email and envelope
        emailServiceObj.handleInboundEmail(email, envelopeInstance);
        
        // Stop the test
        Test.stopTest();
        
        // Create the instance of the contact
        contactInstance = 
            [
                SELECT
                    Id
                FROM
                    Contact
                WHERE
                    Email = :email.fromAddress
            ];

        // Check if the contact is inserted or not 
        System.assertEquals(1, contactInstance.size());
        
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
    }
    
   /**
    * This is the test method that will check if the queryforcontact is inserted if the sender 
    * has send the query in appropriate format. 
    */
    static testMethod void testForQueryForContactInserted() 
    {
        
        // Create an instance of the inbound email
        Messaging.InboundEmail email = new Messaging.InboundEmail();
        
        // Create an instance of the inbound envelope
        Messaging.InboundEnvelope envelopeInstance = new Messaging.InboundEnvelope();

        // Assign the subject
        email.subject = 'test';
        
        // Assign the from address
        email.fromAddress = 'test@123.com';

        // Assign the from name
        email.fromName = 'test';
        
        // Assign the body
        email.plainTextBody = '(test)';
        
        // Create the instance of class
        GoobleForceEmailService emailServiceObj = new GoobleForceEmailService();
        
        // Fetch the contact 
        List<Contact> contactInstance = 
            [
                SELECT
                    Id
                FROM
                    Contact
                WHERE
                    Email = :email.fromAddress
            ];

        // Check if the contact is inserted or not 
        System.assertEquals(0, contactInstance.size());
        
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
        
        // Start the test
        Test.startTest();
        // Call the set mock test
        Test.setMock(HttpCalloutMock.class, new TestForGoobleMockCallOut());

        // Call method with parameters as email and envelope
        emailServiceObj.handleInboundEmail(email, envelopeInstance);
        
        // Stop the test
        Test.stopTest();
        
        // Create the instance of the contact
        contactInstance = 
            [
                SELECT
                    Id
                FROM
                    Contact
                WHERE
                    Email = :email.fromAddress
            ];

        // Check if the contact is inserted or not 
        System.assertEquals(1, contactInstance.size());
        
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

        // Check if the query is inserted or not 
        System.assertEquals(1, queryList.size());
        
        // Fetch the queryforcontact 
       List<QueryForContact__c> queryForContactList = 
            [
                SELECT
                    Id
                FROM
                    QueryForContact__c
                WHERE
                    QueryDetails__c = :queryList[0].Id
            ];
        // Check if the contact and query are inserted or not 
        System.assertEquals(1, queryForContactList.size());
    }
    
   /**
    * This is the test method that will check if the responses are generated if the sender 
    * has send the query in appropriate format. 
    */
    static testMethod void testForQueryWithResponse() 
    {
        
        // Create an instance of the inbound email
        Messaging.InboundEmail email = new Messaging.InboundEmail();
        
        // Create an instance of the inbound envelope
        Messaging.InboundEnvelope envelopeInstance = new Messaging.InboundEnvelope();

        // Assign the subject
        email.subject = 'test';
        
        // Assign the from address
        email.fromAddress = 'test@123.com';

        // Assign the from name
        email.fromName = 'test response';
        
        // Assign the body
        email.plainTextBody = '(test)';
        
        // Create the instance of class
        GoobleForceEmailService emailServiceObj = new GoobleForceEmailService();
        
        // Fetch the contact 
        List<Contact> contactInstance = 
            [
                SELECT
                    Id
                FROM
                    Contact
                WHERE
                    Email = :email.fromAddress
            ];

        // Check if the contact is inserted or not 
        System.assertEquals(0,contactInstance.size());
        
        // Fetch the responses 
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
        
        // Fetch the response 
        List<Response__c> responseList = 
            [
                SELECT
                    Id
                FROM
                    Response__c
            ];
            
        // Check if the contact is inserted or not 
        System.assertEquals(0,responseList.size());
        
        // Start the test
        Test.startTest();
        
        // Call the set mock test
        Test.setMock(HttpCalloutMock.class, new TestForGoobleMockCallOut());

        // Call method with parameters as email and envelope
        emailServiceObj.handleInboundEmail(email, envelopeInstance);
        
        // Stop the test
        Test.stopTest();
        
        // Create the instance of the contact
        contactInstance = 
            [
                SELECT
                    Id,
                    Email
                FROM
                    Contact
                WHERE
                    Email = :email.fromAddress
            ];

        // Check if the contact is inserted or not 
        System.assertEquals(1,contactInstance.size());
        
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

        // Check if the query is inserted or not 
        System.assertEquals(1, queryList.size());
        
        // Fetch the response 
        responseList = 
            [
                SELECT
                    Id
                FROM
                    Response__c
                WHERE
                    Search_Query__c = :queryList[0].Id
            ];

        // Check if the responses are generated or not 
        System.assertNotEquals(0, responseList.size());
    }
    
    /**
    * This is the test method that will check if the responses are generated if the sender 
    * has send the query in appropriate format. 
    */
    static testMethod void testForCornerCaseQueryWithResponse() 
    {
        
        // Create an instance of the inbound email
        Messaging.InboundEmail email = new Messaging.InboundEmail();
        
        // Create an instance of the inbound envelope
        Messaging.InboundEnvelope envelopeInstance = new Messaging.InboundEnvelope();

        // Assign the subject
        email.subject = 'test';
        
        // Assign the from address
        email.fromAddress = 'test@123.com';

        // Assign the from name
        email.fromName = 'test response';
        
        // Assign the body
        email.plainTextBody = '(test(For)(CornerCase))';
        
        // Create the instance of class
        GoobleForceEmailService emailServiceObj = new GoobleForceEmailService();
        
        // Fetch the contact 
        List<Contact> contactInstance = 
            [
                SELECT
                    Id
                FROM
                    Contact
                WHERE
                    Email = :email.fromAddress
            ];

        // Check if the contact is inserted or not 
        System.assertEquals(0, contactInstance.size());
        
        // Fetch the responses 
        List<Query__c> queryList = 
            [
                SELECT
                    Id
                FROM
                    Query__c
                WHERE
                    Query_Field__c = :'test For CornerCase'
            ];
            
        // Check if the contact is inserted or not 
        System.assertEquals(0,queryList.size());
        
        // Fetch the response 
        List<Response__c> responseList = 
            [
                SELECT
                    Id
                FROM
                    Response__c
            ];
            
        // Check if the contact is inserted or not 
        System.assertEquals(0, responseList.size());
        
        // Start the test
        Test.startTest();
        
        // Call the set mock test
        Test.setMock(HttpCalloutMock.class, new TestForGoobleMockCallOut());

        // Call method with parameters as email and envelope
        emailServiceObj.handleInboundEmail(email, envelopeInstance);
        
        // Stop the test
        Test.stopTest();
        
        // Create the instance of the contact
        contactInstance = 
            [
                SELECT
                    Id,
                    Email
                FROM
                    Contact
                WHERE
                    Email = :email.fromAddress
            ];

        // Check if the contact is inserted or not 
        System.assertEquals(1, contactInstance.size());
        
        // Fetch the query 
        queryList = 
            [
                SELECT
                    Id
                FROM
                    Query__c
                WHERE
                    Query_Field__c = :'test For CornerCase'
            ];

        // Check if the query is inserted or not 
        System.assertEquals(1, queryList.size());
        
        // Fetch the response 
        responseList = 
            [
                SELECT
                    Id
                FROM
                    Response__c
                WHERE
                    Search_Query__c = :queryList[0].Id
            ];

        // Check if the responses are generated or not 
        System.assertNotEquals(0, responseList.size());
    }
    
    
   /**
    * This is the test method that will check if the no responses are generated if the sender 
    * has send the query in appropriate format. 
    */
    static testMethod void testForNoResultsFoundForQuery() 
    {
        
        // Create an instance of the inbound email
        Messaging.InboundEmail email = new Messaging.InboundEmail();
        
        // Create an instance of the inbound envelope
        Messaging.InboundEnvelope envelopeInstance = new Messaging.InboundEnvelope();

        // Assign the subject
        email.subject = 'test';
        
        // Assign the from address
        email.fromAddress = 'test@123.com';

        // Assign the from name
        email.fromName = 'test response';
        
        // Assign the body
        email.plainTextBody = '(gafgasiciahiohaichaohoaaffsgsga)';
        
        // Create the instance of class
        GoobleForceEmailService emailServiceObj = new GoobleForceEmailService();
        
        // Fetch the contact 
        List<Contact> contactInstance = 
            [
                SELECT
                    Id
                FROM
                    Contact
                WHERE
                    Email = :email.fromAddress
            ];

        // Check if the contact is inserted or not 
        System.assertEquals(0, contactInstance.size());
        
        // Fetch the responses 
        List<Query__c> queryList = 
            [
                SELECT
                    Id
                FROM
                    Query__c
                WHERE
                    Query_Field__c = :'gafgasiciahiohaichaohoaaffsgsga'
            ];
            
        // Check if the contact is inserted or not 
        System.assertEquals(0, queryList.size());
        
        // Fetch the response 
        List<Response__c> responseList = 
            [
                SELECT
                    Id
                FROM
                    Response__c
            ];
            
        // Check if the contact is inserted or not 
        System.assertEquals(0, responseList.size());
        
        // Start the test
        Test.startTest();
        
        // Call the set mock test
        Test.setMock(HttpCalloutMock.class, new TestGoogleMockCallOutWithNoResponse()); 

        // Call method with parameters as email and envelope
        emailServiceObj.handleInboundEmail(email, envelopeInstance);
        
        // Stop the test
        Test.stopTest();
        
        // Create the instance of the contact
        contactInstance = 
            [
                SELECT
                    Id,
                    Email
                FROM
                    Contact
                WHERE
                    Email = :email.fromAddress
            ];

        // Check if the contact is inserted or not 
        System.assertEquals(1, contactInstance.size());
        
        // Fetch the query 
        queryList = 
            [
                SELECT
                    Id
                FROM
                    Query__c
                WHERE
                    Query_Field__c = :'gafgasiciahiohaichaohoaaffsgsga'
            ];

        // Check if the query is inserted or not 
        System.assertEquals(1, queryList.size());
        
        // Fetch the response 
        responseList = 
            [
                SELECT
                    Id,
                    Description__c
                FROM
                    Response__c
                WHERE
                    Search_Query__c = :queryList[0].Id
            ];

        // Check if the responses are generated or not 
        System.assertEquals(0, responseList.size());
    }
    
   /**
    * This is the test method that will check if the responses is generated if the sender 
    * has send the query inappropriate format. 
    */
    static testMethod void testForQueryWithNoResponseGenerated() 
    {

        // Create an instance of the inbound email
        Messaging.InboundEmail email = new Messaging.InboundEmail();
        
        // Create an instance of the inbound envelope
        Messaging.InboundEnvelope envelopeInstance = new Messaging.InboundEnvelope();

        // Assign the subject
        email.subject = 'test';
        
        // Assign the from address
        email.fromAddress = 'test@123.com';

        // Assign the from name
        email.fromName = 'test response';
        
        // Assign the body
        email.plainTextBody = 'test';
        
        // Create the instance of class
        GoobleForceEmailService emailServiceObj = new GoobleForceEmailService();
        
        // Fetch the contact 
        List<Contact> contactInstance = 
            [
                SELECT
                    Id
                FROM
                    Contact
                WHERE
                    Email = :email.fromAddress
            ];

        // Check if the contact is inserted or not 
        System.assertEquals(0, contactInstance.size());
        
        // Fetch the responses 
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
        
        // Fetch the response 
        List<Response__c> responseList = 
            [
                SELECT
                    Id
                FROM
                    Response__c
            ];
            
        // Check if the contact is inserted or not 
        System.assertEquals(0, responseList.size());
        
        // Start the test
        Test.startTest();
        
        // Call the set mock test
        Test.setMock(HttpCalloutMock.class, new TestForGoobleMockCallOut());
        
        // Call method with parameters as email and envelope
        emailServiceObj.handleInboundEmail(email, envelopeInstance);
        
        // Stop the test
        Test.stopTest();
        
        // Create the instance of the contact
        contactInstance = 
            [
                SELECT
                    Id,
                    Email
                FROM
                    Contact
                WHERE
                    Email = :email.fromAddress
            ];

        // Check if the contact is inserted or not 
        System.assertEquals(1, contactInstance.size());
        
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
        // Check if the query is inserted or not 
        System.assertEquals(0, queryList.size());
        
        // Fetch the response 
        responseList = 
            [
                SELECT
                    Id
                FROM
                    Response__c
            ];
            
        // Check if the responses are generated or not 
        System.assertEquals(0, responseList.size());
    }
    
   /**
    * This is the test method that will check if the responses is generated if the sender 
    * has send the query is blank. 
    */
    static testMethod void testForQueryIsBlank() 
    {
        // Create an instance of the inbound email
        Messaging.InboundEmail email = new Messaging.InboundEmail();
        
        // Create an instance of the inbound envelope
        Messaging.InboundEnvelope envelopeInstance = new Messaging.InboundEnvelope();

        // Assign the subject
        email.subject = 'test';
        
        // Assign the from address
        email.fromAddress = 'test@123.com';

        // Assign the from name
        email.fromName = 'test response';
        
        // Assign the body
        email.plainTextBody = '()';
        
        // Create the instance of class
        GoobleForceEmailService emailServiceObj = new GoobleForceEmailService();
        
        // Fetch the contact 
        List<Contact> contactInstance = 
            [
                SELECT
                    Id
                FROM
                    Contact
                WHERE
                    Email = :email.fromAddress
            ];
        // Check if the contact is inserted or not 
        System.assertEquals(0, contactInstance.size());
        
        // Fetch the responses 
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
        
        // Fetch the response 
        List<Response__c> responseList = 
            [
                SELECT
                    Id
                FROM
                    Response__c
            ];
            
        // Check if the contact is inserted or not 
        System.assertEquals(0, responseList.size());
        
        // Start the test
        Test.startTest();

        // Call the set mock test for lead creation
        Test.setMock(HttpCalloutMock.class, new TestForGoobleMockCallOut());
        
        // Call method with parameters as email and envelope
        emailServiceObj.handleInboundEmail(email, envelopeInstance);
        
        // Stop the test
        Test.stopTest();
        
        // Create the instance of the contact
        contactInstance = 
            [
                SELECT
                    Id,
                    Email
                FROM
                    Contact
                WHERE
                    Email = :email.fromAddress
            ];

        // Check if the contact is inserted or not 
        System.assertEquals(1, contactInstance.size());
        
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

        // Check if the query is inserted or not 
        System.assertEquals(0,queryList.size());
        
        // Fetch the response 
        responseList = 
            [
                SELECT
                    Id
                FROM
                    Response__c
            ];
            
        // Check if the responses are generated or not 
        System.assertEquals(0, responseList.size());
    }
    
   /**
    * This is the test method that will check if the responses are appended if the sender 
    * has send the query that already exist in the org. 
    */
    static testMethod void testForQueryForResponseAppended() 
    {

         // Create the instance of the query
        Query__c queryInstance = new Query__c(Query_Field__c = 'Test');
        
        List<Query__c> checkQueryList = 
            [
                SELECT
                    Id
                FROM
                    Query__c
            ];
        
        // Check for the size of the querylist
        System.assertEquals(0, checkQueryList.size());
        
        // Insert the queryInstance
        insert queryInstance;
        
        checkQueryList = 
            [
                SELECT
                    Id
                FROM
                    Query__c
                WHERE
                    Query_Field__c = 'Test'
            ];
        
        // Check for the size of the querylist
        System.assertEquals(1,checkQueryList.size());
        
        // Create the instance of the response
        Response__c responseInstance = new Response__c(
            Description__c = 'Test Description',
            Search_Query__c = queryInstance.Id,
            Title__c = 'Speedtest.net by Ookla - The Global Broadband Speed Test',
            Links__c = 'Test Link'
        );
        
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
        
        // Insert the queryInstance
        insert responseInstance;
        
        // Fetch the response list
        checkResponseList = 
            [
                SELECT
                    Id
                FROM
                    Response__c
                WHERE
                    Title__c = :'Speedtest.net by Ookla - The Global Broadband Speed Test'
            ];
        
        // Check for the records inserted or not.
        System.assertEquals(1, checkResponseList.size());
        
        // Create a instance of the inbound email
        Messaging.InboundEmail email = new Messaging.InboundEmail();
        
        // Create a instance of the inbound envelope
        Messaging.InboundEnvelope envelopeInstance = new Messaging.InboundEnvelope();

        // Assign the subject
        email.subject = 'test';
        
        // Assign the from address
        email.fromAddress = 'test@123.com';

        // Assign the from name
        email.fromName = 'test response';
        
        // Assign the body
        email.plainTextBody = '(test)';
        
        // Create the instance of class
        GoobleForceEmailService emailServiceObj = new GoobleForceEmailService();
        
        // Fetch the contact 
        List<Contact> contactInstance = 
            [
                SELECT
                    Id
                FROM
                    Contact
                WHERE
                    Email = :email.fromAddress
            ];
        // Check if the contact is inserted or not 
        System.assertEquals(0, contactInstance.size());
        
        // Fetch the responses 
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
        System.assertEquals(1, queryList.size());
        
        // Fetch the response 
        List<Response__c> responseList = 
            [
                SELECT
                    Id
                FROM
                    Response__c
            ];
            
        // Check if the contact is inserted or not 
        System.assertEquals(1, responseList.size());
        

                                                      
        // Call the set mock test
        Test.setMock(HttpCalloutMock.class, new TestForGoobleMockCallOut());
        // Start the test
        Test.startTest();
        
        // Call method with parameters as email and envelope
        emailServiceObj.handleInboundEmail(email, envelopeInstance);
        
        // Stop the test
        Test.stopTest();
        
        // Create the instance of the contact
        contactInstance = 
            [
                SELECT
                    Id,
                    Email
                FROM
                    Contact
                WHERE
                    Email = :email.fromAddress
            ];

        // Check if the contact is inserted or not 
        System.assertEquals(1, contactInstance.size());
        
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
        // Check if the query is inserted or not 
        System.assertEquals(1, queryList.size());
        
        // Fetch the response 
        responseList = 
            [
                SELECT
                    Id,title__c
                FROM
                    Response__c
                WHERE
                    Search_Query__c = :queryList[0].Id
            ];
            system.debug(responseList[1].title__c);

        // Check if the responses are generated or not 
        System.assertEquals(3, responseList.size());
        
    }
    
   /**
    * This is the test method that will check if the same query is repeated
    */
    static testMethod void testForQueryIsRepeted() 
    {
        // Create an instance of the inbound email
        Messaging.InboundEmail email = new Messaging.InboundEmail();
        
        // Create an instance of the inbound envelope
        Messaging.InboundEnvelope envelopeInstance = new Messaging.InboundEnvelope();

        // Assign the subject
        email.subject = 'test';
        
        // Assign the from address
        email.fromAddress = 'test@123.com';

        // Assign the from name
        email.fromName = 'test response';
        
        // Assign the body
        email.plainTextBody = '(test)';
        
        // Create the instance of class
        GoobleForceEmailService emailServiceObj = new GoobleForceEmailService();
        
        // Fetch the contact 
        List<Contact> contactInstance = 
            [
                SELECT
                    Id
                FROM
                    Contact
                WHERE
                    Email = :email.fromAddress
            ];

        // Check if the contact is inserted or not 
        System.assertEquals(0, contactInstance.size());
        
        Query__c queryInstance = new Query__c(Query_Field__c = 'test' );
        
        insert queryInstance;
        
        // Fetch the responses 
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
        System.assertEquals(1, queryList.size());
        
        // Fetch the response 
        List<Response__c> responseList = 
            [
                SELECT
                    Id
                FROM
                    Response__c
            ];
            
        // Check if the contact is inserted or not 
        System.assertEquals(0, responseList.size());
        
        // Start the test
        Test.startTest();

        // Call the set mock test for lead creation
        Test.setMock(HttpCalloutMock.class, new TestForGoobleMockCallOut());
        
        // Call method with parameters as email and envelope
        emailServiceObj.handleInboundEmail(email, envelopeInstance);
        
        // Stop the test
        Test.stopTest();
        
        // Create the instance of the contact
        contactInstance = 
            [
                SELECT
                    Id,
                    Email
                FROM
                    Contact
                WHERE
                    Email = :email.fromAddress
            ];
            
        // Check if the contact is inserted or not 
        System.assertEquals(1, contactInstance.size());
        
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

        // Check if the query is inserted or not 
        System.assertEquals(1, queryList.size());
        
        // Fetch the response 
        responseList = 
            [
                SELECT
                    Id
                FROM
                    Response__c
            ];
            
        // Check if the responses are generated or not 
        System.assertNotEquals(0, responseList.size());
    }
}
