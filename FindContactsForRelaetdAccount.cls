public class FindContactsForRelaetdAccount 
{
       /**
        * Method that finds the list of contacts related to a Account
        * Where Account is Passed
        */
    public void findContact(ID accountInstance)
    {
        //List of contact for a Perticular Account.
        List<Contact> contactList = [Select Id, FirstName, LastName 
                                     FROM Contact 
                                     WHERE AccountId = :accountInstance]; 
        System.debug(contactList);
    }
}
/**
*Accountlist AccountlistInstance=new Accountlist();
*AccountlistInstance.findContact('00128000003vQ79');
*/