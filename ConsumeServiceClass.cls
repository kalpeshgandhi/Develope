public with sharing class ConsumeServiceClass {
    public partnerSoapSforceCom.LoginResult loginDetails;
   
    //partnerSoapSforceCom.Soap soapInstance = new partnerSoapSforceCom.Soap();
    public void loginMethod() {
        partnerSoapSforceCom.Soap soapInstance = new partnerSoapSforceCom.Soap();
        String password = 'test@123';
        String userName = 'kalpesh.gandhi@eternussolutions.com';
        loginDetails = soapInstance.login( userName, password);
        String sessionIdInstance = loginDetails.sessionId;
        system.debug('.........loginDetails'+sessionIdInstance);
        
        soapSforceComSchemasClassLeadmanipu.LeadManipulatorServicesSoap webserviceClassInstance = new soapSforceComSchemasClassLeadmanipu.LeadManipulatorServicesSoap();
        webserviceClassInstance.sessionHeader = new soapSforceComSchemasClassLeadmanipu.SessionHeader_element();
        webserviceClassInstance.sessionHeader.sessionID = loginDetails.sessionId;
        
        //soapSforceComSchemasClassLeadmanipu.serviceResponse responseInstance = new soapSforceComSchemasClassLeadmanipu.serviceResponse();
        //string insertInstance =  clsInstance.insertLeadInstance('serviceLead1N', 'Eternus1', 'Open', '4363571', 'service@eternus1.com');
        //system.debug('++++++++++responseInstance.serviceStatus ' +insertInstance );
        //system.debug('----------responseInstance' +insertInstance);
        String updateInstance =  clsInstance.updateLeadInstance('kalpesh', 'serviceLead1N', '4000000', 'service1@eternus.com');
        system.debug('----------responseInstance' +updateInstance);
        //String deleteInstance =  clsInstance.deleteLeadInstance('00Q280000029jFj');
        //system.debug('----------responseInstance' +deleteInstance);
    }

}