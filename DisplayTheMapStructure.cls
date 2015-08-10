public with sharing class DisplayTheMapStructure{
    
    /**
    * Method that displays the map structures :
    * a. Account Name as key and AccountId as value.
    * b. Account Id as key and entire Account object as value.
    */
    public void mapAccount()
    {
        // List that fetches the All the Account
        List<Account> accountList =[
                             SELECT a.Id, 
                                    a.AccountNumber,
                                    a.name 
                             FROM Account a 
                             LIMIT 200];
                                    
        // Intialize the Map where Id is the Key and Account Is the Value  
        Map<Id,Account> accountIdWithAccountMap=new Map<Id,Account>();
        
        // Intialize the Map where  Account Name is the Key and Id the Value  
        Map<String,Id> accountNameWithAccountIdMap=new Map<String,Id>();
        
        // Iterate Over the List of the Account
        for(Account accountInstance:accountList )
        {   
           // Add key Value Pair to the Map
            accountIdWithAccountMap.put(accountInstance.Id,accountInstance);
        } 
        
        //Print the map
        System.debug('Map of Account ID and Account is :\n'+accountIdWithAccountMap);  
              
        // Iterate Over the List of the Account 
        for(Account accountInstance:accountList )
        {          
             // Add key Value Pair to the Map
             accountNameWithAccountIdMap.put(accountInstance.name,accountInstance.id);
        } 
           
        //Print the map
        System.debug('Map of Account Name And Account ID is :\n' + accountNameWithAccountIdMap);  
        }
}