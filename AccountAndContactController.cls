/**
 * This is a custom controller that is used on the account page and the contact page to 
 * perform operations to display the list of account and contacts, search the contact,
 * delete the contact.  
 */
public with sharing class AccountAndContactController 
{
    
    // Declare the list of the account.
    public List<Account> accountList;
    
    // Declare the list of the contact.
    public List<Contact> contactList;
    
    // Declare the list of the contact.
    public List<Contact> contactListInstanceForWrapper;
    
    // Declare the Id of the getter and setters which saves the Id instance of account.
    public Id idAccount {get; set;}
    
    // Declare the String with getters and Setters which saves the name from the account List .
    public List<Account> accountName {get; set;}
    
    // Declare the Integer with getters and setters which saves the size of the list.
    public Integer countSizeOfList {get; set;}
    
    // Declare the String with getters and setters to save the string that helps to search.
    public String searchStringAccount {get; set;}
    
    // Declare the list of string used for creating the adding A to Z variables.
    public List<String> listAToZInstance;
    
    // Declare the String with getters and setters Which saves the string to search the element. 
    public String alphabetName {get; set;}
    
    // Declare the Id of the getters and setters Which saves the Id instance of contact.
    public Id idcontact {get; set;}
    
    // Declare the list of contact.
    public List<Contact> seletedContactList {get; set;}
    
    // Declare the list of Wrapper.
    public List<WrapperForBindingCheckBoxWithContact> wrapperList;
    
    // Declare the boolean variable used to render the page block to add contact 
    public Boolean renderAddPage {get; set;}
    
    // Declare the boolean variable used to render the page block to display contact
    public Boolean renderContactDispalyPage {get; set;}
    
    // Declare the boolean variable used to render the page block to display contact
    public Boolean deleteContact {get; set;}
    
    // Declare the string with getters and setters for saving the last name.
    public String contactLastName {get; set;}
    
    public String contactEmail {get; set;}
    
   
   /**
    * This is a constructor that will initialize all the list.
    */
    public AccountAndContactController()
    {
        
        // Initialize the list of the wrapper
        wrapperList = new List<WrapperForBindingCheckBoxWithContact>();
        
        // Intitalize the boolean variable to false
        renderAddPage = false;
        
        // Intitalize the string to blank
        contactLastName = '';
        searchStringAccount= '';
        contactEmail = '';
        
        // Inititalize the boolean variable to true that by default shows the account page
        deleteContact = false;
        
        // Inititalize the boolean variable to true that by default shows the account page
        renderContactDispalyPage = true;
        
        // Initialize the list of the contact
        seletedContactList = new List<Contact>();
        
        // Initialize the list of the account
        accountList = new List<Account>();
        
        // Initialize the list of the contact
        contactList = new List<Contact>();
        
        // Initialize the list of the contact
        contactListInstanceForWrapper = new List<Contact>();
        
        // Initialize the list of the wrapper
        wrapperList = new List<WrapperForBindingCheckBoxWithContact>();
        
        // Initialize the list of the contact
        seletedContactList = new List<Contact>();
        
        // Initialize the list of the string
        listAToZInstance = new List<String>();
        
        // Initialize the list of the account
        accountName = new List<Account>();
    }
    
    
   /**
    * This is a getter that will fetch all the records of the account when the flag is false 
    * or if the flag is true fetch the searched account.
    */
    public List<Account> getAccountList()
    { 
        
        // Check if the search string is Empty.
        if(String.isEmpty(searchStringAccount))
        {
            
             // Fetch all the accounts record.
             accountList = 
                [
                    SELECT 
                        a.Website,
                        a.Phone, 
                        a.Name, 
                        a.Email_ID__c,
                        a.Id 
                    FROM 
                        Account a
                ];
          
             // Save total size of the account list.
             countSizeOfList = accountList.size();
        }
        else 
        {   
                
            // Fetch the accounts record that are searched.
            accountList = 
                [
                    SELECT 
                        a.Website, 
                        a.Phone, 
                        a.Name, 
                        a.Email_ID__c,
                        a.Id 
                    FROM 
                        Account a
                    WHERE 
                        Account.Name 
                    LIKE : '%'+ searchStringAccount.normalizeSpace() + '%'
                ];

            // Save total size of the account list.
            countSizeOfList = accountList.size();
        }
        
        // Return the account list.
        return accountList;
    }

   /**
    * This is a getter that will fetch all the records of the contact related to that account 
    * when the flag is false Or if the flag is true fetch the searched account.
    */
    public List<Contact> getContactList()
    {
        
        // Get the id passed from the accounts page.
        idAccount = ApexPages.currentPage().getParameters().get('accountid');
       
        // Check for the alphabet name string is empty or not. 
        if(String.isEmpty(alphabetName))
        {

            // Get the name of that account.
            accountName = 
                [
                    SELECT
                        Name
                    FROM 
                        Account 
                    WHERE 
                        Id = :idAccount
                ];

            // Fetch the contact records that are related to that account.
            contactList = 
                [
                    SELECT 
                        Id,
                        Name
                    FROM 
                        Contact 
                    WHERE
                        Account.Id = :idAccount
                ];
                
            // Saves the size of the list.
            countSizeOfList = contactList.size();
            
            // Return the contact list 
            return contactList;
        }
        else
        {
            
            // Fetch the contact records that are related to that account and which are searched.
            contactList = 
                [
                    SELECT 
                        Id,
                        Name 
                    FROM 
                        Contact 
                    WHERE 
                        (
                            LastName LIKE : alphabetName+ '%' 
                         AND
                            Account.Id = :idAccount
                        )
                    OR 
                        (
                            FirstName LIKE :alphabetName+ '%' 
                        AND 
                            Account.Id = :idAccount
                        )
                ];
                
           // Saves the size of the list.
           countSizeOfList = contactList.size();
           
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
        PageReference contactPage = Page.ContactPages;
        
        // Setting redirect true allows to redirect to new page.
        contactPage.setRedirect(true);
        
        // Set the parameters of account Id.
        contactPage.getParameters().put('accountid',idAccount);
        
        // Return the contact page.
        return contactPage;
    }
    
   /**
    * This is a method that will render the page block tabel
    */
    public void rerenderAddColumn()
    {
        
        // Set the contact pageblocktabel as false
        renderContactDispalyPage = false;
        
        // Set the add page 
        renderAddPage = true;
    }
    
   /**
    * This is a method that will insert the contact 
    */
    public void addContact()
    {
        // Create the instance of the contact
        Contact contactInstance = 
            new Contact(
                LastName = contactLastName,
                Email = contactEmail,
                AccountId = idAccount
            );
        
        try 
        {
            
            // Insert the contact instance
            insert contactInstance;
        
        }
        catch(Exception e)
        {   
        
            contactInstance.clear();
        }
        
        // Render the pageblocktabel
        renderContactDispalyPage = true;
        
        // Render the add page section to false 
        renderAddPage = false;
        
        // Initialize the string as blank
        contactLastName='';
        
        // Initialize the string as blank
        contactEmail = '';
    }
    
   /**
    * This is a method that will render the delete button if check box is selected
    */
    public void selectMultipleContact()
    {
        
        // Render the delete button if check box is selected
        deleteContact = true;
    }
    
   /**
    * This is a method that will delete multiple contact.
    */
    public void deleteMultipleContact()
    {
        
        // Iterate over the wrapper list
        for(WrapperForBindingCheckBoxWithContact wrapperInstance : wrapperList)
        {       
        
            // Check if the checkbox is selected or not
            if(wrapperInstance.checkBoxInstance)
            {
        
                // Add the contact instance to the selected contact list
                seletedContactList.add(wrapperInstance.contactInstance);
            }
        
        }// End of the for loop
       
        // Delete the selected contact list
        delete seletedContactList ;
         
        // Clear the contact list 
        seletedContactList.clear();
    }
    
   /**
    * This is the method that add the contact instance in to the wrapper list 
    * 
    */
    public List<WrapperForBindingCheckBoxWithContact> getwrapperList()
    {  
        
        // Clear the wrapper list
        wrapperList.clear();
        
        // Copy the list of the contact 
        contactListInstanceForWrapper = getContactList();
        
        // Iterate over the contact list
        for(Contact contactInstance : contactListInstanceForWrapper)
        {
        
            // Create the instance of the wrapper
            WrapperForBindingCheckBoxWithContact wrapperInstance = 
                new WrapperForBindingCheckBoxWithContact(contactInstance);

            // Add the wrapper instance to the wrapper list
            wrapperList.add(wrapperInstance);
            
        }
        
        // Return the wrapper list
        return wrapperList;
    }
         
   /**
    * Redirect to the account page 
    */
    public PageReference returnToAccount() 
    {
        
        // Render the pageblocktabel
        renderContactDispalyPage = true;
        
        // Render the add page section to false 
        renderAddPage = false;
        
        // Create the Reference of the page account
        PageReference accountPage = Page.AccountPage;
        
        // Setting redirect true allows to redirect to account Page.
        accountPage.setRedirect(true);
        
        // Return the Account Page.
        return accountPage;
    }
    
   /** 
    * This is a method that searches the account if the search result is less then 3 letters 
    * display the message else search the result.
    */
    public void searchResultAccount() 
    {
        
        // Check the length of the search string is less then 3 letters.
        if(searchStringAccount.normalizeSpace().length() < 3)
        {
            
            // Add error message on the page.
            ApexPages.addmessage(
                new ApexPages.message(
                    ApexPages.severity.info,
                    'Please enter at least 3 characters to perform search'
                )
            );
            
            searchStringAccount = '';
        }
    }
    
   /**
    * This is a method that clears the search result.
    */
    public void clearSearchResult()
    {
        
        // Set the search string as blank.
        searchStringAccount = '';
    }
   
   /**
    * This is a method that will add A to Z to the string list.
    */
    public List<String> getlistAToZInstance()
    {
        // Add A to Z to the list.
        listAToZInstance = new List<String> {'A','B','C','D','E','F','G','H','I','J','K','L',
            'M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z'};
                                        
        // Returns the list of letters.
        return listAToZInstance;
    }
   

   
   /**
    * This is a method that will delete the records from the contacts using the Vf remoting.
    */
    @RemoteAction
    public static void deleteRelatedContact(Id idcontact)
    {
        // Instantiate the contact.
        Contact deleteContact = new Contact();
        
        // Fetches the contact record to be deleted.
        deleteContact = 
            [
                SELECT 
                    Id 
                FROM 
                    contact 
                WHERE 
                    Id = :idcontact
           ];
        
        // Delete the contact record.
        delete deleteContact;
        
    }
    
   /**
    * This is a inner class that will bind the checkbox and the contact together
    */
    public class WrapperForBindingCheckBoxWithContact
    {
        // Declare the instance of the contact
        public Contact contactInstance {get; set;}
        
        // Declare the boolean variable.
        public Boolean checkBoxInstance {get; set;}
        
       /**
        * This is a constructor that will initialize the variables.
        */
        public WrapperForBindingCheckBoxWithContact(Contact contactParameter)
        {
            // Create the instance of the contact
            contactInstance = new Contact();
            
            // Assign the contact instance
            contactInstance = contactParameter;
            
            // Make the checkbox by default
            checkBoxInstance = false;
        }
    }
}