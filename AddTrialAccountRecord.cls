public class AddTrialAccountRecord
{
    /**
    * Method Creates a Contact Record through the DML Operations.
    * It uses the DML Insert Operation.  
    */ 
    public void addAccount()
    { 
        // Add A Single Record of the Account 
        Account accountRecord= new Account(Name = 'Trial Add Account',Industry = 'Banking');
        //Inserts a Single Account Record.
        insert accountRecord;
    }

}