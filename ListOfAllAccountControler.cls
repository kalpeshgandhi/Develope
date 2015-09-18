/**
 * This is a custom controller that is used on the account page and the contact page to 
 * perform operations to display the list of account and contacs,search the contact,delete the 
 * contact.  
 */
global with sharing class ListOfAllAccountControler 
{
  // Declare the list of the account.
    public List<Account> account;
    
    // Declare the list of the contact.
    public List<Contact> contactList;
    
    // Declare the Id of the getters and setters which saves the Id instance of account.
    public Id idAccount {get; set;}
    
    // Declare the String with getters and Setters which saves the name from the account List .
    public Account accName {get; set;}
    
    // Declare the Integer with getters and setters which saves the size of the list.
    public Integer countSizeOfList{get;set;}
    
    // Declare the String with getters and setters to save the string that helps to search.
    public String searchStringAccount{get;set;}
    
    // Declare the list of string used for creating the adding A to Z variables.
    public List<String> listAToZInstance;
    
    // Declare the String with getters and setters Which saves the string to search the element. 
    public String alphaName {get; set;}
    
    // Declare the Id of the getters and setters Which saves the Id instance of contact.
    public Id idcontact{get; set;}
 
   /**
    * This is a getter that will fetch all the records of the account when the flag is false 
    * or if the flag is true fetch the searched account.
    */
    public List<Account> getAccount()
    { 
        // Check if the flag is false.
        if(String.isEmpty(searchStringAccount))
        {
            // Fetch all the accounts record.
             account=[
                      SELECT a.Website,
                             a.Phone, 
                             a.Name, 
                             a.Email_ID__c,
                             a.Id 
                      FROM Account a];
             // Save total size of the account list.
             countSizeOfList=account.size();
        }
        else 
        {   
            // Fetch the accounts record that are searched.
              account=[SELECT a.Website, 
                              a.Phone, 
                              a.Name, 
                              a.Email_ID__c,
                              a.Id 
                             FROM Account a
                             WHERE Account.name 
                             LIKE :'%'+ searchStringAccount.trim() +'%'];
              // Save total size of the account list.
              countSizeOfList=account.size();
        }
        // Return the account list.
        return account;
    }
 
   /**
    * This is a getter that will fetch all the records of the contact related to that account 
    * when the flag is false Or if the flag is true fetch the searched account.
    */
    public List<Contact> getcontactList()
    {
        // Get the id passed from the accounts page.
        idAccount = ApexPages.currentPage().getParameters().get('aid');
        // Check for the Flag.
        if(String.isEmpty(alphaName))
        {
            // Get the name of that account.
            accName =[SELECT Name
                      FROM Account 
                      Where Id= :idAccount];
                         
            // Fetch the contact records that are related to that account.
            contactList=[
                       SELECT Id,
                              Name
                         FROM Contact 
                         WHERE Account.id =: idAccount];
            // Saves the size of the list.
            countSizeOfList=contactList.size();
            // Return the contact list 
            return contactList;
        }
        else
        {
           // Fetch the contact records that are related to that account and are which are searched.
            contactList=[SELECT Id,Name 
                         FROM Contact 
                         WHERE Name LIKE :alphaName+ '%' and Account.id =: idAccount];
           //  Saves the size of the list.
           countSizeOfList=contactList.size();
           // Return the contact list 
           return contactList;
        }
    }
   /**
    * Redirect to the contact page and pass the parameters account id and account name.
    */
    public PageReference gotoContact()
    {
        // Create the reference of the page Contact
        PageReference contactPage =Page.ContactPages;
        
        // Setting redirect true allows to redirect to new page.
        contactPage.setRedirect(true);
        
        contactPage.getParameters().put('aid',idAccount);
        
        // Return the contact page.
        return contactPage;
    }
    
   /**
    * Redirect to the Account page 
    */
    public PageReference returnToAccount() {
        // Create the Reference of the page account
        PageReference AccountPage=Page.ListOfAccountPage;
        
         // Setting redirect true allows to redirect to account Page.
        AccountPage.setRedirect(true);
        
        // Return the Account Page.
        return AccountPage;
    }
    
   /** 
    * This is a method that searches the account if the search result is less then 3 letters display
    * the message else search the result.
    */
    public void searchResultAccount() 
    {  
        // Check the length of the search string is less then 3 letters.
         if(searchStringAccount.length()<3)
        {
           // Add error message on the page.
           ApexPages.addmessage(new ApexPages.message(
                                          ApexPages.severity.info,
                                         'Please enter at least 3 characters to perform search'));
        }
    }
    
    /**
     * This is a method that clears the search result.
     */
    public void clearSearchResult()
    {
        // Set the search string as blank
        searchStringAccount=' ';
    }
    /**
    * This is a method that will add A to Z to the string list.
    */
    public List<String> getlistAToZInstance()
    {
        // Add A to Z to the list.
      listAToZInstance=new List<String>{'A','B','C','D','E','F','G','H','I','J','K','L',
                                        'M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z'};
                                        
      // Returns the list of leters.
      return listAToZInstance;
    }
   /**
    * This is a method that sets the flag true so as to search the contact result.
    */
    public void displayAlfa()
    {
        // Returns the Contact List.
        getcontactList();
    }
   /*
    * This is a method that will delete the records from the contacts using the Vf remoting.
    */
    @RemoteAction
    global static void deleteRelatedContact(Id idcontact)
    {
        // Intantiate the Contact.
        Contact deleteContact=new Contact();
        
        // Fetches the contact record to be deleted.
        deleteContact =[
                        SELECT id 
                        FROM contact 
                        WHERE id =:idcontact];
        
        // Delete the contact record.
        delete deleteContact;
    }
}