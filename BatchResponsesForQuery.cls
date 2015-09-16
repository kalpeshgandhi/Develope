/**
 * This is the batch class that will send the responses back to all the respective contact
 */
public with sharing class BatchResponsesForQuery implements Database.Batchable<sObject>
,Database.Stateful
{
    // Create the instance of the string
    public String query;
       
   /**
    * This is the constructor that will fetch all the queryforcontact records created today 
    */
    public BatchResponsesForQuery()
    {
         // Fetch all the records created today
         query='SELECT ID,Contact_Details__c,QueryDetails__c FROM' 
               +' QueryForContact__c WHERE CreatedDate = today ';
    }
    
   /**
    * This is the start method that will return the results after executing the query
    */
    public Database.QueryLocator start(Database.BatchableContext BC)
    {
        // Return the results after executing the query
        return Database.getQueryLocator(query);
    }
    
   /**
    * This is the execute method that will send the mails
    */
     public void execute(Database.BatchableContext BC, List<QueryForContact__c> queryListInstance)
     {
         
         // Fetch the emailtemplate with email response
         EmailTemplate emailTemplateId = 
            [
                SELECT 
                    Id, 
                    Name 
                FROM 
                    EmailTemplate 
                WHERE 
                    Name = 'Email Response'
            ]; 
            
         // Create an Instance of the Messaging.SingleEmailMessage 
         List<Messaging.SingleEmailMessage> mails = new List<Messaging.SingleEmailMessage>();
         
         // Iterate over the query list
         for(QueryForContact__c queryInstance : queryListInstance)
         {
             
             // Create the instance of the single email message
             Messaging.SingleEmailMessage emailInstance = new Messaging.SingleEmailMessage();
             
             // Set the contact detail whom to send the mail
             emailInstance.setTargetObjectId(queryInstance.Contact_Details__c);
             
             // Set the id of the objects whose fields are to be merged in the response
             emailInstance.setWhatId(queryInstance.QueryDetails__c); 
             
             // Set the template id
             emailInstance.setTemplateId(emailTemplateId.Id);
             
             // Add the email to a list of mails
             mails.add(emailInstance);
             
             // Update the response send field as true
             queryInstance.ResponseSend__c = true;
         }
         
         try
         {
             
            // Send all the emails
            Messaging.sendEmail(mails);
            
            // Update the query instance
            update queryListInstance;
            
         }
         catch(Exception exceptionInstance)
         {
             
             // Print the exception
             System.debug(exceptionInstance.getmessage());
         }
     }
     
     public void finish(Database.BatchableContext BC)
     {
         System.debug('Mail sent Successfully');
     }
}
