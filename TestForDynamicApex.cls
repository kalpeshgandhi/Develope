/**
 * This is a test class that will test the method for searching a record from multiple objects and 
 * multiple fields using the sosl query. 
 */
@isTest
private class TestForDynamicApex 
{
   /**
    * This is a method that will check the list of object. 
    */
    static testMethod void testForlistOfObject() 
    {
        // Get all the information about the objects in the map
        Map<String, Schema.SObjectType> mapOfObjectTest = Schema.getGlobalDescribe();

        // Check if the map size is not zero
        System.assertNotEquals(0 ,mapOfObjectTest.size());
        
        // Create the instance of the list of string
        List<String> objectNameList = new List<String>();
        
         // Check if the list size is zero
        System.assertEquals(0 ,objectNameList.size());
        
        // Declare the integer for saving the size of the list
        Integer objectListSize = 0;
        
        // Check if the integer value is zero
        System.assertEquals(0 ,objectListSize);
        
        // Iterate over the keyset of the map
        for(String objectNameInstance : mapOfObjectTest.keySet())
        {
            // Check if the object is searchable
            if(mapOfObjectTest.get(objectNameInstance).getDescribe().isSearchable() == true)
            {
                // Add the object to the list
                objectNameList.add(objectNameInstance);
            }
        } 
        
        objectListSize = objectNameList.size();
        
        // Check if the size is equal or not.
        System.assertNotEquals(0 ,objectListSize);
        
        // Add 'None' to the list
        objectNameList.add('None');
        
        // Check if the none is added or not.
        System.assertEquals(objectListSize + 1 ,objectNameList.size());
        
        // Create the instance of the controller
        DynamicSoslClass contollerInstance = new DynamicSoslClass();
        
        // Start the test
        Test.startTest();
        
        // Save the size of the list returned from the controller
        objectListSize = contollerInstance.getListOfObject().size();
        
        // Stop the test
        Test.stopTest();
        
        // Check if the list size is equal or not.
        System.assertEquals(objectNameList.size(), objectListSize);
    }
    
    
   /**
    * This is a method that will test the fields that are been displayed.
    */
    static testMethod void testSelectionOfFields()
    {
        // Create the instance of the controller
        DynamicSoslClass contollerInstance = new DynamicSoslClass();
        
        // Set the selected object as account
        contollerInstance.selectedObject = 'Account';
        
        // Check if the account is selected or not
        System.assertEquals('Account', contollerInstance.selectedObject);
        
        // Fetch the size of fields for accounts
        Integer sizeOffieldList = 
            Schema.getGlobalDescribe().get(contollerInstance.selectedObject).
            getDescribe().fields.getMap().keyset().size();
        
        // Check if the size is equal or not.
        System.assertNotEquals(0, sizeOffieldList);
        
        // Create the integer with default value as 0
        Integer fieldsListSize = 0;
        
        // Check if the integer value is zero
        System.assertEquals(0, fieldsListSize);
        
        // Start the test
        Test.startTest();
        
        // Call the getter to save object fields
        contollerInstance.getObjectFields();
        
        // Save the size of the displayed file
        fieldsListSize = contollerInstance.setOfDisplayedFields.size();
       
        // Stop the test
        Test.stopTest();
        
        // Check if the size of the returned list matches to fetched list
        System.assertEquals(sizeOffieldList, fieldsListSize);
    }
    
   /**
    * This is a method that will test the generated query.  
    */
    static testMethod void testForQueryGeneration() 
    {
        // Create the instance of the controller
        DynamicSoslClass contollerInstance = new DynamicSoslClass();

        // Create the records for account
        List<Account> accountListInstance = TestDataFactory.accountTestData(5);

        // Check records are added to the list
        System.assertEquals(5 , accountListInstance.size());
        
        // Insert the account records
        insert accountListInstance;
        
        // Fetch all the account records with name as test
        List<Account> checkAccountList = 
            [
                SELECT
                    Name
                FROM
                    Account
                WHERE
                    Name LIKE 'Test%'
            ]; 
        
        // Check the records are added or not
        System.assertEquals(5,checkAccountList.size());
        
        // Set the selected object as account
        contollerInstance.selectedObject = 'Account';
       
        // Check the object is selected or not
        System.assertEquals('Account',contollerInstance.selectedObject);

        // Add the fields to the list of selected fields
        contollerInstance.setOfSelectedFields.add('Name');
        
        // Check the name is added to the list or not
        System.assertEquals(1,contollerInstance.setOfSelectedFields.size());
        
        // Set the limit of the accounts to be fetched
        contollerInstance.selectedNumber = '500';
        
        // Check the number is selected or not
        System.assertEquals('500',contollerInstance.selectedNumber);
        
        // Call the getter to add the selected fields to the selected field list
        contollerInstance.getSelectedFields();
        
        // Set the input string as test
        contollerInstance.inputSearch = 'test';
        
        // Add the fields to the list of selected fields
        contollerInstance.listOfOrderByFields.add(new SelectOption('Name','Name'));
        
        // Check the name is added to the list or not
        System.assertEquals(1,contollerInstance.setOfSelectedFields.size());
        
        // Add the fields to the list of selected fields
        contollerInstance.orderbyselectedField.add('Name');
        
        // Check the name is added to the list or not
        System.assertEquals(1,contollerInstance.orderbyselectedField.size());
        
        // Set the string as ASC
        contollerInstance.selectedRadio = 'ASC';
        
        // Save the query in the string
        String testQuery = 
            'FIND {test}  IN ALL FIELDS RETURNING  Account( Name , Id  ORDER BY Name  ASC )LIMIT 500';

        // Start the test
        Test.startTest();
        
        // Execute the query
        contollerInstance.query();
        
        // Stop the test
        Test.stopTest();
        
        // check if the query matches
        System.assertEquals(testQuery, contollerInstance.dynamicQuery);
    }
    
   /**
    * This is a method that will check the result when query is executed. 
    */
    static testMethod void testForQueryExecution() 
    {
        // Create the instance of the controller
        DynamicSoslClass contollerInstance = new DynamicSoslClass();
        
        // Create the instance of the list of SObject
        List<SObject> sObjectListInstance = new List<SObject>();
        
        // Check if the list has no records
        System.assertEquals(0 , sObjectListInstance.size());
        
        // Create the records for account
        List<Account> accountListInstance = TestDataFactory.accountTestData(5);

        // Check records are added to the list
        System.assertEquals(5 , accountListInstance.size());
        
        // Insert the account records
        insert accountListInstance;
        
        // Fetch all the account records with name as test
        List<Account> checkAccountList = 
            [
                SELECT
                    Name,Id
                FROM
                    Account
                WHERE
                    Name LIKE 'TestAccount%'
            ]; 
            
        // Check the records are added or not
        System.assertEquals(5,checkAccountList.size());

        // Create the instance of the list of id
        List<Id> listOfAccountId=new List<Id>();
        
        // Check if the list has no records
        System.assertEquals(0 , listOfAccountId.size());
        
        // Iterate over the account list
        for(Account accountIdInstance : checkAccountList)
        {
            // Add the accounts id to the list of id's
            listOfAccountId.add(accountIdInstance.Id);
        }// End of for loop
        
        // Check the id are added or not
        System.assertEquals(5,listOfAccountId.size());
        
        // Sosl queries return () if Test.setFixedSearchResults is not return,
        // so add the id's of your data to Test.setFixedSearchResults to gain the expected results.
        Test.setFixedSearchResults(listOfAccountId);
       
        // Set the selected object as account
        contollerInstance.selectedObject = 'Account';

        // Add the fields to the list of selected fields
        contollerInstance.setOfSelectedFields.add('Name');
        
        // Check the name is added or not
        System.assertEquals(1,contollerInstance.setOfSelectedFields.size());
        
        // Set the limit of the accounts to be fetched
        contollerInstance.selectedNumber = '500';
        
        // Call the getter to add the selected fields to the selected field list
        List<SelectOption> listOfSelectedFields = contollerInstance.getSelectedFields();
        
        // Check the selected fields are added or not
        System.assertEquals(1,listOfSelectedFields.size());
        
        // Set the input string as test
        contollerInstance.inputSearch = 'Test*';
        
        // Add the fields to the list of selected fields
        contollerInstance.listOfOrderByFields.add(new SelectOption('Name','Name'));
        
        // Check the name is added or not
        System.assertEquals(1,contollerInstance.listOfOrderByFields.size());
        
        // Add the fields to the list of selected fields
        contollerInstance.orderbyselectedField.add('Name');
 
        // Start the test     
        Test.startTest();
        
        // Execute the query
        contollerInstance.query();
 
        // Stop the test
        Test.stopTest();
       
        // Check if the record is found by checking the size of the searchlist result 
        System.assertEquals(1, contollerInstance.searchList.size());
        
        // Create the instance of the list of sobject
        List<SObject> listOfSObject = new List<SObject>();
        // Iterate over the result of searchlist
        for(List<SObject> sobjectListInstanceTrial : contollerInstance.searchList)
        {
            // Iterate over the list of sobject
            for(SObject sobjectInstance : sobjectListInstanceTrial)
            {
                // Add the elements to the list of sobject
                listOfSObject.add(sobjectInstance);
            }
        }
        // Check for the records are searched or not
        System.assertEquals(5,listOfSObject.size());
    }
    /**
    * This is a method that will check the result when query is executed for two Obejcts. 
    */
    static testMethod void testForQueryExecutionOnMultipleObjects() 
    {
        // Create the instance of the controller
        DynamicSoslClass contollerInstance = new DynamicSoslClass();
        
        // Create the instance of the list of sobject
        List<SObject> sObjectListInstance = new List<SObject>();
        
        // Check if the list has no records
        System.assertEquals(0 , sObjectListInstance.size());
        
        // Create the records for account
        List<Account> accountListInstance = TestDataFactory.accountTestData(5);
        
        // Insert the account records
        System.assertEquals(5 , accountListInstance.size());
        
        // Insert the account records
        insert accountListInstance;
        
        // Fetch all the account records with name as test
        List<Account> checkAccountList = 
            [
                SELECT
                    Name
                FROM
                    Account
                WHERE
                    Name LIKE 'Test%'
            ]; 
        
        // Check the records are added or not
        System.assertEquals(5,checkAccountList.size());
        
        // Create the instance of the list of id
        List<Id> listOfId=new List<Id>();
        
        // Check if the list has no records
        System.assertEquals(0 , listOfId.size());
        
        // Create the records for contact
        List<Contact> contactListInstance = TestDataFactory.contactTestData(5);
        
        // Check records are added to the list
        System.assertEquals(5, contactListInstance.size());
        
        // Insert the contact records
        insert contactListInstance;
        
        // Fetch all the contact records with name as test
        List<Contact> checkContactList = 
            [
                SELECT
                    Name
                FROM
                    Contact
                WHERE
                    LastName LIKE 'Test%'
            ]; 
        
        // Check the records are added or not
        System.assertEquals(5,checkContactList.size());
        
        // Iterate over the account list
        for(Account accountIdInstance : checkAccountList)
        {
            // Add the accounts id to the list of id's
            listOfId.add(accountIdInstance.Id);
        }// End of for loop
        
        // Check the records are added or not
        System.assertEquals(5,listOfId.size());
        
        // Iterate over the account list
        for(Contact contactIdInstance : checkContactList)
        {
            // Add the accounts id to the list of id's
            listOfId.add(contactIdInstance.Id);
        }// End of for loop
        
        // Check the records are added or not
        System.assertEquals(10,listOfId.size());
        
        // Sosl queries return () if Test.setFixedSearchResults is not return,
        // so add the id's of your data to Test.setFixedSearchResults to gain the expected results.
        Test.setFixedSearchResults(listOfId);
        
        // Add the fields to the list of selected fields
        contollerInstance.listOfOrderByFields.add(new SelectOption('Name','Name'));
        
        // Check the name is added or not
        System.assertEquals(1,contollerInstance.listOfOrderByFields.size());
        
        // Add the fields to the list of selected fields
        contollerInstance.orderbyselectedField.add('Name');
        
        // Check the name is added or not
        System.assertEquals(1,contollerInstance.orderbyselectedField.size());
        
        // Set the selected object as account
        contollerInstance.selectedObject = 'Account';
        
        // Add the fields to the list of selected fields
        contollerInstance.setOfSelectedFields.add('Name');
        
        // Check the name is added or not
        System.assertEquals(1,contollerInstance.setOfSelectedFields.size());
        
        // Set the limit of the accounts to be fetched
        contollerInstance.selectedNumber = '500';
        
        // Call the getter to add the selected fields to the selected field list
        contollerInstance.getSelectedFields();
        
        // Set the input string as test
        contollerInstance.inputSearch = 'Test*';
        
        // Save the result size of search result
        Integer searchresultsize = contollerInstance.searchResultsInstance.size();
        
        System.assertEquals(0, searchresultsize);
        
        // Start the test     
        Test.startTest();
        
        // Add new object
        contollerInstance.addNewObjectToQuery();
        
        // Set the selected object as contact
        contollerInstance.selectedObject = 'Contact';
        
        // Add the fields to the list of selected fields
        contollerInstance.setOfSelectedFields.add('Name');
        
        // Check the name is added or not
        System.assertEquals(1,contollerInstance.setOfSelectedFields.size());
        
        // Add the fields to the list of selected fields
        contollerInstance.listOfOrderByFields.add(new SelectOption('Name','Name'));
        
        // Check the name is added or not
        System.assertEquals(1,contollerInstance.listOfOrderByFields.size());
        
        // Add the fields to the list of selected fields
        contollerInstance.orderbyselectedField.add('Name');
        
        // Check the name is added or not
        System.assertEquals(1,contollerInstance.orderbyselectedField.size());
        
        // Call the getter to add the selected fields to the selected field list       
        contollerInstance.getSelectedFields();
        
        // Execute the query
        contollerInstance.query();
        
        // Save results in the list of search result 
        contollerInstance.getsearchResultsOfQuery();

        // Stop the test
        Test.stopTest();
        
        // Check if the size of the search result is not equal before and after query is executed
        System.assertNotEquals(searchresultsize, contollerInstance.searchResultsInstance.size());
        
        // Check if the record is found by checking the size of the searchlist result 
        System.assertEquals(2, contollerInstance.searchList.size());
        
        // Create the instance of the list of sobject
        List<SObject> listOfSObject = new List<SObject>();
        // Iterate over the result of searchlist
        system.debug(contollerInstance.searchList);
        for(List<SObject> sobjectListInstanceTrial : contollerInstance.searchList)
        {
            // Iterate over the list of sobject
            for(SObject sobjectInstance : sobjectListInstanceTrial)
            {
                // Add the elements to the list of sobject
                listOfSObject.add(sobjectInstance);
            }
        }
        // Check for the records are searched or not
        System.assertEquals(10,listOfSObject.size());
    }
    
   /**
    * This is a method that will check the results when user presses clear button.
    */
    static testMethod void testForClearButton() 
    {
        // Create the instance of the controller
        DynamicSoslClass contollerInstance = new DynamicSoslClass();
        
        // Create the instance of the list of sobject
        List<SObject> sObjectListInstance = new List<SObject>();
        
        // Create the records for account
        List<Account> accountListInstance = TestDataFactory.accountTestData(5);
        
        // Insert the account records
        System.assertEquals(5 , accountListInstance.size());
        
        // Insert the account records
        insert accountListInstance;
        
        // Fetch all the account records with name as test
        List<Account> checkAccountList = 
            [
                SELECT
                    Name
                FROM
                    Account
                WHERE
                    Name LIKE 'Test%'
            ]; 
        
        // Check the records are added or not
        System.assertEquals(5,checkAccountList.size());

        // Create the records for contact
        List<Contact> contactListInstance = TestDataFactory.contactTestData(5);
        
        // Check records are added to the list
        System.assertEquals(5, contactListInstance.size());
        
        // Insert the contact records
        insert contactListInstance;
        
        // Fetch all the contact records with name as test
        List<Contact> checkContactList = 
            [
                SELECT
                    Name
                FROM
                    Contact
                WHERE
                    LastName LIKE 'Test%'
            ]; 
        
        // Check the records are added or not
        System.assertEquals(5,checkContactList.size());
        
        // Add the fields to the list of selected fields
        contollerInstance.listOfOrderByFields.add(new SelectOption('Name','Name'));
        
        // Check the name is added or not
        System.assertEquals(1,contollerInstance.listOfOrderByFields.size());
        
        // Add the fields to the list of selected fields
        contollerInstance.orderbyselectedField.add('Name');
        
        // Check the name is added or not
        System.assertEquals(1,contollerInstance.orderbyselectedField.size());
        
        // Set the selected object as account
        contollerInstance.selectedObject = 'Account';
        
        // Add the fields to the list of selected fields
        contollerInstance.setOfSelectedFields.add('Name');
        
        // Check the name is added or not
        System.assertEquals(1,contollerInstance.setOfSelectedFields.size());
        
        // Set the limit of the accounts to be fetched
        contollerInstance.selectedNumber = '500';
        
        // Call the getter to add the selected fields to the selected field list
        contollerInstance.getSelectedFields();
        
        // Set the input string as test
        contollerInstance.inputSearch = 'Test';
        
        // Save the result size of search result
        Integer searchresultsize = contollerInstance.searchResultsInstance.size();
        
        // Add new object
        contollerInstance.addNewObjectToQuery();
        
        // Set the selected object as contact
        contollerInstance.selectedObject = 'Contact';
        
        // Add the fields to the list of selected fields
        contollerInstance.setOfSelectedFields.add('Name');
        
        // Check the name is added or not
        System.assertEquals(1,contollerInstance.setOfSelectedFields.size());
        
        // Add the fields to the list of selected fields
        contollerInstance.listOfOrderByFields.add(new SelectOption('Name','Name'));
        
        // Check the name is added or not
        System.assertEquals(1,contollerInstance.listOfOrderByFields.size());
        
        // Add the fields to the list of selected fields
        contollerInstance.orderbyselectedField.add('Name');
        
        // Check the name is added or not
        System.assertEquals(1,contollerInstance.orderbyselectedField.size());
        
        // Call the getter to add the selected fields to the selected field list       
        contollerInstance.getSelectedFields();
        
        // Execute the query
        contollerInstance.query();

        // Save results in the list of search result 
        contollerInstance.getsearchResultsOfQuery();
        
        // Check if the size of the search result is not equal before and after query is executed
        System.assertNotEquals(searchresultsize, contollerInstance.searchResultsInstance.size());
        
        // Start the test     
        Test.startTest();
        
        // Clear the properties.
        contollerInstance.clearProperties();

        // Stop the test
        Test.stopTest();

        // Check if the list size is 0
        System.assertEquals(0, contollerInstance.searchResultsInstance.size());
        
        // Check if the list size is 0
        System.assertEquals(0,contollerInstance.orderbyselectedField.size());
        
        // Check if the list size is 0
        System.assertEquals(0,contollerInstance.listOfOrderByFields.size());
        
        // Check the name is added or not
        System.assertEquals(0,contollerInstance.setOfSelectedFields.size());
    }
    
   /**
    * This is a method that will test the functionality if the search string is blank.
    */
    static testMethod void testForBlankSearchString() 
    {
        // Create the instance of the controller
        DynamicSoslClass contollerInstance = new DynamicSoslClass();
        
        // Create the records for account
        List<Account> accountListInstance = TestDataFactory.accountTestData(5);
        
        // Check records are added to the list
        System.assertEquals(5, accountListInstance.size());
        
        // Insert the account records
        insert accountListInstance;
        
        // Fetch all the account records with name as test
        List<Account> checkAccountList = 
            [
                SELECT
                    Name
                FROM
                    Account
                WHERE
                    Name LIKE 'Test%'
            ]; 
        
        // Check the records are added or not
        System.assertEquals(5,checkAccountList.size());
        
        // Set the input string as blank
        contollerInstance.inputSearch = '';
        
        // Check the input string is blank
        System.assertEquals('',contollerInstance.inputSearch);
        
        // Start the test
        Test.startTest();
        
        // Execute the query
        contollerInstance.query();
        
        // Stop the test
        Test.stopTest();
        
        // Check if the message is given or not
        System.assertequals('Please Provide Atleast One Field/Atleast OneObject/Atleast Three Letters in SearchBox',
            (ApexPages.getMessages()[0].getDetail())); 
    }
    
   /**
    * This is a method that will test the functionality of the field selection.
    */
    static testMethod void testFieldsSelection() 
    {
        // Create the instance of the page reference
        PageReference pagerefrenceInstance = Page.DynamicSoslPage;
        
        // Set the page to DynamicSoslPage
        Test.setCurrentPage(pagerefrenceInstance);
        
        // Create the instance of the controller
        DynamicSoslClass contollerInstance = new DynamicSoslClass();
        
        // Set the selected object as account
        contollerInstance.selectedObject = 'Account'; 
        
        // Check the account is selected
        System.assertEquals('Account',contollerInstance.selectedObject);
        
        // Add the fields to the list of selected fields
        contollerInstance.setOfDisplayedFields.add('Name');
        
        // Check the name is added to the list or not
        System.assertEquals(1,contollerInstance.setOfDisplayedFields.size());
        
        // Start the test
        Test.startTest();
        
        // Call the getter of selected list
         List<SelectOption> displayedListTest = contollerInstance.getDisplayedFields();
        
        // Stop the test
         Test.stopTest();
        
        // Check the size of the field list 
        System.assertEquals(1,displayedListTest.size());
    }
    
    /**
    * This is a method that will test the functionality if the object selected is none.
    */
    static testMethod void testForObjectIsSelectedNone() 
    { 
        // Create the instance of the page reference
        PageReference pagerefrenceInstance = Page.DynamicSoslPage;
        
        // Set the page to DynamicSoslPage
        Test.setCurrentPage(pagerefrenceInstance);
        
        // Create the instance of the controller
        DynamicSoslClass contollerInstance = new DynamicSoslClass();
        
        // Set the selected object as none
        contollerInstance.selectedObject = 'None'; 
        
        // Check if none is selected
        System.assertEquals('None',contollerInstance.selectedObject);
        
        // Start the test
        Test.startTest();
        
        // Call the getter of object list
        contollerInstance.getObjectFields();
        
        // Stop the test
        Test.stopTest();
        
        // Check the size of the field list 
        System.assertEquals(0,contollerInstance.listOfDisplayedFields.size());
    }
    
   /**
    * This will check once the field are selected they are removed from the list.
    */
    static testMethod void testRemovalOfAllDisplayedFields() 
    {
        // Create the instance of the page reference
        PageReference pagerefrenceInstance = Page.DynamicSoslPage;
        
        // Set the page to DynamicSoslPage
        Test.setCurrentPage(pagerefrenceInstance);
        
        // Create the instance of the controller
        DynamicSoslClass contollerInstance = new DynamicSoslClass();
        
        // Set the selected object as account
        contollerInstance.selectedObject = 'Account'; 
        
        // Check if account is added
        System.assertEquals('Account',contollerInstance.selectedObject);
        
        // Add the fields to the list of selected fields
        contollerInstance.setOfDisplayedFields.add('Name');
        
        // Check if name is added
        System.assertEquals(1,contollerInstance.setOfDisplayedFields.size());
        
        // Call the getter to add the field list
        contollerInstance.getDisplayedFields();
        
        // Save the size of the fields
        Integer countOfSelectedField = contollerInstance.listOfDisplayedFields.size();
        
        // Add the fields to the selected list
        contollerInstance.selectedFieldFromAllDisplayedField = new String[] {'Name'}; 
        
        // Start the test
        Test.startTest();
        
        // Adds the fields to the selected field
        contollerInstance.addToSelectedFields();
        
        // Stop the test
        Test.stopTest();
        
        // Call the getter to display all fields
        contollerInstance.getDisplayedFields();
        
        // Compares the size of the selected list
        System.assertNotEquals(countOfSelectedField,contollerInstance.listOfDisplayedFields.size());
    }
    
   /**
    * This will check once the field are selected they are removed from the list.
    */
    static testMethod void testRemovalOfAllSelectedFields() 
    {
        // Create the instance of the page reference
        PageReference pagerefrenceInstance = Page.DynamicSoslPage;
        
        // Set the page to DynamicSoslPage
        Test.setCurrentPage(pagerefrenceInstance);
        
        // Create the instance of the controller
        DynamicSoslClass contollerInstance = new DynamicSoslClass();
        
        // Set the selected object as account
        contollerInstance.selectedObject = 'Account'; 
        
        // Check if account is selected
        System.assertEquals('Account',contollerInstance.selectedObject);
        
        // Add the fields to the list of selected fields
        contollerInstance.setOfSelectedFields.add('Name');
       
        // Check the name is added to the set or not
        System.assertEquals(1,contollerInstance.setOfSelectedFields.size());
       
        // Call the getter to add the field list
        List<SelectOption> selectedListTest = contollerInstance.getSelectedFields();
        
        // Check the selected is added to the list or not
        System.assertEquals(1,selectedListTest.size());
        
        // Save the size of the fields
        Integer countOfSelectedField = contollerInstance.listOfSelectedFields.size();
        
        // Add the fields to the selected list
        contollerInstance.selectedFieldFromAllSelectedField = new String[] {'Name'}; 
        
        // Start the test
        Test.startTest();
        
        // Calls the method to remove the selcted field
        contollerInstance.removeFromSelectedFields();
        
        // Stop the test
        Test.stopTest();
        
        // Calls the method that will add the selected field to other picklist
        List<SelectOption> selectedListTestResult = contollerInstance.getSelectedFields();
       
        // Compairs the size of the selected list
        System.assertNotEquals(countOfSelectedField,selectedListTestResult.size());
    }
}