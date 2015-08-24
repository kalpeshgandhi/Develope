/***/
@isTest
private class TestRelationshipQueries 
{
    /**
     * This is a Method that queries on contact to retrieve all active contacts belonging 
     * to 'media' industry. It also displays the name of the account to which it is associated 
     * to.
     */
     static testMethod void associatedContactRecords() 
     {
         // Create the instance of the list of account.
         List<Account> accountList = new List<Account>();

         // Create the instance of the list of contact.
         List<Contact> contactList = new List<Contact>();

         // Create the record of account
         Account accountInstance = new Account(
                                               Name = 'TestAccount',
                                               Industry = 'Media',
                                               Active__c = 'Yes'
                                              );

         // Add account record the list
         accountList.add(accountInstance);

         // Check for the size of List that is been Inserted.
         System.assertEquals(1, accountList.size());

         // Insert account list
         insert accountList;

         // Fetch the record
         List<Account> accountListInstance=
            [
                SELECT 
                    Id,
                    Name
                FROM
                    Account
                WHERE
                    Name = 'TestAccount'
            ];

         // Check If the record is inserted or not.
         System.assertEquals(1, accountListInstance.size());

         // Create the record of contact
         Contact contactInstance = new Contact(
                                               LastName = 'TestContact', 
                                               AccountId = accountInstance.Id
                                              );
         contactList.add(contactInstance);   

         // Check for the size of list that is been inserted.
         System.assertEquals(1, contactList.size());

         // Insert contact list
         insert contactList;

         // Fetch the record
         List<Contact> contactListInstance=
            [
                SELECT 
                    Id,
                    Name
                FROM
                    Contact
                WHERE
                    Name = 'TestContact'
            ];

         // Check if the record is inserted or not.
         System.assertEquals(1, contactListInstance.size());

         // Create the instance of the 
         RelationQueriesSoql relationshipQueriesInstance = new RelationQueriesSoql(); 

         // Start the test
         Test.startTest();

         // Save the size of the returned list
         Integer listSize = relationshipQueriesInstance.retriveActiveContactsFromAccounts().size();

         // Stop the test
         Test.stopTest();

         // Check the size of the list matches the expected value.
         System.assertEquals(1,listSize);
    } 

    /**
     * This is a method that queries on contact to retrieve all active contacts belonging 
     * to 'media' industry. It also displays the name of the account to which it is associated 
     * to.
     */
     static testMethod void associatedContactRecordsBulkTest() 
     {
         // Create the instance of the list of account.
         List<Account> accountList = new List<Account>();

         // Create the record of account
         Account accountInstance = new Account(
                                               Name = 'TestAccount',
                                               Industry = 'Media',
                                               Active__c = 'Yes'
                                              );

         // Add account record the list
         accountList.add(accountInstance);

         // Check for the size of List that is been Inserted.
         System.assertEquals(1, accountList.size());

         // Insert account List
         insert accountList;

         // Fetch the record
         List<Account> accountListInstance=
            [
                SELECT 
                    Id,
                    Name
                FROM
                    Account
                WHERE
                    Name = 'TestAccount'
            ];

         // Check If the record is inserted or not.
         System.assertEquals(1, accountListInstance.size());

         // Initialize the list to create the data.
         List<Contact> contactList = new List<Contact>();
         for(Integer i = 0; i < 100; i++)
         {
              // Add The contacts to the list.
              contactList.add(new Contact(LastName ='TestContact' + i,
                                          AccountId = accountListInstance[0].Id)
                                         );
         }
         // Check for the size of List that is been inserted.
         System.assertEquals(100, contactList.size());

         // Insert Contact List
         insert contactList;

         // Fetch the record
         List<Contact> contactListInstance =
            [
                SELECT 
                    Id,
                    Name
                FROM
                    Contact
                WHERE
                    Name LIKE 'TestContact%'
            ];

         // Check if the record is inserted or not.
         System.assertEquals(100, contactListInstance.size());

         // Create the instance of the 
         RelationQueriesSoql relationshipQueriesInstance = new RelationQueriesSoql(); 

         // Start the test
         Test.startTest();

         // Save the size of the returned list
         Integer listSize = relationshipQueriesInstance.retriveActiveContactsFromAccounts().size();

         // Stop the test
         Test.stopTest();

         // Check the size of the list matches the expected value.
         System.assertEquals(100,listSize);
    }
    
    /**
     * This is a method that queries on contact to retrieve all inactive accounts belonging 
     * to 'media’ industry. It also displays the name of the account to which it is associated 
     * to.
     */
     static testMethod void associatedContactForInactiveAccount() 
     {
         // Create the instance of the list of account.
         List<Account> accountList = new List<Account>();

         // Create the instance of the list of contact.
         List<Contact> contactList = new List<Contact>();

         // Create the record of account
         Account accountInstance = new Account(
                                               Name = 'TestAccount',
                                               Industry = 'Media',
                                               Active__c = 'No'
                                              );

         // Add account record the list
         accountList.add(accountInstance);

         // Check for the size of list that is been inserted.
         System.assertEquals(1, accountList.size());

         // Insert account list
         insert accountList;

         // Fetch the record
         List<Account> accountListInstance=
            [
                SELECT 
                    Id,
                    Name
                FROM
                    Account
                WHERE
                    Name ='TestAccount'
            ];

         // Check if the record is inserted or not.
         System.assertEquals(1, accountListInstance.size());

         // Create the record of contact
         Contact contactInstance = new Contact(
                                               LastName = 'TestContact', 
                                               AccountId = accountInstance.Id
                                              );
         // Add contacts to the list
         contactList.add(contactInstance);   

         // Check for the size of list that is been inserted.
         System.assertEquals(1, contactList.size());

         // Insert contact list
         insert contactList;

         // Fetch the record
         List<Contact> contactListInstance=
            [
                SELECT 
                    Id,
                    Name
                FROM
                    Contact
                WHERE
                    Name ='TestContact'
            ];

         // Check if the record is inserted or not.
         System.assertEquals(1, contactListInstance.size());

         // Create the instance of the 
         RelationQueriesSoql relationshipQueriesInstance = new RelationQueriesSoql(); 

         // Start the test
         Test.startTest();

         // Save the size of the returned list
         Integer listSize = relationshipQueriesInstance.retriveActiveContactsFromAccounts().size();

         // Stop the test
         Test.stopTest();

         // Check the size of the list matches the expected value.
         System.assertEquals(0,listSize);
    }
    
    /**
     * This is a method that queries on contact to retrieve all active contacts belonging 
     * to Non 'media' industry. It also displays the name of the account to which it is associated 
     * to.
     */
     static testMethod void associatedContactForActiveAccountDifferentIndustry() 
     {
         // Create the instance of the list of account.
         List<Account> accountList = new List<Account>();

         // Create the instance of the list of contact.
         List<Contact> contactList = new List<Contact>();

         // Create the record of account
         Account accountInstance = new Account(
                                               Name = 'TestAccount',
                                               Industry = 'Energy',
                                               Active__c = 'Yes'
                                              );

         // Add account record the list
         accountList.add(accountInstance);

         // Check for the size of List that is been inserted.
         System.assertEquals(1, accountList.size());

         // Insert account List
         insert accountList;

         // Fetch the record
         List<Account> accountListInstance=
            [
                SELECT 
                    Id,
                    Name
                FROM
                    Account
                WHERE
                    Name = 'TestAccount'
            ];

         // Check If the record is inserted or not.
         System.assertEquals(1, accountListInstance.size());

         // Create the record of contact
         Contact contactInstance = new Contact(
                                               LastName = 'TestContact', 
                                               AccountId = accountInstance.Id
                                              );

         // Add Contact record to the list
         contactList.add(contactInstance);

         // Check for the size of List that is been Inserted.
         System.assertEquals(1, contactList.size());

         // Insert contact list
         insert contactList;

         // Fetch the record
         List<Contact> contactListInstance=
            [
                SELECT 
                    Id,
                    Name
                FROM
                    Contact
                WHERE
                    Name = 'TestContact'
            ];

         System.assertEquals(1, contactListInstance.size());

         // Create the instance of the 
         RelationQueriesSoql relationshipQueriesInstance = new RelationQueriesSoql(); 

         // Start the test
         Test.startTest();

         // Save the size of the returned list
         Integer listSize = relationshipQueriesInstance.retriveActiveContactsFromAccounts().size();

         // Stop the test
         Test.stopTest();

         // Check the size of the list matches the expected value.
         System.assertEquals(0,listSize); 
    }
    
    /**
     * This is a method that queries on contact to retrieve all inactive contacts belonging 
     * to Non 'media' industry. It also displays the name of the account to which it is associated 
     * to.
     */
     static testMethod void associatedContactForInActiveAccountDifferentIndustry() 
     {
         // Create the instance of the list of account.
         List<Account> accountList = new List<Account>();

         // Create the instance of the list of contact.
         List<Contact> contactList = new List<Contact>();

         // Create the record of account
         Account accountInstance = new Account(
                                               Name = 'TestAccount',
                                               Industry = 'Energy',
                                               Active__c = 'No'
                                              );

         // Add account record the list
         accountList.add(accountInstance);

         // Check for the size of List that is been Inserted.
         System.assertEquals(1, accountList.size());

         // Insert account List
         insert accountList;

         // Fetch the record
         List<Account> accountListInstance=
            [
                SELECT 
                    Id,
                    Name
                FROM
                    Account
                WHERE
                    Name = 'TestAccount'
            ];

         // Check if the record is inserted or not.
         System.assertEquals(1, accountListInstance.size());

         // Create the record of contact
         Contact contactInstance = new Contact(
                                               LastName = 'TestContact', 
                                               AccountId = accountInstance.Id
                                              );

         // Add contact record to the list
         contactList.add(contactInstance);

         // Check for the size of list that is been inserted.
         System.assertEquals(1, contactList.size());

         // Insert contact list
         insert contactList;

         // Fetch the record
         List<Contact> contactListInstance=
            [
                SELECT 
                    Id,
                    Name
                FROM
                    Contact
                WHERE
                    Name = 'TestContact'
            ];

         // Check if the record is inserted or not.
         System.assertEquals(1, contactListInstance.size());

         // Create the instance of the 
         RelationQueriesSoql relationshipQueriesInstance = new RelationQueriesSoql(); 

         // Start the test
         Test.startTest();

         // Save the size of the returned list
         Integer listSize = relationshipQueriesInstance.retriveActiveContactsFromAccounts().size();

         // Stop the test
         Test.stopTest();

         // Check the size of the list matches the expected value.
         System.assertEquals(0,listSize); 
    }
    
    /**
     *  This is a Method to fetch Accounts and find all associated contact records of the Account
     *  which contains the word 'John'. Print all Account and Contact records retrieved above.
     */
     static testmethod void contactsWithNameAsJohn() 
     {
        // Create the instance of the list of account.
        List<Account> accountList = new List<Account>();

        // Create the instance of the list of contact.
        List<Contact> contactList = new List<Contact>();

        // Create the record of account
        Account accountInstance = new Account(Name = 'TestAccount');

        // Add account record the list
        accountList.add(accountInstance);

        // Check for the size of List that is been inserted.
        System.assertEquals(1, accountList.size());

        // Insert account list
        insert accountList;

        // Fetch the record
        List<Account> accountListInstance=
           [
               SELECT 
                   Id,
                   Name
               FROM
                   Account
               WHERE
                   Name = 'TestAccount'
           ];

        // Check if the record is inserted or not.
        System.assertEquals(1, accountListInstance.size());

        // Create the record of contact
        Contact contactInstance = new Contact(
                                              LastName = 'John', 
                                              AccountId = accountInstance.Id
                                             );

        // Add the records to the list
        contactList.add(contactInstance);   

        // Check for the size of list that is been inserted.
        System.assertEquals(1, contactList.size()); 

        // Insert contact list
        insert contactList;

        // Fetch the record
        List<Contact> contactListInstance=
            [
                SELECT 
                    Id,
                    Name
                FROM
                    Contact
                WHERE
                    Name = 'John'
            ];

        // Check if the record is inserted or not.
        System.assertEquals(1, contactListInstance.size());


        // Start the test
        Test.startTest();

        // Create the instance of the class
        RelationQueriesSoql relationshipQueriesInstance = new RelationQueriesSoql(); 

        // Save the size of the returned list
        Integer listSize = relationshipQueriesInstance.retriveAccountAndRelatedContactsWhichContainsJohn().size();

        // Stop the test
        Test.stopTest();

        // Check the size of the list matches the expected value.
        System.assertEquals(1,listSize); 
    }
    
   /**
    *  This is a Method to fetch Accounts and find all associated contact records of the Account
    *  which does not contains the word 'John'. Print all Account and Contact records.
    */
    static testmethod void contactsWithNoNameAsJohn() 
    {
        // Create the instance of the list of account.
        List<Account> accountList = new List<Account>();

        // Create the instance of the list of contact.
        List<Contact> contactList = new List<Contact>();

        // Create the record of account
        Account accountInstance = new Account(Name = 'TestAccount');

        // Add account record the list
        accountList.add(accountInstance);

        // Check for the size of List that is been inserted.
        System.assertEquals(1, accountList.size());

        // Insert account List
        insert accountList;

        // Fetch the record
        List<Account> accountListInstance=
           [
               SELECT 
                   Id,
                   Name
               FROM
                   Account
               WHERE
                   Name = 'TestAccount'
           ];

        // Check if the record is inserted or not.
        System.assertEquals(1, accountListInstance.size());

        // Create the record of contact
        Contact contactInstance = new Contact(
                                              LastName = 'TestContact', 
                                              AccountId = accountInstance.Id
                                             );
        // Add the records to the list
        contactList.add(contactInstance);  

        // Check for the size of List that is been inserted.
        System.assertEquals(1, contactList.size()); 

        // Insert contact list
        insert contactList;

        // Fetch the record
        List<Contact> contactListInstance=
            [
                SELECT 
                    Id,
                    Name
                FROM
                    Contact
                WHERE
                    Name = 'TestContact'
            ];

        // Check if the record is inserted or not.
        System.assertEquals(1, contactListInstance.size());

        // Create the instance of the class
        RelationQueriesSoql relationshipQueriesInstance = new RelationQueriesSoql(); 

        // Start the test
        Test.startTest();

        // Save the size of the returned list
        Integer listSize = relationshipQueriesInstance.retriveAccountAndRelatedContactsWhichContainsJohn().size();

        // Stop the test
        Test.stopTest();

        // Check the size of the list matches the expected value.
        System.assertEquals(0,listSize); 
    }
    
    /**
    *  This is a bulk test method to fetch accounts and find all associated contact records of the
    * account which contains the word 'John'. Print all account and contact records retrieved above.
    */
    static testMethod void contactsWithNameAsJohnBulk() 
    {
         // Create the instance of the list of account.
         List<Account> accountList = new List<Account>();

         // Create the record of account
         Account accountInstance = new Account(Name = 'TestAccount');

         // Add account record the list
         accountList.add(accountInstance);

         // Check for the size of List that is been inserted.
         System.assertEquals(1, accountList.size());

         // Insert account list
         insert accountList;

         // Fetch the record
         List<Account> accountListInstance=
            [
                SELECT 
                    Id,
                    Name
                FROM
                    Account
                WHERE
                    Name = 'TestAccount'
            ];

         // Check If the record is inserted or not.
         System.assertEquals(1, accountListInstance.size());

         // Initialize the list to create the data.
         List<Contact> contactList = new List<Contact>();

         for(Integer i = 0; i < 100; i++)
         {
              // Add The contacts to the list.
              contactList.add(new Contact(
                                          LastName ='John'+i,
                                          AccountId=accountListInstance[0].Id)
                                         );
         }

         // Check for the size of list that is been inserted.
         System.assertEquals(100, contactList.size());

         // Insert contact list
         insert contactList;

         // Fetch the record
         List<Contact> contactListInstance=
            [
                SELECT 
                    Id,
                    Name
                FROM
                    Contact
                WHERE
                    Name LIKE 'John%'
            ];

         // Check if the record is inserted or not.
         System.assertEquals(100, contactListInstance.size());

         // Createthe instance of the class
         RelationQueriesSoql relationshipQueriesInstance = new RelationQueriesSoql(); 

         // Start the test
         Test.startTest();

         // Save the size of the returned list
         Integer listSize = relationshipQueriesInstance.retriveAccountAndRelatedContactsWhichContainsJohn().size();

         // Stop the test
         Test.stopTest();

         // Check the size of the list matches the expected value.
         System.assertEquals(1,listSize); 
    }
    
    /**
    *  This is a method to fetch accounts and find all associated contact records of the account
    *  which contains the word 'John'. Print all account and contact records retrieved above.
    */
    static testmethod void contactsWithNameAsTestJohn() 
    {
        // Create the instance of the list of account.
        List<Account> accountList = new List<Account>();

        // Create the instance of the list of contact.
        List<Contact> contactList = new List<Contact>();

        // Create the record of account
        Account accountInstance = new Account(Name = 'TestAccount');

        // Add account record the list
        accountList.add(accountInstance);

        // Check for the size of list that is been inserted.
        System.assertEquals(1, accountList.size());

        // Insert account list
        insert accountList;

        // Fetch the record
        List<Account> accountListInstance=
           [
               SELECT 
                   Id,
                   Name
               FROM
                   Account
               WHERE
                   Name = 'TestAccount'
           ];

        // Check if the record is inserted or not.
        System.assertEquals(1, accountListInstance.size());

        // Create the record of contact
        Contact contactInstance = new Contact(
                                              LastName = 'TestJohn', 
                                              AccountId = accountInstance.Id
                                             );

        // Add the records to the list
        contactList.add(contactInstance);  

        // Check for the size of list that is been inserted.
        System.assertEquals(1, contactList.size()); 

        // Insert contact list
        insert contactList;

        // Fetch the record
        List<Contact> contactListInstance=
            [
                SELECT 
                    Id,
                    Name
                FROM
                    Contact
                WHERE
                    Name = 'TestJohn'
            ];

        // Check if the record is inserted or not.
        System.assertEquals(1, contactListInstance.size());

        // Create the instance of the class
        RelationQueriesSoql relationshipQueriesInstance = new RelationQueriesSoql(); 

        // Start the test
        Test.startTest();

        // Save the size of the returned list
        Integer listSize = relationshipQueriesInstance.retriveAccountAndRelatedContactsWhichContainsJohn().size();

        // Stop the test
        Test.stopTest();

        // Check the size of the list matches the expected value.
        System.assertEquals(1,listSize); 
    }

   /**
    * This is a method that has a SOQL query to find all account records which have at least an 
    * opportunity record which is 'Closed Won'.
    */
    static testmethod void opportunityClosedWon() 
    { 
        // Create the instance of the list of account.
        List<Account> accountList = new List<Account>();

        // Create the instance of the list of opportunity.
        List<Opportunity> opportunityList = new List<Opportunity>();

        // Create the record of account
        Account accountInstance = new Account(Name = 'TestAccount');

        // Add account record the list
        accountList.add(accountInstance);

        // Check for the size of List that is been inserted.
        System.assertEquals(1, accountList.size()); 

        // Insert account List
        insert accountList;

        // Fetch the record
        List<Account> accountListInstance=
           [
               SELECT 
                   Id,
                   Name
               FROM
                   Account
               WHERE
                   Name = 'TestAccount'
           ];

        // Check If the record is inserted or not.
        System.assertEquals(1, accountListInstance.size());

        opportunityList.add(new Opportunity
                                            (Name = 'Test',
                                            AccountId = accountInstance.Id,
                                            CloseDate = System.today(),
                                            StageName = 'Closed Won'
                                            ));

        // Check for the size of list that is been inserted.
        System.assertEquals(1, opportunityList.size()); 

        // Insert contact list
        insert opportunityList;

        // Fetch the record
        List<Opportunity> opportunityListInstance=
           [
               SELECT 
                   Id,
                   Name
               FROM
                   Opportunity
               WHERE
                   Name = 'Test'
           ];

         // Check If the record is inserted or not.
         System.assertEquals(1, opportunityListInstance.size()); 

        // Create the instance of the class
        RelationQueriesSoql relationshipQueriesInstance = new RelationQueriesSoql(); 

        // Start the test
        Test.startTest();

        // Save the size of the returned list
        Integer listSize = relationshipQueriesInstance.findsAccountRecordHavingAtleastOneOpportunity().size();

        // Stop the test
        Test.stopTest();

        // Check the size of the list matches the expected value.
        System.assertEquals(1,listSize); 
    }
    
    /**
    * This is a method that has a SOQL query to find all account records which have at least an 
    * opportunity record which is not  'Closed Won'.
    */
    static testmethod void opportunityNotClosedWon() 
    { 
        // Create the instance of the list of account.
        List<Account> accountList = new List<Account>();

        // Create the instance of the list of opportunity.
        List<Opportunity> opportunityList = new List<Opportunity>();

        // Create the record of account
        Account accountInstance = new Account(Name = 'TestAccount');

        // Add account record the list
        accountList.add(accountInstance);

        // Check for the size of List that is been inserted.
        System.assertEquals(1, accountList.size());

        // Insert account List
        insert accountList;

        // Fetch the record
        List<Account> accountListInstance=
           [
               SELECT 
                   Id,
                   Name
               FROM
                   Account
               WHERE
                   Name = 'TestAccount'
           ];

        // Check if the record is inserted or not.
        System.assertEquals(1, accountListInstance.size());

        opportunityList.add(new Opportunity(Name = 'Test',
                                            AccountId = accountInstance.Id,
                                            CloseDate = System.today(),
                                            StageName = 'Closed Lost'
                                           ));

        // Check for the size of List that is been inserted.
        System.assertEquals(1, opportunityList.size());

        // Insert contact list
        insert opportunityList;

        // Fetch the record
        List<Opportunity> opportunityListInstance=
           [
               SELECT 
                   Id,
                   Name
               FROM
                   Opportunity
               WHERE
                   Name = 'Test'
           ];

        // Check if the record is inserted or not.
        System.assertEquals(1, opportunityListInstance.size()); 
        // Create the instance of the class
        RelationQueriesSoql relationshipQueriesInstance = new RelationQueriesSoql(); 

        // Start the test
        Test.startTest();

        // Save the size of the returned list
        Integer listSize = relationshipQueriesInstance.findsAccountRecordHavingAtleastOneOpportunity().size();

        // Stop the test
        Test.stopTest();

        // Check the size of the list matches the expected value.
        System.assertEquals(0,listSize); 
    }
    
    /**
    * This is a method that has a SOQL query to find all account records which does not have at 
    * least an opportunity record which is 'Closed Won'.
    */
    static testmethod void noOpportunityForAnAccount() 
    { 
        // Create the instance of the list of account.
        List<Account> accountList = new List<Account>();

        // Create the instance of the list of opportunity.
        List<Opportunity> opportunityList = new List<Opportunity>();

        // Create the record of account
        Account accountInstance = new Account(Name = 'TestAccount');

        // Add account record the list
        accountList.add(accountInstance);

        // Check for the size of List that is been inserted.
        System.assertEquals(1, accountList.size());

        // Insert account list
        insert accountList;

        // Fetch the record
        List<Account> accountListInstance=
           [
               SELECT 
                   Id,
                   Name
               FROM
                   Account
               WHERE
                   Name = 'TestAccount'
           ];

        // Check if the record is inserted or not.
        System.assertEquals(1, accountListInstance.size());

        opportunityList.add(new Opportunity(Name = 'Test',
                                            CloseDate = System.today(),
                                            StageName = 'Closed Won'
                                           ));

        // Check for the size of List that is been inserted.
        System.assertEquals(1, opportunityList.size());

        // Insert contact list
        insert opportunityList;

        // Fetch the record
        List<Opportunity> opportunityListInstance=
           [
               SELECT 
                   Id,
                   Name
               FROM
                   Opportunity
               WHERE
                   Name = 'Test'
           ];

        // Check if the record is inserted or not.
        System.assertEquals(1, opportunityListInstance.size()); 

        // Create the instance of the class
        RelationQueriesSoql relationshipQueriesInstance = new RelationQueriesSoql(); 

        // Start the test
        Test.startTest();

        // Save the size of the returned list
        Integer listSize = relationshipQueriesInstance.findsAccountRecordHavingAtleastOneOpportunity().size();

        // Stop the test
        Test.stopTest();

        // Check the size of the list matches the expected value.
        System.assertEquals(0,listSize); 
    }

    /**
     * This is a test method that will retrieve all records of 'C' with name 'John' 
     *  along with parent details.
     */
     static testmethod  void recordsOfCWithNameJohnWithParentDetails()
     {
        // Creates the record for A object 
        A__c instanceOfA = new A__c(Name = 'Test');

        // Creates the record for B object
        B__c instanceOfB = new B__c(Name = 'Test');

        // Insert the record of A
        insert instanceOfA;

        // Check for the record is inserted.
        System.assert(String.isNotBlank(instanceOfA.Id));

        // Insert the record of B
        insert instanceOfB;

        // Check for the record is inserted.
        System.assert(String.isNotBlank(instanceOfB.Id));

        // Creates the record for C object
        C__c instanceOfC = new C__c(
                                    Name = 'John', 
                                    A_relation__c = instanceOfA.Id,
                                    Bs__c = instanceOfB.Id
                                   );

        // Insert the record of C
        insert instanceOfC;

        // Check for the record is inserted.
         System.assert(String.isNotBlank(instanceOfC.Id));

        // Create the instance of the class
        RelationQueriesSoql relationshipQueriesInstance = new RelationQueriesSoql(); 

        // Start the Test
        Test.startTest(); 

        List<C__c> cListInstance = relationshipQueriesInstance.retriveAllrecordsWithNameJohnFromC();

        // Stop the test
        Test.stopTest();

        // Check the list size.
        System.assertEquals(1,cListInstance.size());

        // Check the parents name is same as returned from the method
        System.assertEquals('Test',cListInstance[0].Bs__r.name);

        // Check the parents name is same as returned from the method
        System.assertEquals('Test',cListInstance[0].A_relation__r.name);
    } 

    /**
     * This is a test method that will retrieve all records of 'C' with name 'John' 
     *  along with parent details.
     */
     static testmethod  void recordsOfCWithNameJohnBulk()
     {
        // Creates the record for A object 
        A__c instanceOfA =new A__c(Name = 'Test');

        // Creates the record for B object
        B__c instanceOfB = new B__c(Name = 'Test');

        List<C__c> listOfC = new List<C__c>();

        // Insert the record of A
        insert instanceOfA;

        // Check for the record is inserted.
        System.assert(String.isNotBlank(instanceOfA.Id));

        // Insert the record of B
        insert instanceOfB;

        // Check for the record is inserted.
        System.assert(String.isNotBlank(instanceOfB.Id));

        for(Integer i = 0; i <= 100; i++)
        {
            // Creates the record for C object
            listOfC.add(new C__c(
                                 Name = 'John', 
                                 A_relation__c = instanceOfA.Id,
                                 Bs__c = instanceOfB.Id
                                ));
        }

        // Check for the records inserted in the list.
        System.assertEquals(101,listOfC.size());

        // Insert the record of C
        insert listOfC;

        List<C__c> cListInstance=
           [
               SELECT 
                   Id,
                   Name
               FROM
                   C__c
               WHERE
                   Name = 'John'
           ];

        // Check If the record is inserted or not.
        System.assertEquals(101, cListInstance.size()); 

        // Create the instance of the class
        RelationQueriesSoql relationshipQueriesInstance = new RelationQueriesSoql(); 

        // Start the Test
        Test.startTest(); 

        // Save the size of the returned list
        Integer listSize = relationshipQueriesInstance.retriveAllrecordsWithNameJohnFromC().size();

        // Stop the test
        Test.stopTest();

        // Check the size of the list matches the expected value.
        System.assertEquals(101,listSize); 
    } 

    /**
     * This is a test method that will retrieve all records of 'C' without name 'John' 
     *  along with parent details.
     */
     static testmethod  void recordsOfCWithOutNameJohn()
     {
         // Creates the record for A object 
         A__c instanceOfA = new A__c(Name = 'Test');

         // Creates the record for B object
         B__c instanceOfB = new B__c(Name = 'Test');

         // Insert the record of A
         insert instanceOfA;

         // Check for the record is inserted.
         System.assert(String.isNotBlank(instanceOfA.Id));

         // Insert the record of B
         insert instanceOfB;

         // Check for the record is inserted.
         System.assert(String.isNotBlank(instanceOfB.Id));

         // Creates the record for C object
         C__c instanceOfC = new C__c(
                                     Name = 'Test', 
                                     A_relation__c = instanceOfA.Id,
                                     Bs__c = instanceOfB.Id
                                    );

         // Insert the record of C
         insert instanceOfC;

         // Check for the record is inserted.
         System.assertNotEquals(null, instanceOfC.Id);

         // Create the instance of the class
         RelationQueriesSoql relationshipQueriesInstance = new RelationQueriesSoql(); 

         // Start the Test
         Test.startTest(); 

         // Save the size of the returned list
         Integer listSize = relationshipQueriesInstance.retriveAllrecordsWithNameJohnFromC().size();

         // Stop the test
         Test.stopTest();

         // Check the size of the list matches the expected value.
         System.assertEquals(0,listSize); 
    }

    /**
     * This is a test method that will query on 'A' and retrieve all parents with all their 
     * child records where in child name is 'John'.
     */
     static testmethod  void recordsOfAWithChildNameJohn()
     {
        // Creates the record for A object 
        A__c instanceOfA = new A__c(Name = 'Test');

        // Creates the record for B object
        B__c instanceOfB = new B__c(Name = 'Test');

        // Insert the record of A
        insert instanceOfA;

        // Check for the record is inserted.
        System.assert(String.isNotBlank(instanceOfA.Id));

        // Insert the record of B
        insert instanceOfB;

        // Check for the record is inserted.
        System.assert(String.isNotBlank(instanceOfB.Id));

        // Creates the record for C object
        C__c instanceOfC = new C__c(
                                    Name = 'John', 
                                    A_relation__c = instanceOfA.Id,
                                    Bs__c = instanceOfB.Id
                                   );

        // Insert the record of C
        insert instanceOfC;

        // Check for the record is inserted.
         System.assert(String.isNotBlank(instanceOfC.Id));

        // Create the instance of the class
        RelationQueriesSoql relationshipQueriesInstance = new RelationQueriesSoql(); 

        // Start the test
        Test.startTest(); 

        // Save the size of the returned list
        Integer listSize = relationshipQueriesInstance.retriveRecordsFromAWhereChildnameisJohn().size();

        // Stop the test
        Test.stopTest();

        // Check the size of the list matches the expected value.
        System.assertEquals(1,listSize); 
    } 

    /**
     * This is a bulk test method that will query on 'A' and retrieve all parents with all their 
     * child records where in child name is 'John'.
     */
     static testmethod  void recordsOfAWithChildNameJohnBulk()
     {
        // Creates the record for A object 
        A__c instanceOfA =new A__c(Name = 'Test');

        // Creates the record for B object
        B__c instanceOfB = new B__c(Name = 'Test');

        List<C__c> listOfC = new List<C__c>();

        // Insert the record of A
        insert instanceOfA;

        // Check for the record is inserted.
        System.assert(String.isNotBlank(instanceOfA.Id));

        // Insert the record of B
        insert instanceOfB;

        // Check for the record is inserted.
        System.assert(String.isNotBlank(instanceOfB.Id));

        for(Integer i = 0; i <= 100; i++)
        {
            // Creates the record for C object
            listOfC.add(new C__c(
                                 Name = 'John', 
                                 A_relation__c = instanceOfA.Id,
                                 Bs__c = instanceOfB.Id
                                 ));
        }

        // Check for the records inserted in the list.
        System.assertEquals(101,listOfC.size());

        // Insert the record of C
        insert listOfC;

        List<C__c> cListInstance=
           [
               SELECT 
                   Id,
                   Name
               FROM
                   C__c
               WHERE
                   Name = 'John'
           ];

        // Check if the record is inserted or not.
        System.assertEquals(101, cListInstance.size()); 

        // Create the instance of the class
        RelationQueriesSoql relationshipQueriesInstance = new RelationQueriesSoql(); 

        // Start the test
        Test.startTest(); 

        // Save the size of the returned list
        Integer listSize = relationshipQueriesInstance.retriveRecordsFromAWhereChildnameisJohn().size();

        // Stop the test
        Test.stopTest();

        System.assertEquals(101,listSize);
    } 

    /**
     *
     */
     static testmethod  void recordsOfAWithNoChildNameJohn()
     {
         // Creates the record for A object 
         A__c instanceOfA = new A__c(Name = 'Test');

         // Creates the record for B object
         B__c instanceOfB = new B__c(Name = 'Test');

         // Insert the record of A
         insert instanceOfA;

         // Check for the record is inserted.
         System.assert(String.isNotBlank(instanceOfA.Id));

         // Insert the record of B
         insert instanceOfB;

         // Check for the record is inserted.
         System.assert(String.isNotBlank(instanceOfB.Id));

         // Creates the record for C object
         C__c instanceOfC = new C__c(
                                     Name = 'Test', 
                                     A_relation__c = instanceOfA.Id,
                                     Bs__c = instanceOfB.Id
                                    );

         // Insert the record of C
         insert instanceOfC;

         // Check for the record is inserted.
         System.assertNotEquals(null, instanceOfC.Id);

         // Create the instance of the class
         RelationQueriesSoql relationshipQueriesInstance = new RelationQueriesSoql(); 

         // Start the test
         Test.startTest(); 

         // Save the size of the returned list
         Integer listSize = relationshipQueriesInstance.retriveRecordsFromAWhereChildnameisJohn().size();

         // Stop the test
         Test.stopTest();

         // Check the size of the list matches the expected value.
         System.assertEquals(0,listSize); 
    }
}