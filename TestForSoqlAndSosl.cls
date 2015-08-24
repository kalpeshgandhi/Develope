/**
 * This is a class that will have the test method for checking the functionality of
 * various Soql and Sosl queries.
 */
@isTest
private class TestForSoqlAndSosl 
{
   /**
    * This is a method to test query on all contact records and add them to the list. 
    */
    static testMethod void testForContacts() 
    {
        // Initialize the list to create the data.
        List<Contact> contactList = TestDataFactory.contactTestData(10);

        // Check the list size.
        System.assertEquals(10,contactList.size());

        // Insert the contact list
        insert contactList;

        // Fetch the records.
        List<Contact> contactListInstance =
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

        // Start the test
        Test.startTest();

        // Save the size of the list returned by the method.
        Integer ListSize = contactInstance.printContactList();

        // Stop the test
        Test.stopTest();

        // Compare the list size and the returned size.
        System.assertEquals(contactListInstance.size(),ListSize);
    }

    /**
    * This is a method to test if no contact is inserted then query on all contact records and 
    * add them to the list. 
    */
    static testMethod void testForContactsNoContactInserted() 
    {
        // Fetch the records.
        List<Contact> contactListInstance =
           [
               SELECT 
                   Id,
                   Name
               FROM
                   Contact
               WHERE
                   Name LIKE 'testContact%'
           ];

        // Check if the record is inserted or not.
        System.assertEquals(0, contactListInstance.size()); 

        // Create the instance of the class
        SimpleSOQLQuery contactInstance = new SimpleSOQLQuery();

        // Start the test
        Test.startTest();

        // Save the size of the list returned by the method.
        Integer ListSize = contactInstance.printContactList();

        // Stop the test
        Test.stopTest();

        // Compare the list size and the returned size.
        System.assertEquals(contactListInstance.size(),ListSize);
    }

   /**
    * This is a method that will test Account name as a key and entire account id as value.
    */
    static testMethod void testMapRecordsWithAccountNameAndAccountId()
    {
        // Initialize the list to create the data.
        List<Account> accountList = TestDataFactory.accountTestData(3);

         // Check the list size.
        System.assertEquals(3,accountList.size());

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

        // Check if the record is inserted or not.
        System.assertEquals(3, accountListInstance.size()); 

        // Create the instance of the map with the String as a key and id as a value.
        Map<String, Id> accountNameWithAccountIdMapInstance = new Map<String, Id>();

        // Iterate over the account list. 
        for (Account accountInstance : accountListInstance ) 
        {
            // Add the values to the map.
            accountNameWithAccountIdMapInstance.put(accountInstance.Name, accountInstance.Id); 
        }

        // Create the instance of the class.
        DisplayTheMapStructure mapInstance = new DisplayTheMapStructure();

        // Start the test.
        Test.startTest();

        // Save the size of the list returned by the method.
        Integer ListSize = mapInstance.mapOfAccountNameAndAccountId().size();

        // Stop the test.
        Test.stopTest();

        // Compare the size of the map and the returned size of the map.
        System.assertEquals(accountNameWithAccountIdMapInstance.size(),ListSize); 
    }

    /**
     * This is a method that will test Account id as a key and entire account object as value.
     */
     static testMethod void testMapRecordsWithAccountIdAndAccount()
     {
        // Initialize the list to create the data.
        List<Account> accountList = TestDataFactory.accountTestData(3);

        // Check the list size.
        System.assertEquals(3,accountList.size());

        // Insert the account list.
        insert accountList;

        // Fetch the records.
        List<Account> accountListInstance =
           [
               SELECT 
                   Id,
                   Name
               FROM
                   Account
               WHERE
                   Name LIKE 'TestAccount%'
           ];

        // Check if the record is inserted or not.
        System.assertEquals(3, accountListInstance.size()); 

        // Create the instance of the map with the id as a key and account as a value.
        Map<Id, Account> accountIdWithAccountMapInstance = new Map<Id, Account>();

        // Iterate over the account list.
        for (Account accountInstance : accountListInstance )
        {
            accountIdWithAccountMapInstance.put(accountInstance.Id, accountInstance); 
        }

        // Create the instance of the class.
        DisplayTheMapStructure mapInstance = new DisplayTheMapStructure();

        // Start the test.
        Test.startTest();

        // Save the size of the list returned by the method.
        Integer ListSize = mapInstance.mapOfIdAndAccount().size();

        // Stop the test.
        Test.stopTest();

       // Compare the size of the map and the returned size of the map.
        System.assertEquals(accountIdWithAccountMapInstance.size(),ListSize);
     }

   /**
    *  This is a test Method to fetch all account records according to the 'Enrollment Year'.
    *  1)2010
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

        // Check if the record is inserted or not.
        System.assertEquals(6, accountListInstance.size()); 

        // Create the instance of the class
        SimpleSOQLQuery soqlInstance = new SimpleSOQLQuery();

        // Start the test
        Test.startTest();

        // Save the size of the list returned by the method.
        Integer ListSize = soqlInstance.checkEnrollmentYear2010().size();

        // Stop the test
        Test.stopTest();

        // Compare the size of the list and the returned size of the list.
        System.assertEquals(accountListInstance.size(), ListSize);
    }

/**
    *  This is a test Method to fetch all account records according to the 'Enrollment Year'.
    *  1)Not In 2010
    */
    static testMethod void testAccountEnrollmentYearNotIn2010() 
    {
        // Initialize the list of account.
        List<Account> accountList = new List<Account>();

        // Iterate over the for loop.
        for (Integer i = 0; i <= 5; i++) 
        {
            Account accountInstanceTest = new Account(Name = 'TestAccount' + i,
                                                      Enrollment_Year__c = '2013'
                                                     );

            // Add the instance to the list.
            accountList.add(accountInstanceTest);
        }

        // Check the list size.
        System.assertEquals(6,accountList.size());

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

        // Check if the record is inserted or not.
        System.assertEquals(6, accountListInstance.size()); 

        // Create the instance of the class
        SimpleSOQLQuery soqlInstance = new SimpleSOQLQuery();

        // Start the test
        Test.startTest();

        // Save the size of the list returned by the method.
        Integer ListSize = soqlInstance.checkEnrollmentYear2010().size();

        // Stop the test
        Test.stopTest();

        // Compare the size of the list and the returned size of the list.
        System.assertEquals(0, ListSize);
    }

   /**
    * This is a test Method to fetch all account records according to the 'Enrollment Year'.
    * 1) 2013 And 2014
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

        // Check if the record is inserted or not.
        System.assertEquals(6, accountListInstance.size()); 

        // Create the instance of the class
        SimpleSOQLQuery soqlInstance = new SimpleSOQLQuery();

        // Start the test
        Test.startTest();

        // Save the size of the list returned by the method.
        Integer ListSize = soqlInstance.checkEnrollmentYear20132014().size();

        // Stop the test
        Test.stopTest();

        // Compare the size of the list and the returned size of the list.
        System.assertEquals(accountList.size(), ListSize);
    }
/**
    * This is a test Method to fetch all account records according to the 'Enrollment Year'.
    * 1) Only 2013 
    */
    static testMethod void testAccountEnrollmentYear2013() 
    {
        // Initialize the list of account.
        List<Account> accountList = new List<Account>();

        // Iterate over the for loop.
        for (Integer i = 0; i <= 5; i++) 
        {
           // Create the records of type account
            Account accountInstanceTest = new Account(Name = 'TestAccount' + i,
                                                      Enrollment_Year__c = '2013'
                                                      );
            // Add the instance to the list.
            accountList.add(accountInstanceTest);
        }

        // Check the list size.
        System.assertEquals(6,accountList.size());

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

        // Check if the record is inserted or not.
        System.assertEquals(6, accountListInstance.size()); 

        // Create the instance of the class
        SimpleSOQLQuery soqlInstance = new SimpleSOQLQuery();

        // Start the test
        Test.startTest();

        // Save the size of the list returned by the method.
        Integer ListSize = soqlInstance.checkEnrollmentYear20132014().size();

        // Stop the test
        Test.stopTest();

        // Compare the size of the list and the returned size of the list.
        System.assertEquals(accountList.size(), ListSize);
    }

   /**
    * This is a Test method that fetches all account records where 'Billing State' is 
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

         // Check if the record is inserted or not.
         System.assertEquals(12, accountListInstance.size()); 

         // Create the instance of the class
         SimpleSOQLQuery soqlInstance = new SimpleSOQLQuery();

         // Start the test
         Test.startTest();

         // Save the size of the list returned by the method.
         Integer ListSize = soqlInstance.billingStateNotMaharashtraOrKerala().size();

         // Stop the test
         Test.stopTest();

         // Check result
         System.assertEquals(6, ListSize); 
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

         // Check if the record is inserted or not.
         System.assertEquals(12, accountListInstance.size()); 

         // Create the instance of the class
         SimpleSOQLQuery soqlInstance = new SimpleSOQLQuery();

         // Start the test
         Test.startTest();

         // Save the size of the list returned by the method.
         Integer ListSize = soqlInstance.billingStateNotMaharashtraOrKerala().size();

         // Stop the test
         Test.stopTest();

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

         // Check if the record is inserted or not.
         System.assertEquals(12, accountListInstance.size()); 

         // Create the instance of the class
         SimpleSOQLQuery soqlInstance = new SimpleSOQLQuery();

         // Start the test
         Test.startTest();

         // Save the size of the list returned by the method.
         Integer ListSize = soqlInstance.billingStateNotMaharashtraOrKerala().size();

         // Stop the test
         Test.stopTest();

         // Check result
         System.assertEquals(12, ListSize); 
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

        // Check if the record is inserted or not.
        System.assertEquals(100, opportunityList.size()); 

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

         // Check if the record is inserted or not.
         System.assertEquals(100, opportunityListInstance.size()); 

        // Create instance of the class 
        SimpleSOQLQuery soqlInstance = new SimpleSOQLQuery();

        // Start the test
        Test.startTest();

        // Save the size of the list returned by the method.
        Integer ListSize = soqlInstance.opportunityAmountGreaterThenTenthosand().size();

        // Stop the test
        Test.stopTest();

        // Checks if the 50 records are not fetched 
        System.assertEquals(50, ListSize);
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

        // Check if the record is inserted or not.
        System.assertEquals(100, opportunityList.size()); 

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

         // Check if the record is inserted or not.
         System.assertEquals(100, opportunityListInstance.size()); 

        // Create instance of the class 
        SimpleSOQLQuery soqlInstance = new SimpleSOQLQuery();

        // Start the test
        Test.startTest();

        // Save the size of the list returned by the method.
        Integer ListSize = soqlInstance.opportunityAmountGreaterThenTenthosand().size();

        // Stop the test
        Test.stopTest();

        // Checks if the records are not fetched.
        System.assertEquals(0, ListSize);
    }
    /**
     * Method that prints all user.
     */
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
                    Name ='Standard User'
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

        // Insert the user 
        insert userInstance;

        // Check for the record is inserted.
        System.assert(String.isNotBlank(userInstance.Id));

        // Create the instance of the user.
        PrintTheActiveUser user = new PrintTheActiveUser();

        // Start the test
        Test.startTest();

        // Save the size of the list returned by the method.
        Integer ListSize = user.printAllActiveUsers().size();

        // Stop the test
        Test.stopTest();

        // Check the size of the map returned by the class.
        system.assertequals(5,ListSize); 
    }

    /**
     * This is a test method to test the word 'test' in all name fields returning Contact, 
     * Account, Lead and User
     */
     static testMethod void findTestFromContactAccountLeadAndUser() 
     {
        // Create the instance the list of account.
        List<Account> accountList = new List<Account>();

        for(Integer i = 0; i < 5; i++) 
        {
            Account accountInstance = new Account(Name = 'Test'+i);
            accountList.add(accountInstance);    
        }

        // Check accounts inserted or not
        System.assertEquals(5, accountList.size()); 

        // Create the instance the list of lead.
        List<Lead> leadlist = new List<Lead>();

        for(Integer i = 0; i < 5; i++) 
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

        // Create the instance the list of contact.
        List<Contact> contactList = new List<Contact>();

        for(Integer i = 0; i < 5; i++) 
        {
            Contact contactInstance = new Contact(LastName = 'Test'+i);
            contactList.add(contactInstance);    
        }

        // Check contact inserted or not
        System.assertEquals(5, accountList.size()); 

        // Create the instance the list of user.
        List<User> testListUser = new List<User>();

        // Insert the account
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

        // Check if the record is inserted or not.
        System.assertEquals(5, accountListInstance.size()); 

        // Insert the lead
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

         // Check if the record is inserted or not.
         System.assertEquals(5, leadListInstance.size()); 

        // Insert the contact
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

        // Check if the record is inserted or not.
        System.assertEquals(5, contactListInstance.size()); 

        // Create the instance of the class
        SoqlAndSoslQueryDmlOperation instanceSosl = new SoqlAndSoslQueryDmlOperation();

        // Start the test
        Test.startTest();

        // Save the size of the list returned by the method.
        Integer ListSize = instanceSosl.findTheTestRecordsUsingSOSL().size();

        // Stop the test
        Test.stopTest();

        System.assertEquals(4, ListSize);
    }
}