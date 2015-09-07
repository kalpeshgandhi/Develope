/**
 * This is a test method that checks the functionality of a visual force pages that has the 
 * functionality such as display the account list, contact list, search for the contact from the 
 * list a to z, search accounts and manage there respective -
 * based on the email domain specified in the primary email of contact.
 */
@isTest
private class TestforVisualForcePages {
   /**
    * This is a method that tests the list of account is displayed on the vf page.
    */
    static testMethod void displayTheAccount()
    {
        // Assign the list returned from data factory to a new instance of the account list 
        List<Account> accountInstanceList = TestDataFactory.accountTestData(10);

        // Check for the size of account list matches expected values
        System.assertEquals(10,accountInstanceList.size());

        // Insert the account list
        insert accountInstanceList;

        // Fetch the record
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
        System.assertEquals(10, accountListInstance.size());

         // Start the test
        Test.startTest();

        // Create a page reference for the account Page.
        PageReference accountPageInstance = Page.AccountPage;

        // Set the current page reference to the account page 
        Test.setCurrentPage(accountPageInstance);

        // Create an instance of the controller
        AccountAndContactController controllerInstance = new AccountAndContactController();

        // Print the value of all the account list
        controllerInstance.getAccountList();

        // Stop the test
        Test.stopTest();

        // Check for the total account Size
        System.assertEquals(10,controllerInstance.countSizeOfList);
    }

   /**
    * This is a method that will test the functionality to search account from the account list.
    */
    static testMethod void searchAccount()
    {
         // Assign the list returned from data factory to a new instance of the account list 
         List<Account> accountInstanceList = TestDataFactory.accountTestData(10);

         // Check for the size of account list matches expected values
         System.assertEquals(10,accountInstanceList.size());

         // Insert the account List
         insert accountInstanceList;

         // Fetch the record
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
         System.assertEquals(10, accountListInstance.size());

        // Create a page reference for the account Page.
        PageReference accountPageInstance = Page.AccountPage;

        // Set the current page reference to the account page 
        Test.setCurrentPage(accountPageInstance);

        // Create an instance of the controller.
        AccountAndContactController controllerInstance = new AccountAndContactController();

        // Print the value of all the account list.
        controllerInstance.getAccountList();

        // Check for the total account size.
        System.assertEquals(10,controllerInstance.countSizeOfList);

        // Start the test
        Test.startTest();

        // Set the search string as 'TestAccount'.
        controllerInstance.searchStringAccount = 'TestAccount';
        
        // Search for the related account.
        controllerInstance.searchResultAccount();

        // Print the value of all the account list.
        controllerInstance.getAccountList();

        // Stop the test
        Test.stopTest();

        // Check for the total account size.
        System.assertEquals(10,controllerInstance.countSizeOfList);
        

    }

/**
    * This is a method that will test the functionality to give error if the length of the search 
    * string to search account is less then 3 from the account list.
    */
    static testMethod void searchAccountError()
    {
        // Assign the list returned from data factory to a new instance of the account list 
        List<Account> accountInstanceList = TestDataFactory.accountTestData(10);

        // Check for the size of account list matches expected values
        System.assertEquals(10,accountInstanceList.size());

        // Insert the account List
        insert accountInstanceList;

        // Fetch the record
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
        System.assertEquals(10, accountListInstance.size());

        // Create a page reference for the account page.
        PageReference accountPageInstance = Page.AccountPage;

        // Set the current page reference to the account page 
        Test.setCurrentPage(accountPageInstance);

        // Create an instance of the controller.
        AccountAndContactController controllerInstance = new AccountAndContactController();

        // Print the value of all the account list.
        controllerInstance.getAccountList();

        // Check for the total account size.
        System.assertEquals(10,controllerInstance.countSizeOfList);

        // Start the test
        Test.startTest();

        // If the search string length is less then 2 then generate the message page error.
        controllerInstance.searchStringAccount = 'Te';

        // Search the related account.
        controllerInstance.searchResultAccount();

        // Print the value of all the account list.
        controllerInstance.getAccountList();

        // Stop the test
        Test.stopTest();

        // Create an instance of the apex page messages.
        List<Apexpages.Message> pageMessages = ApexPages.getMessages();

        // Checks the no of messages that are generated from the page.
        System.assertEquals(1,pageMessages.size());
    }

    /**
     * This is a method that will test the functionality to search contact associated to the 
     * account list.
     */
     static testMethod void associatedContactForAccount() 
     { 
         // Create a page reference for the account page.
         PageReference pageRefrenceInstance = Page.AccountPage;

         // Set the current page reference to the account page 
         Test.setCurrentPage(pageRefrenceInstance);

         // Create the instance of the account
         Account accountInstance = new Account();

         // Create a record
         accountInstance.Name = 'AccountPageTest';

         // Insert the account instance 
         insert accountInstance;

         // Check for the record is inserted.
         System.assert(String.isNotBlank(accountInstance.Id));

         // Create instance of a contact list
         List<Contact> contactInstance = new List<Contact>();

         // Iterate to insert the 10 records.
         for(integer i = 0; i < 10; i++) 
         { 
               // Add the contacts to the list 
               contactInstance.add(new Contact (LastName = 'ContactPageTest'+i,
                                                AccountId = accountInstance.Id));
         }

         // Check the contacts are inserted or not.
         System.assertEquals(10,contactInstance.size());

         // Insert the contact list
         insert contactInstance;

         // Fetch the record
         List<Contact> contactListInstance = 
            [
                SELECT 
                    Id,
                    Name
                FROM
                    Contact
                WHERE
                    Name LIKE 'ContactPageTest%'
            ];

         // Check if the record is inserted or not.
         System.assertEquals(10, contactListInstance.size());

         // Create the instance of the controller 
         AccountAndContactController controllerInstance = new AccountAndContactController();

         // assign the account id to the idAccount which is a property of the controller
         controllerInstance.idAccount = accountInstance.Id;

         // Add the key and value to the map.
         pageRefrenceInstance.getParameters().put('accountid',controllerInstance.idAccount);

         // Create the page reference
         PageReference pageReferenceforcontact = controllerInstance.gotoContact();

         // Set the current page as contact 
         Test.setCurrentPage(pageReferenceforcontact);

         // Checks the url returned and the expected url matches.
         System.assertEquals('/apex/contactpages?accountid='+accountInstance.Id,
         controllerInstance.gotoContact().getURL());

         // Check for the parameters matches
         System.assertEquals(accountInstance.Id,
            pageReferenceforcontact.getParameters().get('accountid'));

         // Start the test
         Test.startTest();
 
         // Get the list of contact
         controllerInstance.getContactList();

         // Stop the test
         Test.stopTest();

         // Check for the size of the contact list equals to 10
         System.assertEquals(10,controllerInstance.countSizeOfList);
    }

    /**
     * This is a method that will test the functionality to print wrapper list.
     */
     static testMethod void testForPrintingWrapperList() 
     { 
         // Create a page reference for the account page.
         PageReference pageRefrenceInstance = Page.AccountPage;

         // Set the current page reference to the account page 
         Test.setCurrentPage(pageRefrenceInstance);

         // Create the instance of the account
         Account accountInstance = new Account();

         // Create a record
         accountInstance.Name = 'AccountPageTest';

         // Insert the account instance 
         insert accountInstance;

         // Check for the record is inserted.
         System.assert(String.isNotBlank(accountInstance.Id));

         // Create instance of a contact list
         List<Contact> contactInstance = new List<Contact>();

         // Iterate to insert the 10 records.
         for(integer i = 0; i < 10; i++) 
         { 
               // Add the contacts to the list 
               contactInstance.add(new Contact (LastName = 'ContactPageTest'+i,
                                                AccountId = accountInstance.Id));
         }

         // Check the contacts are inserted or not.
         System.assertEquals(10,contactInstance.size());

         // Insert the contact list
         insert contactInstance;

         // Fetch the record
         List<Contact> contactListInstance = 
            [
                SELECT 
                    Id,
                    Name
                FROM
                    Contact
                WHERE
                    Name LIKE 'ContactPageTest%'
            ];

         // Check if the record is inserted or not.
         System.assertEquals(10, contactListInstance.size());

         // Create the instance of the controller 
         AccountAndContactController controllerInstance = new AccountAndContactController();

         // assign the Account id to the idAccount which is a property of the controller
         controllerInstance.idAccount = accountInstance.Id;

         // Add the key and value to the map.
         pageRefrenceInstance.getParameters().put('accountid',controllerInstance.idAccount);

         // Create the page reference
         PageReference pageReferenceforcontact = controllerInstance.gotoContact();

         // Set the current page as contact 
         Test.setCurrentPage(pageReferenceforcontact);

         // Checks the url returned and the expected url matches.
         System.assertEquals('/apex/contactpages?accountid='+accountInstance.Id,
            controllerInstance.gotoContact().getURL());

         // Check for the parameters matches
         System.assertEquals(accountInstance.Id,
            pageReferenceforcontact.getParameters().get('accountid'));
 
         // Start the test
         Test.startTest();
 
         // Get the list of contact
         controllerInstance.getwrapperList();

         // Stop the test
         Test.stopTest();

         // Check for the size of the contact list equals to 10
         System.assertEquals(10,controllerInstance.countSizeOfList);
    }


    /**
     * This is a method that will test the functionality to delete multiple contacts.
     */
     static testMethod void testForMultipleDelete() 
     { 
         // Create a page reference for the account page.
         PageReference pageRefrenceInstance = Page.AccountPage;

         // Set the current page reference to the account page 
         Test.setCurrentPage(pageRefrenceInstance);

         // Create the instance of the account
         Account accountInstance = new Account();

         // Create a record
         accountInstance.Name = 'AccountPageTest';

         // Insert the account instance 
         insert accountInstance;

         // Check for the record is inserted.
         System.assert(String.isNotBlank(accountInstance.Id));

         // Create instance of a contact list
         List<Contact> contactInstance = new List<Contact>();

         // Iterate to insert the 10 records.
         for(integer i = 0; i < 10; i++) 
         { 
               // Add the contacts to the list 
               contactInstance.add(new Contact (LastName = 'ContactPageTest'+i,
                                                AccountId = accountInstance.Id));
         }

         // Check the contacts are inserted or not.
         System.assertEquals(10,contactInstance.size());

         // Insert the contact list
         insert contactInstance;

         // Fetch the record
         List<Contact> contactListInstance = 
            [
                SELECT 
                    Id,
                    Name
                FROM
                    Contact
                WHERE
                    Name LIKE 'ContactPageTest%'
            ];

         // Check if the record is inserted or not.
         System.assertEquals(10, contactListInstance.size());

         // Create the instance of the controller 
         AccountAndContactController controllerInstance = new AccountAndContactController();

         // assign the account id to the idAccount which is a property of the controller
         controllerInstance.idAccount = accountInstance.Id;

         // Add the Key and Value to the map.
         pageRefrenceInstance.getParameters().put('accountid',controllerInstance.idAccount);

         // Create the page reference
         PageReference pageReferenceforcontact = controllerInstance.gotoContact();

         // Set the current page as contact 
         Test.setCurrentPage(pageReferenceforcontact);

         // Checks the url returned and the expected url matches.
         System.assertEquals('/apex/contactpages?accountid='+accountInstance.Id,
            controllerInstance.gotoContact().getURL());

         // Check for the parameters matches
         System.assertEquals(accountInstance.Id,
            pageReferenceforcontact.getParameters().get('accountid'));
         
         // Get the list of contact
         controllerInstance.getwrapperList();
         
         // Check for the size of the contact list equals to 10
         System.assertEquals(10,controllerInstance.countSizeOfList);
         
         for(AccountAndContactController.WrapperForBindingCheckBoxWithContact wrapperInstance :
         controllerInstance.wrapperList)
         {
             wrapperInstance.checkBoxInstance = true;
         }
         // Start the test
         Test.startTest();
 
         // Get the list of contact
         controllerInstance.deleteMultipleContact();

         // Stop the test
         Test.stopTest();

         // Check for the size of the contact list equals to 10
         System.assertEquals(10,controllerInstance.countSizeOfList);
    }
    
    
    /**
     * This is a method that will test the functionality to delete contact associated to the 
     * account.
     */
     static testMethod void testForDeleteContact() 
     { 
         // Create a page reference for the account page.
         PageReference pageRefrenceInstance = Page.AccountPage;

         // Set the current page reference to the account page 
         Test.setCurrentPage(pageRefrenceInstance);

         // Create the instance of the account
         Account accountInstance = new Account();

         // Create a record
         accountInstance.Name = 'AccountPageTest';

         // Insert the account instance 
         insert accountInstance;

         // Check for the record is inserted.
         System.assert(String.isNotBlank(accountInstance.Id));

         // Create instance of a contact list
         List<Contact> contactInstance = new List<Contact>();

         // Iterate to insert the 10 records.
         for(integer i = 0; i < 10; i++) 
         { 
               // Add the contacts to the list 
               contactInstance.add(new Contact (LastName = 'ContactPageTest'+i,
                                                AccountId = accountInstance.Id));
         }

         // Check the contacts are inserted or not.
         System.assertEquals(10,contactInstance.size());

         // Insert the contact list
         insert contactInstance;

         // Fetch the record
         List<Contact> contactListInstance = 
            [
                SELECT 
                    Id,
                    Name
                FROM
                    Contact
                WHERE
                    Name LIKE 'ContactPageTest%'
            ];

         // Check if the record is inserted or not.
         System.assertEquals(10, contactListInstance.size());

         // Create the instance of the controllerInstance 
         AccountAndContactController controllerInstance = new AccountAndContactController();

         // assign the account id to the idAccount which is a property of the Controller
         controllerInstance.idAccount = accountInstance.Id;

         // Add the key and value to the map.
         pageRefrenceInstance.getParameters().put('accountid',controllerInstance.idAccount);

         // Create the page reference
         PageReference pageReferenceforcontact = controllerInstance.gotoContact();

         // Set the current page as contact 
         Test.setCurrentPage(pageReferenceforcontact);

         // Checks the url returned and the expected url matches.
         System.assertEquals('/apex/contactpages?accountid='+accountInstance.Id,
         controllerInstance.gotoContact().getURL());

         // Check for the parameters matches
         System.assertEquals(accountInstance.Id,
            pageReferenceforcontact.getParameters().get('accountid'));

         // Fetch all the contact list
         controllerInstance.getContactList();
         
         // Start the test
         Test.startTest();

         // Delete the contact by calling the delete related contact
         AccountAndContactController.deleteRelatedContact(contactInstance[2].Id);
         
         // Stop the test
         Test.stopTest();
         
         // Print the contact list
         controllerInstance.getContactList();  

         // Checks the value of the contacts list size matches to the present contact.
         System.assertEquals(9,controllerInstance.countSizeOfList);
    }
    
    /**
     * This is a method that will test the functionality to return back to the account page when 
     * return button on the contact page is pressed.
     */
     static testMethod void testForReturnButton() 
     { 
         // Create a page reference for the account page.
         PageReference pageRefrenceInstance = Page.AccountPage;

         // Set the current page reference to the account page 
         Test.setCurrentPage(pageRefrenceInstance);

         // Create the instance of the controller 
         AccountAndContactController controllerInstance = new AccountAndContactController();

         // Create the page reference
         PageReference pageReferenceforcontact = controllerInstance.gotoContact();

         // Set the current page as contact 
         Test.setCurrentPage(pageReferenceforcontact);
         
         // Start the test
         Test.startTest();
         
         // Test return button
         PageReference pageReturn = controllerInstance.returnToAccount();

         // Set the current page as account 
         Test.setCurrentPage(pageReturn);

         // Stop the test
         Test.stopTest();

         // Check the url of the account page and the returned url after pressing the return button
         System.assertEquals('/apex/accountpage',controllerInstance.returnToAccount().getURL());
    }
    
    /**
     * This is a method that will test the functionality of add contact button on contact page when 
     * add button on the contact page is pressed.
     */
     static testMethod void testForAddButton() 
     { 
         // Create the instance of the account
         Account accountInstance = new Account();

         // Create a record
         accountInstance.Name = 'AccountPageTest';

         // Insert the account instance 
         insert accountInstance;

         // Check for the record is inserted.
         System.assert(String.isNotBlank(accountInstance.Id));
         
         // Create a page reference for the account page.
         PageReference pageRefrenceInstance = Page.AccountPage;

         // Set the current page reference to the account page 
         Test.setCurrentPage(pageRefrenceInstance);

         // Create the instance of the controller 
         AccountAndContactController controllerInstance = new AccountAndContactController();
         
         // Set the account ID to the property of the controller.
         controllerInstance.idAccount = accountInstance.Id;
         
         // Create the page reference
         PageReference pageReferenceforcontact = controllerInstance.gotoContact();

         // Set the current page as contact 
         Test.setCurrentPage(pageReferenceforcontact);
         
         // Set the account id to the property of the controller.
         controllerInstance.contactLastName = 'TestAddContact';

         // Print the contact list
         controllerInstance.getContactList();  

         // Checks the value of the contacts list size matches to the present contact.
         System.assertEquals(0,controllerInstance.countSizeOfList);
         
         // Start the test
         Test.startTest();
         
         // Fetch all the contact list
         controllerInstance.addContact();
         
         // Stop the test
         Test.stopTest();
         
         // Print the contact list
         controllerInstance.getContactList();  

         // Checks the value of the contacts list size matches to the present contact.
         System.assertEquals(1,controllerInstance.countSizeOfList);
     }


   /**
    * This is a method that will test the functionality to search contacts according to the word 
    * searched and then display the list of the contact.
    */
    static testMethod void contactAlphabetSearchPage() 
    { 
        // Assign the list returned from data factory to a new instance of the account list 
        List<Account> accountInstanceList = TestDataFactory.accountTestData(1);

        // Check for the size of account list matches expected values
        System.assertEquals(1,accountInstanceList.size());

        // Insert the account list
        insert accountInstanceList;

         // Fetch the record
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
         System.assertEquals(1, accountListInstance.size());

        // Assign the list returned from data factory to a new instance of the contact list
        List<Contact> contactInstanceList = 
            TestDataFactory.contactTestData(10,accountInstanceList[0].Id);

        // Check for the size of account list matches expected values
        System.assertEquals(10,contactInstanceList.size());

        // Insert the contact list
        insert contactInstanceList;
        
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
        System.assertEquals(10, contactListInstance.size());

        // Create the instance of the controller
        AccountAndContactController controllerInstance = new AccountAndContactController();

        // Create the instance of the page
        PageReference pageRefrenceInstance = Page.AccountPage;

        // Set the current page as contact Page
        Test.setCurrentPage(pageRefrenceInstance);

        // Assign the account ID to the property
        controllerInstance.idAccount = accountInstanceList[0].Id;

        System.debug(controllerInstance.idAccount);

        // Create the instance of the page
        PageReference pageRef = controllerInstance.gotoContact();

        // Set the current page as contact Page
        Test.setCurrentPage(pageRef);

        // Start the test
        Test.startTest();

        // Set the alphabet name to search the contacts related to it.
        controllerInstance.alphabetName = 'T';

        // Call the method that is called from the controller
        controllerInstance.getContactList();

        // Stop the test
        Test.stopTest();

        // Check the list of the contacts starting with T
        System.assertEquals(10,controllerInstance.countSizeOfList);
    }
   
   /**
    * This is a method that will test the functionality to clear the search results text box when 
    * clear button is pressed.
    */
    static testMethod void testForClearButton() 
    { 
        // Create the instance of the controller
        AccountAndContactController controllerInstance = new AccountAndContactController();

        // Set the search string as TestAccount.
        controllerInstance.searchStringAccount = 'TestAccount';

        // Start the test
        Test.startTest();

        // Test to clear the search text box
        controllerInstance.clearSearchResult();

        // Stop the test
        Test.stopTest();

        // check the value of searchStringAccount.
        System.assertEquals('',controllerInstance.searchStringAccount);
    }
    
   /**
    * This is a method that will test the functionality to check the list of a to z 
    * list will be printed or not.
    */
     static testMethod void CheckTheListAtoZ() 
     {
         // Creae the instance of the controller
         AccountAndContactController controllerInstance = new AccountAndContactController();
           
         // Create the list of the string
         List<String> StringList = new List<String>();

         // Start the test
         Test.startTest();

         // Returns the list of the string
         StringList = controllerInstance.getlistAToZInstance();

         // Stop the test
         Test.stopTest();

         // Checks the size of the stringList
         System.assertEquals(26,StringList.size());
      }
}
