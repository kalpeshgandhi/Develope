/**
 * This is a class that has the test methods to test the functionality of Dml operations performed.
 */
@isTest
private class TestDmlOperation 
{
    /**
     * This is a method that test to delete all inactive Account records created in last 90 days.
     */
     static testMethod void testAccountRecords()
     {
         // Create the list of account
         List<Account> listAccount = new List<Account>(); 
         // Iterate over the loop
         for (Integer i = 0 ; i < 5; i++)
         {
             // Create the account record
             Account accountInstance = new Account(Name ='Test' + i, Active__c = 'No');
             listAccount.add(accountInstance);
         }
         
         // Check the records are added or not
         System.assertEquals(5,listAccount.size());
         
         // Start the Test
         Test.startTest();
         
         // Insert list of account
         insert listAccount;
         
         // Fetch the record
         List<Account> accountListInstance=
            [
                SELECT 
                    Id,
                    Name
                FROM
                    Account
                WHERE
                    Name LIKE 'Test%'
            ];
            
         // Check If the record is inserted or not.
         System.assertEquals(5, accountListInstance.size());
         
         // Create the instance of the class
         SoqlAndSoslQueryDmlOperation dmlInstance = new SoqlAndSoslQueryDmlOperation();
         
         // Call the Method 
         dmlInstance.deletAllinActiveAccountInLastNintyDays();
         
         // Stop the test
         Test.stopTest();
         
         List <Account> listAccountInstance = 
            [
                SELECT 
                    Id,
                    Name 
                FROM 
                    Account
                WHERE 
                    Name LIKE 'Test%'
            ];
         
         System.assertEquals(0,listAccountInstance.size());
    }
    
   /**
    * This is a method that tests the functionality to upsert Asset records.
    */
    static testMethod void testUpsertOfAssetRecords()
    {
         // Create the Account record
         Account accountInstance = new Account(Name = 'Test');
         
         
         // Create the instance of asset list
         List<Asset> listAsset = new List<Asset>();
         
         // Create the Asset record
         Asset assetInstance = new Asset(Line_Item_Id__c = 'WER',Name = 'Test');
         
         
         // Start the test
         Test.startTest();
         
         // Insert Account
         insert accountInstance;
         
         // Check the records are added or not
         System.assert(String.isNotBlank(accountInstance.Id));
         
         // Assign the Id to asset record
         assetInstance.AccountId = accountInstance.Id;
         
         // Add the Asset to the list
         listAsset.add(assetInstance);
         
         // Insert the Asset
         insert listAsset;
         
         List<Asset> assetListInstance=
           [
               SELECT 
                   Id,
                   Name
               FROM
                   Asset
               WHERE
                   Name = 'Test'
           ];
           
         // Check If the record is inserted or not.
         System.assertEquals(1, assetListInstance.size()); 
         
         // Create the Instance of the Class 
         SoqlAndSoslQueryDmlOperation soqlDmlInstance = new SoqlAndSoslQueryDmlOperation();
         
         // Call the Method from the Class
         soqlDmlInstance.usingUpsertOnAssets();
         
          // Stop the test
         Test.stopTest();
         
         // Fetch all the Assets
         List<Asset> accountAfterUpdate =
            [
                SELECT 
                    NAME
                FROM 
                    Asset
            ];
         
         // Check the records are added or not
         System.assertEquals('TrailAssetsUpsert',accountAfterUpdate[0].Name);
    }
    
    
   /**
    * This is a method that test for all records which were not inserted into Lead object, 
    * insert a record in Log object along with the reason why a record was not inserted.
    */
    static testMethod void testLogsRecord() 
    {
        // Create the instance of the Lead
        List<Lead> listLead = new List<Lead>();
        
        // Fetch all log before Insert 
        list<Log__c> logList =
            [
                SELECT Id,
                       Name
                FROM 
                    Log__c
            ];
        
         // Check If the record is inserted or not.
         System.assertEquals(0, logList.size()); 
         
        // Stop the test
        Test.startTest();
        
        // Create the Insatnce of the class
        SoqlAndSoslQueryDmlOperation loginstance = new SoqlAndSoslQueryDmlOperation();
        
        // Call the function
        loginstance.insertRecordInLeadIfErrorInsertErrorInLog();
        
        // Call the function
        loginstance.insertRecordInLeadIfErrorInsertErrorInLog();
        
        // Stop the test
        Test.stopTest();
        
        // Fetch all log after insert.
        List<Log__c> listAfterLog =
            [
                SELECT 
                    Id,
                    Name
                FROM Log__c
            ];
        
        // Checks the log size before and after insert of lead.
        System.assertNotEquals(logList.size(),listAfterLog.size());
    }
}