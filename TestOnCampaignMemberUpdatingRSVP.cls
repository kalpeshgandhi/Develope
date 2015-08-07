@isTest
private class TestOnCampaignMemberUpdatingRSVP {
    /**
     * This is a test Method that executes Successfull and updates the campaign member rsvp field 
     * if while inserting the CampaignMember field is kept Blank.
     */
    static testMethod void campaignMemberRSVPupdateSuccessfull() 
    {
        // Create a list of lead records.
        Lead testDataLead = new Lead(Lastname = 'TestLead',Company = 'TCS',Status = 'Open - Not Contacted ',RSVP__c= 'Open');
        // Insert the Lead Test data.
        insert testDataLead;
        // Create an Instance Of the Campaign
        Campaign testDataCampaign = new Campaign();
        // Creating the Test Campaign member record
        testDataCampaign.Name = 'TestCampaign';
        // Insert the test Campaign
        insert testDataCampaign;
        // Create the test Campaign Member
        CampaignMember testDataCampaignMember = new CampaignMember(CampaignId =testDataCampaign.id,LeadId =testDataLead.id,RSVP__c ='');
        // Start the test
        Test.startTest();
        // Insert the Campaign Member
        insert testDataCampaignMember;
        // Stop the test
        Test.stopTest();
        // Fetch the Records of the Campaign Member whose name is Like testLead
        List<CampaignMember> campaignMemberListTest = [select Id,RSVP__c
                                                       From CampaignMember 
                                                       where lead.lastname= 'TestLead'];
        // Create a Instance of Campaign Member
        for(CampaignMember CampaignInstance :campaignMemberListTest)
        {
            // Assign the Rsvp field value to a Temprory String
            String valueStrig=CampaignInstance.RSVP__c;
            // Check Assert Values
            System.assertequals('Open',valueStrig);
        }// End of for Loop
    }
    
    /**
     * This is a test Method that executes UnSuccessfull and doesnt updates the campaign member 
     * rsvp field if while inserting the CampaignMember field is kept Blank.
     */
    static testMethod void campaignMemberRSVPupdateUnSuccessfull() 
    {
        // Create the Test records of Lead Data Type
        Lead testDataLead = new Lead(Lastname = 'TestLead',Company = 'TCS',Status = 'Open - Not Contacted ',RSVP__c= 'Open');
        // Insert the test lead record.
        insert testDataLead;
        // Create the Instance of the Campaign.
        Campaign testDataCampaign = new Campaign();
        testDataCampaign.Name = 'TestCampaign';
        // Insert the test Campaign
        insert testDataCampaign;
         // Create the test Campaign Member
        CampaignMember testDataCampaignMember = new CampaignMember(CampaignId =testDataCampaign.id,LeadId =testDataLead.id,RSVP__c ='Open');
        // Start the test
        Test.startTest();
        // Insert the Campaign Member
        insert testDataCampaignMember;
        // Stop the test
        Test.stopTest();
        // Fetch the Records of the Campaign Member whose name is Like testLead
        List<CampaignMember> campaignMemberListTest = [select Id,RSVP__c
                                                       From CampaignMember 
                                                       where lead.lastname= 'TestLead'];
         // Create a Instance of Campaign Member
        for(CampaignMember CampaignInstance :campaignMemberListTest)
        {
             // Assign the Rsvp field value to a Temprory String
            String valueStrig=CampaignInstance.RSVP__c;
            // Check Assert Values
            System.assertequals('Open',valueStrig);
        }// End of for Loop
    }
}