/**
 * This is a class that displays the map structure for Account with account Id and account 
 * and account name and account Id.
 */
public with sharing class DisplayTheMapStructure
{    
    /**
    * Method that displays the map structures :
    * Account Id as key and entire Account object as value.
    */
    public Map<Id,Account> mapOfIdAndAccount()
    {
      
        // List that fetches the All the Account
        List<Account> accountList = 
            [
                SELECT 
                    a.Id, 
                    a.name 
                FROM 
                    Account a 
                LIMIT 200
            ];

        // Initialize the Map where Id is the Key and Account Is the Value  
        Map<Id,Account> accountIdWithAccountMap=new Map<Id,Account>();

        // Iterate Over the List of the Account
        for(Account accountInstance:accountList)
        {   
           // Add key Value Pair to the Map
            accountIdWithAccountMap.put(accountInstance.Id,accountInstance);
        } 
        
        //Print the map
        System.debug('Map of Account ID and Account is :\n'+accountIdWithAccountMap);  
        
        return accountIdWithAccountMap;
        // Iterate Over the List of the Account 
    }
        
   /**
    * Method that displays the map structures :
    * Account Name as key and Account Id object as value.
    */
    public Map<String,Id> mapOfAccountNameAndAccountId()
    {
         // List that fetches the All the Account
        List<Account> accountList = 
            [
                SELECT 
                    a.Id, 
                    a.name 
                FROM 
                    Account a 
                LIMIT 200
            ];

        // Initialize the Map where  Account Name is the Key and Id the Value  
        Map<String,Id> accountNameWithAccountIdMap=new Map<String,Id>();
        
        for(Account accountInstance:accountList)
        {          
             // Add key Value Pair to the Map
             accountNameWithAccountIdMap.put(accountInstance.name,accountInstance.id);
        } 
           
        //Print the map
        System.debug('Map of Account Name And Account ID is :\n' + accountNameWithAccountIdMap);
        
        return accountNameWithAccountIdMap;
    }
        
}
