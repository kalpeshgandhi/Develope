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
        List<Contact> contactList =TestDataFactory.contactTestData(10);
        
        // Start the test
        Test.startTest();
        
        // Insert the contact list
        insert contactList;
        
        // Check the list size.
        System.assertEquals(10,contactList.size());
        
        // Stop the test
        Test.stopTest();
      
        // Create the Instance of the class
        SimpleSOQLQuery contactInstance = new SimpleSOQLQuery();
        
        // Compare the list size and the returned size.
        System.assertEquals(contactList.size(),contactInstance.printContactList());
    }
    
   /**
    * This is a method that will test Account id as a key and entire account object as value.
    */
    static testMethod void testMapRecords()
    {
        // Initialize the list to create the data.
        List<Account> accountList =TestDataFactory.accountTestData(3);
        
        // Start the test.
        Test.startTest();
        
        // Insert the account list.
        insert accountList;
        
        // Check the list size.
        System.assertEquals(3,accountList.size());
        
        // Stop the test.
        Test.stopTest(); 
        
        // Create the Instance of the map with the String as a Key and Id as a Value.
        Map<String, Id> accountNameWithAccountIdMapInstance = new Map<String, Id>();
        
        // Iterate over the account list. 
        for (Account accountInstance : accountList ) 
        {
            // Add the values to the map.
            accountNameWithAccountIdMapInstance.put(accountInstance.Name, accountInstance.Id); 
        }
        
        // Create the Instance of the map with the Id as a Key and Account as a Value.
        Map<Id, Account> accountIdWithAccountMapInstance = new Map<Id, Account>();
        
        // Iterate over the account list.
        for (Account accountInstance : accountList )
        {
            accountIdWithAccountMapInstance.put(accountInstance.Id, accountInstance); 
        }
        // Create the Instance of the class.
        DisplayTheMapStructure instance = new DisplayTheMapStructure();
        
        // Compare the size of the map and the returned size of the map.
        System.assertEquals(accountIdWithAccountMapInstance.size(), instance.mapOfIdAndAccount().size());
        
        // Compare the size of the map and the returned size of the map.
        System.assertEquals(accountNameWithAccountIdMapInstance.size(), instance.mapOfAccountNameAndAccountId().size()); 
    }
    
   /**
    *  This is a test Method to fetch all account records according to the 'Enrollment Year'.
    *  a. 2010
    *  b. 2013 and 2014
    */
    static testMethod void testAccountEnrollmentYear() 
    {
        // Initialize the list of account.
        List<Account> accountList = new List<Account>();
        
        // Initialize the list of account.
        List<Account> accountList2 = new List<Account>();
        
        // Iterate over the for loop.
        for (Integer i = 0; i <= 5; i++) 
        {
            // Create the records of type account
            Account accountInstance = new Account(Name = 'TestAccount' + i,
                                              Enrollment_Year__c = '2013;2014');
            Account accountInstanceTest = new Account(Name = 'TestAccount' + i,
                                              Enrollment_Year__c = '2010');
            // Add the instance to the list.
            accountList.add(accountInstance);
            accountList2.add(accountInstanceTest);
        }
        
        // Start the Test
        Test.startTest();
        
        // Insert the account list.
        insert accountList;
        
        // Check the list size.
        System.assertEquals(6,accountList.size());
        
        // Insert the account list.
        insert accountList2;
        
        // Check the list size.
        System.assertEquals(6,accountList.size());
        
        // Stop the test
        Test.stopTest();
        
        // Create the Instance of the class
        SimpleSOQLQuery soqlInstance = new SimpleSOQLQuery();
        
        // Compare the size of the list and the returned size of the list.
        System.assertEquals(accountList.size(), soqlInstance.checkEnrollmentYear20132014().size());
        
        // Compare the size of the list and the returned size of the list.
        System.assertEquals(accountList2.size(), soqlInstance.checkEnrollmentYear2010().size());
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
                                                   BillingState__c = 'Gujrat');
             Account accountInstanceTest = new Account(Name = 'TestAccount' + i,
                                                       BillingState__c = 'Maharashtra');
             // Add the instance to the list.
             accountList.add(accountInstance);
             accountList.add(accountInstanceTest);
         }
        
         // Start the Test
         Test.startTest();
        
         // Insert the account list.
         insert accountList;
        
         // Check the list size.
         System.assertEquals(12,accountList.size());
        
         // Stop the test
         Test.stopTest();
        
         // Create the Instance of the class
         SimpleSOQLQuery soqlInstance = new SimpleSOQLQuery();
         // Check result
         System.assertEquals(6, soqlInstance.billingStateNotMaharashtraOrKerala().size()); 
    }
    
   /**
    *  Method to test SOQL query to display 100 opportunity records with amount greater than 10,000 
    *  order by created date. Skip first 50 records and include records from recycle bin. 
    */
    static testMethod void testOportunitys() 
    {
        // Create the instance the list of account.
        List<Opportunity> opportunityList = new List<Opportunity>();
        
        // Iterate over the loop for 50 times
        for (Integer i = 0; i<100; i++) 
        {
            // Add the records of opportunity type.
            Opportunity opportunityInstance = new Opportunity(Name = 'Test' + i,
                                                          CloseDate = System.Today(),
                                                          StageName = 'Closed Won',
                                                          Amount  =  20000);
            // Add the records to the list.
            opportunityList.add(opportunityInstance);    
        }
        
        // Start the test
        Test.startTest();
        
        // Create instance of the class 
        SimpleSOQLQuery soqlInstance = new SimpleSOQLQuery();
        
        // Insert the opportunity List
        insert opportunityList;
        
        // Stop the test
        Test.stopTest();
        
        // Checks if the 5o records are not fetched only 50 is fetched
        System.assertEquals(50, soqlInstance.opportunityAmountGreaterThenTenthosand().size());
    }

    static testMethod void testToPrintUser() 
    {
        // Fetch the profile of Standard User 
        Profile profileInstance = [
                                   SELECT Id 
                                   FROM Profile 
                                   WHERE Name='Standard User']; 
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
                                     UserName='userTest@testorg.com');
        
        // Start the test
        Test.startTest();
        // Insert the User 
        insert userInstance;
        
        // Stop the test
        Test.stopTest();
        
        // Create the Instance of the User.
        PrintTheActiveUser user = new PrintTheActiveUser();
        
        // Check the size of the map returned by the class.
        system.assertequals(5,user.printAllActiveUsers().size()); 
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
        
        // Create the instance the list of lead.
        List<Lead> leadlist = new List<Lead>();
        
        for(Integer i=0;i<5;i++) 
        {
            Lead leadInstance = new Lead(LastName = 'Test'+i, 
                                         Company = 'ESPL', 
                                         LeadSource ='Web', 
                                         Status ='Closed');
            leadlist.add(leadInstance);    
        }
        
        // Create the instance the list of Contact.
        List<Contact> contactList = new List<Contact>();
        for(Integer i=0;i<5;i++) 
        {
            Contact contactInstance = new Contact(LastName = 'Test'+i);
            contactList.add(contactInstance);    
        }
        // Create the instance the list of User.
        List<User> testListUser = new List<User>();
        // Start the test
        Test.startTest();
        
        // Insert the Account
        insert accountList;
        
        // Check accounts inserted or not
        System.assertEquals(5, accountList.size()); 
        
        // Insert the Lead
        insert leadlist;
        
        // Check leads inserted or not
        System.assertEquals(5, leadlist.size()); 
        
        // Insert the Contact
        insert contactList;
        
        // Check contact inserted or not
        System.assertEquals(5, accountList.size()); 
        
        // Stop the test
        Test.stopTest();
        // Create the instance of the class
        SoqlAndSoslQueryDmlOperation instanceSosl = new SoqlAndSoslQueryDmlOperation();
      
        System.assertEquals(4, instanceSosl.findTheTestRecordsUsingSOSL().size());
    }
}
