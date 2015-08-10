@isTest
private class TestforVisualForcePages {
    
    static testMethod void TestredirectToContacts()
    {
        // Intantiate List of Account 
        List<Account> accountInstance = new List<Account>();
        
        // Iterate over the for loop for 10 values
        for(integer i=0;i<10;i++)
        {
            // Add account instance to account list
            accountInstance.add(new Account (Name='TestPage'+i));
        }
        
        // Insert the account List
        insert accountInstance;
        
        // Check for the Size of Account list matches expected values
        system.assertequals(10,accountInstance.Size());
        
        // Create a page refrence for the Account Page.
        PageReference accountPageInstance = page.ListOfAccountPage;
        
        // Set the Current page refrence to the Account page 
        Test.setCurrentPage(accountPageInstance);
        
        // Crearte a Instance of the Controller
        ListOfAllAccountControler controller = new ListOfAllAccountControler();
        
        // Print the Value of all the Account List
        controller.getAccount();
        // Check for the total Account Size
        system.assertequals(10,controller.accountSize);
        
        // Set the Search String as testPage
        controller.searchStringAccount='TestPage';
        
        // Search For the Related Account 
        controller.SearchResultAccount();
        
        // Print the Value of all the Account List
        controller.getAccount();
        
        // Check for the total Account Size
        system.assertequals(10,controller.accountSize);
        
        // If the Search String length is less then 2 then generate the Message page error.
        controller.searchStringAccount='Te';
        
        // Search the Related Account
        controller.SearchResultAccount();
        
        // Create an Instance of the Apex pages.
        List<Apexpages.Message> pageMessages = ApexPages.getMessages();
        system.assertequals(1,pageMessages.Size());
    }
    
     static testMethod void associated() 
     { 
          // Create a page refrence for the Account Page.
         PageReference pagerefrenceInstanec = page.ListOfAccountPage;
         
         // Set the Current page refrence to the Account page 
         Test.setCurrentPage(pagerefrenceInstanec);
         // Create the Instance of the Account
         Account accountInstance = new Account();
         // Create a Record
         accountInstance.Name='AccountPageTest';
         // Insert the Account Instance 
         insert accountInstance;
         // Crearte instance of a Contact List
         List<Contact> contactInstance = new List<Contact>();
         // Iterate over the 10 Records
         for(integer i=0;i<10;i++) 
         {
               // Add the Contacts to the List 
               contactInstance.add(new Contact (LastName='ContactPageTest'+i,AccountId=accountInstance.Id));
         }
         // Insert the Contact list
         insert contactInstance;
         // Create the Instance of the Controller 
         ListOfAllAccountControler controller = new ListOfAllAccountControler();
         // assign the Account id to the idAccount which is a property of the Controller
         controller.idAccount=accountInstance.Id;
         // Add the Key and Value to the map.
         pagerefrenceInstanec.getParameters().put('aid',controller.idAccount);
         // Create the page Refrence
         PageReference pageref = controller.gotoContact();
         // Set the Current Page as Contact 
         Test.setCurrentPage(pageRef);
         // Checks the Url returned and the expected url mathces.
         System.assertEquals('/apex/contactpages?aid='+accountInstance.Id,controller.gotoContact().getURL());
         // Check for the Parameters matches
         system.assertEquals(accountInstance.Id,pageRef.getParameters().get('aid'));
         // Set the AccountID on the Property of the Controller.
         controller.idAccount = accountInstance.Id;
         // Get the List Of Contact
         controller.getcontactList();
         // Check for the Size of the Contact List equals to 10
         system.assertequals(10,controller.contactSize);
         // Fetch all the Contact List
         Controller.getcontactList();
         // Delete the Contact by calling the DeleteRelatd Contact
         ListOfAllAccountControler.deleteRelatedContact(contactInstance[2].Id);
         // Print the Contact List
         controller.getcontactList();  
         // Copy the Size of the Contact List 
         integer countContact = controller.contactSize;
         // Checks the Value of the Contactlist Size Matches to the present contact.
         system.assertequals(9,countContact);
         
         // Test return button
         PageReference pageReturn = Page.ListOfAccountPage;
         Test.setcurrentPage(pageReturn);
         // Check the Url of the Accpount page and the returned URl after pressing the Return Button
         System.assertEquals('/apex/listofaccountpage',controller.returnToAccount().getURL());
      } 
     
    static testMethod void contactAlphabetSearchPage2() 
    { 
        // Create the instance of the Account
        Account accountInstance = new Account();
        // Create the Record of Account
        accountInstance.Name='TestAccount';
        // Create the Contact Instance 
        Contact contactInstance = new Contact();
        // Create the record for the Contact
        contactInstance.LastName='pagetest';
        // Assign the Account ID to the Contact 
        contactInstance.AccountId=accountInstance.Id;
        // insert the Account List
        insert accountInstance;
        // Insert the Contact List
        insert contactInstance;
        // Create the Instance of the page
        PageReference pageref = page.ContactPages;
        // Set tge Current page as Contact Page
        Test.setCurrentPage(pageRef);
        // Create the Instance of the Controller
        ListOfAllAccountControler controller = new ListOfAllAccountControler();
        // Assign the Account ID to the Property
        controller.idAccount = accountInstance.Id;
        // Set the Slphaname to search the contacts related to it.
        controller.alphaName='p';
        // Call the method that is  called from the Controller
        controller.displayAlfa();
        // Check the List of the Contacts starting with P
        system.assertequals(1,controller.contactSize);
        
        // Test to clear the searchText Box
        controller.clearSearchResult();
        // check the valeof SearchStringAccount.
        system.assertequals(' ',controller.searchStringAccount);
    }
    
       /*static testMethod void deletecontactPage2() {
        Account accountInstance = new Account();
        accountInstance.Name='TestAccountPage';
        Contact contactInstance = new Contact();
        contactInstance.LastName='TestContactPage';
        contactInstance.AccountId=accountInstance.Id;
          insert accountInstance;
        insert contactInstance;
        Contact contactInstance2 = new Contact();
        contactInstance2.LastName='TestContactPage2';
        contactInstance2.AccountId=accountInstance.Id;
        insert contactInstance2;
        PageReference pageref = page.ContactPages;
        Test.setCurrentPage(pageRef);
        ListOfAllAccountControler controller = new ListOfAllAccountControler();
        ListOfAllAccountControler.deleteRelatedContact(contactInstance2.Id);
        controller.getcontactList();  
        integer countContact = controller.contactSize;
        system.assertequals(1,countContact);
    }*/
      static testMethod void CheckTheListAtoZ() 
      {
          // Creae the Instance of the Controller
           ListOfAllAccountControler controller = new ListOfAllAccountControler();
           // Create the List of the String
           List<String> StringList=new List<String>();
           // Returns the list of the String
           StringList=controller.getlistAToZInstance();
           // Checks the Size of the StringList
           system.assertequals(26,StringList.size());
      }
     
   
}