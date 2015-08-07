public with sharing class SimpleSOQLQuery {
  
  /**
  * Method that Querys on all Contact records and 
  * add them to the List. Print that contents of this list.
  */
    public void contactQueryOnListAndPrintIt()
    {
        // Intialize the List of The Contact
        List<Contact> contactList=[Select c.Name, c.Id 
                                   From Contact c
                                   where LastName <> :null];
        // Iterate Over the List of Contact
        for(contact contactInstance:contactList)
           {
               //Print The Conatact List
              system.debug(contactinstance);
           }
    /**
     * SimpleSOQLQuery soqlInstance=new SimpleSOQLQuery();
     * soqlInstance.contactQueryOnListAndPrintIt();
     */
    }
    
       /**
        * Method that Gets all the Account Record that have Enrolled in Year
        * 1)2010
        * 2)2013,2014 Checks account Enrollment Year in 2010,2013,2014
        */
      public void checkEnrollmentYear() 
       {
        // This is a List that fetches the Account Records Having Enrollment Year 2010.
        List<Account> accountList =[Select a.Name, a.Id, a.Enrollment_Year__c 
                                    From Account a 
                                    where Enrollment_Year__c 
                                    INCLUDES('2010')]; 
        // This is a List that fetches the Account Records Having Enrollment Year 2013 or 2014.
        List<Account> accountListForTwoYears=[Select a.Name, a.Id, a.Enrollment_Year__c 
                                              From Account a 
                                              where Enrollment_Year__c 
                                              INCLUDES ('2013','2014')];
         
        System.debug(accountList);
        System.debug(accountListForTwoYears);
    }
    
  
    
    /**
     * Method That has a SOQL query to find all Account records where 'Billing State' is not 
     *'Maharashtra' and 'Kerala'.Order the results by Billing State in descending order with 
     * null values at the end. Display first 10,000 records only. 
     */
    public void billingStateNotMaharashtraOrKerala()
    {
        // Iterate Over the list of Account 
         for(Account accountInstance:[Select a.Name, a.Id, a.AccountNumber 
                                      From Account a 
                                      where BillingState__c 
                                      NOT IN  ('Mumbai','Kerala') 
                                      ORDER BY BillingState__c DESC Nulls Last 
                                      limit :10000])
            {
                // print The List
                    System.debug(accountInstance);
            }
           /**
           * SimpleSOQLQuery soqlInstance=new SimpleSOQLQuery();
           * soqlInstance.billingStateNotMaharashtraOrKerala();
           */
    }
    
    /**
     * Write a SOQL query to display 100 opportunity records with amount greater than 10,000 
     * order by created date.Skip first 50 records and include records from recycle bin. 
     */
     public void opportunityAmountGreaterThenTenthosand()
     {
         // Iterate Over the List of Opportunity
          for(Opportunity opportunityInstance:[Select o.Name, o.Id, o.Amount 
                                               From Opportunity o 
                                               where Amount>10000 
                                               ORDER BY CreatedDate 
                                               limit 100 Offset 50 All Rows])
             {
                 //Print the Result
                  System.debug(opportunityInstance);
             }
            /**
             * SimpleSOQLQuery soqlInstance=new SimpleSOQLQuery();
             * soqlInstance.opportunityAmountGreaterThenTenthosand();
             */
     }
}