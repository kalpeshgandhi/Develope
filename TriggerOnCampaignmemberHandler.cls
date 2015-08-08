public with sharing class TriggerOnCampaignmemberHandler 
{	/*
	public static void CampaignMemberUpdateRSVPForLead(list<CampaignMember> CampaignMem)
	{
		list<Lead> Listlead=[SELECT id,RSVP__c from Lead ];
		for(CampaignMember CampInstance :CampaignMem)
		{
			if(CampInstance.RSVP__c == NULL)
   			{
    			for(Lead leadInstance: Listlead)
    			{
     				if(CampInstance.LeadId == leadInstance.Id)
     				{
                        CampInstance.RSVP__c = leadInstance.RSVP__c;
                    }
                }
            }
		}
	}*/
	
	/**
	 * This is a Method States that Whenever a Campaign member of type lead is inserted, check the 
	 * RSVP field on campaign member, if it is blank and if the Lead RSVP field has value we would 
	 * need to update that value on the Campaign member RSVP field.
	 */
	public static void campaignMemberUpdateRSVPForLead(List<CampaignMember> campaignMemberList)
    {
        // Instantiate the Set of ids which will store the lead Ids.  
        Set<id> setofLeadid=new Set<id>();
        // Iterate over the CampaignMember list(Trigger.new)  
        for(CampaignMember campaignMemberInstancetoFetchId:campaignMemberList)
        {
            // Add the Ids to the set fetching all the Leads id from the List.
             setofLeadid.add(campaignMemberInstancetoFetchId.LeadId);
        }// End of the For loop
        // A Map is created where id of lead is the Key and RSVP field is the Value.
        Map<id,Lead> mapOfCampaignMembersTypeLead=new Map<id,Lead>([Select id,RSVP__c 
                                                                    From Lead
                                                                    Where id 
                                                                    IN :setofLeadid]);
        // Iterate over the List of Campaignmembers(trigger.new)
        for(CampaignMember campaignMemberInstance :campaignMemberList)
        {
            // Checks if the RSVP field is null or not.
              if(campaignMemberInstance.RSVP__c==null)
              {
                  // If RSVP field is null Assign the value of the Perticular Id to a Lead Record.
                  Lead leadInstance=mapOfCampaignMembersTypeLead.get(campaignMemberInstance.Leadid);
                  // Assign the Leads RSVP field to the CampaignMember RSVP Field.
                  campaignMemberInstance.RSVP__c=leadInstance.RSVP__c;
              } // End of the If loop
        }//End of the For Loop
    }
}