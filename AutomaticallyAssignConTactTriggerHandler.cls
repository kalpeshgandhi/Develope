/**
 * This is a handler class that will automatically associate a contact created 
 * with the respective account based on the email domain specified in the 
 * primary email address of the Contact
 */
public with sharing class AutomaticallyAssignConTactTriggerHandler
{
    /**
    * This is a method that will automatically associate a contact
    * with the respective account based on the email domain 
    * specified in the primary email address of the contact.
    */
    public static void assignAccountID(List<Contact> contactList)
    {
        // Instantiate the map that will map the website and the account id. 
        Map<String,Id> mapOfAccountAndWebsite=new Map<String,Id>();
        
        // Instantiate the set that has the value of contact domain.
        Set<String> setOfDomain= new Set<String>();
        
        // Iterate over the contact instance.
        for(Contact contactInstanceForDomain:contactList)
        { 
            // Checks whether the email is not equals to null.
            if(contactInstanceForDomain.Email <> null)
            {
                // Add the elements to the set.
                setOfDomain.add('%'+ (contactInstanceForDomain.Email).substringAfter('@'));
            }
        }
        // For loop iterates over all the accounts whose website is not null.
        for(Account accountInstance :[
                                SELECT Id,
                                       Website 
                                FROM Account 
                                WHERE Website 
                                LIKE :setOfDomain])
        { 
            // Add elements in the map where key is a website and ID is The value.
            mapOfAccountAndWebsite.put(
                                (accountInstance.Website).substringAfterLast('w.'),
                                 accountInstance.Id);
        } // End of the for loop
        
        // Iterate over the instance of the contactList(Trigger New)
        for(Contact contactListInstance : contactList)
        {
             // Checks whether the email field is blank or not
             if(contactListInstance.Email <> null)
             {
                   // Associate the account to the contact by fetching the accountid from map.
                   contactListInstance.AccountId=
                   mapOfAccountAndWebsite.get(
                                           (contactListInstance.Email).substringAfter('@'));
             } // End of the if loop
             
        } // End of the for loop
    }
}