public with sharing class CloningOfOpportunityHandler 
{
    //This is a flag to denote boolean true or false
    public static Boolean flag = true;
    /**
    * This is a Handler for a trigger that 
    * clones the opportunity record
    */
    public static void cloningOpportunity(List<Opportunity> opportuntiyInstance)
    {
        // Instantiate the List of Opportunity
        List<Opportunity> listOpportunity =new List<Opportunity>();
        // Iterate over a List of Opportuntiy(trigger.new) using for loop
        for(Opportunity InstanceOfOpportunity:opportuntiyInstance)
          {
              // Add the Cloned Opportuntity to the list
             listOpportunity.add(InstanceOfOpportunity.clone());
          }// End of the for Loop
         // Use this if loop to avoid the Recurtion.Presently flag is true.
         if(flag)
          { 
              //Set the flag as false so as to stop recurtion.
              flag=false;
              // Insert the List of Opportunity 
              insert listOpportunity;
          }// End of if loop. 
    }
}