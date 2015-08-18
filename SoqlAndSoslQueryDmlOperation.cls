/**
 * This is a class that has a method which compute the soql and sosl queries.
 */
public with sharing class SoqlAndSoslQueryDmlOperation 
{
   
   /**
    * This method finds the word 'test' in all name fields 
    * returning Contact, Account, Lead and User. 
    */
    public List<List<SObject>> findTheTestRecordsUsingSOSL()
    {
       //Fire a SOSL query to find the fest record from all the Contact, Account, Leads & user table. 
        List<List<SObject>> searchList = 
            [
                FIND 
                    'test' 
                IN
                    NAME 
                FIELDS RETURNING 
                    contact(name), 
                    account(name),
                    lead(name),
                    user(name)
            ];
                                         
        // Add to contact list if it is found in the contact.
        Contact[] listContact = ((List<contact>)searchList[0]);
        
        // Add to account list if it is found in the account.
        Account[] listAccount = ((List<account>)searchList[1]);
        
        // Add to lead list if it is found in the lead.
        Lead[] listLead = ((List<lead>)searchList[2]);
        
        // Add to user list if it is found in the user.
        User[] listUser = ((List<user>)searchList[3]);
        
        //Iterate over the contact instance and print the list.
        for(Contact contactInstance : listContact)
        {
            
            // Print the list of the contacts.
            System.debug(contactInstance);
            
        }// End of the For Loop
        
        // Iterate over the account Instance and print the list.
        for(Account accountInstance : listAccount)
        {
            //Print the list of the accounts.
            system.debug(accountInstance);
            
        }// End of the For Loop
        
        //  Iterate over the lead Instance and print the list.
        for(Lead leadInstance : listLead)
        {           
            //Print the List of the Leads.
            system.debug(leadInstance);
            
        }// End of the For Loop
        
        // Iterate over the user instance and print the list.
        for(User userInstance : listUser)
        {
            //Print the list of the users.
            system.debug(userInstance);
            
        }// End of the for loop
        
        return searchList;
       /**
        * SoqlAndSoslQueryDmlOperation soqlInstance=new SoqlAndSoslQueryDmlOperation();
        * soqlInstance.findTheTestRecordsUsingSOSL();
        */
    }
     
    /**
     * Method that Create 100 lead records using DML operations having a unique name. 
     * For all records which were not inserted into Lead object, 
     * insert a record in Log object along with the reason why a record  it was not inserted.
     */
     public void insertRecordInLeadIfErrorInsertErrorInLog()
     {
         // Initialize the List of Leads
         List<Lead> leadList=new List<Lead>();
         
         // Start of for loop 
         for(Integer i = 0; i < 100; i++)
         { 
             // Adds 100 new lead 
             Lead leadInstance = new Lead(
                                          LastName = 'Test' + i, 
                                          Company = 'Test1 Inc.',
                                          Status = 'Status changed',
                                          Unique__c = 'Unique' + i
                                         );
             
             leadList.add(leadInstance);
         }// End of the For Loop
         
         // Add Existing Records so that it gets inserted in the Logs.  
         leadList.add(
                     new Lead(
                              LastName = 'Test11', 
                              Company = 'Test1 Inc.',
                              Status = 'Status changed', 
                              Unique__c = 'abc1'
                              )
                      );
                        
         leadList.add(
                      new Lead(
                               LastName = 'Test12', 
                               Company = 'Test1 Inc.',
                               Status = 'Status changed', 
                               Unique__c = 'abc2'
                               )
                       );
                        
         // Try to insert the List using dataBase.query()
         Database.SaveResult[] saveresultList = database.insert(leadList,false);
        
         // Create an Instance of log list
         List<Log__c> errorList = new List<Log__c>();
        
         // Iterate over the 
         for (Database.SaveResult saveresultInstance : saveresultList) 
         {
             // Check for the Success
             if (saveresultInstance.isSuccess())
             {
             }
               
             else
             {
                 // iterate over the list of the errors
                
                 for(Database.Error error : saveresultInstance.getErrors())
                 {
                      // Add errors to the New Log Instance
                      Log__c log =   new Log__c(Error__c = error.getMessage());
                
                      // Add the log to the list.
                      errorList.add(log); 
                
                 }// End of the For Loop
             }// End of the Else loop
         } // End of the For loop          
            
         // Check the Error List size
         if(errorList <> null)
         {
            // Insert the Error List
            insert errorList;
         }
        /**
         * SoqlAndSoslQueryDmlOperation soqlInstance=new SoqlAndSoslQueryDmlOperation();
         * soqlInstance.InsertRecordInLeadIfErrorInsertErrorInLog();
         */
     }
     
     /**
      * Method that Deletes all inactive Account records created in last 90 days.
      * 
      **/
      public void deletAllinActiveAccountInLastNintyDays()
      {
            // List of Account that has been Created In Last 90 Days And Is Inactive
            List <Account> listAccount=
                [
                    SELECT 
                        Id,
                        Name 
                    FROM
                        Account 
                    WHERE 
                        Active__c ='No' 
                    AND 
                        CreatedDate = LAST_90_DAYS
                ];
            
            // Iterate over the Account List
            for(Account accountInstance : listAccount)
            {
                
               // Print the List
                    System.debug('Accounts To Be Deleted'+listAccount);
            }// End Of For Loop 
            
            try
            {
                //Delete the record in the List 
                delete listAccount;
                
            }
            
            catch(DMLException e)
            { 
                
                // Print Any Exceptions Catch
                System.debug(e.getmessage());
                
            }
      }
    /**
     * This is a Method that will upsert the Assets
     */
    public void usingUpsertOnAssets() 
    {
        // Fetch all the records of asset
        List<Asset> assetsList =
            [
                SELECT 
                    Id,
                    AccountId,
                    Line_Item_Id__c,
                    Name
                FROM Asset
            ];
                                 
         // Create an Instance Of List Of Assets
         List<Asset> listAssetInstance = new List<Asset>();
         
         // Iterate On Asset List
         for(Asset assetInstance : assetsList) 
         {
              //Assign Assets Name
              assetInstance.Name = 'TrailAssetsUpsert';
                
              //Set Account Lookup
              assetInstance.AccountId = assetInstance.AccountId;
               
              //Add The Instance To The list
              listAssetInstance.add(assetInstance);
         }
         try
         {
              // Upsert The List of The Assert
              upsert listAssetInstance Line_Item_Id__c;
         }
         catch(Exception e)
         {
              // Prints if Any exception Occurred
              system.debug('Exception Occurred:'+ e);
         }
    }  
}