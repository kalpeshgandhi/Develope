/**
 * This is a class which has the queries on the Aggregate Relationship
 */
 public with sharing class AggregateRelationShipSoql 
 {
    /**
     * This is a method that finds the sum of closed opportunity for a current fiscal year
     * and store this information in a map with key as year and value as sum of amount.
     */
     public Map<Integer,Double> sumOfClosedOpportunityAmountForCurrentFiscalYear()
     {
        // Fetches the query and stores it in the list
        List<AggregateResult> listAggregateResult=[
                                                  SELECT SUM(o.Amount) sumAlias,
                                                         CloseDate 
                                                  FROM   Opportunity o 
                                                  WHERE CloseDate = THIS_FISCAL_YEAR 
                                                  AND StageName LIKE 'Closed %'
                                                  GROUP BY CloseDate];

        // Initialize the map of integer as a key and a double
        Map<Integer,Double> mapForYearAndSum=new Map<Integer,Double>();

        // Start of for loop
        for(AggregateResult aggregateResultInstance:listAggregateResult)
        {
            // Get the closed date from list of aggregate results and save it in a date Instance.  
            Date dateInstance=Date.valueof(aggregateResultInstance.get('Closedate'));

            // Assign the year from the fetched closed date 
            Integer yearInstannce=dateInstance.year();

            // Get the value of sum from List of aggregate results and save it in a date instance. 
            Double amountInstance = Double.valueOf(aggregateResultInstance.get('sumAlias'));

            // Add key as year and value as sum to the map 
            mapForYearAndSum.put(yearInstannce,amountInstance);
        } //End of for loop

        system.debug(mapForYearAndSum);
        return mapForYearAndSum;
      
       /**
        * AggregateRelationShipSoql instance=new AggregateRelationShipSoql();
        * instance.sumOfClosedOpportunityAmountForCurrentFiscalYear();
        */
     }

    /**
     * This is a method that find total number of distinct lead records on basis of 'Lead Source'
     * having greater than 10 leads And Print this information.
     */
     public List<AggregateResult> totalNoOfDistinctLeadRecordsOnBasisOfLeadSource()
     {
        List<AggregateResult> aggregateList=new List<AggregateResult>();
        // Fetches the query and stores it in the list.
        List<AggregateResult> listAggregate=[
                                             SELECT count_distinct(Name),
                                                    LeadSource 
                                             FROM lead 
                                             GROUP BY LeadSource 
                                             HAVING count_distinct(Name)>10];

        // Iterate Over The list of Aggregate Result
        for(AggregateResult aggregateInstance :listAggregate)
        {
            System.debug(aggregateInstance);
            aggregateList.add(aggregateInstance);
        }
        return aggregateList;

      /**
       * AggregateRelationShipSoql instance=new AggregateRelationShipSoql();
       * instance.TotalNoOfDistinctLeadRecordsOnBasisOfLeadSource();
       */
    }
 
  /**
   * This is a method to find total number of Lead records by status by Lead Source. 
   * Store this information in map and display the same.
   */
   public Map<string,Map<string,integer>> leadRecordsByStatus()
   {
       // Fetches the query and stores it in the list.
       List<AggregateResult> aggregateResultList=[
                                          SELECT count(id) countAlias,
                                                 status,
                                                 leadsource 
                                          FROM   lead 
                                          GROUP BY status,leadsource];

       // Instantiate the map with key As a string and value as a map of string and integer.
       Map<string,Map<string,integer>> mapOfLeadStatusByLeadSource=new Map<string,Map<string,integer>>();

       // Instantiate the map with string as a key and integer as a value.
       Map<string,Integer> mapInstanceSting= new map<string,Integer>();

       // Iterate over the aggregate results list
       for(AggregateResult aggrigateInstance:aggregateResultList )
       {
            // Fetches the value of the count from the List.
            Integer countInteger = Integer.valueof(aggrigateInstance.get('countAlias'));

            // Fetch all the lead Sources from the List.
            string leadSource = string.valueof(aggrigateInstance.get('LeadSource'));

            // Insert the values in the map.
            mapInstanceSting.put(leadSource,countInteger);  

            // Fetch the status from the list of aggrigate results.
            string leadStatus =string.valueof(aggrigateInstance.get('Status'));

            // Insert the values in the map.
            mapOfLeadStatusByLeadSource.put(leadStatus,new map<string,Integer>(mapInstanceSting));
       }// End of the For loop.

       system.debug(mapOfLeadStatusByLeadSource);
       return mapOfLeadStatusByLeadSource;
       
      /**
       * AggregateRelationShipSoql instance=new AggregateRelationShipSoql();
       * instance.leadRecordsByStatus();
       */
   }
}
