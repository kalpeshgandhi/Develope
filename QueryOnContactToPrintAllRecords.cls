public class QueryOnContactToPrintAllRecords 
{
    //Query On All The Contacts Are Stored In This List.
    List<Contact> contactListInstance=[Select id,name 
                                   From Contact where Lastname <> :null];
   /**
    * Prints all the Contact Records in the list  
    */
    public void printContactList()
    {
    
        System.debug('This is the Contact for '+ contactListInstance);
    }
}
/*
 * Contact1List Mytrial =new Contact1List();
 *Mytrial.con();
 */