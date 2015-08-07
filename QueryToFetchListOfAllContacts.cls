public with sharing class QueryToFetchListOfAllContacts {
     /**
      * Method that Fetches all the Contatcs in a list 
      * And Prints The List.
      */
    public void QueryOnContactToAddThemToList() 
    {
       //List that fetches all the Contact Record.
        List<Contact> contactList=new List<Contact>();
        contactList=[Select c.Name, c.Id 
                     From Contact c 
                     where LastName <> :null];
        //Iterates over the List of all the Contacts.
        for(Contact contactInstance:contactList)
        {
            //Print the Result
            system.debug(contactInstance);
        }
    }    
}