public class AddTrialContactRecordDML 
{
   /**
    * Method Creates a Contact Record through the DML Operations.
    * It uses the DML Insert Operation.  
    */ 
    public void addContact()
    {
       // Adds a Single Contact Record.
       Contact contactRecord = new Contact(Firstname ='Trial',LastName='Add Contact',Department='ECS');
       //Inserts A Single Contact Record.
       insert contactRecord ;  
    }
 
}