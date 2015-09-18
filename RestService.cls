public with sharing class RestService 
{
    public static WrapperResponse loginMethod()
    {
        // Set the username
        String username = 'kalpesh.gandhi@eternussolutions.com';
        
        // Set the password
        String password = 'test@123';
        
        // Set the client id
        String clientId = '3MVG9ZL0ppGP5UrBRtL8DoI.bKYF.EUrMHeH94fqJ0bnP1cJWr7fHTjT.QzmwaKmoKWtyxgY0Wg8_yfrsNM__';
        
        // Set the client secret 
        String clientSecret = '6655140149994110469';
        
        // Create the instance of the httprequest 
        HttpRequest request = new HttpRequest();
        
        // Set the end point 
        request.setEndpoint('https://login.salesforce.com/services/oauth2/token'); 
        
        // Pass the parameters through the body
        request.setBody('grant_type=password' +'&client_id=' + clientId +'&client_secret=' + clientSecret + 
                    '&username=' + EncodingUtil.urlEncode(username, 'UTF-8') + '&password=' + EncodingUtil.urlEncode(password, 'UTF-8'));
        
        // Set the method as post
        request.setMethod('POST');
        
        // Create the instance of the http
        Http http = new Http();
        
        // Create the instance of the http Response
        HTTPResponse res = http.send(request);
        
        // Print the response
        System.debug('BODY: '+res.getBody());
        
        // Print the response
        System.debug('STATUS:'+res.getStatus());
        
        // Print the response
        System.debug('STATUS_CODE:'+res.getStatusCode());
        
        // Create the instance of the wrapper
        WrapperResponse wrapperInstane = (WrapperResponse)JSON.deserialize(res.getBody(),WrapperResponse.class);
        return wrapperInstane;
    }
    
    
    public HttpResponse leadCreate()
    {
        // Create the instance of the wrapper
        WrapperResponse Instance = RestService.loginMethod();
        
        // Create the instance of the http
        Http httpInstance = new Http();
        
        // Create the instance of httpRequest 
        HttpRequest HttpRequestInstance = new HttpRequest();
        
        // Set the header
        HttpRequestInstance.setHeader('Authorization','Bearer '+Instance.access_token);
        
        // Set the header
        HttpRequestInstance.setHeader('Content-Type','application/json');
        
        // Set the header
        HttpRequestInstance.setHeader('accept','application/json');
        
        // Set the method as Post
        HttpRequestInstance.setMethod('POST');
        
        // Copy the parameter that are in Json formate
        String parameterForCreate = 
        '{"firstName":"rest1", "lastName":"rest2", "email":"rest1@rest2.com", "phone":"1234567890", "company":"TCS"}';
        // Set the body 
        HttpRequestInstance.setBody(parameterForCreate);
        
        // Append the end point
        HttpRequestInstance.setEndpoint(Instance.instance_url+'/services/apexrest/LeadManipulation');
        
        // Send the http request 
        HttpResponse responseInstance = httpInstance.send(HttpRequestInstance);
        
        // Print the responce
        System.debug('Response : -'+responseInstance.getBody());
        
        return responseInstance;
    } 
     
    public HttpResponse leadUpdate()
    {
        // Create the instance of the wrapper
        WrapperResponse Instance = RestService.loginMethod();
        
        // Create the instance of the http
        Http httpInstance = new Http();
        
        // Create the instance of the httprequest
        HttpRequest HttpRequestInstance = new HttpRequest();
        
        // Set the header with authorization details
        HttpRequestInstance.setHeader('Authorization','Bearer '+Instance.access_token);
        
        // Set the header with content type details
        HttpRequestInstance.setHeader('Content-Type','application/json');
        
        // Set the header 
        HttpRequestInstance.setHeader('accept','application/json');
        
        // Append the end point
        HttpRequestInstance.setEndpoint(Instance.instance_url+'/services/apexrest/LeadManipulation?_HttpMethod=PATCH');
        HttpRequestInstance.setHeader('X-HTTP-Method-Override','PATCH');
        
        // Set the method as post
        HttpRequestInstance.setMethod('POST');
        // Copy the parameter that are in Json formate
        String parameterForUpdate = '{"firstName":"rest1", "lastName":"rest2", "email":"rest2@rest1.com", "phone":"9876543210"}';
        // Set the body  
        HttpRequestInstance.setBody(parameterForUpdate);
        
        // Send the http request
        HttpResponse responseInstance = httpInstance.send(HttpRequestInstance);
        // Print the responce
        System.debug('Response : -'+responseInstance.getBody());
        
        return responseInstance;
    }
    
    public HttpResponse leadDelete()
    {   
        // Create the instance of the wrapper
        WrapperResponse Instance = RestService.loginMethod();
        
        // Create the instance of the http
        Http httpInstance = new Http();
        
        // Create the instance of the httprequest
        HttpRequest HttpRequestInstance = new HttpRequest();
        
        // Set the header with authorization details
        HttpRequestInstance.setHeader('Authorization','Bearer '+Instance.access_token);
        
        // Set the header
        HttpRequestInstance.setHeader('Content-Type','application/json');
        
        // Set the header
        HttpRequestInstance.setHeader('accept','application/json');
        // Set the End Point
        HttpRequestInstance.setEndpoint(Instance.instance_url+'/services/apexrest/LeadManipulation?firstName=rest1&lastName=rest2&email=rest2@rest1.com&phone=9876543210');
        
        // Set the Delete
        HttpRequestInstance.setMethod('DELETE');      
        
        //HttpRequestInstance.setHeader('Authorization', 'OAuth '+Instance.access_token);       
        HttpResponse responseInstance = httpInstance.send(HttpRequestInstance);
        
        // Print the response
        System.debug('Response :-'+responseInstance.getBody());
        
        return responseInstance;
    }
    
    public class WrapperResponse
    {
        // Declare the string id with getters and setters
        public String id{get;set;}
        
        // Declare the string with getters and setters
        public String issued_at{get;set;}
       
        // Declare the string url
        public String instance_url{get;set;}
       
        // Declare the string signature
        public String signature{get;set;}
       
        // Declare the Stringaccess
        public String access_token{get;set;}
    }
}