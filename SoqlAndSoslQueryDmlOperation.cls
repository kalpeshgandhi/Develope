public with sharing class SoqlAndSoslQueryDmlOperation {
    /**
    * This method Finds the word 'test' in all name fields 
    * returning Contact, Account, Lead and User. 
    */
    
    public void SOSl()
    {
       //Fire a SOSL query to find the Test record from all the Contact,Account,Leads & user table. 
        List<List<SObject>> searchList = [FIND 'test' 
                                         IN NAME FIELDS RETURNING contact(name), 
                                         account(name),lead(name),user(name)];
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
        *Assignment_10_sec3_DmL Assignment_10_sec3_DmLInstance=new Assignment_10_sec3_DmL();
        *Assignment_10_sec3_DmLInstance.SOSl();
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
             Lead leadInstance = new Lead(LastName='Test100'+i, Company='Test1 Inc.',Status='Status changed', Unique__c= 'abc'+i);
             leadList.add(leadInstance);
         }// End of the For Loop
         try
         {
             // Try to insert the List
             insert leadList;
         }
         catch(DMLException e)
         { 
             // If Duplicate Record  Occured Add record in the Log Object.
             Log__c error =new Log__c(Error__c = e.getMessage());
             //Insert the Log
             insert error;
             // Print the Error Message
             System.debug('This exception has occurred: ' + e.getMessage());
         }
     }
     
     /**
      * Method that Delets all inactive Account records created in last 90 days.
      * 
      **/
      public void deletAllinActiveAccountInLastNintyDays()
       {
            // List of Account that has been Created In Last 90 Days And Is Inactive
            List <Account> listAccount=[Select id, name 
                                        from Account 
                                        Where Active__c ='No' 
                                        And CreatedDate = LAST_90_DAYS];
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
        //Intialize the List of Assets
        List<Asset> assetsList=new List<Asset>();
        // Add foure new Records. 
        for(integer i=1;i<4;i++)
        {
              // Add new record Asserts 
                assetsList.add(new Asset(Name='AssetsFromDml'+i,Line_Item_Id__c='ID'+i,
                AccountId='00128000003vQ71'));
        }
        try
        {
              // Upsert The List of The Assert
                upsert AssetsList Line_Item_Id__c;
        }
        catch(Exception e)
        {
              // Prints if Any exception Occured
                system.debug('Exception Occured:'+e);
        }
    } 
}