public with sharing class MapofAccountNameAndId {
    /**
    * Method that displays the map structures :
    * a. Account Name as key and AccountId as value.
    * b. Account Id as key and entire Account object as value.
    */
    public void mapAccount()
    {
        // List that fetches the All the Account
        List<Account> accountList =[Select a.Id, a.AccountNumber,a.name 
                                    From Account a 
                                    where name<> :null];
        //Intialize the Map where Id is the Key and Account Name Is the Value  
        Map<Id,String> mapAccountIdAndAccount=new Map<Id,String>();
        //Intialize the Map where  Account Name is the Key and Id the Value  
        Map<String,Id> mapAccountNameAndAccountId=new Map<String,Id>();
        // Iterate Over the List of the Account
        for(Account accountInstance:accountList )
        {   
           // Add key Value Pair to the Map
            mapAccountIdAndAccount.put(accountInstance.Id,accountInstance.name);
        } 
             //Print the map
             System.debug('\n\r'+mapAccountIdAndAccount);  
              // Iterate Over the List of the Account 
          for(Account accountInstance:accountList )
           {   
             // Add key Value Pair to the Map
            mapAccountNameAndAccountId.put(accountInstance.name,accountInstance.id);
           } 
                //Print the map
            System.debug('\n\r'+mapAccountNameAndAccountId);  
        /**
        * SimpleSOQLQuery soqlInstance=new SimpleSOQLQuery();
        * soqlInstance.mapAccount();
        */
    }
}