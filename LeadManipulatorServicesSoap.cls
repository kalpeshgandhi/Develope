global with sharing class LeadManipulatorServicesSoap 
{
     /**
    * This is a method that will create the leads
    */
    webservice static ResponseWrapper insertLeadManipulatorService(String firstName,String lastName,String email,String phone,String company)
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
    * This is a method that will delete the leads.
    */
    webservice static ResponseWrapper deleteLeadManipulatorService(String firstName,String lastName,String email,String phone)
    {


        try 
        {
            // Fetch the query
            Lead leadInstance = 
                [
                    SELECT 
                        Id, 
                        FirstName,
                        LastName, 
                        Phone, 
                        Email
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
                    LIMIT 1
                ];
            
            // Delete the lead
            delete leadInstance;
            
            // Create the instance of the wrapper
            ResponseWrapper responseInstance = new ResponseWrapper();
            
            // Set the isSuccess as true
            responseInstance.isSuccess = true;
            
            // Assign the LeadInstance as leadName
            responseInstance.leadInstance = leadInstance.FirstName + '' + leadInstance.LastName ;
            
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
    * This is a method that will update the leads.
    */
    webservice static ResponseWrapper updateLeadManipulatorService(String firstName,String lastName,String email,String phone)
    {

        try
        {
            // Fetch the Query
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
            
            // Update the lead
            update leadInstance;
            
            // Create the instance of the wrapper
            ResponseWrapper responseInstance = new ResponseWrapper();
            
            // Set the isSuccess as true
            responseInstance.isSuccess = true;
            
            // Assign the LeadInstance as lead id
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
    
    global class ResponseWrapper
    {
       // Declare the issuccess as boolean
       webservice Boolean isSuccess;
       
       // Declare the lead as string
       webservice String leadInstance;
       
       // Declare the status as string 
       webservice String status;
       
       public ResponseWrapper()
       {
            // Initialize the issuccess as false 
            isSuccess = false;
            
            // Initialize the leadinstacne as '' 
            leadInstance = '';
            
            // Initialize the status as ''
            status = '';
       }
    }
}