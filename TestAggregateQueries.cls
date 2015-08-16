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
         for (Integer i = 0; i<=1; i++) 
         {
             // Create the opportunity Record
             Opportunity opportunityInstance = new Opportunity(Name = 'Test' + i,
                                                               CloseDate = System.Today(),
                                                               StageName = 'Closed Won',
                                                               Amount = 13000);
                                                               
             // Create the opportunity Record
             Opportunity opportunityInstance2 = new Opportunity(Name = 'Test' + i,
                                                                CloseDate = System.Today(),
                                                                StageName = 'Closed Won',
                                                                Amount = 14000);
             // Add records to the List
             opportunityList.add(opportunityInstance);
             opportunityList.add(opportunityInstance2);
         }
         // Start the Test
         Test.startTest();
         
         // Insert the List
         insert opportunityList;
         
         // Check the records are added or not
         System.assertEquals(4,opportunityList.size());
         
         // Stop the test
         Test.stopTest();
         // Create the Instance of the Class
         AggregateRelationShipSoql aggregateInstance = new AggregateRelationShipSoql();
         Map<Integer,Double> mapInstance=aggregateInstance.sumOfClosedOpportunityAmountForCurrentFiscalYear();
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
         for (Integer i = 0; i<=1; i++) 
         {
             // Create the opportunity Record
             Opportunity opportunityInstance = new Opportunity(Name = 'Test' + i,
                                                               CloseDate = System.Today(),
                                                               StageName = 'Qualification',
                                                               Amount = 13000);
                                                               
             // Create the opportunity Record
             Opportunity opportunityInstance2 = new Opportunity(Name = 'Test' + i,
                                                                CloseDate = System.Today(),
                                                                StageName = 'Qualification',
                                                                Amount = 14000);
             // Add records to the List
             opportunityList.add(opportunityInstance);
             opportunityList.add(opportunityInstance2);
         }
         // Start the Test
         Test.startTest();
         
         // Insert the List
         insert opportunityList;
         
         // Check the records are added or not
         System.assertEquals(4,opportunityList.size());
         
         // Stop the test
         Test.stopTest();
         // Create the Instance of the Class
         AggregateRelationShipSoql aggregateInstance = new AggregateRelationShipSoql();
         Map<Integer,Double> mapInstance=aggregateInstance.sumOfClosedOpportunityAmountForCurrentFiscalYear();
         System.assertEquals(null,mapInstance.get(2015)); 
    } 
    
   /**
    * This is a Method that Test to get distinct Lead records on basis of 'Lead Source'
    *  having greater than 10 leads. Print this information.
    */
    static testMethod void testDuplicateLeadRecords() 
    {
        // Create the instance of the lead list
        List<Lead> leadList = new List<Lead>();
        // Iterate over the loop
        for (Integer i = 0;i<= 50; i++) 
        {
            // Create the lead record
            Lead leadInstance = new Lead(LastName = 'TestLead'+i, 
                                         Company = 'ESPL', 
                                         LeadSource ='Web', 
                                         Status ='Closed');
                                         
            Lead leadInstance2 = new Lead(LastName = 'TestLead'+i, 
                                         Company = 'ESPL', 
                                         LeadSource ='Other', 
                                         Status ='Closed');
            // Add record to the list
            leadList.add(leadInstance);
            leadList.add(leadInstance2);    
        }
        for (Integer i = 0;i < 5; i++) 
        {
            // Create the lead record
            Lead leadInstance3 = new Lead(LastName = 'TestLead'+i, 
                                         Company = 'ESPL', 
                                         LeadSource ='Phone Inquiry', 
                                         Status ='Closed');
            // Add record to the list 
            leadList.add(leadInstance3);    
        }
        
        // Start the test
        Test.startTest();
        
        // Insert the lead 
        insert leadList;
        
        // Check the records are added or not
        System.assertEquals(107,leadList.size());
      
        // Stop the test
         Test.stopTest();
       
        // Create the Instance of the Class
        AggregateRelationShipSoql aggregateInstance = new AggregateRelationShipSoql();
       
        System.assertEquals(2, aggregateInstance.totalNoOfDistinctLeadRecordsOnBasisOfLeadSource().size());
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
        for (Integer i=0;i<50;i++) 
        {
            // Create the lead record
            Lead leadInstance = new Lead(LastName = 'TestLead'+i, 
                                         Company = 'ESPL', 
                                         LeadSource ='Web', 
                                         Status ='Open - Not Contacted');
                                         
            Lead leadInstance2 = new Lead(LastName = 'TestLead'+i, 
                                         Company = 'ESPL', 
                                         LeadSource ='Other', 
                                         Status ='Closed - Converted');
            // Add record to the list
            leadList.add(leadInstance);
            leadList.add(leadInstance2);    
        }
        for (Integer i=0;i<5;i++) 
        {
            // Create the lead record
            Lead leadInstance3 = new Lead(LastName = 'TestLead'+i, 
                                         Company = 'ESPL', 
                                         LeadSource ='Phone Inquiry', 
                                         Status ='Closed - Not Converted');
            // Add record to the list 
            leadList.add(leadInstance3);    
        }
        
        // Start the test
        Test.startTest();
        
        // Insert the lead 
        insert leadList;
        
        // Check the records are added or not
        System.assertEquals(105,leadList.size());
      
        // Stop the test
        Test.stopTest();
       
        // Create the Instance of the Class
        AggregateRelationShipSoql aggregateInstance = new AggregateRelationShipSoql();
       
        System.assertEquals(3, aggregateInstance.leadRecordsByStatus().size());
    }
}
    
