public with sharing class RelationQueriesSoql
{
    
   /* This Method has the SOQL query on Contact to retrieve all active contacts belonging 
    * to 'media' Industry.It Also display the name of the account to which it is associated to.
    */
     public void retriveActiveContactsFromAccounts()
     {
          // Iterate Over Contact List which fetches all The Contacts having the industry as Media 
          for(Contact contactInstance:[  
                                SELECT  c.Id,
                                        c.Name,
                                       c.AccountId,
                                       c.Account.Name 
                                FROM    Contact c 
                                WHERE   Account.industry ='Media' 
                                AND     Account.Active__c ='Yes'
                                ])
          {
               // Prints The ContactList
               System.debug('Contact Information'+contactInstance);
               // Prints The Account Name
               System.debug('Account Name'+contactInstance.Account.Name);
          }
          /**
          * RelationQueriesSoql relationInstance=new RelationQueriesSoql();
          * relationInstance.retriveActiveContactsFromAccounts();
          */
    }
    
    /**
     * Method that Has the the SOQL query on 'C'(Object) to retrieve all records of 'C' 
     * with name 'John' along with Details of the A and B Object.
     */
     public void retriveAllecordsWithNameJohnFromC()
     {
     // Iterate Over List which fetches all records of 'C' with name 'John' along with Details of Parent
        for(C__c cInstance:[
                       SELECT c.Name,
                              c.Bs__r.name,
                              c.A_relation__r.name
                       FROM C__c c
                       WHERE Name='John'])
        {
            // Prints The List C's Name
            System.debug('C name------------>'+cInstance.name);
            // Prints The B's Name
            System.debug('C Parent Bs Name---------->'+cInstance.Bs__r.name);
            // Prints The C's Name
            System.debug('C Parent As Name---------->'+cInstance.A_relation__r.name);
        }
        
        /* RelationQueriesSoql relationInstance=new RelationQueriesSoql();
         * relationInstance.retriveAllecordsWithNameJohnFromC();
         */
     }
    
    /**
     * Method that has a SOQL query to find all Account records which have at least has an 
     * opportunity record which is 'Closed Won'.
     */
    public void findsAccountRecordHavingAtleastOneOpportunity()
     {
         // Iterate Over List of Account which fetches all records Having Opportunity Stage As Closed Won
        for(Account accountInstance :[
                              SELECT a.Name,
                                     a.Id 
                              FROM Account a 
                              WHERE a.id 
                              IN 
                              (SELECT AccountId 
                               FROM Opportunity 
                               WHERE Stagename='Closed won')])
          {
               //Print the Account List
               System.debug(accountInstance);
          }
       /**
        * RelationQueriesSoql relationInstance=new RelationQueriesSoql();
        * relationInstance.findsAccountRecordHavingAtleastOneOpportunity();
        */
    }
    
   /**
    * Method that fetches And prints the Account Record and finds all associated contact which 
    * contains the word 'John'.
    */
    public void retriveAccountAndRelatedContactsWhichContainsJohn()
    {
        // Fetches the account record and all associated contact which contains the word 'John'.
         List<Account> listAccount=[Select a.Name,
                                           a.Id , 
                                   (Select Name 
                                    from Contacts
                                    where Name 
                                    Like '%john%') 
                                    From Account a 
                                    Where a.Id 
                                    IN
                                   (Select AccountID
                                    From Contact
                                    Where Name 
                                    Like '%john%')];
                                    
          // Iterate Over the Accout List to Print the Result
          for(Account accountInstance :ListAccount)
             {
                 // Print the List
                   System.debug('Account Details ---------->'+accountInstance );
                 
                 // Iterate Over the Accout List to Print the Result
                 for(Contact contactInstance:AccountInstance.Contacts)
                 {
                        // Print the List
                         System.debug('Contact Details ---------->'+contactInstance);
                 }//End Of the For Loop
             }//End Of the For Loop
          /**
           * RelationQueriesSoql relationInstance=new RelationQueriesSoql();
           * relationInstance.retriveAccountAndRelatedContactsWhichContainsJohn();
           */
    }
    
    /**
    * Method That querys on 'A' and retrieve all parents with all their child records 
    * where in child name is 'John.
    */
    public void retriveRecordsFromAWhereChildnameisJohn()
    {
       // Initalize the List that Queries On 'A' and retrieve all records having child name as John.
        List<A__c> listOfA=[
            Select
                a.Name,
                a.Id,
                (Select
                    Name
                from
                    Cs__r
                where
                    Name 
                Like
                    '%john%'
                ) 
            From
                A__c a 
            where
                a.Id 
                IN
                (Select
                    A_relation__c
                from
                    C__c
                where
                    Name 
                Like
                    '%john%'
                )
            ];
            // Iterate Over the List Of A 
              for(A__c AInstance :listOfA)
                {   
                  // Print the List 
                  System.debug('A details -->' + AInstance);
                    
                    // Iterate Over the List Of Child Object C
                    for(C__c Cinstance:AInstance.Cs__r)
                    {
                        //Print The list 
                        System.debug('C details -->' + Cinstance);
                    }// End of inner for loop
                }// End of inner for loop
    }
}