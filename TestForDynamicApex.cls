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
        // Get all the information about the objects in the Map
        Map<String, Schema.SObjectType> mapOfObject = Schema.getGlobalDescribe();
        
        // Create the instance of the list of string
        List<String> objectNameList = new List<String>();
        
        // Declare the Integer for saving the size of the list
        Integer objectListSize;
        
        // Iterate over the keyset of the map
        for(String objectNameInstance : mapOfObject.keySet())
        {
            // Check if the object is searchable
            if(mapOfObject.get(objectNameInstance).getDescribe().isSearchable() == true)
            {
                // Add the object to the list
                objectNameList.add(objectNameInstance);
            }
        } 
        
        // Add 'None' to the list
        objectNameList.add('None');
        
        // Create the instance of the controller
        DynamicSoslClass contollerInstance = new DynamicSoslClass();
        
        // Start the test
        Test.startTest();
        
        // Save the size of the list returned from the controller
        objectListSize = contollerInstance.getListOfObject().size();
        
        // Stop the test
        Test.stopTest();
        
        // Check if the size is equal or not.
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
        
        // Fetch the size of fields for accounts
        Integer sizeOffieldList = 
            Schema.getGlobalDescribe().get(contollerInstance.selectedObject).
            getDescribe().fields.getMap().keyset().size();
       
        // Create the instance of the controller
        Integer fieldsListSize;
       
        // Start the test
        Test.startTest();
        // Call the getter to save object fields
        contollerInstance.getObjectFields();
        
        // Save the size of the displayed file
        fieldsListSize = contollerInstance.nameOfSelectedFields.size();
       
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
        
        // Create the instance of the list of sobject
        List<SObject> sObjectListInstance = new List<SObject>();

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

        // Add the fields to the list of selected fields
        contollerInstance.nameOfMultiSelectedFields.add('Id');
        
        // Set the limit of the accounts to be fetched
        contollerInstance.selectedNumber = '500';
        
        // Call the getter to add the selected fields to the selected field list
        contollerInstance.getMultiSelectedList();
        
        // Set the input string as test
        contollerInstance.inputSearch = 'test';
        
        // Add the fields to the list of selected fields
        contollerInstance.listOfOrderByFields.add(new SelectOption('Id','Id'));
        
        // Add the fields to the list of selected fields
        contollerInstance.orderbyselectedField.add('Id');
        
        // Set the string as ASC
        contollerInstance.selectedRadio = 'ASC';
        
        // Save the query in the string
        String testQuery = 
            'FIND {test}  IN ALL FIELDS RETURNING  Account( Id , Name  ORDER BY Id  ASC )LIMIT 500';

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

        // Add the fields to the list of selected fields
        contollerInstance.nameOfMultiSelectedFields.add('Id');
        
        // Set the limit of the accounts to be fetched
        contollerInstance.selectedNumber = '500';
        
        // Call the getter to add the selected fields to the selected field list
        contollerInstance.getMultiSelectedList();
        
        // Set the input string as test
        contollerInstance.inputSearch = 'Test';
        
        // Add the fields to the list of selected fields
        contollerInstance.listOfOrderByFields.add(new SelectOption('Id','Id'));
        
        // Add the fields to the list of selected fields
        contollerInstance.orderbyselectedField.add('Id');
        
        // Start the test     
        Test.startTest();
       
        // Execute the query
        contollerInstance.query();
       
        // Stop the test
        Test.stopTest();
       
        // Check if the record is found by checking the size of the searchlist result 
        System.assertEquals(1, contollerInstance.searchList.size());
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
        
        // Create the instance of list of list of sobject
        List<List<SObject>> searchList = new List<List<SObject>>();
        
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
        contollerInstance.listOfOrderByFields.add(new SelectOption('Id','Id'));
        
        // Add the fields to the list of selected fields
        contollerInstance.orderbyselectedField.add('Id');
        
        // Set the selected object as account
        contollerInstance.selectedObject = 'Account';
        
        // Add the fields to the list of selected fields
        contollerInstance.nameOfMultiSelectedFields.add('Id');
        
        // Set the limit of the accounts to be fetched
        contollerInstance.selectedNumber = '500';
        
        // Call the getter to add the selected fields to the selected field list
        contollerInstance.getMultiSelectedList();
        
        // Set the input string as test
        contollerInstance.inputSearch = 'Test';
        
        // Save the result size of search result
        Integer searchresultsize = contollerInstance.searchResultsInstance.size();
        
        // Start the test     
        Test.startTest();
        
        // Add new object
        contollerInstance.addNewObjectToQuery();
        
        // Set the selected object as contact
        contollerInstance.selectedObject = 'Contact';
        
        // Add the fields to the list of selected fields
        contollerInstance.nameOfMultiSelectedFields.add('Id');
        
        // Add the fields to the list of selected fields
        contollerInstance.listOfOrderByFields.add(new SelectOption('Id','Id'));
        
        // Add the fields to the list of selected fields
        contollerInstance.orderbyselectedField.add('Id');
        
        // Call the getter to add the selected fields to the selected field list       
        contollerInstance.getMultiSelectedList();
        
        // Execute the query
        contollerInstance.query();
        
        // Save results in the list of search result 
        contollerInstance.getsearchResultsOfQuery();
        
        // Stop the test
        Test.stopTest();
        
        // Check if the size of the search result is not equal before and after query is executed
        System.assertNotEquals(searchresultsize, contollerInstance.searchResultsInstance.size());
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
        
        // Create the instance of list of list of sobject
        List<List<SObject>> searchList = new List<List<SObject>>();
        
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
        contollerInstance.listOfOrderByFields.add(new SelectOption('Id','Id'));
        
        // Add the fields to the list of selected fields
        contollerInstance.orderbyselectedField.add('Id');
        
        // Set the selected object as account
        contollerInstance.selectedObject = 'Account';
        
        // Add the fields to the list of selected fields
        contollerInstance.nameOfMultiSelectedFields.add('Id');
        
        // Set the limit of the accounts to be fetched
        contollerInstance.selectedNumber = '500';
        
        // Call the getter to add the selected fields to the selected field list
        contollerInstance.getMultiSelectedList();
        
        // Set the input string as test
        contollerInstance.inputSearch = 'Test';
        
        // Save the result size of search result
        Integer searchresultsize = contollerInstance.searchResultsInstance.size();
        
        // Add new object
        contollerInstance.addNewObjectToQuery();
        
        // Set the selected object as contact
        contollerInstance.selectedObject = 'Contact';
        
        // Add the fields to the list of selected fields
        contollerInstance.nameOfMultiSelectedFields.add('Id');
        
        // Add the fields to the list of selected fields
        contollerInstance.listOfOrderByFields.add(new SelectOption('Id','Id'));
        
        // Add the fields to the list of selected fields
        contollerInstance.orderbyselectedField.add('Id');
        
        // Call the getter to add the selected fields to the selected field list       
        contollerInstance.getMultiSelectedList();
        
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

        // Check if the size of the search result is not equal before and after query is executed
        System.assertEquals(0, contollerInstance.searchResultsInstance.size());
       
    }
    
   /**
    * This is a method that will test the functionality if the search string is blank.
    */
    static testMethod void testForBlankSearchString() 
    {
        // Create the instance of the controller
        DynamicSoslClass contollerInstance = new DynamicSoslClass();
        
        // Create the instance of the list of sobject
        List<SObject> sObjectListInstance = new List<SObject>();
        
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
        
        // Start the test
        Test.startTest();
        
        // Execute the query
        contollerInstance.query();
        
        // Stop the test
        Test.stopTest();
        
        // Check if the message is given or not
        System.assertequals('Please Provide Atleast One Field/Atleast One Object/Value to Search',
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
        
        // Add the fields to the list of selected fields
        contollerInstance.nameOfSelectedFields.add('Id');
        
        // Start the test
        Test.startTest();
        
        // Call the getter of selected list
        contollerInstance.getSelectedList();
        
        // Stop the test
         Test.stopTest();
        
        // Check the size of the field list 
        system.assertEquals(1,contollerInstance.nameOfFields.size());
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
        
        // Start the test
        Test.startTest();
        
        // Call the getter of object list
        contollerInstance.getObjectFields();
        
        // Stop the test
        Test.stopTest();
        
        // Check the size of the field list 
        System.assertEquals(0,contollerInstance.nameOfFields.size());
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
        
        // Add the fields to the list of selected fields
        contollerInstance.nameOfSelectedFields.add('Id');
        
        // Call the getter to add the field list
        contollerInstance.getSelectedList();
        
        // Save the size of the fields
        Integer countOfSelectedField = contollerInstance.nameOfFields.size();
        
        // Add the fields to the selected list
        contollerInstance.selectedField = new String[] {'Id'}; 
        
        // Adds the fields to the selected field
        contollerInstance.addMultiSelectFields();
        
        contollerInstance.getSelectedList();
        
        // Compares the size of the selected list
        System.assertNotEquals(countOfSelectedField,contollerInstance.nameOfFields.size());
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
        
        // Add the fields to the list of selected fields
        contollerInstance.nameOfMultiSelectedFields.add('Id');
        
        // Call the getter to add the field list
        contollerInstance.getMultiSelectedList();
        
        // Save the size of the fields
        Integer countOfSelectedField = contollerInstance.multiSelectdFields.size();
        
        // Add the fields to the selected list
        contollerInstance.multiSelected = new String[] {'Id'}; 
        
        // Calls the method to remove the selcted field
        contollerInstance.removeMultiSelectFields();
        
        // Calls the method that will add the selected field to other picklist
        contollerInstance.getMultiSelectedList();
        
        // Compairs the size of the selected list
        System.assertNotEquals(countOfSelectedField,contollerInstance.multiSelectdFields.size());
    }
}
