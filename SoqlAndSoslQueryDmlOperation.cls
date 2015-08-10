public with sharing class SoqlAndSoslQueryDmlOperation {
   
    /**
    * This method Finds the word 'test' in all name fields 
    * returning Contact, Account, Lead and User. 
    */
    public void findTheTestRecordsUsingSOSL()
    {
       //Fire a SOSL query to find the Test record from all the Contact,Account,Leads & user table. 
        List<List<SObject>> searchList = [
                                         FIND 'test' 
                                         IN NAME 
                                         FIELDS RETURNING 
                                         contact(name), 
                                         account(name),
                                         lead(name),
                                         user(name)];
                                         
        // Add to Contact List if it is found in the Contact.
        Contact[] listContact = ((List<contact>)searchList[0]);
        
        // Add to Account List if it is found in the Account.
        Account[] listAccount = ((List<account>)searchList[1]);
        
        // Add to Lead List if it is found in the Lead.
        Lead[] listLead = ((List<lead>)searchList[2]);
        
        // Add to user List if it is found in the User.
        User[] listUser = ((List<user>)searchList[3]);
        
        //Iterate over the ContactInstance and Print the List.
        for(Contact contactInstance:listContact)
        {
            // Print the List of the Contacts.
            system.debug(contactInstance);
        }// End of the For Loop
        
        // Iterate over the AccountInstance and Print the List.
        for(Account accountInstance:listAccount)
        {
            //Print the List of the Accounts.
            system.debug(accountInstance);
        }// End of the For Loop
        
        //  Iterate over the LeadInstance and Print the List.
        for(Lead leadInstance:listLead)
        {           
            //Print the List of the Leads.
            system.debug(leadInstance);
        }// End of the For Loop
        
        // Iterate over the UserInstance and Print the List.
        for(User userInstance:listUser)
        {
            //Print the List of the Users.
            system.debug(userInstance);
        }// End of the For Loop
        
       /**
        * SoqlAndSoslQueryDmlOperation soqlInstance=new SoqlAndSoslQueryDmlOperation();
        * soqlInstance.findTheTestRecordsUsingSOSL();
        */
     }
     
    /**
     * Method that Create 100 Lead records using DML operations having a unique name. 
     * For all records which were not inserted into Lead object, 
     * insert a record in Log object along with the reason why a record  it was not inserted.
     */
     public void InsertRecordInLeadIfErrorInsertErrorInLog()
     {
         // Intialize the List of Leads
         List<Lead> leadList=new List<Lead>();
         
         // Start of for loop 
         for(Integer i=0;i<100;i++)
         { 
             // Adds 100 new lead 
             Lead leadInstance = new Lead(
                                LastName='Test'+i, 
                                Company='Test1 Inc.',
                                Status='Status changed',
                                Unique__c= 'Unique'+i);
                                leadList.add(leadInstance);
         }// End of the For Loop
         
         // Add Existing Records so that it gets inserted in the Logs.  
         leadList.add(
                    new Lead(
                        LastName='Test1001', 
                        Company='Test1 Inc.',
                        Status='Status changed', 
                        Unique__c= 'abc1')
                        );
                        
         leadList.add(
                    new Lead(
                        LastName='Test1002', 
                        Company='Test1 Inc.',
                        Status='Status changed', 
                        Unique__c= 'abc2')
                        );
                        
         // Try to insert the List using dataBase.search()
         Database.SaveResult[] saveresultList=database.insert(leadList,false);
        
         // Create a Instance of log list
         List<Log__c> errorList=new List<Log__c>();
        
         // Iterate over the 
            for (Database.SaveResult saveresultInstance : saveresultList) 
            {
                // Check for the Success
                if (saveresultInstance.isSuccess()) {}
               
                else
                {
                    // iterate over the list of the errors
                
                       for(Database.Error error:saveresultInstance.getErrors())
                       {
                           // Add errors to the New Log Instance
                           Log__c log =   new Log__c(Error__c = error.getMessage());
                
                           // Add the log to the list.
                           errorList.add(log); 
                
                       }// End of the For Loop
                }// End of the Else loop
            } // End of the For loop          
            
            // Check the Error List size
            if(errorList <>null)
            {
                // Insert the ErrorList
                insert errorList;
            }
            /**
             * SoqlAndSoslQueryDmlOperation soqlInstance=new SoqlAndSoslQueryDmlOperation();
             * soqlInstance.InsertRecordInLeadIfErrorInsertErrorInLog();
             */
     }
     
     /**
      * Method that Delets all inactive Account records created in last 90 days.
      * 
      **/
      public void deletAllinActiveAccountInLastNintyDays()
       {
            // List of Account that has been Created In Last 90 Days And Is Inactive
            List <Account> listAccount=[
                                 SELECT id, name 
                                 FROM Account 
                                 WHERE Active__c ='No' 
                                 AND CreatedDate = LAST_90_DAYS];
            
            // Iterate over the Account List
            for(Account accountInstance :listAccount)
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
                // Print Any Exceptions Catched
                System.debug(e.getmessage());
            }
       }

    public void usingUpsertOnAssets() 
    {
        // Fetch all the records of asset
        List<Asset> assetsList=[SELECT Id,
                                        AccountId,
                                        Line_Item_Id__c,
                                        Name
                                 FROM Asset
                                 ];
         // Create a Instance Of List Of Assets
         List<Asset> listAssetInstance = new List<Asset>();
         // Iterate On AssetList
         for(Asset assetInstance : assetsList) 
         {
                //Assign Assets Name
                assetInstance.Name = 'TrailAssets';
                //Set Account Lookup
                assetInstance.AccountId = assetInstance.AccountId;
                //Add The Instance To The list
                listAssetInstance.add(assetInstance);
         }
         try
         {
               // Upsert The List of The Assert
                upsert assetsList Line_Item_Id__c;
         }
         catch(Exception e)
         {
              // Prints if Any exception Occured
                system.debug('Exception Occured:'+e);
         }
    }  
}