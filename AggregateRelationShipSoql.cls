public with sharing class AggregateRelationShipSoql 
{
    
   /**
    * This is a Method that Finds the Sum of Closed Opportunity for a Current Fiscal Year
    * And Store this information in a map with key as year and value as sum of amount.
    */
    public void sumOfClosedOpportunityAmountForCurrentFiscalYear()
   {
        // Fetches the query and stores it in the list
        List<AggregateResult> listAggregateResult=[
                                              SELECT SUM(o.Amount) sumAlias,
                                                     CloseDate 
                                              FROM   Opportunity o 
                                              WHERE CloseDate = THIS_FISCAL_YEAR 
                                              GROUP BY CloseDate];

        /** 
        * can use [Select Sum(Amount) s,CloseDate From 
        * Opportunity o Group By CloseDate having 
        * CloseDate=this_Fiscal_Year]
        */
        
         // Initialize the map of integer as a key and a Double
         Map<Integer,Double> mapForYearAndSum=new Map<Integer,Double>();
        
         // Start of for loop
         for(AggregateResult aggregateResultInstance:listAggregateResult)
         {
          // Get the Closed Date from List of Aggrigate Results And save it in a DateInstance.  
          Date dateinstance=Date.valueof(aggregateResultInstance.get('Closedate'));
          
          // Assign the Year From The Fetched Closed date 
          Integer yearInstannce=dateinstance.year();
          
          // Get the value of sum from List of Aggrigate Results And save it in a DateInstance. 
          Double  amountInstance = Double.valueOf(aggregateResultInstance.get('sumAlias'));
          
          // Add key as Year and Value as Sum to the map 
          mapForYearAndSum.put(yearInstannce,amountInstance);
         }//End of For Loop
         
         system.debug(mapForYearAndSum);
    /**
    * AggregateRelationShipSoql instance=new AggregateRelationShipSoql();
    * instance.sumOfClosedOpportunityAmountForCurrentFiscalYear();
    */
   }

   /**
    * This is a Method that Find total number of distinct Lead records on basis of 'Lead Source'
    * having greater than 10 leads And Print this information.
    */
    public void TotalNoOfDistinctLeadRecordsOnBasisOfLeadSource()
    {
       // Fetches the query and stores it in the list.
       List<AggregateResult> listAggregate=[
                                     SELECT count_distinct(Name),
                                            LeadSource 
                                     FROM lead 
                                     GROUP BY LeadSource 
                                     HAVING Count_distinct(Name)>10];
       
       // Iterate Over The list of Aggregate Result
       for(AggregateResult aggregateInstance :listAggregate)
       {
          System.debug(aggregateInstance);
       }
       
      /**
       * AggregateRelationShipSoql instance=new AggregateRelationShipSoql();
       * instance.TotalNoOfDistinctLeadRecordsOnBasisOfLeadSource();
       */
    }
  
  /**
   * This is a Method to find total number of Lead records by status by Lead Source. 
   * Store this information in map and display the same.
   */
   public void LeadRecordsByStatus()
   {
       // Fetches the query and stores it in the list.
       List<AggregateResult> aggregateResultList=[
                                          SELECT count(id) countAlias,
                                                 status,
                                                 leadsource 
                                          FROM   lead 
                                          GROUP BY status,leadsource];
       
       // Intantiate the map with  Key As a String And value as a map of string and Integer.
       Map<string,Map<string,integer>> mapofmap=new Map<string,Map<string,integer>>();
       
       // Intantiate the Map with String as a Key and Integer as a Value.
       Map<string,Integer> mapInstanceSting= new map<string,Integer>();
       
       // Iterate over the Aggrigate results list
       for(AggregateResult aggrigateInstance:aggregateResultList )
       {
            // Fetches the value of the count from the List.
            Integer countInteger = Integer.valueof(aggrigateInstance.get('countAlias'));
            
            // Fetch all the lead Sources from the List.
            string leadSource = string.valueof(aggrigateInstance.get('LeadSource'));
            
            // Insert the Valyes in the map.
            mapInstanceSting.put(leadSource,countInteger);  
      
           // Fetch the status from the list of Aggrigate Results.
           string leadStatus =string.valueof(aggrigateInstance.get('Status'));
  
           // Insert the values in the Map.
           Mapofmap.put(leadStatus,new map<string,Integer>(mapInstanceSting));
       }// End of the For loop.
       
       system.debug(mapofmap);
       
      /**
       * AggregateRelationShipSoql instance=new AggregateRelationShipSoql();
       * instance.LeadRecordsByStatus();
       */
   }
}