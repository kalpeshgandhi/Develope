/**
 * This is a class send the mail to the primary contact associated with an account to know which 
 * all are the closed won opportunities for his account per day. 
 */
public with sharing class CollectionOfClosedWonOpportunities implements Database.Batchable<sObject>
,Database.Stateful
{
    // Saves the query 
    public String query = '';
    public static Decimal totalAmount = 0;
       
    // Create an instance of map of mail and wrapper class 
    Map<String,WrapperAmountAndListOfOpportuntiy> mapofEmail = 
        new  Map<String,WrapperAmountAndListOfOpportuntiy>();
    
   /**
    * This is a wrapper class which will initialize the variables
    */
    public class WrapperAmountAndListOfOpportuntiy
    {
        
        // Create an instance of list Of opportunity
        List<Opportunity> opportunityList = new  List<Opportunity>();
        
        // Initialize the amount to 0 
        public Decimal Amount = 0;
        
    }
    
   /** 
    * It is a constructor that fetches the query in a variable query.
    */
    public CollectionOfClosedWonOpportunities()
    {
        
        query = 
            'SELECT '
           + '   o.id,'
           + '   o.Name,'
           + '   o.Amount,'
           + '   o.Account.Primary_ContactEmail__c ' 
           + 'FROM ' 
           + '   Opportunity o ' 
           + 'WHERE '
           + '   StageName = \'Closed Won\' '
           + 'AND '
           + '   CreatedDate = today';
           
           System.debug(query);
    }
       
   /**
    * This is a start method that returns the query string that is to be fetched.
    * In this we fetch the query to be processed.
    */
    public Database.QueryLocator start(Database.BatchableContext BC)
    {
        
        // Returns the query
        return Database.getQueryLocator(query);
    }
        
   /**
    * This is a method that will execute the code in batches.
    */
    public void execute(Database.BatchableContext BC, List<Opportunity> opportunityListInstance)
    {   
        
        // Iterate over the instance of the opportunity
        for(Opportunity opportunityInstance : opportunityListInstance)
        {
            
            // Check for the primary_contact_email and opportunity amount is not null.
            if(opportunityInstance.Account.Primary_ContactEmail__c != null && 
                opportunityInstance.Amount != null)
            {
                
                // Check if the map contains the email id or not.
                if(!mapofEmail.containskey(opportunityInstance.Account.Primary_ContactEmail__c))
                {
                    
                    // Create the instance of new wrapper class
                    WrapperAmountAndListOfOpportuntiy wrapper = 
                        new WrapperAmountAndListOfOpportuntiy();
                        
                    // Insert the amount of opportunity instance into the wrapper instance. 
                    wrapper.Amount = opportunityInstance.Amount; 

                    totalAmount = wrapper.Amount;

                    // Add an opportunity instance
                    wrapper.opportunityList.add(opportunityInstance);
                        
                    // Add the values of the map and a key in the map.
                    mapofEmail.put(opportunityInstance.Account.Primary_ContactEmail__c, wrapper);
                    System.debug(wrapper);
                }
                else
                { 
                    // Add the values in the wrapper class.
                    WrapperAmountAndListOfOpportuntiy wrapper = 
                       mapofEmail.get(opportunityInstance.Account.Primary_ContactEmail__c);
                   
                    // Add The amount of the opportunity to the wrapper class amount instance.
                    wrapper.Amount += opportunityInstance.Amount;
                    totalAmount = wrapper.Amount;
                     system.debug(totalAmount);
                    // Add the opportunity instance to the wrapper.
                    wrapper.opportunityList.add(opportunityInstance);
                }
            }
        }
          System.debug('>>>>>>>mapofEmail' + mapofEmail);  
    }
   /**
    * This is a finish block of the data.
    */
    public void finish(Database.BatchableContext BC)
    {
        // Create an instance of the messaging.singleEmailMessage 
        List<Messaging.SingleEmailMessage> mails = new List<Messaging.SingleEmailMessage>();
        
        // Iterate over the emails 
        for(String Email : mapofEmail.keyset())
        {
            // Creata an instance of the message.singleMessage
            Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
            
            
            // Create the list of the string 
            List<String> sendTo = new List<String>();
            
            // Add whom to send the email 
            sendTo.add(Email);
            
            // Set the address to whom the message is to be send. 
            mail.setToAddresses(sendTo);
            
            // Set whom reply is to be send
            mail.setReplyTo('kalpesh.gandhi@eternussolutions.com');
            
            // Set the display name
            mail.setSenderDisplayName('Kalpesh Gandhi');
            
            // Set the subject of the mail as contact
            mail.setSubject('Closed Won Opportunity Details ');
            
            // Save the values to the new instance of the wrapper class
            WrapperAmountAndListOfOpportuntiy wrapper=mapofEmail.get(Email);
            
            String body = 'Hello ,' ;
            body += ' \n Opportunities associated to your'; 
            body += ' account and the aggregate of their amount';
            
            // Iterate over the wrapper opportunity instance
            for(Opportunity oportunityInstance :wrapper.opportunityList)
            {
                // Add the body.
                body += '\n ' +oportunityInstance.Name +' Amount :-' + oportunityInstance.Amount;
            }
            
            // Add total amount
            body += '\n Total Amount' + wrapper.Amount;
            
            // Set the HTML body.
            mail.setHtmlBody(body);
            
            // Add single mail to a list of mails
            mails.add(mail);
        }           
        // Send the emails
        Messaging.sendEmail(mails);   
    }
}