/**
 * This is a class that will check the functionality for the fetched queries related to the 
 * aggregate result. It also prints the results.
 */
@isTest
private class TestAggregateQueries 
{
    /**
     * This is a method that test to retrieve sum of all closed Opportunity amount for 
     * current fiscal year. Store this information in a map with key as year and value as 
     * sum of amount. Iterate this map to display statistics.
     */
     static testMethod void testOpportunityRecords() 
     {
         // Create the instance of the Opportunity
         List<Opportunity> opportunityList = new List<Opportunity>();
         
         for (Integer i = 0; i <= 1; i++) 
         {
             // Create the opportunity Record
             Opportunity opportunityInstance = new Opportunity(
                                                               Name = 'Test' + i,
                                                               CloseDate = System.Today(),
                                                               StageName = 'Closed Won',
                                                               Amount = 13000
                                                               );
                                                               
             // Create the opportunity Record
             Opportunity opportunityInstance2 = new Opportunity(
                                                                Name = 'Test' + i,
                                                                CloseDate = System.Today(),
                                                                StageName = 'Closed Won',
                                                                Amount = 14000
                                                                );
             // Add records to the List
             opportunityList.add(opportunityInstance);
             opportunityList.add(opportunityInstance2);
         }
         
         // Check the list size.
         System.assertEquals(4,opportunityList.size());
         
         // Start the Test
         Test.startTest();
         
         // Insert the List
         insert opportunityList;
         
         List<Opportunity> checkOpportunityList = 
            [
                SELECT
                    Name
                FROM
                    Opportunity
                WHERE
                    Name LIKE 'Test%'
            ]; 
         
         // Check the records are added or not
         System.assertEquals(4,checkOpportunityList.size());
         
         // Create the Instance of the Class
         AggregateRelationShipSoql aggregateInstance = new AggregateRelationShipSoql();
         
         // Save the returned value from function in map
         Map<Integer,Double> mapInstance = aggregateInstance.sumOfClosedOpportunityAmountForCurrentFiscalYear();
         
         // Stop the test
         Test.stopTest();
         
         // Check if amount matches.
         System.assertEquals(54000,mapInstance.get(2015)); 
    } 
    
    /**
     * This is a method that test to retrieve sum of all Open Opportunity amount for 
     * current fiscal year. Store this information in a map with key as year and value as 
     * sum of amount. Iterate this map to display statistics.
     */
     static testMethod void testOpportunityRecordsUnsuccessful() 
     {
         // Create the instance of the Opportunity
         List<Opportunity> opportunityList = new List<Opportunity>();
         for (Integer i = 0; i <= 1; i++) 
         {
             // Create the opportunity Record
             Opportunity opportunityInstance = new Opportunity(Name = 'Test' + i,
                                                               CloseDate = System.Today(),
                                                               StageName = 'Qualification',
                                                               Amount = 13000
                                                              );
                                                               
             // Create the opportunity Record
             Opportunity opportunityInstance2 = new Opportunity(Name = 'Test' + i,
                                                                CloseDate = System.Today(),
                                                                StageName = 'Qualification',
                                                                Amount = 14000
                                                               );
             // Add records to the List
             opportunityList.add(opportunityInstance);
             opportunityList.add(opportunityInstance2);
         }
         
         // Check the list size.
         System.assertEquals(4,opportunityList.size());
         
         // Start the Test
         Test.startTest();
         
         // Insert the List
         insert opportunityList;
         
         List<Opportunity> checkOpportunityList =
            [
                SELECT
                    Name
                FROM
                    Opportunity
                WHERE
                    Name  LIKE 'Test%'
            ]; 
         
         // Check the records are added or not
         System.assertEquals(4,checkOpportunityList.size());
         
         // Create the Instance of the Class
         AggregateRelationShipSoql aggregateInstance = new AggregateRelationShipSoql();
         
         // Save the returned value from function in map
         Map<Integer,Double> mapInstance = aggregateInstance.sumOfClosedOpportunityAmountForCurrentFiscalYear();
         
         // Stop the test
         Test.stopTest();
         
         // Check if amount is null.
         System.assertEquals(null,mapInstance.get(2015)); 
    } 
    
     /**
     * This is a method that test to retrieve sum of all closed Opportunity amount are not from 
     * current fiscal year. Store this information in a map with key as year and value as 
     * sum of amount. Iterate this map to display statistics.
     */
     static testMethod void testOpportunityRecordsOtherThenFiscalYear() 
     {
         // Create the instance of the Opportunity
         List<Opportunity> opportunityList = new List<Opportunity>();
         
         for (Integer i = 0; i <= 1; i++) 
         {
             // Create the opportunity Record
             Opportunity opportunityInstance = new Opportunity(
                                                               Name = 'Test' + i,
                                                               CloseDate = 
                                                                   (Date) Date.valueOf('2014-05-02'),
                                                               StageName = 'Closed Won',
                                                               Amount = 13000
                                                               );
                                                               
             // Create the opportunity Record
             Opportunity opportunityInstance2 = new Opportunity(
                                                                Name = 'Test' + i,
                                                                CloseDate = 
                                                                   (Date) Date.valueOf('2014-05-02'),
                                                                StageName = 'Closed Won',
                                                                Amount = 14000
                                                                );
             // Add records to the List
             opportunityList.add(opportunityInstance);
             opportunityList.add(opportunityInstance2);
         }
         
         // Check the list size.
         System.assertEquals(4,opportunityList.size());
         
         // Start the Test
         Test.startTest();
         
         // Insert the List
         insert opportunityList;
         
         List<Opportunity> checkOpportunityList =
            [
                SELECT
                    Name
                FROM
                    Opportunity
                WHERE
                    Name LIKE 'Test%'
            ] ;
         
         // Check the records are added or not
         System.assertEquals(4,checkOpportunityList.size());
         
         // Create the Instance of the Class
         AggregateRelationShipSoql aggregateInstance = new AggregateRelationShipSoql();
         
         // Save the returned value from function in map
         Map<Integer,Double> mapInstance=aggregateInstance.sumOfClosedOpportunityAmountForCurrentFiscalYear();
         
         // Stop the test
         Test.stopTest();
         
         // Check if amount matches.
         System.assertEquals(null,mapInstance.get(2015)); 
    } 
    
    
   /**
    * This is a test method which tests for distinct Lead records on basis of 'Lead Source'
    *  having count of leads greater than 10.
    */
    static testMethod void testDistinctLeadRecordsByLeadSource() 
    {
        // Create the instance of the lead list
        List<Lead> leadList = new List<Lead>();
        
        // Iterate over the loop
        for (Integer i = 0; i <= 50; i++) 
        {
            // Create the lead record with lead source as web.  
            Lead leadInstance = new Lead(LastName = 'TestLead'+i, 
                                         Company = 'ESPL', 
                                         LeadSource = 'Web', 
                                         Status = 'Closed'
                                        );
            
                                         
            // Create the lead record with lead source as other.  
            Lead leadInstance2 = new Lead(LastName = 'TestLead'+i, 
                                          Company = 'ESPL', 
                                          LeadSource = 'Other', 
                                          Status = 'Closed'
                                         );
            
            // Add record to the list
            leadList.add(leadInstance);
            leadList.add(leadInstance2);    
        }
        for (Integer i = 0; i < 5; i++) 
        {
            // Create the lead record
            Lead leadInstance3 = new Lead(LastName = 'TestLead'+i, 
                                          Company = 'ESPL', 
                                          LeadSource = 'Phone Inquiry', 
                                          Status = 'Closed'
                                         );
            
            // Add record to the list 
            leadList.add(leadInstance3);    
        
        }
        
        // Check the records are added or not
        System.assertEquals(107,leadList.size());
        
        // Start the test
        Test.startTest();
        
        // Insert the lead 
        insert leadList;
        
        List<Lead> checkOpportunityList =
            [
                SELECT
                    LastName
                FROM
                    Lead
                WHERE
                    LastName LIKE 'TestLead%'
            ] ;
       
        // Check the records are added or not
        System.assertEquals(107,checkOpportunityList.size());
         
        // Create the Instance of the Class
        AggregateRelationShipSoql aggregateInstance = new AggregateRelationShipSoql();
       
        // Save the returned list from the method
        List<AggregateResult> testListAggregateResult = 
            aggregateInstance.totalNoOfDistinctLeadRecordsOnBasisOfLeadSource();
        
        // Stop the test
        Test.stopTest();
        
        // Check the Leadsource of the record.
        System.assertEquals(2,testListAggregateResult.size());
        
        // Fetch the value of the leadsource returned from the method. 
        String stringInstance = String.valueOF(testListAggregateResult[0].get('LeadSource'));
        
        // Check the Leadsource of the record.
        System.assertEquals('Web',stringInstance);
        
        // Fetch the value of the Count of lead returned from the method. 
        Double countInstance = Double.valueOF(testListAggregateResult[0].get('expr0'));
        
        // Check the Count of lead for each LeadSource.
        System.assertEquals(51,countInstance);
        
        // Fetch the value of the leadsource returned from the method. 
        String stringInstance1 = String.valueOF(testListAggregateResult[1].get('LeadSource'));
        
        // Check the Leadsource of the record.
        System.assertEquals('Other',stringInstance1);
        
        // Fetch the value of the Count returned from the method. 
        Double countInstance1 = Double.valueOF(testListAggregateResult[0].get('expr0'));
        
        // Check the Count of lead for each LeadSource.
        System.assertEquals(51,countInstance1);
    }
   
    /**
    * This is a test method which tests for distinct Lead records on basis of 'Lead Source'
    *  having count less than 10 leads.
    */
    static testMethod void testDistinctLeadRecordsByLeadSourceHavingLessNoOfLead() 
    {
        // Create the instance of the lead list
        List<Lead> leadList = new List<Lead>();
        
        // Iterate over the loop
        for (Integer i = 1; i < 10; i++) 
        {
            // Create the lead record with lead source as web.  
            Lead leadInstance = new Lead(LastName = 'TestLead'+i, 
                                         Company = 'ESPL', 
                                         LeadSource = 'Web', 
                                         Status = 'Closed'
                                        );
            
            // Add record to the list
            leadList.add(leadInstance);
        }
        
        for (Integer i = 1; i < 5; i++) 
        {
            // Create the lead record
            Lead leadInstance3 = new Lead(LastName = 'TestLead'+i, 
                                          Company = 'ESPL', 
                                          LeadSource = 'Phone Inquiry', 
                                          Status = 'Closed'
                                         );
            
            // Add record to the list 
            leadList.add(leadInstance3);    
        
        }
        
        // Check the records are added or not
        System.assertEquals(13,leadList.size());
        
        // Start the test
        Test.startTest();
        
        // Insert the lead 
        insert leadList;
        
        List<Lead> checkOpportunityList =
            [
                SELECT
                    LastName
                FROM
                    Lead
                WHERE
                    LastName LIKE 'TestLead%'
            ] ;
       
        // Check the records are added or not
        System.assertEquals(13,checkOpportunityList.size());
         
        // Create the Instance of the Class
        AggregateRelationShipSoql aggregateInstance = new AggregateRelationShipSoql();
       
        // Save the returned list from the method
        List<AggregateResult> testListAggregateResult = 
            aggregateInstance.totalNoOfDistinctLeadRecordsOnBasisOfLeadSource();
        
        // Stop the test
        Test.stopTest();
        
        // Check the Leadsource of the record.
        System.assertEquals(0,testListAggregateResult.size());
    }
       
    /**
     * This is a test method to find total number of Lead records by status by Lead Source. 
     * Store this information in map and display the same.
     */
     static testMethod void testLeadRecordsByLeadStatus() 
     {
          // Create the instance of the lead list
          List<Lead> leadList = new List<Lead>();
        
          // Iterate over the loop
          for (Integer i = 0; i < 50; i++) 
          {
              // Create the lead record
              Lead leadInstance = new Lead(LastName = 'TestLead'+i, 
                                           Company = 'ESPL', 
                                           LeadSource ='Web', 
                                           Status ='Open - Not Contacted'
                                          );
                                         
              Lead leadInstance2 = new Lead(LastName = 'TestLead'+i, 
                                            Company = 'ESPL', 
                                            LeadSource ='Other', 
                                            Status ='Open - Not Contacted'
                                           );
              // Add record to the list
              leadList.add(leadInstance);
              leadList.add(leadInstance2);    
          }
          for (Integer i = 0; i < 5; i++) 
          {
              // Create the lead record
              Lead leadInstance3 = new Lead(LastName = 'TestLead'+i, 
                                            Company = 'ESPL', 
                                            LeadSource ='Phone Inquiry', 
                                            Status ='Closed - Not Converted'
                                           );
              // Add record to the list 
              leadList.add(leadInstance3);    
          }
        
          // Check the records are added or not
          System.assertEquals(105,leadList.size());
          
          // Start the test
          Test.startTest();
          
          // Insert the lead 
          insert leadList;
        
          List<Lead> checkOpportunityList =
              [
                  SELECT
                      LastName
                  FROM
                      Lead
                  WHERE
                      LastName LIKE 'TestLead%'
              ] ;
       
          // Check the records are added or not
          System.assertEquals(105,checkOpportunityList.size());
          
          // Create the Instance of the Class
          AggregateRelationShipSoql aggregateInstance = new AggregateRelationShipSoql();
      
          Map<String,Map<String,Integer>> mapByStageByLeadSource = 
              aggregateInstance.leadRecordsByStatus();
         
          // Stop the test
          Test.stopTest();
          
          // Instantiate the map with string as a key and integer as a value.
          Map<String,Integer> mapInstanceSting = new Map<String,Integer>();
          
          // Check the size of the map of status and map of leadsource and count of leads.
          System.assertEquals(2, mapByStageByLeadSource.size());
          
          // Assign the value to the instance which is a map of leadsource and count of leads.
          mapInstanceSting =  mapByStageByLeadSource.get('Open - Not Contacted');
          
           // Check the size
          System.assertEquals(2,mapInstanceSting.size());
          
          // Check the no of records with leadsource as web.
          System.assertEquals(50,mapInstanceSting.get('Web'));
          
     }
     
     /**
     * This is a test method to find what happens if the lead Source is not provided when a map is 
     * created for total number of Lead records by status by Lead Source. 
     * Store this information in map and display the same.
     */
     static testMethod void testLeadRecordsByLeadStatusNoLeadSourceProvided() 
     {
          // Create the instance of the lead list
          List<Lead> leadList = new List<Lead>();
        
          // Iterate over the loop
          for (Integer i = 0; i < 50; i++) 
          {
              // Create the lead record
              Lead leadInstance = new Lead(LastName = 'TestLead'+i, 
                                           Company = 'ESPL', 
                                           Status ='Closed - Not Converted'
                                          );
                                         
              Lead leadInstance2 = new Lead(LastName = 'TestLead'+i, 
                                            Company = 'ESPL', 
                                            Status ='Open - Not Contacted'
                                           );
              // Add record to the list
              leadList.add(leadInstance);
              leadList.add(leadInstance2);    
          }
          for (Integer i = 0; i < 5; i++) 
          {
              // Create the lead record
              Lead leadInstance3 = new Lead(LastName = 'TestLead'+i, 
                                            Company = 'ESPL', 
                                            Status ='Closed - Not Converted'
                                           );
              // Add record to the list 
              leadList.add(leadInstance3);    
          }
        
          // Check the records are added or not
          System.assertEquals(105,leadList.size());
          
          // Start the test
          Test.startTest();
          
          // Insert the lead 
          insert leadList;
        
          List<Lead> checkOpportunityList =
              [
                  SELECT
                      LastName
                  FROM
                      Lead
                  WHERE
                      LastName LIKE 'TestLead%'
              ] ;
       
          // Check the records are added or not
          System.assertEquals(105,checkOpportunityList.size());
          
          // Create the Instance of the Class
          AggregateRelationShipSoql aggregateInstance = new AggregateRelationShipSoql();
      
          Map<String,Map<String,Integer>> mapByStageByLeadSource = 
              aggregateInstance.leadRecordsByStatus();
         
          // Stop the test
          Test.stopTest();
          
          // Instantiate the map with string as a key and integer as a value.
          Map<String,Integer> mapInstanceSting = new Map<String,Integer>();
          
          // Check the size of the map of status and map of leadsource and count of leads.
          System.assertEquals(0, mapByStageByLeadSource.size());
     }
}
    
