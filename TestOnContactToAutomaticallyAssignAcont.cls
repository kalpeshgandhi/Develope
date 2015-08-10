@isTest
private class TestOnContactToAutomaticallyAssignAcont 
{
 /**
  * This is the Positive Test Method Automatically associate a Contact created 
  * with the respective Account based on the email domain 
  * specified in the primary email address of the Contact.
  */
    static testMethod void automaticallyAssignContactTest() 
    {
       // It Creates the Test Data for the Account.
       Account AccountTestData=new Account(Name='TestAccount',Website='http:http://www.testforce.com'); 
       // Create a Instance list of Contact.
       List<Contact> contactList=new List<Contact>();
       // Start of the For Loop
       for(integer i=0;i<=200;i++)
            {
                // Add The 200 Contacts to the list.
                contactList.add(new Contact(LastName='testContact'+i,Email='test@testforce.com'));
            }// End of the For Loop
       // Start the Test
       Test.startTest();
       // Insert the Account List
       insert AccountTestData;
       // Insert the Contact List
       insert contactList;
       // Stop the test
       Test.stopTest();
       // Fetch the Contacts in a list Having the name as testContact.
       List<Contact> contacttestList=[Select id,AccountId 
                                      from Contact
                                      where Name 
                                      like'testContact%'];
       // Iterate Over the Contat List.
       for(Contact contactTest:contacttestList)
       {
       // Check Wheter the Excepted Value and Actual Value Are Same.
         System.assertequals(AccountTestData.id,contactTest.Accountid);
       }
  }
          
 /**
  * This is the Negative Test Method where email is kept Blank when Need to Automatically associate 
  * a Contact created with the respective Account based on the email domain 
  * specified in the primary email address of the Contact.
  */  
    static testMethod void noEmailProvidedTest() 
    {
        // It Creates the Test Data for the Account.
        Account AccountTestData=new Account(Name='TestAccount',Website='http:http://www.testforce.com/'); 
         // Create a Instance list of Contact.
        List<Contact> contactList=new List<Contact>();
         // Start of the For Loop
        for(integer i=0;i<=200;i++)
          {
              // Add The 200 Contacts to the list with the Email As Blank.
             contactList.add(new Contact(LastName='testContactNoEmail'+i,Email=''));
          }// End of the For Loop.
        // Start the Test
        Test.startTest();
        // Insert the Account List
        insert AccountTestData;
        // Insert the Contact List
        insert contactList;
        // Stop the test
        Test.stopTest();
        // Fetch the Contacts in a list Having the name as testContactNoEmail.
        List<Contact> contacttestList=[Select id,AccountId 
                                       from Contact
                                       where Name 
                                       like'testContactNoEmail%'];
        // Iterate Over the Contat List.
        for(Contact contactTest:contacttestList)
        {
            // Check Wheter the Excepted Value and Actual Value Are Same.
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
          // It Creates the Test Data for the Account having the Website Field Blank.
        Account AccountTestData=new Account(Name='TestAccount',Website='');
         // Create a Instance list of Contact. 
        List<Contact> contactList=new List<Contact>();
         // Start of the For Loop
        for(integer i=0;i<=200;i++)
        {
            // Add The 200 Contacts to the list.
            contactList.add(new Contact(LastName='testContactNoWebsite'+i,Email='test@testforce.com'));
        }// End of the For Loop.
        // Start the Test
        Test.startTest();
        // Insert the Account List
        insert AccountTestData;
        // Insert the Contact List
        insert contactList;
        // Stop the test
        Test.stopTest();
         // Fetch the Contacts in a list Having the name as testContactNoWebsite.
        List<Contact> contacttestList=[Select id,AccountId 
                                       from Contact
                                       where Name like'testContactNoWebsite%'];
        // Iterate Over the Contat List.
        for(Contact contactTest:contacttestList)
        {
            // Check Wheter the Excepted Value and Actual Value Are Same.
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
          // It Creates the Test Data for the Account.
        Account AccountTestData=new Account(Name='TestAccount',Website='http:/www.google.com'); 
         // Create a Instance list of Contact.
        List<Contact> contactList=new List<Contact>();
         // Start of the For Loop
        for(integer i=0;i<=200;i++)
        {
            contactList.add(new Contact(LastName='testContactdatamismatch'+i,Email='test@testforce.com'));
        }// End of the For Loop.
        // Start the Test
        Test.startTest();
        // Insert the Account List
        insert AccountTestData;
        // Insert the Contact List
        insert contactList;
        // Stop the test
        Test.stopTest();
         // Fetch the Contacts in a list Having the name as testContact.
        List<Contact> contacttestList=[Select id,AccountId 
                                       from Contact
                                       where Name like'testContact%'];
        // Iterate Over the Contat List.
        for(Contact contactTest:contacttestList)
        {
            // Check Wheter the Excepted Value and Actual Value Are Same.
            System.assertequals(null,contactTest.Accountid);
        }
    }
}