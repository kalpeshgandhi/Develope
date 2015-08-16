/***/
@isTest
private class TestRelationshipQueries 
{
    /**
     * This is a Method that queries on Contact to retrieve all active contacts belonging 
     * to 'media' Industry. It Also displays the name of the account to which it is associated 
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
                                              Active__c = 'Yes');
         
         // Add account record the list
         accountList.add(accountInstance);
         
         
         
         // Start the test
         Test.startTest();
         
         // Insert account List
         insert accountList;
         
         // Check for the size of List that is been Inserted.
         System.assertEquals(1, accountList.size());
         
         // Create the record of contact
         Contact contactInstance = new Contact(
                                           LastName = 'TestContact', 
                                           AccountId = accountInstance.Id);
         contactList.add(contactInstance);   
         
         // Insert Contact List
         insert contactList;
         
         // Check for the size of List that is been Inserted.
         System.assertEquals(1, contactList.size());

         // Stop the test
         Test.stopTest();
         
         // Create the instance of the 
         RelationQueriesSoql relationshipQueriesInstance = new RelationQueriesSoql(); 
         
         // Check for result
         System.assertEquals(1,
         relationshipQueriesInstance.retriveActiveContactsFromAccounts().size());
    } 
    
    /**
     * This is a Method that queries on Contact to retrieve all inactive contacts belonging 
     * to 'media’ Industry. It Also displays the name of the account to which it is associated 
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
                                              Active__c = 'No');
         
         // Add account record the list
         accountList.add(accountInstance);
         
         // Start the test
         Test.startTest();
         
         // Insert account List
         insert accountList;

         // Check for the size of List that is been Inserted.
         System.assertEquals(1, accountList.size());
         
         // Create the record of contact
         Contact contactInstance = new Contact(
                                           LastName = 'TestContact', 
                                           AccountId = accountInstance.Id);
         // Add Contacts to the list
         contactList.add(contactInstance);   
         
         // Insert Contact List
         insert contactList;
         
         // Check for the size of List that is been Inserted.
         System.assertEquals(1, contactList.size());
         
         // Stop the test
         Test.stopTest();
         
         // Create the instance of the 
         RelationQueriesSoql relationshipQueriesInstance = new RelationQueriesSoql(); 
         
         // Check for result
         System.assertEquals(0,
           relationshipQueriesInstance.retriveActiveContactsFromAccounts().size());
    }
    
    /**
     * This is a Method that queries on Contact to retrieve all active contacts belonging 
     * to Non 'media' Industry. It Also displays the name of the account to which it is associated 
     * to.
     */
     static testMethod void associatedContactForActiveAccountDifferentCity() 
     {
         // Create the instance of the list of account.
         List<Account> accountList = new List<Account>();
         
         // Create the instance of the list of contact.
         List<Contact> contactList = new List<Contact>();
         
         // Create the record of account
         Account accountInstance = new Account(
                                              Name = 'TestAccount',
                                              Industry = 'Energy',
                                              Active__c = 'Yes');
         
         // Add account record the list
         accountList.add(accountInstance);
         
         // Start the test
         Test.startTest();
         
         // Insert account List
         insert accountList;
         
         // Check for the size of List that is been Inserted.
         System.assertEquals(1, accountList.size());
         
         // Create the record of contact
         Contact contactInstance = new Contact(
                                           LastName = 'TestContact', 
                                           AccountId = accountInstance.Id);
         
         // Add Contact record to the list
         contactList.add(contactInstance);
         
         // Insert Contact List
         insert contactList;
         
         // Check for the size of List that is been Inserted.
         System.assertEquals(1, contactList.size());
         
         // Stop the test
         Test.stopTest();
         
         // Create the instance of the 
         RelationQueriesSoql relationshipQueriesInstance = new RelationQueriesSoql(); 
         
         // Check for result
         System.assertEquals(0,
         relationshipQueriesInstance.retriveActiveContactsFromAccounts().size());
    }
    
    /**
     * This is a Method that queries on Contact to retrieve all Inactive contacts belonging 
     * to Non 'media' Industry. It Also displays the name of the account to which it is associated 
     * to.
     */
     static testMethod void associatedContactForInActiveAccountDifferentCity() 
     {
         // Create the instance of the list of account.
         List<Account> accountList = new List<Account>();
         
         // Create the instance of the list of contact.
         List<Contact> contactList = new List<Contact>();
         
         // Create the record of account
         Account accountInstance = new Account(
                                              Name = 'TestAccount',
                                              Industry = 'Energy',
                                              Active__c = 'No');
         
         // Add account record the list
         accountList.add(accountInstance);
         
         
         
         // Start the test
         Test.startTest();
         
         // Insert account List
         insert accountList;
         
         // Check for the size of List that is been Inserted.
         System.assertEquals(1, accountList.size());
         
         // Create the record of contact
         Contact contactInstance = new Contact(
                                           LastName = 'TestContact', 
                                           AccountId = accountInstance.Id);
         contactList.add(contactInstance);   
         
         // Insert Contact List
         insert contactList;
         
         // Check for the size of List that is been Inserted.
         System.assertEquals(1, contactList.size());
         
         // Stop the test
         Test.stopTest();
         
         // Create the instance of the 
         RelationQueriesSoql relationshipQueriesInstance = new RelationQueriesSoql(); 
         
         // Check for result
         System.assertEquals(0,
          relationshipQueriesInstance.retriveActiveContactsFromAccounts().size());
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
        
        // Start the test
        Test.startTest();
         
        // Insert account List
        insert accountList;
        
        // Check for the size of List that is been Inserted.
        System.assertEquals(1, accountList.size());
          
        // Create the record of contact
        Contact contactInstance = new Contact(
                                           LastName = 'John', 
                                           AccountId = accountInstance.Id);
        // Add the records to the List
        contactList.add(contactInstance);   
         
        // Insert Contact List
        insert contactList;
        
        // Check for the size of List that is been Inserted.
        System.assertEquals(1, contactList.size()); 
        
        // Stop the test
        Test.stopTest();
         
        // Create the instance of the class
        RelationQueriesSoql relationshipQueriesInstance = new RelationQueriesSoql(); 
        
        // Check for the search
        System.assertEquals(1,
           relationshipQueriesInstance.retriveAccountAndRelatedContactsWhichContainsJohn().size());
    }
    
   /**
    *  This is a Method to fetch Accounts and find all associated contact records of the Account
    *  which contains the word 'John'. Print all Account and Contact records retrieved above.
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
        
        // Start the test
        Test.startTest();
         
        // Insert account List
        insert accountList;
         
        // Check for the size of List that is been Inserted.
        System.assertEquals(1, accountList.size());
        
        // Create the record of contact
        Contact contactInstance = new Contact(
                                           LastName = 'TestContact', 
                                           AccountId = accountInstance.Id);
        contactList.add(contactInstance);   
         
        // Insert Contact List
        insert contactList;
        
        // Check for the size of List that is been Inserted.
        System.assertEquals(1, contactList.size()); 
        
        // Stop the test
        Test.stopTest();
         
        // Create the instance of the class
        RelationQueriesSoql relationshipQueriesInstance = new RelationQueriesSoql(); 
        
        // Check for the search
        System.assertEquals(0,
          relationshipQueriesInstance.retriveAccountAndRelatedContactsWhichContainsJohn().size());
    }
    
    /**
    *  This is a Method to fetch Accounts and find all associated contact records of the Account
    *  which contains the word 'John'. Print all Account and Contact records retrieved above.
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
        
        // Start the test
        Test.startTest();
         
        // Insert account List
        insert accountList;
        
        // Check for the size of List that is been Inserted.
        System.assertEquals(1, accountList.size()); 
         
        // Create the record of contact
        Contact contactInstance = new Contact(
                                           LastName = 'TestJohn', 
                                           AccountId = accountInstance.Id);
        // Add the records to the list
        contactList.add(contactInstance);   
         
        // Insert Contact List
        insert contactList;
        
        // Check for the size of List that is been Inserted.
        System.assertEquals(1, contactList.size()); 
         
        // Stop the test
        Test.stopTest();
         
        // Create the instance of the class
        RelationQueriesSoql relationshipQueriesInstance = new RelationQueriesSoql(); 
        
        // Check for the result match.
        System.assertEquals(1,
           relationshipQueriesInstance.retriveAccountAndRelatedContactsWhichContainsJohn().size());
    }
    
   /**
    * This is a Method that has a SOQL query to find all Account records which have at least an 
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
        
        // Start the test
        Test.startTest();
         
        // Insert account List
        insert accountList;
        
        // Check for the size of List that is been Inserted.
        System.assertEquals(1, accountList.size()); 
        
        opportunityList.add(new Opportunity(Name = 'Test',
                                          AccountId = accountInstance.Id,
                                          CloseDate = System.today(),
                                          StageName = 'Closed Won'));
        // Insert Contact List
        insert opportunityList;
         
        // Check for the size of List that is been Inserted.
        System.assertEquals(1, opportunityList.size()); 
        
        // Stop the test
        Test.stopTest();
         
        // Create the instance of the class
        RelationQueriesSoql relationshipQueriesInstance = new RelationQueriesSoql(); 
         
        // Check for the result match.
        System.assertEquals(1,
               relationshipQueriesInstance.findsAccountRecordHavingAtleastOneOpportunity().size());
    }
    
    /**
    * This is a Method that has a SOQL query to find all Account records which have at least an 
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
        
        // Start the test
        Test.startTest();
         
        // Insert account List
        insert accountList;
        
        // Check for the size of List that is been Inserted.
        System.assertEquals(1, accountList.size());
        
        opportunityList.add(new Opportunity(Name = 'Test',
                                          AccountId = accountInstance.Id,
                                          CloseDate = System.today(),
                                          StageName = 'Closed Lost'));
        // Insert Contact List
        insert opportunityList;
         
        // Check for the size of List that is been Inserted.
        System.assertEquals(1, opportunityList.size());
        
        // Stop the test
        Test.stopTest();
         
        // Create the instance of the class
        RelationQueriesSoql relationshipQueriesInstance = new RelationQueriesSoql(); 
         
        // Check for the result match.
        System.assertEquals(0,
              relationshipQueriesInstance.findsAccountRecordHavingAtleastOneOpportunity().size());
    }
    
    
    /**
    * This is a Method that has a SOQL query to find all Account records which does not have at 
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
        
        // Start the test
        Test.startTest();
         
        // Insert account List
        insert accountList;
        
        // Check for the size of List that is been Inserted.
        System.assertEquals(1, accountList.size());
        
        opportunityList.add(new Opportunity(Name = 'Test',
                                          CloseDate = System.today(),
                                          StageName = 'Closed Won'));
        // Insert Contact List
        insert opportunityList;
         
        // Check for the size of List that is been Inserted.
        System.assertEquals(1, opportunityList.size());
        
        // Stop the test
        Test.stopTest();
         
        // Create the instance of the class
        RelationQueriesSoql relationshipQueriesInstance = new RelationQueriesSoql(); 
         
        // Check for the result match.
        System.assertEquals(0,
               relationshipQueriesInstance.findsAccountRecordHavingAtleastOneOpportunity().size());
    }
    
    /**
     * This is a test method that will retrieve all records of 'C' with name 'John' 
     *  along with parent details.
     */
     static testmethod  void recordsOfCWithNameJohn()
     {
        // Creates the record for A Object 
        A__c instanceOfA = new A__c(Name = 'Test');
         
        // Creates the record for B Object
        B__c instanceOfB = new B__c(Name = 'Test');
        
        // Start the Test
        Test.startTest(); 
         
        // Insert the record of A
        insert instanceOfA;
         
        // Check for the record is Inserted.
        System.assertNotEquals(null, instanceOfA.Id);
         
        // Insert the record of B
        insert instanceOfB;
         
        // Check for the record is Inserted.
        System.assertNotEquals(null, instanceOfB.Id);
        
        // Creates the record for C Object
        C__c instanceOfC = new C__c(Name = 'John', 
                                     A_relation__c = instanceOfA.Id,
                                     Bs__c = instanceOfB.Id);
        // Insert the record of C
        insert instanceOfC;
         
        // Check for the record is Inserted.
        System.assertNotEquals(null, instanceOfC.Id);
         
        // Stop the test
        Test.stopTest();
         
        // Create the instance of the class
        RelationQueriesSoql relationshipQueriesInstance = new RelationQueriesSoql(); 
                         
        System.assertEquals(1,
        relationshipQueriesInstance.retriveRecordsFromAWhereChildnameisJohn().size());
    } 
    
    
    /**
     * This is a test method that will retrieve all records of 'C' without name 'John' 
     *  along with parent details.
     */
     static testmethod  void recordsOfCWithOutNameJohn()
     {
         // Creates the record for A Object 
         A__c instanceOfA = new A__c(Name = 'Test');
         
         // Creates the record for B Object
         B__c instanceOfB = new B__c(Name = 'Test');
         
         // Start the Test
         Test.startTest(); 
         
         // Insert the record of A
         insert instanceOfA;
         
         // Check for the record is Inserted.
         System.assertNotEquals(null, instanceOfA.Id);
         
         // Insert the record of B
         insert instanceOfB;
         
         // Check for the record is Inserted.
         System.assertNotEquals(null, instanceOfB.Id);
         
         // Creates the record for C Object
         C__c instanceOfC = new C__c(Name = 'Test', 
                                     A_relation__c = instanceOfA.Id,
                                     Bs__c = instanceOfB.Id);
         // Insert the record of C
         insert instanceOfC;
         
         // Check for the record is Inserted.
         System.assertNotEquals(null, instanceOfC.Id);
         
         // Stop the test
         Test.stopTest();
         
         // Create the instance of the class
         RelationQueriesSoql relationshipQueriesInstance = new RelationQueriesSoql(); 
                          
         System.assertEquals(0,
             relationshipQueriesInstance.retriveRecordsFromAWhereChildnameisJohn().size()); 
    }  
}
