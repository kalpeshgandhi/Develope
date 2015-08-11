/**
 * This is a test method that checks the functionality to automatically assign respective account 
 * based on the email domain specified in the primary email of contact.
 */
@isTest
private class TestOnContactToAssignAccount 
{
 /**
  * This is the Positive Test Method Automatically associate a Contact created 
  * with the respective Account based on the email domain 
  * specified in the primary email address of the Contact.
  */
    static testMethod void automaticallyAssignContactTest() 
    {
       // It creates the test data for the account.
       Account accountTestData=new Account(Name='TestAccount',
                                           Website='http:http://www.testforce.com'); 
       
       // Create a instance list of contact.
       List<Contact> contactList=new List<Contact>();
       
       // Start of the for loop
       for(integer i=0;i<200;i++)
       {
                // Add The 200 contacts to the list.
                contactList.add(new Contact(LastName='testContact'+i,
                                            Email='test@testforce.com'));
       } // End of the for loop
       
       // Start the test
       Test.startTest();
       
       // Insert the account list
       insert accountTestData;
       
       // Insert the contact list
       insert contactList;
       
       // Check all the contacts are inserted or not.
       System.assertequals(200,contactList.Size());
       
       // Stop the test
       Test.stopTest();
       
       // Fetch the contacts in a list having the name as testContact.
       List<Contact> contacttestList=[
                                      SELECT id,
                                             AccountId 
                                      FROM Contact
                                      WHERE Name 
                                      LIKE 'testContact%'];
                                      
       // Iterate over the contact list.
       for(Contact contactTest:contacttestList)
       {
             // Check wheter the excepted value and actual value are same.
             System.assertequals(accountTestData.id,contactTest.Accountid);
       }
  }
          
 /**
  * This is the negative test method where email is kept blank when need to automatically associate 
  * a contact created with the respective account based on the email domain 
  * specified in the primary email address of the contact.
  */  
    static testMethod void noEmailProvidedTest() 
    {
        // It creates the test data for the account.
        Account accountTestData=new Account(
                                            Name='TestAccount',
                                            Website='http:http://www.testforce.com/'); 
         
        // Create a instance list of contact.
        List<Contact> contactList=new List<Contact>();
        
        // Start of the for loop
        for(integer i=0;i<200;i++)
        {
             // Add The 200 contacts to the list with the email as blank.
             contactList.add(new Contact(LastName='testContactNoEmail'+i,Email=''));
        }// End of the For Loop.
        
        // Start the Test
        Test.startTest();
        
        // Insert the account List
        insert accountTestData;

        // Insert the contact list
        insert contactList;
        
        // Check the contacts are inserted or not.
        System.assertequals(200,contactList.Size());
        
        // Stop the test
        Test.stopTest();
        
        // Fetch the contacts in a list having the name as testContactNoEmail.
        List<Contact> contacttestList=[
                                       SELECT id,AccountId 
                                       FROM Contact
                                       WHERE Name 
                                       LIKE 'testContactNoEmail%'];
        
        // Iterate over the contat list.
        for(Contact contactTest:contacttestList)
        {
            // Check wheter the excepted value and actual value are same.
            System.assertequals(null,contactTest.Accountid);
        }
    }

 /**
  * This is the Negative Test Method where Account Website is kept Blank when Need to 
  * Automatically associate a Contact created with the respective Account based on the email domain 
  * specified in the primary email address of the Contact.
  */  
    static testMethod void noWebsiteProvidedTest() 
    {
          // It creates the test data for the account having the website field blank.
        Account accountTestData=new Account(Name='TestAccount',Website='');
        
         // Create a Instance list of contact. 
        List<Contact> contactList=new List<Contact>();
        
         // Start of the for loop
        for(integer i=0;i<200;i++)
        {
            // Add The 200 contacts to the list.
            contactList.add(new Contact(
                                        LastName='testContactNoWebsite'+i,
                                        Email='test@testforce.com'));
        }// End of the for loop.
        
        // Start the test
        Test.startTest();
        
        // Insert the account List
        insert accountTestData;
        
        // Insert the contact List
        insert contactList;
        
        // Stop the test
        Test.stopTest();
         // Fetch the contacts in a list having the name as testContactNoWebsite.
        List<Contact> contacttestList=[
                                      SELECT id,AccountId 
                                      FROM Contact
                                      WHERE Name 
                                      LIKE 'testContactNoWebsite%'];
                                      
        // Iterate over the contat List.
        for(Contact contactTest:contacttestList)
        {
            // Check wheter the excepted value and actual value are same.
            System.assertequals(null,contactTest.Accountid);
        }
    }

 /**
  * This is the Negative Test Method where Account Email And Website Does Not match when Need to 
  * Automatically associate a Contact created with the respective Account based on the email domain 
  * specified in the primary email address of the Contact.
  */  
    static testMethod void wrongProvidedTest() 
    {
        // It creates the test data for the account.
        Account accountTestData=new Account(Name='TestAccount',
                                            Website='http:/www.google.com'); 
        
        // Create a instance list of contact.
        List<Contact> contactList=new List<Contact>();
        
        // Start of the for loop
        
        for(integer i=0;i<200;i++)
        {
            contactList.add(new Contact(LastName='testContactdatamismatch'+i,
                                        Email='test@testforce.com'));
        }// End of the for loop.
        
        // Start the test
        Test.startTest();
        
        // Insert the account list
        insert accountTestData;
        
        // Insert the contact list
        insert contactList;
        
        // Check the contacts are inserted or not.
        System.assertequals(200,contactList.Size());
       
        // Stop the test
        Test.stopTest();
        
        // Fetch the contacts in a list having the name as testContact.
        List<Contact> contacttestList=[
                                       SELECT id,
                                              AccountId 
                                       FROM Contact
                                       WHERE Name 
                                       LIKE 'testContact%'];
        // Iterate Over the Contat List.
        for(Contact contactTest:contacttestList)
        {
            // Check Wheter the excepted value and actual value are same.
            System.assertequals(null,contactTest.AccountId);
        }
    }
}