/**
 * This is a test method that checks the functionality to automatically assign respective account 
 * based on the email domain specified in the primary email of contact.
 */
@isTest
private class TestOnContactToAssignAccount 
{
 /**
  * This is the positive test method automatically associate a contact created 
  * with the respective account based on the email domain 
  * specified in the primary email address of the contact.
  */
    static testMethod void automaticallyAssignContactTest() 
    {
       // Assign the list returned from data factory to a new instance of the Account List 
       List<Account> accountInstanceList=TestDataFactory.accountTestData(1);
       
       // Assign the list returned from data factory to a new instance of the Contact List
       List<Contact> contactInstanceList=TestDataFactory.contactTestData(200);
       
       // Start the test
       Test.startTest();
       
       // Insert the account list
       insert accountInstanceList;
       
       // Check all the account are inserted or not.
       System.assertEquals(1,accountInstanceList.size());
       
       // Insert the contact list
       insert contactInstanceList;
       
       // Check all the contacts are inserted or not.
       System.assertEquals(200,contactInstanceList.size());
       
       // Stop the test
       Test.stopTest();
       
       // Fetch the accounts in a list having the name as TestAccount.
       List<Account> accountTestList=[
                                      SELECT Id
                                      FROM Account
                                      WHERE Name 
                                      LIKE 'TestAccount%'];
                                      
       // Fetch the contacts in a list having the name as testContact.
       List<Contact> contactTestList=[
                                      SELECT Id,
                                             AccountId 
                                      FROM Contact
                                      WHERE Name 
                                      LIKE 'testContact%'];
       // Iterate over the contact list.
       for(Contact contactTest : contactTestList)
       {
             // Check whether the excepted value and actual value are same.
             System.assertEquals(accountTestList[0].Id,contactTest.AccountId);
       }
  }
          
          
 /**
  * This is the negative test method where email is kept blank when need to automatically associate 
  * a contact created with the respective account based on the email domain 
  * specified in the primary email address of the contact.
  */  
    static testMethod void noEmailProvidedTest() 
    {
         // Assign the list returned from data factory to a new instance of the Account List 
       List<Account> accountInstanceList=TestDataFactory.accountTestData(1);
       
        // Create an instance list of contact.
        List<Contact> contactList = new List<Contact>();
         
        // Start of the for loop
        for(Integer i=0;i<200;i++)
        {
             // Add The 200 contacts to the list with the email as blank.
             contactList.add(new Contact(LastName='testContactNoEmail'+i,Email=''));
        } // End of the for Loop.
        
        // Start the test
        Test.startTest();
        
        // Insert the account list
        insert accountInstanceList;
        
        // Check all the account are inserted or not.
        System.assertEquals(1,accountInstanceList.size());

        // Insert the contact list
        insert contactList;

        // Check the contacts are inserted or not.
        System.assertEquals(200,contactList.size());
        
        // Stop the test
        Test.stopTest();
        
        // Fetch the contacts in a list having the name as testContactNoEmail.
        List<Contact> contactTestList=[
                                       SELECT Id,
                                              AccountId 
                                       FROM Contact
                                       WHERE Name 
                                       LIKE 'testContactNoEmail%'];
        
        // Iterate over the contact list.
        for(Contact contactTest : contactTestList)
        {
            // Check whether the excepted value and actual value are same.
            System.assertEquals(null,contactTest.AccountId);
        }
    }

 /**
  * This is the negative test method where account website is kept blank when need to 
  * automatically associate a contact created with the respective account based on the email domain 
  * specified in the primary email address of the contact.
  */  
    static testMethod void noWebsiteProvidedTest() 
    {
        // It creates the test data for the account having the website field blank.
        Account accountTestData= new Account(Name='TestAccount',Website='');
        
        // Assign the list returned from data factory to a new instance of the Contact List
        List<Contact> contactInstanceList=TestDataFactory.contactTestData(200);

        // Start the test
        Test.startTest();

        // Insert the account List
        insert accountTestData;

        // Check the contacts are inserted or not.
        System.assertNotEquals(null, accountTestData.Id);

        // Insert the contact list
        insert contactInstanceList;

        // Check all the contacts are inserted or not.
        System.assertEquals(200,contactInstanceList.size());

        // Stop the test
        Test.stopTest();

        // Fetch the contacts in a list having the name as testContactNoWebsite.
        List<Contact> contactTestList=[
                                      SELECT c.Id,
                                             c.AccountId 
                                      FROM Contact c
                                      WHERE c.Name 
                                      LIKE 'testContactNoWebsite%'];
                                      
        // Iterate over the contact List.
        for(Contact contactTest:contactTestList)
        {
            // Check whether the excepted value and actual value are same.
            System.assertEquals(null,contactTest.AccountId);
        }
    }

 /**
  * This is the negative test method where account email and website does not match when need to 
  * automatically associate a contact created with the respective account based on the email domain 
  * specified in the primary email address of the contact.
  */  
    static testMethod void wrongProvidedTest() 
    {
        // It creates the test data for the account.
        Account accountTestData=new Account(Name='TestAccount',
                                            Website='http:/www.google.com'); 
        
        // Create an instance list of contact.
        List<Contact> contactList=new List<Contact>();
        
        // Start of the for loop
        
        for(Integer i=0;i<200;i++)
        {
            contactList.add(new Contact(LastName='testContactdatamismatch'+i,
                                        Email='test@testforce.com'));
        }// End of the for loop.
        
        // Start the test
        Test.startTest();
        
        // Insert the account list
        insert accountTestData;

        // Check the contacts are inserted or not.
        System.assertNotEquals(null, accountTestData.Id);

        // Insert the contact list
        insert contactList;

        // Check the contacts are inserted or not.
        System.assertEquals(200,contactList.size());

        // Stop the test
        Test.stopTest();

        // Fetch the contacts in a list having the name as testContact.
        List<Contact> contactTestList=[
                                       SELECT Id,
                                              AccountId 
                                       FROM Contact
                                       WHERE Name 
                                       LIKE 'testContact%'];

        // Iterate Over the contact list.
        for(Contact contactTest : contactTestList)
        {
            // Check whether the excepted value and actual value are same.
            System.assertEquals(null,contactTest.AccountId);
        }
    }
}
