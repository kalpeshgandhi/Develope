/**
 * This is a test method that creates the test data for all the test methods.
 * This method is created for reuse of the data. 
 */
@isTest
public class TestDataFactory 
{
    /**
    * This is the method that used to create the account. It takes an integer as a 
    * parameter which defines the no of accounts to be created. 
    */
    public static List<Account> accountTestData(Integer listAccountsize) 
    {
        // Create the instance of list of account
        List<Account> accountDataList = new List<Account>();

        // Iterate over the for loop to add accounts. 
        for(Integer i = 0; i < listAccountsize; i++)
        {
            // Add the Accounts to the list.
            accountDataList.add(new Account(Name = 'TestAccount' + i,
                                            Website = 'http://www.testforce.com')
                                           ); 
        } // End of the for loop
        
        // Return the list of account.
        return accountDataList;
    }
    
    public static List<Contact> contactTestData(Integer listContactsize) 
    {
       // Create an instance list of contact.
       List<Contact> contactList = new List<Contact>();
       
        // Iterate over the for loop to add contacts. 
       for(Integer i = 0; i < listContactsize; i++)
       {
                // Add The contacts to the list.
                contactList.add(new Contact(LastName = 'testContact' + i,
                                            Email = 'test@testforce.com')
                                            );
       } // End of the for loop
       
       // Return the list of contact.
       return contactList;
    }
    
    public static List<Contact> contactTestData(Integer listContactsize,Id AccountIdParameter) 
    {
       // Create an instance list of contact.
       List<Contact> contactList = new List<Contact>();
       
        // Iterate over the for loop to add contacts. 
       for(Integer i = 0; i < listContactsize; i++)
       {
                // Add The contacts to the list.
                contactList.add(new Contact(LastName = 'TestContact' + i,
                                            Email = 'test@testforce.com',
                                            AccountId = AccountIdParameter)
                                            );
       } // End of the for loop
       
       // Return the list of contact.
       return contactList;
    }
}
