/**
 * This is a class that has various methods that contains the relationship queries from Parent to 
 * Child And Child to Parent. 
 */
public with sharing class RelationQueriesSoql
{
    
   /* This Method has the SOQL query on Contact to retrieve all active contacts belonging 
    * to 'media' Industry. It Also display the name of the account to which it is associated to.
    */
     public List<Contact> retriveActiveContactsFromAccounts()
     {
         List<Contact> contactList = new List<Contact>();
         // Iterate Over Contact List which fetches all The Contacts having the industry as Media 
         for(Contact contactInstance:[  
                                      SELECT  c.Id,
                                              c.Name,
                                              c.AccountId,
                                              c.Account.Name 
                                      FROM    Contact c 
                                      WHERE   Account.Industry ='Media' 
                                      AND     Account.Active__c ='Yes'
                                     ])
         {
              contactList.add(contactInstance);
              // Prints The ContactList
              System.debug('Contact Information'+contactInstance);
              
              // Prints The Account Name
              System.debug('Account Name'+contactInstance.Account.Name);
         }
         return contactList;
        /**
         * RelationQueriesSoql relationInstance=new RelationQueriesSoql();
         * relationInstance.retriveActiveContactsFromAccounts();
         */
    }
    
    /**
     * Method that Has the SOQL query on 'C'(Object) to retrieve all records of 'C' 
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
     public List<Account> findsAccountRecordHavingAtleastOneOpportunity()
     {
          // Create the instance of the list of account.
          List<Account> accountList = new List<Account>();
          
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
               
               // Add the records to the list
               accountList.add(accountInstance);
          }
          
          return accountList;
       /**
        * RelationQueriesSoql relationInstance=new RelationQueriesSoql();
        * relationInstance.findsAccountRecordHavingAtleastOneOpportunity();
        */
    }
    
   /**
    * Method that fetches And prints the Account Record and finds all associated contact which 
    * contains the word 'John'.
    */
    public List<Account> retriveAccountAndRelatedContactsWhichContainsJohn()
    {
        // Create the instance of the list of account.
        List<Account> accountList = new List<Account>();
        
        // Fetches the account record and all associated contact which contains the word 'John'.
        List<Account> listAccount=[
                                   SELECT a.Name,
                                          a.Id , 
                                   (
                                    SELECT Name 
                                    FROM Contacts
                                    WHERE Name 
                                    LIKE '%john%'
                                    ) 
                                    FROM Account a 
                                    WHERE a.Id 
                                    IN
                                   (
                                    SELECT AccountID
                                    FROM Contact
                                    WHERE Name 
                                    LIKE '%john%'
                                    )
                                    ];
                                    
        // Iterate Over the Account List to Print the Result
        for(Account accountInstance :ListAccount)
        {
            // Print the List
            System.debug('Account Details ---------->'+accountInstance );
            accountList.add(accountInstance);
            // Iterate Over the Account List to Print the Result
            for(Contact contactInstance:AccountInstance.Contacts)
            {
                // Print the List
                System.debug('Contact Details ---------->'+contactInstance);
            }// End Of the For Loop
        }// End Of the For Loop
        return accountList;
        
        /**
         * RelationQueriesSoql relationInstance=new RelationQueriesSoql();
         * relationInstance.retriveAccountAndRelatedContactsWhichContainsJohn();
         */
    }
    
    /**
    * Method That query’s on 'A' and retrieve all parents with all their child records 
    * where in child name is 'John.
    */
    public List<C__c> retriveRecordsFromAWhereChildnameisJohn()
    {
        // Create the instance of List of C__c
        List<C__c> listOfC= new List<C__c>();
        
        // Create the instance of List of A__c
        List<A__c> listAInstance= new List<A__c>();
        
        // Initialize the List that Queries On 'A' and retrieve all records having child name as John.
        List<A__c> listOfA=[
                            SELECT a.Name,
                                   a.Id,
                                  (
                                   SELECT Name
                                   FROM
                                        Cs__r
                                   WHERE
                                         Name 
                                   LIKE
                                        '%john%'
                                   ) 
                             FROM
                                 A__c a 
                             WHERE
                                  a.Id 
                             IN
                                (SELECT
                                        A_relation__c
                                 FROM
                                       C__c
                                 WHERE
                                       Name 
                                 LIKE
                                      '%john%'
                                )
                                ];
            // Iterate Over the List Of A 
            for(A__c aInstance :listOfA)
            {   
                // Print the List 
                System.debug('A details -->' + aInstance);
                listAInstance.add(AInstance);
                // Iterate Over the List Of Child Object C
                for(C__c cInstance:AInstance.Cs__r)
                {
                     //Print The list 
                     System.debug('C details -->' + cInstance);
                     listOfC.add(cInstance);
                }// End of inner for loop
            }// End of inner for loop

           return listOfC;
    }
}
