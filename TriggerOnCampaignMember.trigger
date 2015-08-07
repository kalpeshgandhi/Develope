trigger TriggerOnCampaignMember on CampaignMember (before insert) 
{
    if(trigger.isbefore)
    {   
        if(trigger.isinsert)
        {
            TriggerOnCampaignmemberHandler.CampaignMemberUpdateRSVPForLead(trigger.new);
        }
    }
}