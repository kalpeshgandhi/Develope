/**
 * This is a class that has the methods that has the soql queries.
 */
public with sharing class SimpleSOQLQuery 
{
    
   /**
    * Method that query on all contact records and 
    * add them to the List.
    */
    public List<Contact> fetchContactList()
    {
    // Fetch all the contacts and save them in the list.
    List<Contact> contactListInstance=[
                                      SELECT Id,
                                             Name 
                                      FROM Contact 
                                      WHERE LastName <> null 
                                      ];
                                      system.debug(contactListInstance);
    return contactListInstance;
    }
   /**
    * Prints all the Contact Records in the list  
    */
    public Integer printContactList()
    {
         List<Contact> contactList=fetchContactList();
        // Print the contact list
        System.debug('This is the Contact for '+ contactList);
        // Returns the size of the list.
        return contactList.size();
    }
    
    /**
     * Method that gets all the account record that have enrolled in year
     * 1)2010
     * 2)2013,2014 checks account enrollment year in 2013,2014
     */
    public List<Account> checkEnrollmentYear2010() 
    {
        // This is a list that fetches the account records having enrollment year 2010.
        List<Account> accountList =[
                                   SELECT a.Name,
                                          a.Id, 
                                          a.Enrollment_Year__c 
                                   FROM Account a 
                                   WHERE Enrollment_Year__c 
                                   INCLUDES('2010')]; 
        System.debug('List of Accounts In 2010' + accountList);
       return accountList;
    }
       
    public List<Account> checkEnrollmentYear20132014() 
    {
        // This is a List that fetches the account records having enrollment year 2013,2014.
        List<Account> accountListForTwoYears=[
                                             SELECT a.Name,
                                                    a.Id,
                                                    a.Enrollment_Year__c 
                                             FROM Account a 
                                             WHERE Enrollment_Year__c 
                                             INCLUDES ('2013','2014')];
        System.debug('List of Accounts In 2013,2014' + accountListForTwoYears);
        return accountListForTwoYears;
    }
    
   /**
    * Method that has a SOQL query to find all account records where 'Billing State' is not 
    *'Maharashtra' and 'Kerala'.Order the results by billing state in descending order with 
    * null values at the end. Display first 10,000 records only. 
    */
    public List<Account> billingStateNotMaharashtraOrKerala()
    {
         // Initialize the list of account.
         List<Account> accountList = new List<Account>();
         
         // Iterate Over the list of Account 
         for(Account accountInstance:[
                                      SELECT a.Name,
                                             a.Id, 
                                             a.AccountNumber 
                                      FROM Account a 
                                      WHERE BillingState__c 
                                      NOT IN ('Maharashtra','Kerala') 
                                      ORDER BY BillingState__c DESC Nulls Last 
                                      LIMIT :10000])
         {
             accountList.add(accountInstance);
             // print The List
             System.debug(accountInstance);
         }
         
         return accountList;
         
        /**
         * SimpleSOQLQuery soqlInstance=new SimpleSOQLQuery();
         * soqlInstance.billingStateNotMaharashtraOrKerala();
         */
    }
    
    /**
     * Write a SOQL query to display 100 opportunity records with amount greater than 10,000 
     * order by created date. Skip first 50 records and include records from recycle bin. 
     */
     public List<Opportunity> opportunityAmountGreaterThenTenthosand()
     {
         // Create the Instance of the opportunity.
         List<Opportunity> opportunityList=new List<Opportunity>();
         // Iterate Over the List of Opportunity
         for(Opportunity opportunityInstance:[
                                              SELECT o.Name,
                                                     o.Id,
                                                     o.Amount 
                                              FROM Opportunity o 
                                              WHERE Amount>10000 
                                              ORDER BY CreatedDate 
                                              LIMIT 100 
                                              OFFSET 50 All Rows])
         {
             //Print the Result
             System.debug(opportunityInstance);
             opportunityList.add(opportunityInstance);
         }
         return opportunityList;
        /**
         * SimpleSOQLQuery soqlInstance=new SimpleSOQLQuery();
         * soqlInstance.opportunityAmountGreaterThenTenthosand();
         */
    }
}
