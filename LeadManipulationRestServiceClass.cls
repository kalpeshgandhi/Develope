/**
 * This is method that will create the leads,update the leads and delete the leads of other org 
 * using its webservices.
 */
@RestResource(urlMapping='/LeadManipulation/*') 
global with sharing class LeadManipulationRestServiceClass 
{
   /**
    * This is a method that will create the leads using the httppost method
    */
    @HttpPost  
    global static ResponseWrapper insertLeadManipulatorService(String firstName,String lastName,String email,String phone,String company)
    {
        // Create the instance of the lead
        Lead leadInstance = new Lead();
        
        // Assign the first name
        leadInstance.FirstName = firstName;
        
        // Assign the last name
        leadInstance.LastName = lastName;
        
        // Assign the email
        leadInstance.Email = email;
        
        // Assign the phone
        leadInstance.Phone = phone;
        
        // Assign the company
        leadInstance.Company = company;
        
        try
        {
            // Insert the lead
            insert leadInstance;
            
            // Create the instance of the wrapper
            ResponseWrapper responseInstance = new ResponseWrapper();
            
            // Set the isSuccess as true
            responseInstance.isSuccess = true;
            
            // Assign the LeadInstance as leadId
            responseInstance.leadInstance = leadInstance.Id;
            
             // Set the Success as success
            responseInstance.status = 'Success';

            // Return responce
            return responseInstance;
        }
        catch(Exception exceptionInstance)
        {
            // Create the instance of the wrapper
            ResponseWrapper responseInstance = new ResponseWrapper();
            
            // Set the isSuccess as false
            responseInstance.isSuccess = false;
            
            // Assign the LeadInstance as ''
            responseInstance.leadInstance = '';
            
            // Assign the status as exception message
            responseInstance.status = '' + exceptionInstance;
            
            // Return responce
            return responseInstance;
        }
    }
    
   /**
    * This is a method that will delete the leads using the httpdelete method
    */
    @HttpDelete 
    global static ResponseWrapper deleteLeadManipulatorService() 
    {
        // Assign the firstname from parameter
        String firstName = RestContext.request.params.get('firstName');
        
        // Assign the lastname from parameter
        String lastName = RestContext.request.params.get('lastName');
        
        // Assign the email from parameter
        String email = RestContext.request.params.get('email');
        
        // Assign the phone from parameter
        String phone = RestContext.request.params.get('phone');
        
        // Create the instance of wrapper
        ResponseWrapper response = new ResponseWrapper();
  

            
        try
        {
            // Fetch the query
            Lead leadInstance = 
                [
                    SELECT 
                        Id,
                        FirstName, 
                        LastName,
                        Email, 
                        Phone 
                    FROM 
                        Lead 
                    WHERE 
                        FirstName = :firstName
                    AND 
                        LastName = :lastName
                    AND 
                        Email = :email
                    AND 
                        Phone = :phone
                ];
            
            // Delete the Lead
            delete leadInstance;
             // Create the instance of the wrapper
            ResponseWrapper responseInstance = new ResponseWrapper();
            
            // Set the isSuccess as true
            responseInstance.isSuccess = true;
                  
            // Assign the LeadInstance as leadId
            responseInstance.leadInstance = leadInstance.Id;
            // Set the Success as success
            responseInstance.status = 'Success';
            
            // Return responce
            return responseInstance;
        } 
        catch (Exception exceptionInstance) 
        {
            // Create the instance of the wrapper
            ResponseWrapper responseInstance = new ResponseWrapper();
            
            // Set the isSuccess as false
            responseInstance.isSuccess = false;
            
            // Assign the LeadInstance as ''
            responseInstance.leadInstance = '';
            
            // Assign the status as exception message
            responseInstance.status = '' + exceptionInstance;
            
            // Return responce
            return responseInstance;
        } 
    }     
     
   /**
    * This is a method that will update the leads using the httppatch method
    */
    @HttpPatch 
    global static ResponseWrapper updateLeadManipulatorService(String firstName,String lastName,String email,String phone)
    {
        try
        {
            // Fetch the query
            Lead leadInstance = 
                [
                    SELECT 
                        Id,
                        Name, 
                        Phone, 
                        Email
                    FROM 
                        Lead
                    WHERE 
                        FirstName = :firstName 
                    AND 
                        LastName = :lastName
                    LIMIT 1
                ];
            
            // Assign the email
            leadInstance.Email = email;
        
            // Assign the phone
            leadInstance.Phone = phone;
        

            // update the lead instance
            update leadInstance;
            // Create the instance of the wrapper
            ResponseWrapper responseInstance = new ResponseWrapper();
             // Set the isSuccess as true
            responseInstance.isSuccess = true;
            // Assign the LeadInstance as leadId
            responseInstance.leadInstance = leadInstance.Id;
            // Set the Success as success
            responseInstance.status = 'Success';
            // Return responce
            return responseInstance;
        }
        catch(Exception exceptionInstance)
        {
            // Create the instance of the wrapper
            ResponseWrapper responseInstance = new ResponseWrapper();
            
            // Set the isSuccess as false
            responseInstance.isSuccess = false;
            
            // Assign the LeadInstance as ''
            responseInstance.leadInstance = '';
            
            // Assign the status as exception message
            responseInstance.status = '' + exceptionInstance;
            
            // Return responce
            return responseInstance;
        }
    }
    
   /**
    * This is a inner wrapper class that is usefull for giving the responce in the from of 
    * status,issucess,leadInstance. 
    */
    global class ResponseWrapper 
    {
        // Declare the status as string 
        public String status;
        // Declare the lead as string
        public String leadInstance;
        // Declare the issuccess as boolean
        public Boolean isSuccess;
        
       /**
        * This is a constructor that will initialize the status, leadinstance ,issuccess
        */
        public ResponseWrapper()
        {
            // Initialize the issuccess as false 
            isSuccess = false;
            // Initialize the leadinstacne as ''' 
            leadInstance = '';
            // Initialize the status as '''
            status = '';
        }
    }
}