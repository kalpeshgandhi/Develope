/**
 * This is a class that will have the test method for checking the functionality of
 * various Soql and Sosl queries.
 */
@isTest
private class TestForSoqlAndSosl 
{
   /**
    *  Method to test query on all Contact records and add them to the list. 
    */
    static testMethod void testForContacts() 
    {
        // Initialize the list to create the data.
        List<Contact> contactList = TestDataFactory.contactTestData(10);
        
        // Check the list size.
        System.assertEquals(10,contactList.size());
        
        // Start the test
        Test.startTest();
        
        // Insert the contact list
        insert contactList;
       
        // Fetch the records.
        List<Contact> contactListInstance=
           [
               SELECT 
                   Id,
                   Name
               FROM
                   Contact
               WHERE
                   Name LIKE 'testContact%'
           ];
           
        
        // Check If the record is inserted or not.
        System.assertEquals(10, contactListInstance.size()); 
        
        // Create the Instance of the class
        SimpleSOQLQuery contactInstance = new SimpleSOQLQuery();
        
        // Compare the list size and the returned size.
        System.assertEquals(contactListInstance.size(),contactInstance.printContactList());
        
        // Stop the test
        Test.stopTest();
    }
    
   /**
    * This is a method that will test Account id as a key and entire account object as value.
    */
    static testMethod void testMapRecordsWithAccountStringAndAccountId()
    {
        // Initialize the list to create the data.
        List<Account> accountList = TestDataFactory.accountTestData(3);
        
         // Check the list size.
        System.assertEquals(3,accountList.size());
        
        // Start the test.
        Test.startTest();
        
        // Insert the account list.
        insert accountList;
        
        // Fetch the records.
        List<Account> accountListInstance=
           [
               SELECT 
                   Id,
                   Name
               FROM
                   Account
               WHERE
                   Name LIKE 'TestAccount%'
           ];
           
        // Check If the record is inserted or not.
        System.assertEquals(3, accountListInstance.size()); 
        
        
        // Create the Instance of the map with the String as a Key and Id as a Value.
        Map<String, Id> accountNameWithAccountIdMapInstance = new Map<String, Id>();
        
        // Iterate over the account list. 
        for (Account accountInstance : accountListInstance ) 
        {
            // Add the values to the map.
            accountNameWithAccountIdMapInstance.put(accountInstance.Name, accountInstance.Id); 
        }
        
        // Create the Instance of the class.
        DisplayTheMapStructure mapInstance = new DisplayTheMapStructure();
        
        // Compare the size of the map and the returned size of the map.
        System.assertEquals(accountNameWithAccountIdMapInstance.size(), mapInstance.mapOfAccountNameAndAccountId().size()); 
        
        
        // Stop the test.
        Test.stopTest();   
    }
    
     static testMethod void testMapRecordsWithAccountIdAndAccount()
     {
        // Initialize the list to create the data.
        List<Account> accountList = TestDataFactory.accountTestData(3);
        
         // Check the list size.
        System.assertEquals(3,accountList.size());
        
        // Start the test.
        Test.startTest();
        
        // Insert the account list.
        insert accountList;
        
        // Fetch the records.
        List<Account> accountListInstance=
           [
               SELECT 
                   Id,
                   Name
               FROM
                   Account
               WHERE
                   Name LIKE 'TestAccount%'
           ];
           
        // Check If the record is inserted or not.
        System.assertEquals(3, accountListInstance.size()); 
        
        // Create the Instance of the map with the Id as a Key and Account as a Value.
        Map<Id, Account> accountIdWithAccountMapInstance = new Map<Id, Account>();
        
        // Iterate over the account list.
        for (Account accountInstance : accountListInstance )
        {
            accountIdWithAccountMapInstance.put(accountInstance.Id, accountInstance); 
        }
        
        // Create the Instance of the class.
        DisplayTheMapStructure mapInstance = new DisplayTheMapStructure();
        
       // Compare the size of the map and the returned size of the map.
        System.assertEquals(accountIdWithAccountMapInstance.size(), mapInstance.mapOfIdAndAccount().size());
     }
       
   /**
    *  This is a test Method to fetch all account records according to the 'Enrollment Year'.
    *  1) 2010
    */
    static testMethod void testAccountEnrollmentYear2010() 
    {
        // Initialize the list of account.
        List<Account> accountList = new List<Account>();
        
        // Iterate over the for loop.
        for (Integer i = 0; i <= 5; i++) 
        {
            
            Account accountInstanceTest = new Account(Name = 'TestAccount' + i,
                                                      Enrollment_Year__c = '2010'
                                                     );
            // Add the instance to the list.
            accountList.add(accountInstanceTest);
        }
        
        // Check the list size.
        System.assertEquals(6,accountList.size());
        
        // Start the Test
        Test.startTest();
        
        // Insert the account list.
        insert accountList;
        
        // Fetch the records.
        List<Account> accountListInstance=
           [
               SELECT 
                   Id,
                   Name
               FROM
                   Account
               WHERE
                   Name LIKE 'TestAccount%'
           ];
           
        // Check If the record is inserted or not.
        System.assertEquals(6, accountListInstance.size()); 
        
        // Create the Instance of the class
        SimpleSOQLQuery soqlInstance = new SimpleSOQLQuery();
        
        // Compare the size of the list and the returned size of the list.
        System.assertEquals(accountListInstance.size(), soqlInstance.checkEnrollmentYear2010().size());
 
        // Stop the test
        Test.stopTest();
    }
    
     /**
    *  This is a test Method to fetch all account records according to the 'Enrollment Year'.
    *  1) 2013 And 2014
    */
    static testMethod void testAccountEnrollmentYear2013and2014() 
    {
        // Initialize the list of account.
        List<Account> accountList = new List<Account>();
        
        // Iterate over the for loop.
        for (Integer i = 0; i <= 5; i++) 
        {
           // Create the records of type account
            Account accountInstanceTest = new Account(Name = 'TestAccount' + i,
                                                      Enrollment_Year__c = '2013;2014'
                                                     );
            // Add the instance to the list.
            accountList.add(accountInstanceTest);
        }
        
        // Check the list size.
        System.assertEquals(6,accountList.size());
        
        // Start the Test
        Test.startTest();
        
        // Insert the account list.
        insert accountList;
        
        // Fetch the records.
        List<Account> accountListInstance=
           [
               SELECT 
                   Id,
                   Name
               FROM
                   Account
               WHERE
                   Name LIKE 'TestAccount%'
           ];
           
        // Check If the record is inserted or not.
        System.assertEquals(6, accountListInstance.size()); 
        
        // Create the Instance of the class
        SimpleSOQLQuery soqlInstance = new SimpleSOQLQuery();
        
        // Compare the size of the list and the returned size of the list.
        System.assertEquals(accountList.size(), soqlInstance.checkEnrollmentYear20132014().size());
       
        // Stop the test
        Test.stopTest();
    }
    
    
   /**
    * This is a Test Method that fetches all Account records where 'Billing State' is 
    * not 'Maharashtra' and 'Kerala'.
    */
     static testMethod void fethAccountAccordingToBillingState() 
     {
         // Create the instance the list of account.
         List<Account> accountList = new List<Account>();
        
         // Initialize the list of account.
         List<Account> accountList2 = new List<Account>();
        
         // Iterate over the for loop.
         for (Integer i = 0; i<=5; i++) 
         {
             // Create the records of type account
             Account accountInstance = new Account(Name = 'TestAccount' + i,
                                                   BillingState__c = 'Gujrat'
                                                  );
             Account accountInstanceTest = new Account(Name = 'TestAccount' + i,
                                                       BillingState__c = 'Maharashtra'
                                                      );
             // Add the instance to the list.
             accountList.add(accountInstance);
             accountList.add(accountInstanceTest);
         }
        
         // Check the list size.
         System.assertEquals(12,accountList.size());
         
         // Start the Test
         Test.startTest();
        
         // Insert the account list.
         insert accountList;
         
         // Fetch the records.
         List<Account> accountListInstance=
           [
               SELECT 
                   Id,
                   Name
               FROM
                   Account
               WHERE
                   Name LIKE 'TestAccount%'
           ];
           
         // Check If the record is inserted or not.
         System.assertEquals(12, accountListInstance.size()); 
        
         // Create the Instance of the class
         SimpleSOQLQuery soqlInstance = new SimpleSOQLQuery();
         
         // Check result
         System.assertEquals(6, soqlInstance.billingStateNotMaharashtraOrKerala().size()); 
         
         // Stop the test
         Test.stopTest();
        
         
    }
    
    
    /**
    * This is a Test Method that fetches all Account records where 'Billing State' is 
    * in 'Maharashtra' and 'Kerala'.
    */
     static testMethod void fethAccountAccordingToBillingStateInMaharashtraAndKerala() 
     {
         // Create the instance the list of account.
         List<Account> accountList = new List<Account>();
        
         // Initialize the list of account.
         List<Account> accountList2 = new List<Account>();
        
         // Iterate over the for loop.
         for (Integer i = 0; i<=5; i++) 
         {
             // Create the records of type account
             Account accountInstance = new Account(Name = 'TestAccount' + i,
                                                   BillingState__c = 'Kerala'
                                                  );
             Account accountInstanceTest = new Account(Name = 'TestAccount' + i,
                                                       BillingState__c = 'Maharashtra'
                                                      );
             // Add the instance to the list.
             accountList.add(accountInstance);
             accountList.add(accountInstanceTest);
         }
         
         // Check the list size.
         System.assertEquals(12,accountList.size());
        
         // Start the Test
         Test.startTest();
        
         // Insert the account list.
         insert accountList;
        
         // Fetch the records.
         List<Account> accountListInstance=
           [
               SELECT 
                   Id,
                   Name
               FROM
                   Account
               WHERE
                   Name LIKE 'TestAccount%'
           ];
           
         // Check If the record is inserted or not.
         System.assertEquals(12, accountListInstance.size()); 
        
         // Stop the test
         Test.stopTest();
        
         // Create the Instance of the class
         SimpleSOQLQuery soqlInstance = new SimpleSOQLQuery();
         // Check result
         System.assertEquals(0, soqlInstance.billingStateNotMaharashtraOrKerala().size()); 
    }
    
     /**
    * This is a Test Method that fetches all Account records where 'Billing State' is not
    * in 'Maharashtra' and 'Kerala'.
    */
     static testMethod void fethAccountAccordingToBillingStateSuccessFull() 
     {
         // Create the instance the list of account.
         List<Account> accountList = new List<Account>();
        
         // Initialize the list of account.
         List<Account> accountList2 = new List<Account>();
        
         // Iterate over the for loop.
         for (Integer i = 0; i <= 5; i++) 
         {
             // Create the records of type account
             Account accountInstance = new Account(Name = 'TestAccount' + i,
                                                   BillingState__c = 'Gujrat'
                                                  );
             Account accountInstanceTest = new Account(Name = 'TestAccount' + i,
                                                       BillingState__c = 'Gujrat'
                                                      );
             // Add the instance to the list.
             accountList.add(accountInstance);
             accountList.add(accountInstanceTest);
         }
        
         // Check the list size.
         System.assertEquals(12,accountList.size());
         // Start the Test
         Test.startTest();
        
         // Insert the account list.
         insert accountList;
        
         // Fetch the records.
         List<Account> accountListInstance=
           [
               SELECT 
                   Id,
                   Name
               FROM
                   Account
               WHERE
                   Name LIKE 'TestAccount%'
           ];
           
         // Check If the record is inserted or not.
         System.assertEquals(12, accountListInstance.size()); 
        
         // Stop the test
         Test.stopTest();
        
         // Create the Instance of the class
         SimpleSOQLQuery soqlInstance = new SimpleSOQLQuery();
         // Check result
         System.assertEquals(12, soqlInstance.billingStateNotMaharashtraOrKerala().size()); 
    }
    
    
   /**
    *  Method to test SOQL query to display 100 opportunity records with amount greater than 10,000 
    *  order by created date. Skip first 50 records and include records from recycle bin. 
    */
    static testMethod void testOpportunities() 
    {
        // Create the instance the list of account.
        List<Opportunity> opportunityList = new List<Opportunity>();
        
        // Iterate over the loop for 100 times
        for (Integer i = 0; i < 100; i++) 
        {
            // Add the records of opportunity type.
            Opportunity opportunityInstance = new Opportunity(Name = 'Test' + i,
                                                              CloseDate = System.Today(),
                                                              StageName = 'Closed Won',
                                                              Amount  =  20000
                                                             );
            // Add the records to the list.
            opportunityList.add(opportunityInstance);    
        }
        
        // Check If the record is inserted or not.
        System.assertEquals(100, opportunityList.size()); 
        
        // Start the test
        Test.startTest();
        
        // Create instance of the class 
        SimpleSOQLQuery soqlInstance = new SimpleSOQLQuery();
        
        // Insert the opportunity List
        insert opportunityList;
        
        // Fetch the records.
        List<Opportunity> opportunityListInstance=
           [
               SELECT 
                   Id,
                   Name
               FROM
                   Opportunity
               WHERE
                   Name LIKE 'Test%'
           ];
           
         // Check If the record is inserted or not.
         System.assertEquals(100, opportunityListInstance.size()); 
        
        // Checks if the 5o records are not fetched only 50 is fetched
        System.assertEquals(50, soqlInstance.opportunityAmountGreaterThenTenthosand().size());
        
        // Stop the test
        Test.stopTest();
        
        
    }

   /**
    *  Method to test SOQL query to display 100 opportunity records with amount greater than 10,000 
    *  order by created date. Skip first 50 records and include records from recycle bin. 
    */
    static testMethod void testOpportunitiesLessThenRequiredAmount() 
    {
        // Create the instance the list of account.
        List<Opportunity> opportunityList = new List<Opportunity>();
        
        // Iterate over the loop for 50 times
        for (Integer i = 0; i < 100; i++) 
        {
            // Add the records of opportunity type.
            Opportunity opportunityInstance = new Opportunity(Name = 'Test' + i,
                                                              CloseDate = System.Today(),
                                                              StageName = 'Closed Won',
                                                              Amount  =  5000
                                                             );
            // Add the records to the list.
            opportunityList.add(opportunityInstance);    
        }
        
        // Check If the record is inserted or not.
        System.assertEquals(100, opportunityList.size()); 
        
        // Start the test
        Test.startTest();
        
        // Create instance of the class 
        SimpleSOQLQuery soqlInstance = new SimpleSOQLQuery();
        
        // Insert the opportunity List
        insert opportunityList;
        
        // Fetch the records.
        List<Opportunity> opportunityListInstance=
           [
               SELECT 
                   Id,
                   Name
               FROM
                   Opportunity
               WHERE
                   Name LIKE 'Test%'
           ];
           
         // Check If the record is inserted or not.
         System.assertEquals(100, opportunityListInstance.size()); 
         
         // Checks if the 5o records are not fetched only 50 is fetched
        System.assertEquals(0, soqlInstance.opportunityAmountGreaterThenTenthosand().size());
        
        // Stop the test
        Test.stopTest();
        
        
    }

    static testMethod void testToPrintUser() 
    {
        // Fetch the profile of Standard User 
        Profile profileInstance = 
            [
                SELECT 
                    Id 
                FROM 
                    Profile 
                WHERE 
                    Name='Standard User'
            ]; 
        // Create the user record
        User userInstance = new User(
                                     Alias = 'stanUser', 
                                     Email='standarduser123@testorg.com', 
                                     EmailEncodingKey='UTF-8', 
                                     LastName='userTest', 
                                     LanguageLocaleKey='en_US', 
                                     LocaleSidKey='en_US',
                                     ProfileId = profileInstance.Id, 
                                     TimeZoneSidKey='America/Los_Angeles', 
                                     UserName='userTest@testorg.com'
                                    );
        
        // Start the test
        Test.startTest();
        // Insert the User 
        insert userInstance;
        
        // Check for the record is Inserted.
        System.assert(String.isNotBlank(userInstance.Id));
        
        // Create the Instance of the User.
        PrintTheActiveUser user = new PrintTheActiveUser();
        
        // Check the size of the map returned by the class.
        system.assertequals(5,user.printAllActiveUsers().size()); 
        
        // Stop the test
        Test.stopTest();
    }
    
    /**
     * This is a test method to test the word 'test' in all name fields returning Contact, 
     * Account, Lead and User
     */
     static testMethod void findTestFromContactAccountLeadAndUser() 
     {
        // Create the instance the list of account.
        List<Account> accountList = new List<Account>();
        
        for(Integer i=0; i<5;i++) 
        {
            Account accountInstance = new Account(Name = 'Test'+i);
            accountList.add(accountInstance);    
        }
        
        // Check accounts inserted or not
        System.assertEquals(5, accountList.size()); 
        
        // Create the instance the list of lead.
        List<Lead> leadlist = new List<Lead>();
        
        for(Integer i=0;i<5;i++) 
        {
            Lead leadInstance = new Lead(LastName = 'Test'+i, 
                                         Company = 'ESPL', 
                                         LeadSource ='Web', 
                                         Status ='Closed'
                                        );
            leadlist.add(leadInstance);    
        }
        
        // Check leads inserted or not
        System.assertEquals(5, leadlist.size()); 
        
        // Create the instance the list of Contact.
        List<Contact> contactList = new List<Contact>();
        for(Integer i=0;i<5;i++) 
        {
            Contact contactInstance = new Contact(LastName = 'Test'+i);
            contactList.add(contactInstance);    
        }
        
        // Check contact inserted or not
        System.assertEquals(5, accountList.size()); 
        
        // Create the instance the list of User.
        List<User> testListUser = new List<User>();
        
        // Start the test
        Test.startTest();
        
        // Insert the Account
        insert accountList;
        
        // Fetch the records
        List<Account> accountListInstance=
           [
               SELECT 
                   Id,
                   Name
               FROM
                   Account
               WHERE
                   Name LIKE 'Test%'
           ];
           
         // Check If the record is inserted or not.
         System.assertEquals(5, accountListInstance.size()); 
        
        
        // Insert the Lead
        insert leadlist;
        
         // Fetch the records
         List<Lead> leadListInstance=
           [
               SELECT 
                   Id,
                   Name
               FROM
                   Lead
               WHERE
                   Name LIKE 'Test%'
           ];
           
         // Check If the record is inserted or not.
         System.assertEquals(5, leadListInstance.size()); 
        
        
        // Insert the Contact
        insert contactList;
        
        // Fetch the records
        List<Contact> contactListInstance=
           [
               SELECT 
                   Id,
                   Name
               FROM
                   Contact
               WHERE
                   Name LIKE 'Test%'
           ];
           
         // Check If the record is inserted or not.
         System.assertEquals(5, contactListInstance.size()); 
         
         // Create the instance of the class
        SoqlAndSoslQueryDmlOperation instanceSosl = new SoqlAndSoslQueryDmlOperation();

        System.assertEquals(4, instanceSosl.findTheTestRecordsUsingSOSL().size());
         
        // Stop the test
        Test.stopTest();
        
    }
}
