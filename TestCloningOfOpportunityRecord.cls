@isTest
private class TestCloningOfOpportunityRecord {
       /**
        * This is a test method that is used to clone the opportunity record.
        * This is a Successfull Method with the bulkification. 
        */
        static testMethod void cloningOfOpportunityRecord() 
        {
            // Fetches all the list of Opportunity.
            List<Opportunity> beforeOpportunityCloningList=[Select Id From Opportunity];
            // Initialize the opportunity List
            List<Opportunity> OpportunityList=new List<Opportunity>();
            // This for loop Iterate for 200 times 
            for(Integer i=0;i<200;i++)
            {
                    // Add the data to the opportuntiy List
                    OpportunityList.add(new Opportunity(Name='TestOpportunity'+i,StageName='Closed Won',CloseDate=system.today()));
            }
            // Start the test
            Test.startTest();
            // insert the opportunity list
            insert OpportunityList;
            // Stop the test
            Test.stopTest();
            // Fecth all the Opportunity Records with the name Test opportunity in a Opportunity list. 
            List<Opportunity> afterOpportunityCloningList = [SELECT ID FROM Opportunity WHERE Name Like 'TestOpportunity%'];
            // Check the Actual size of the list after and before insert of Opportunity.
            System.assertEquals(afterOpportunityCloningList.size(),(beforeOpportunityCloningList.size()+400));
        }
}