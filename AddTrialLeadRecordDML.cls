public class AddTrialLeadRecordDML 
{
    /**
    * Method Creates a Lead Record through the DML Operations.
    * It uses the DML Insert Operation.  
    */ 
    public void addLead()
    {
        //Adds a Single Lead Record
        Lead leadRecord = new Lead(Firstname ='Trial',LastName = 'Add Lead',Company = 'Eternus',Status= 'Open - Not Contacted');
        //Inserts a Single Lead Record
        insert leadRecord ;    
    }
}