public with sharing class SoapServiceClass 
{
    // Create the instance of the login result
    public partnerSoapSforceCom.LoginResult loginDetailInstance;
    
   /**
    * This is a method that will initalize the login process and perform the action of insert update
    * and delete. 
    */
    public void loginMethod()
    {
        // Create the instance of the inner class soap
        partnerSoapSforceCom.Soap partnerSoapInstance = new partnerSoapSforceCom.Soap();
        
        // Save the password in a string variable
        String password = 'test@123';
        
        // Save the username in a string variable
        String userName = 'kalpesh.gandhi@eternussolutions.com';
        
        // Save the result of login inside the instance of loginresult 
        loginDetailInstance = partnerSoapInstance.login( userName, password);
        
        // Save the session id in the string of session id 
        String sessionIdInstance = loginDetailInstance.sessionId;
        
        // Create the instance of the webservice class
        soapSforceComSchemasClassLeadmanipu.LeadManipulatorServicesSoap webserviceClassInstance = 
        new soapSforceComSchemasClassLeadmanipu.LeadManipulatorServicesSoap();
        
        // Create the instance of the session header
        webserviceClassInstance.sessionHeader = 
        new soapSforceComSchemasClassLeadmanipu.SessionHeader_element();

        // Assign the session id 
        webserviceClassInstance.sessionHeader.sessionID = loginDetailInstance.sessionId;
       
        // Create the instance of the wrapper class
        soapSforceComSchemasClassLeadmanipu.ResponseWrapper responceWrapperinstance= 
        new soapSforceComSchemasClassLeadmanipu.ResponseWrapper();
        
        // Call the insert method and save the results in the instance of wrapper class
        responceWrapperinstance = 
        webserviceClassInstance.insertLeadManipulatorService(
                                                            'Lead',
                                                            'Trial', 
                                                            'lead@Trial.com', 
                                                            '20000',
                                                            'EternusSolution'
                                                            );
        // Print the responce
        System.debug('Insert Process');
        System.debug('isSuccess :- ' + responceWrapperinstance.isSuccess);
        System.debug('Lead id :- ' + responceWrapperinstance.leadInstance);
        System.debug('Status :- ' + responceWrapperinstance.status);
        
        // Call the update method and save the results in the instance of wrapper class
        responceWrapperinstance = 
        webserviceClassInstance.updateLeadManipulatorService(
                                                             'Lead', 
                                                             'Trial', 
                                                             'lead@Trial.com', 
                                                             '20000'
                                                            );
        // Print the responce
        System.debug('Update Process');
        System.debug('isSuccess :- ' + responceWrapperinstance.isSuccess);
        System.debug('Lead id :- ' + responceWrapperinstance.leadInstance);
        System.debug('Status :- ' + responceWrapperinstance.status);
        
        // Call the delete method and save the results in the instance of wrapper class
        responceWrapperinstance = 
        webserviceClassInstance.deleteLeadManipulatorService(
                                                             'Lead', 
                                                             'Trial', 
                                                             'lead@Trial.com', 
                                                             '20000'
                                                            );
        // Print the responce
        System.debug('Delete Process');
        System.debug('isSuccess :- ' + responceWrapperinstance.isSuccess);
        System.debug('Lead id :- ' + responceWrapperinstance.leadInstance);
        System.debug('Status :- ' + responceWrapperinstance.status);
    }
}