public with sharing class AutomaticallyAssignConTactTriggerHandler
{
    /**
     * The Method Automatically associate a Contact created 
     * with the respective Account based on the email domain 
     * specified in the primary email address of the Contact.
     */
    public static void assignAccountID(List<Contact> contactList)
    {
        // Instantiate the Map That will Map the Website and the Account Id. 
        Map<String,id> mapOfAccountAndWebsite=new Map<String,id>();
        
        // For loop  iterates over all the accounts whose Website is not null.
        for(Account accountInstance :[
                                SELECT id,WebSite 
                                FROM Account 
                                WHERE Website<>null])
        { 
            // Add elements in the Map where key is a Website and ID is The value.
            mapOfAccountAndWebsite.put(
                                (accountInstance.Website).substringAfterLast('w.'),
                                 accountInstance.id);
        } // End of the for loop
    /*
    // Iterate over the Instance of the ContactList(Trigger New)
        for(Contact contactListinstance:contactList)
        {
           // Iterate over the Instance of the Websites in the Map
           for(String websiteInstance:mapOfAccountAndWebsite.keyset())
           {
               // Checks whether the Email Field is blank or not
               if(contactListinstance.Email<>null)
               {
                    // Checks the Email matches the website is present in the Map or Not
                    if(websiteInstance.containsIgnoreCase
                    (
                    (contactListinstance.Email).substringafter('@')))
                    {
                       // Add the Contact to the found Account fetch it from the Map of website and id
                      contactListinstance.AccountId=mapOfAccountAndWebsite.get(websiteInstance);
                    }
               }
           }
        }
    */
           // Iterate over the Instance of the ContactList(Trigger New)
          for(Contact contactListinstance:contactList)
          {
             // Checks whether the Email Field is blank or not
             if(contactListinstance.Email<>null)
               {
                   // Add the Contact to the found Account fetch it from the Map of website and id
                    contactListinstance.AccountId=
                    mapOfAccountAndWebsite.get((contactListinstance.Email).substringafter('@'));
               } // End of the if loop
          } // End of the for loop
    }
}