public Class AddTrialOpportunityRecordDML
{
    /**
    * Method Creates a Opportunity Record through the DML Operations.
    * It uses the DML Insert Operation.  
    */ 
      public void AddOportunity()
      {
          //Adds a Single Opportunity Record
          Opportunity opportunityRecord = new Opportunity(Name = 'Add Opportunity',StageName= 'Closed Won',CloseDate=system.today());
          //Insert A Single Opportuntiy Record.
          insert opportunityRecord ;
    }
}