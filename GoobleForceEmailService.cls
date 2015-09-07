/*
 * This is the class that will handle the inbound emails. The email is send back to the sender if 
 * any exception is caused or if he specifies the query in wrong format. 
 */
global with sharing class GoobleForceEmailService implements Messaging.InboundEmailHandler 
{
   /**
    * This is a method that implements the method having parameters as email and envelope
    */
    global Messaging.InboundEmailResult handleInboundEmail(Messaging.InboundEmail email,
    Messaging.InboundEnvelope envelope) 
    {
        // Create the instance of the contact.
        Contact contactInstance;
       
        // Create the instance of the queryforcontact.
        QueryForContact__c queryForContactInstance = new QueryForContact__c();
        
        // Create the list of contact
        List<Contact> contactList;
        
        // Create the instance of the email.
        Email__c EmailInstance;
        
        // Create the instance of the inbound email results
        Messaging.InboundEmailResult result = new Messaging.InboundEmailresult();
        
        try
        {
            // Fetch the contact having email id same as the senders email id
            contactList =
                [
                        SELECT 
                            Id,
                            Email,
                            LastName
                        FROM 
                            Contact 
                        WHERE Email = :email.fromAddress
                ];
            
            // Check if the contact is already present in the org or not
            if (contactList.size() == 0) 
            {
                // Create the instance of the contact
                contactInstance = new Contact();
                
                // Assign the email address
                contactInstance.Email = email.fromAddress;
                
                // Assign the last name
                contactInstance.LastName = email.fromName;
                
                // Insert the contact instance
                insert contactInstance;
            } 
            else
            {
                // Create the instance of the contact
                contactInstance = contactList[0];
                
            }
            
            // Create the instance of the email
            EmailInstance = new Email__c();
            
            // Assign the name 
            EmailInstance.Name = email.fromName;
            
            // Assign the contact id
            EmailInstance.Contact_Details__c = contactInstance.Id;
            
            
            // Assign the body
            EmailInstance.Email_Body__c = email.plainTextBody;
            
            // Assign the subject
            EmailInstance.Subject__c = email.subject;
            
            // Check if the body is empty or not
            if(
                EmailInstance.Email_Body__c.contains('(') && 
                EmailInstance.Email_Body__c.contains(')') 
               )
            {
                // Create the instance of the query
                Query__c queryInstance = new Query__c();
               
                // Save the email body 
                String bodyInstance = emailInstance.Email_Body__c;

                // Create the instance of the body
                bodyInstance = bodyInstance.substringBeforeLast(')');
                
                // Assign the body
                 bodyInstance= bodyInstance.substringAfter('(');
                queryInstance.Query_Field__c = bodyInstance.replaceAll('\\s+', ' ');
                // Check if the body contains (,)
                if(queryInstance.Query_Field__c.contains('(') || 
                   queryInstance.Query_Field__c.contains(')')
                  )
                { 
                    // Replace the ( with space
                    queryInstance.Query_Field__c = queryInstance.Query_Field__c.replace('(',' ');
                    
                    // Replace the )
                    queryInstance.Query_Field__c = queryInstance.Query_Field__c.replace(')','');
                    
                    //Trim extra spaces
                    queryInstance.Query_Field__c = queryInstance.Query_Field__c.trim();
                }
                
                // Check if the queryString is empty or not
                if((String.isNotEmpty(queryInstance.Query_Field__c)) && 
                   (String.isNotBlank(queryInstance.Query_Field__c)) &&
                    queryInstance.Query_Field__c.length() <= 255
                  )
                {
                    // Fetch the query 
                    List<Query__c> queryList = 
                        [
                            SELECT
                                Id
                            FROM
                                Query__c
                            WHERE
                                Query_Field__c = :queryInstance.Query_Field__c
                        ]; 

                    // Check if the size of the list is zero or not
                    if(queryList.size() == 0)
                    {
                        // Insert the query
                        insert queryInstance;
                        
                        // Assign the query details
                        queryForContactInstance.QueryDetails__c = queryInstance.id;
                    }
                    else
                    {
                        // Assign the query details
                        queryForContactInstance.QueryDetails__c = queryList[0].id;
                    }
                    
                    // Assign the contact details
                    queryForContactInstance.Contact_Details__c = EmailInstance.Contact_Details__c;
                    
                    // Insert the queryforcontact
                    insert queryForContactInstance;
                    
                    // Insert the email instance
                    insert EmailInstance;
                    
  /*                  // Fetch the query 
                    List<Response__c> responseList = 
                        [
                            SELECT
                                Id
                            FROM
                                Response__c
                            WHERE
                                Search_Query__c = :queryForContactInstance.QueryDetails__c
                        ]; 
                    System.debug('queryForContactInstance.QueryDetails__c'
                        +queryForContactInstance.QueryDetails__c);
                    System.debug('responseList'+ responseList);
                    if(responseList.size() == 0)
                    {
                        result.success = false;
                        result.message = 'Sorry we cant find any results for your Query ';
                    
                    }*/
                }
                else
                {
                    // Set the result as false
                    result.success = false;
                    
                    // Set the result message
                    result.message = 'Please specify your query within' 
                        + ' the range of 1 - 255  characters.';
                }
           }
           else
           {
               // Set the result as false
               result.success = false;
               
               // Set the result message
               result.message = 
               'Please specify the query in proper format.\nFor Example : '
             + ' (Your Query) \n \n'+ 'Thank you for your request' 
             + 'We are happy to serve you.';
           }
           
            // Return the result
            return result;
       }
        catch(Exception e)
        {
            // Set the result status as false
            result.success = false;
            
            // Set the message
            result.message = 
                'Please specify the query in proper format. \nFor Example : '
               + ' (Your Query) \n \n'+ 'Thank you for your request' 
               + '\nWe are happy to serve you.';
            
            // Return the result
            return result;
        }
    }
}
