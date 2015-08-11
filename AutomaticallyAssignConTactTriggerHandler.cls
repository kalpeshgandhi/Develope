/**
 * This is a handler class that will automatically associate a Contact created 
 * with the respective Account based on the email domain specified in the 
 * primary email address of the Contac.t
 */
public with sharing class AutomaticallyAssignConTactTriggerHandler
{
   /**
    * This is a method that will automatically assosiate a contact
    * with the respective account based on the email domain 
    * specified in the primary email address of the Contact.
    */
    public static void assignAccountID(List<Contact> contactList)
    {
        // Instantiate the map that will map the website and the account id. 
        Map<String,Id> mapOfAccountAndWebsite=new Map<String,Id>();
        
        // Instantiate the set that has the value of contact domain.
        Set<String> setOfDomain=new  Set<String>();
        
        // Iterate over the contact instance.
        for(Contact contactInstanceForDomain:contactList)
        { 
             // Checks whether the email is not equals to null.
             if(contactInstanceForDomain.Email <> null)
             {
                 // Add the elements to the set.
                 setOfDomain.add('%'+ (contactInstanceForDomain.Email).substringafter('@'));
             }
        }
        // For loop  iterates over all the accounts whose website is not null.
        for(Account accountInstance :[
                                SELECT id,WebSite 
                                FROM Account 
                                WHERE Website 
                                LIKE :setOfDomain])
        { 
            // Add elements in the map where key is a website and ID is The value.
            mapOfAccountAndWebsite.put(
                                (accountInstance.Website).substringAfterLast('w.'),
                                 accountInstance.id);
        } // End of the for loop
        
        // Iterate over the instance of the contactList(Trigger New)
        for(Contact contactListInstance : contactList)
        {
             // Checks whether the email field is blank or not
             if(contactListInstance.Email <> null)
             {
                   // Assosiate the account to the contact ny fetching the accountid from map.
                   contactListInstance.AccountId=
                   mapOfAccountAndWebsite.get(
                                           (contactListInstance.Email).substringafter('@'));
             } // End of the if loop
             
        } // End of the for loop
    }
}