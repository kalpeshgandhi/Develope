/**
 * This is the handler class that will parse the string from the email body and saves it into the 
 * query object. Before saving it to the query object it checks if the query already exists, 
 * responses are apended. If query does not exists a call out is made that will search the results 
 * and save the responses by parsing the HTML.
 */
global with sharing class TriggerForQueryGenerationHandler 
{
    
   /**
    * This is a method that will generate the query by parsing the email body. It checks if the 
    * query is already present, responses are appended. If query is not present a call out is made
    * the responses are saved. 
    */
    global static void generationOfQuery(List<Email__c> emailList)
    {
        
        // Iterate over the list of the email
        for(Email__c emailInstance: EmailList)
        {
            
            // Create the instance of the email body
            String bodyInstance = emailInstance.Email_Body__c;

            // Create the instance of the body
            bodyInstance = bodyInstance.substringBeforeLast(')');
            bodyInstance = bodyInstance.substringAfter('(');
            bodyInstance = bodyInstance.replaceAll('\\s+', ' ');
            
            // Check if the body contains the ( & )
            if(bodyInstance.contains('(') || bodyInstance.contains(')'))
            {
                // replace body
                bodyInstance = bodyInstance.replace('(',' ');
                
                // replace body
                bodyInstance = bodyInstance.replace(')','');
                
                
                // Trim body 
                bodyInstance= bodyInstance.trim();

            }
            
            // Call the web service
            callTheWebservice(bodyInstance);
        
        }// End of for loop
    }
    
   /**
    * This is a method that will make a callous to the google and will save the responses.
    */
    @future(callout = true)
    global static void callTheWebservice(String queryInstance)
    {
        
        // Trim query 
        queryInstance= queryInstance.trim();
        
        // Create the instance of the http request
        HttpRequest request = new HttpRequest();
        
        // Set the http endpoint
        request.setEndpoint('https://www.google.com/search?q=' 
            + EncodingUtil.urlEncode(queryInstance, 'UTF-8')); 
        
        // Set the method
        request.setMethod('GET');
        
        // Create the instance of the http
        Http http = new Http();
        
        // Store the response
        HTTPResponse res = http.send(request);
        
        // Parse the string
        String parseString = res.getBody().remove('<!doctype html>');
        
        // Create the instance of the http response 
        HtmlResponse__c responsehtmlInstance = new HtmlResponse__c();
        
        // Assign the response
        responsehtmlInstance.HtmlResponse__c = parseString;
       
        // Assign the query name
        responsehtmlInstance.QueryName__c = queryInstance;
       
        // Insert the resopnseInstance 
        insert responsehtmlInstance;
        
        parseString = parseString.substringAfter('<div id="search">');
        
        // Check if it contains the table tag
        if(parseString.contains('</table></div></li>'))
        {
            // Store the string after end of the table
            parseString = parseString.substringAfter('</table></div></li>');
        }
        
        // Replace the html tag 
        parseString = parseString.replace('<a href=','titleLinkStart');
        parseString = parseString.replace('</a>','titleLinkEnd');

        parseString = parseString.replace('<cite>',' HyperLinkStart[ '); 
        parseString = parseString.replace('</cite>',']HyperLinkEnd description['); 
        
        parseString = parseString.replace('</div></li>',']EndEnddescription ');
        parseString = parseString.replace('Cached',' '); 

        parseString = parseString.stripHtmlTags();  
       
        // Create the instance of the list of string
        List<String> responseList = new List<String>();
        
        // Split from description 
        responseList = parseString.split('Enddescription');
        
        // Remove the last element which contains suggestions
        responseList.remove(responseList.size()-1);
        
        // Fetch the query
        List<Query__c> queryStringInstance = 
            [
                SELECT 
                    Id,
                    Query_Field__c
                FROM 
                    Query__c
                WHERE 
                    Query_Field__c = :queryInstance
            ];

        // Create the instance of the set
        Set<String> setOfTitles = new Set<String>();
        
        System.debug('queryStringInstance' + queryStringInstance);

        // Iterate over the response
        for(Response__c responseInstance : [
                                                SELECT
                                                    Title__c,
                                                    Description__c,
                                                    TitleLinks__c,
                                                    Links__c,
                                                    Search_Query__c 
                                                FROM
                                                    Response__c
                                                WHERE
                                                    Search_Query__c = : queryStringInstance[0].Id
                                               ])
        {
        
            // Add the response instance to the set
            setOfTitles.add(responseInstance.Title__c);
        
        }// End of for
        
        // Create the instance of the response list
        List<Response__c> responseListInstance = new List<Response__c>();
        
        // Iterate over the response list
        for(String stringInstance : responseList) 
        {
        
            // Check if the string is not empty and blank
            if(String.isNotEmpty(stringInstance) && String.isNotBlank(stringInstance))
            {
                // Create the instance of the string
                String titleLink ='';
                
                // Create the instance of the string
                String titleName = '';
                
                // Store the string between titlelink
                titleLink = stringInstance.substringBetween('titleLinkStart','titleLinkEnd');
                
                // Check if the title link is blank or not
                if(String.isNotBlank(titleLink) && titleLink.contains('http'))
                {
 
                    // Fetch the title Link
                    titleLink = titleLink.substringAfter('http');
                    titleName = titleLink.substringAfter('">');
                    titleLink = titleLink.substringBefore('&sa');
 
                }
                
                // Append the <a href tag
                titleLink= '<a href=http' + titleLink + '>'+titleName+'</a>';
                
                // Fetch the title
                String titleInstance = stringInstance.substringBetween('>','titleLinkEnd');
                
                // Fetch the link
                String linkInstance = 
                    stringInstance.substringBetween('HyperLinkStart[', ']HyperLinkEnd');
                
                // Replace back with html tag 
                stringInstance = stringInstance.replace('titleLinkStart','<a href=');
                stringInstance = stringInstance.replace('titleLinkEnd','</a>');
                
                stringInstance = stringInstance.replace('Similar','');
                stringInstance = stringInstance.replace(' HyperLinkStart[ ','<cite>'); 
                
                stringInstance = stringInstance.replace(']HyperLinkEnd description[','!!!!'); 
                
                // Strip html tag
                stringInstance = stringInstance.stripHtmlTags();
                
                // Save the description
                String descriptionInstance = stringInstance.substringBetween('!!!!', ']End');
                
                // Check if the responses are already not present in the set
                if(setOfTitles.contains(titleInstance) == false)
                {

                    // Add the response instance
                    responseListInstance.add(new Response__c(
                        Description__c = descriptionInstance,
                        TitleLinks__c = titleLink,
                        Links__c = linkInstance,
                        Title__c = titleInstance ,
                        Search_Query__c = queryStringInstance[0].Id
                        )
                    );
                    
                }
            }// End of if loop
               
        }// End of for loop
        try
        {
            
            // Check if the list is not empty
            if(!responseListInstance.isEmpty())
            {
                // insert the responselist
                insert responseListInstance;
            }
       }
       catch(Exception exceptionInstance)
       {
           System.debug('Error'+e);
       }
    }
}
