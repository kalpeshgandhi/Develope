global with sharing class ListOfAllAccountControler 
{
    // Declare the List of the Account.
    public List<Account> account;
    // Declare the List of the Contact.
    public List<Contact> contactList;
    // Declare the Id of the getters and setters Which saves the Id Instance of Account.
    public Id idAccount {get; set;}
    // Declare the String with getters and Setters Which saves the Name from the account List .
    public String accName {get; set;}
    // Declare the Integer with getters and setters Which saves the size of the account list.
    public Integer accountSize{get;set;}
    // Declare the Integer with getters and setters Which saves the size of the contact list.
    public Integer contactSize{get;set;}
    // Declare the String with getters and setters to save the String that helps to search.
    public String searchStringAccount{get;set;}
    // Declare the list of string used for creating the adding A to Z Variables.
    public List<String> listAToZInstance;
    // Initialize the Flag to false.
    public Boolean flagCheck=false;
    // Declare the String with getters and Setters Which saves the string to search the element. 
    public String alphaName {get; set;}
      // Declare the Id of the getters and setters Which saves the Id Instance of Contact.
    public Id idcontact{get; set;}
 
   /**
    * This is a Getter that will fetch all the records of the Account when the flag is false 
    * Or if the Flag is true fetch the searched account.
    */
    public List<Account> getAccount()
    { 
        // Check if the Flag is false.
        if(flagCheck==false)
        {
            // Fetch all the Accounts record.
             account=[Select a.Website, a.Phone, a.Name, a.Email_ID__c,a.Id 
                      From Account a];
             // Save total size of the Account List.
             accountSize=account.size();
        }
        else 
        {   
            // Fetch the Accounts record that are searched.
              account=[Select a.Website, a.Phone, a.Name, a.Email_ID__c,a.Id 
                             From Account a
                             Where Account.name like :'%'+ searchStringAccount.trim() +'%'];
              // Save total size of the Account List.
              accountSize=account.size();
        }
        // Return the Account list.
        return account;
    }
 
   /**
    * This is a Getter that will fetch all the records of the Contact related to that account 
    * when the flag is false Or if the Flag is true fetch the searched account.
    */
    public List<Contact> getcontactList()
    {
        // Get the id passed from the accounts page.
        idAccount = ApexPages.currentPage().getParameters().get('aid');
        // Check for the Flag.
        if(flagCheck==false)
        {
            // Get the name of that account.
            accName = ApexPages.currentPage().getParameters().get('aname');
            // Fetch the contact records that are related to that account.
            contactList=[Select Id,Name 
                         from Contact 
                         where Account.id =: idAccount];
            // Saves the size of the list.
            contactSize=contactList.size();
            // Return the contact list 
                  return contactList;
        }
        else
        {
           // Fetch the contact records that are related to that account and are which are searched.
            contactList=[Select Id,Name 
                         from Contact 
                         where Name like :alphaName+ '%' and Account.id =: idAccount];
           //  Saves the size of the list.
           contactSize=contactList.size();
           // Return the contact list 
                  return contactList;
        }
    }
   /**
    * Redirect to the contact page and pass the parameters Account id and account name.
    */
    public PageReference gotoContact()
    {
        // Create the Reference of the page Contact
        PageReference contactPage =Page.ContactPages;
        // Setting redirect true allows to redirect to new page.
        contactPage.setRedirect(true);
        contactPage.getParameters().put('aid',idAccount);
        contactPage.getParameters().put('aname',accName);
        // Return the Contact Page.
        return contactPage;
    }
    
   /**
    * Redirect to the Account page 
    */
    public PageReference returnToAccount() {
        // Create the Reference of the page Account
        PageReference AccountPage=Page.ListOfAccountPage;
         // Setting redirect true allows to redirect to Account Page.
        AccountPage.setRedirect(true);
        // Return the Account Page.
        return AccountPage;
    }
    
   /** 
    * This is a method that searches the Account if the search result is less then 3 letters Display
    * the message else search the result.
    */
    public void SearchResultAccount() 
    {  
        // Check the Length of the Search String is less then 3 letters.
         if(searchStringAccount.length()<3)
        {
            // Assign Flag as False.
            flagCheck=false;
            // Add error message on the page.
           ApexPages.addmessage(new ApexPages.message(ApexPages.severity.info,
                                                       'Please enter at least 3 characters to perform search'));
        }
        else
        {
             // Assign Flag as True.
            flagCheck=true;
        }
    }
    
    /**
     * This is a Method that clears the search result.
     */
    public void clearSearchResult()
    {
        // Set the Flag as Flase.
        flagCheck=false;
        // Set the Search string as Blank
        searchStringAccount=' ';
    }
    /**
    * This is a Method that will add A to Z to the string list.
    */
    public List<String> getlistAToZInstance()
    {
        // Add A to Z to the list.
      listAToZInstance=new List<String>{'A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z'};
      // Returns the list of leters.
      return listAToZInstance;
    }
   /**
    * This is a method that sets the flag true so as to search the contact result.
    */
    public void displayAlfa()
    {
        // Set the Flag as true.
        flagcheck=true;
        // Returns the Contact List.
        getcontactList();
    }
   /*
    * This is a Method that will delete the records from the contacts using the Vf Remoting.
    */
    @RemoteAction
    global static void deleteRelatedContact(Id idcontact)
    {
        // Intantiate the Contact.
        Contact deleteContact=new Contact();
        // Fetches the contact record to be deleted.
        deleteContact =[Select id from contact where id =:idcontact];
        // Delete the contact record.
        delete deleteContact;
    }
}